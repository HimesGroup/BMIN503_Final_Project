# Load packages required to define the pipeline:
library(targets)
library(tarchetypes) # for tar_map / tar_file helpers
tar_option_set(
  packages = c(
    "tidyverse",
    "pdftools",
    "tm",
    "skimr",
    "readr",
    "readxl",
    "data.table",
    "readxl",
    "kableExtra",
    "stringr",
    "foreach",
    "doParallel",
    "ranger",
    "purrr",
    "dplyr",
    "stringr",
    "sf",
    "reclin2",
    "dbscan",
    "stringdist",
    "geosphere",
    "units",
    "igraph",
    "RSocrata",
    "mapview",
    "leaflet",
    "cols4all",
    "tmap",
    "ggthemes",
    "tidycensus",
    "tigris",
    "units",
    "panelView",
    "easystats",
    "ggsci",
    "car",
    "fixest",
    "spdep",
    "spatstat",
    "ggridges",
    "did"
  ),
  format = "qs", # Optionally set the default storage format. qs is fast.
)

# Configure parallelization
options(clustermq.scheduler = "multicore")

# Configure backend of tar_make_clustermq()
future::plan(future.callr::callr)

# Load the R scripts in the R/ folder with custom functions:
tar_source(list.files("code", full.names = TRUE))

# Set project coordinate reference system
projcrs <- "EPSG:5070" # Choosing USGS Contiguous US Albers Equal Area, as we are doing density-based calculations and will want to preserve area comparisons
#### Given that we are focusing on Chicago, it may also be appropriate to project to something specific to Cook County, IL, like EPSG:3435 (NAD83 / Illinois East (ftUS))

units::install_unit("persons")
units::install_unit("crimes")

crime_loaders <- list(
  atlanta = load_atlanta_crime,
  austin = load_austin_crime,
  baltimore = load_baltimore_crime,
  boston = load_boston_crime,
  chicago = load_chicago_crime,
  cincinnati = load_cincinnati_crime,
  dallas = load_dallas_crime,
  denver = load_denver_crime,
  detroit = load_detroit_crime,
  los_angeles = load_los_angeles_crime,
  new_york = load_new_york_crime,
  philadelphia = load_philadelphia_crime,
  raleigh = load_raleigh_crime,
  san_francisco = load_san_francisco_crime,
  seattle = load_seattle_crime,
  washington = load_washington_crime
)

# Census API key
#### Located in R environment: readRenviron("~/.Renviron")
# census_api_key("REDACTED")

# Project color palette
# Color Palette
cb_palette <- c(
  "#E69F00", # orange
  "#56B4E9", # sky blue
  "#009E73", # bluish green
  "#F0E442", # yellow
  "#0072B2", # blue
  "#D55E00", # vermillion
  "#CC79A7", # reddish purple
  "#999999", # grey

  # extended set (similar luminance/saturation)
  "#117733", # dark green
  "#882255", # wine
  "#44AA99", # teal
  "#332288", # indigo
  "#DDCC77", # sand
  "#AA4499", # magenta
  "#88CCEE", # light blue
  "#661100" # dark brown
)

# Targets function list
list(
  ###################### CITIES INCLUDED ###################
  tar_target(
    # This is the cities for which we will run the data prep and analysis! We have their city name, county name, county FIPS, state name, and state FIPS
    cities,
    data.frame(
      city = c(
        "Atlanta",
        "Austin",
        "Baltimore",
        "Boston",
        "Chicago",
        "Cincinnati",
        "Dallas",
        "Denver",
        "Detroit",
        "Los Angeles",
        "New York",
        "Philadelphia",
        "Raleigh",
        "San Francisco",
        "Seattle",
        "Washington"
      ),
      state = c(
        "Georgia",
        "Texas",
        "Maryland",
        "Massachusetts",
        "Illinois",
        "Ohio",
        "Texas",
        "Colorado",
        "Michigan",
        "California",
        "New York",
        "Pennsylvania",
        "North Carolina",
        "California",
        "Washington",
        "District of Columbia"
      ),
      st_abbr = c(
        "GA",
        "TX",
        "MD",
        "MA",
        "IL",
        "OH",
        "TX",
        "CO",
        "MI",
        "CA",
        "NY",
        "PA",
        "NC",
        "CA",
        "WA",
        "DC"
      ),
      st_fips = c(
        "13",
        "48",
        "24",
        "25",
        "17",
        "39",
        "48",
        "08",
        "26",
        "06",
        "36",
        "42",
        "37",
        "06",
        "53",
        "11"
      )
    )
  ),

  ####################### SECTION 3: CITY / BLOCK GROUP GEOGRAPHY ################

  ### County Geography
  tar_target(
    counties_geo,
    counties(cb = TRUE, resolution = "500k", year = 2000) %>%
      st_transform(crs = projcrs) %>%
      mutate(
        st_fips = STATEFP,
        county_fips = COUNTYFP,
        STATE = cities$st_abbr[match(STATEFP, cities$st_fips)]
      ) %>%
      filter(!is.na(STATE))
  ),
  tar_target(
    counties_sample,
    filter_county(counties_geo) # Here we manually assign a list of the counties we want to keep-- this could be programmatically done to be more flexible, but that juice is not worth the squeeze at the moment
  ),
  ### City Boundares
  tar_target(
    places,
    places(state = cities$st_fips, cb = TRUE, year = 2015) %>% # Places data for city boundaries, using 2015 as reference year
      rename(st_fips = STATEFP, city = NAME) %>%
      filter(st_fips %in% cities$st_fips) %>%
      st_transform(crs = projcrs)
  ),
  tar_target(
    cities_sample,
    filter_merge_cities(cities, places, counties_sample, projcrs)
  ),

  # ### ACS Variables (block group)
  tar_target(
    county_sample_fips,
    counties_sample$county_fips
  ),
  tar_target(
    county_sample_states,
    counties_sample$STATE
  ),
  tar_target(
    acs_data,
    load_acs(
      vintage = 2015, # Using 2015 block group data as pre-2012 CBG data for ACS is not available from the govt at the moment
      countyname = county_sample_fips,
      stateabbrev = county_sample_states
    ),
    pattern = map(county_sample_fips, county_sample_states)
  ),
  tar_target(
    acs_sample,
    calc_nds(
      acs_df = acs_data
    )
  ),

  # ### Block Group Geography
  tar_target(
    bg_poly,
    command = get_acs(
      geography = "cbg",
      state = county_sample_states,
      county = county_sample_fips,
      year = 2015,
      geometry = TRUE,
      variables = c(pop = "B01001_001")
    ) %>%
      st_transform(crs = projcrs) %>%
      mutate(
        state = county_sample_states,
        county_fips = county_sample_fips,
      ),
    pattern = map(county_sample_fips, county_sample_states)
  ),
  tar_target(
    bg_cenpop,
    load_sf(
      path = "data/NHGIS_Block_Group_Centroids/2010/US_blck_grp_cenpop_2010.shp",
      crs = projcrs
    )
  ),
  tar_target(
    cenpop_sample,
    command = st_intersection(bg_cenpop, cities_sample) # Filter the block group pop. centroids to only those contained in the block group polygons for Cook County
  ),

  # ######################### SECTION 1: CLINIC DATA ############################
  # #### City Data
  tar_target(
    city_names,
    load_city_names(file = "data/us_cities_states_counties.csv")
  ),
  #### Facility Keys
  tar_target(
    keys,
    import_keys(directory = "data/dtc_keys")
  ),
  tar_target(
    keys_crosswalk,
    read_csv("data/working_data/keys_crosswalk.csv")
  ),
  #### Ingest Clinic PDF & CSV Data, flatten to single cleaned df
  tar_target(
    years,
    c(2005:2023)
  ),
  tar_target(
    pdf_df,
    extract_pdfs(years),
    pattern = map(years)
  ),
  tar_target(
    pdf_split,
    split_pdf(pdf_df),
    pattern = map(pdf_df)
  ),
  tar_target(
    combined_clinics_tagged,
    tag_clinics(pdf_split, keys, cities = city_names)
  ),
  tar_target(
    clinics_grouped,
    group_clinics(df = combined_clinics_tagged, cities = city_names)
  ),
  tar_target(
    csv_df,
    csv_clinics()
  ),
  tar_target(
    csv_pdf_merged,
    all_clinics_merge(
      pdf_merged = clinics_grouped,
      csv_merged = csv_df
    )
  ),
  tar_target(
    clinics_keyed,
    assign_keys(df = csv_pdf_merged)
  ),
  tar_target(
    clinic_year_summary,
    clinic_years_summary(df = clinics_keyed)
  ),

  #### Save Cleaned, Keyed df to CSV for Geocoding in ArcGIS
  tar_target(
    write_arc_geocode_df,
    write_csv(
      clinics_keyed %>%
        select(year:Zip) %>%
        mutate(Name_Combine = gsub("[^[:alnum:] ]", " ", Name_Combine)), # Clean non-alphanumerics so Arc doesn't complain
      "data/working_data/combined_df_09-03_for_geocode.csv"
    )
  ),

  #### Import Geocoded Clinic Data from ArcGIS
  tar_target(
    clinics_geo,
    read_clinic_geo(df = clinics_keyed)
  ),

  #### Probabalistically Match Clinics Across Years
  tar_target(
    clin_proj,
    prob_link_clean_addr(df = clinics_geo)
  ),
  tar_target(
    clinic_counties,
    unique(clin_proj$Subregion)
  ),
  tar_target(
    candidate_pairs,
    prob_link_pair_gen(clin_proj = clin_proj, region = clinic_counties),
    pattern = map(clinic_counties),
    memory = "transient"
  ),
  tar_target(
    pairs_geom,
    prob_link_pair_distance(
      clin_proj = clin_proj,
      candidate_pairs = candidate_pairs
    )
  ),
  tar_target(
    clinic_pairs_linked,
    prob_link_pairs(
      pairs_geom = pairs_geom,
      clin_proj = clin_proj,
      candidate_pairs = candidate_pairs
    )
  ),
  #### Assign Clinics the most common location across years for their clinic ID
  ##### where there is minor geocoding difference (<80m)
  tar_target(
    clinics_linked,
    mode_coords_clinics(clinic_pairs = clinic_pairs_linked, projcrs)
  ),
  # #### Plot Clinic Availability per City
  # tar_target(
  #   plot_clinic_year,
  #   plot_city_clinic_by_year(
  #     clinics = clinics_linked,
  #     selected_city = "Chicago, Illinois"
  #   )
  # ),
  # tar_target(
  #   plot_clinic_year_matrix,
  #   plot_city_clinic_avail_year(
  #     clinics = clinics_linked,
  #     selected_city = "Chicago, Illinois"
  #   )
  # ),

  # ##### Clinics in our sample #####
  tar_target(
    clinics_sample,
    command = st_intersection(clinics_linked, cities_sample) %>%
      filter(
        ### NOTE: These ranges are hardcoded here and were determined by looking at the crime data quality over time-- they should be verified and modified as new crime data and clinic data come in, or I should find a way to automate this.
        (city == "Atlanta" & (year %in% 2005:2016)) |
          (city == "Austin" & (year %in% 2004:2024)) |
          (city == "Baltimore" & (year %in% 2011:2024)) |
          (city == "Boston" & (year %in% 2015:2024)) |
          (city == "Chicago" & (year %in% 2004:2024)) |
          (city == "Cincinnati" & (year %in% 2011:2024)) |
          (city == "Dallas" & (year %in% 2015:2024)) |
          (city == "Denver" & (year %in% 2010:2024)) |
          (city == "Detroit" & (year %in% 2017:2024)) |
          (city == "Los Angeles" & (year %in% 2005:2024)) |
          (city == "New York" & (year %in% 2006:2024)) |
          (city == "Philadelphia" & (year %in% 2006:2024)) |
          (city == "Raleigh" & (year %in% 2016:2024)) |
          (city == "Seattle" & (year %in% 2008:2024)) |
          (city == "San Francisco" & (year %in% 2004:2024)) |
          (city == "Washington" & (year %in% 2008:2024))
      ) %>%
      mutate(year = year - 1) # This is because the data collection occurs a year before release, so we adjust so that crimes match!
  ),

  ######################### SECTION 2: CRIME DATA ############################
  ### NIBRS Crosswalk for UCR Codes
  tar_target(
    nibrs_crosswalk,
    read.csv("data/crime/nibrs_ucr_crosswalk.csv", colClasses = "character")
  ),
  ### Data Ingest
  tar_target(
    ingested_crimes,
    {
      city_name <- gsub(" ", "_", tolower(cities$city))
      loader <- crime_loaders[[city_name]]
      if (is.null(loader)) {
        stop("No crime ingest function defined for city: ", city_name)
      }
      loader(nibrs_crosswalk) %>% # Using the loading function defined above, pass it the crosswalk, then apply our filters!
        dplyr::mutate(
          drop = dplyr::case_when(
            lat == "0" |
              lon == "0" |
              is.na(lat) |
              is.na(lon) ~ "Missing Location",
            ucr == "" | is.na(ucr) ~ "Missing UCR Code",
            is.na(date) ~ "Missing Date"
          )
        )
    },
    pattern = map(cities),
    iteration = "list"
  ),
  # Mapping across ingested_crime datasets, we will now remove observations with missing data, apply some initial filtering for year and UCR, and project the data to an sf object
  tar_target(
    crime_geo,
    crime_geo_filter(ingested_crimes, nibrs_crosswalk, projcrs),
    pattern = map(ingested_crimes),
    iteration = "list",
    error = "null"
  ),

  ####################### Data Quality Check: Map All Layers ############
  tar_target(
    all_layer_map,
    {
      pal_points <- c4a("brewer.set1", n = 3)

      # # centroids
      # cenpop_sf <- st_filter(
      #   st_as_sf(cenpop_sample),
      #   st_as_sf(cities_sample)
      # ) %>%
      #   dplyr::mutate(pt_type = "Pop. Centroid")

      # crimes (sample 1000)
      crime_sf <- crime_geo %>%
        dplyr::bind_rows() %>%
        dplyr::sample_n(1000) %>%
        dplyr::mutate(pt_type = "Crimes")

      # clinics
      clinics_sf <- clinics_sample %>%
        dplyr::mutate(pt_type = "DTCs")

      tm_shape(
        st_filter(st_as_sf(bg_poly), st_as_sf(cities_sample)) %>%
          left_join(acs_sample %>% as.data.frame(), by = "GEOID")
      ) +
        tm_polygons(
          fill = "ice",
          fill.scale = tm_scale_continuous(values = "-hiroshige"),
          fill.legend = tm_legend("ICE Score", group_id = "top"),
          lwd = 0
        ) +

        # # CBG population centroids
        # tm_shape(cenpop_sf) +
        # tm_symbols(
        #   shape = 20,
        #   size = 0.6,
        #   fill = "pt_type",
        #   fill_alpha = 0.2,
        #   fill.scale = tm_scale_categorical(
        #     values = c("Pop. Centroid" = pal_points[1])
        #   ),
        #   fill.legend = tm_legend("", group_id = "top")
        # ) +

        # Crimes (sample)
        tm_shape(crime_sf) +
        tm_dots(
          fill = "pt_type",
          fill_alpha = 0.5,
          fill.scale = tm_scale_categorical(
            values = c("Crimes" = pal_points[2])
          ),
          fill.legend = tm_legend("", group_id = "top")
        ) +

        # DTCs
        tm_shape(clinics_sf) +
        tm_dots(
          fill = "pt_type",
          fill_alpha = 0.5,
          fill.scale = tm_scale_categorical(values = c("DTCs" = pal_points[3])),
          fill.legend = tm_legend("", group_id = "top")
        ) +

        # City border
        tm_shape(cities_sample) +
        tm_borders(lwd = 2) +

        tm_title(
          cities_sample$city,
          width = 15,
          group_id = "top",
          z = 0
        ) +
        tm_compass(group_id = "bottom") +
        tm_scalebar(group_id = "bottom") +
        # tm_credits(
        #   "© Data: U.S. Census Bureau, NHGIS, SAMSHA, City Municipalities, Software: R-tmap",
        #   group_id = "bottom"
        # ) +
        tm_components(
          "bottom",
          position = tm_pos_in("left", "bottom", align.h = "left")
        ) +
        tm_components(
          "top",
          position = tm_pos_out("right"),
          frame = FALSE,
          bg = FALSE
        ) +
        tm_crs("auto")
    },
    pattern = map(cities_sample, crime_geo),
    iteration = "list"
  ),

  ####################### SECTION 4: CLINIC-CRIME DISTANCES #########################

  #### Define buffer ring sizes
  tar_target(
    buffers,
    seq(60.96, 804.67, 60.96) # 1,400ft (426.72m) in 200ft (60.96m) increments
  ),
  tar_target(
    clinics_changepoint,
    create_changepoint(
      clinics_df = clinics_sample %>% filter(city == cities$city),
      crime_df = crime_geo
    ),
    pattern = map(cities, crime_geo),
    iteration = "list"
  ),
  tar_target(
    unit_points,
    create_unit_points(
      clinics_df = clinics_changepoint
    ),
    pattern = map(clinics_changepoint),
    iteration = "list"
  ),

  tar_target(
    crime_by_city,
    {
      # crime_geo here is a list of sf objects (one per city, from the dynamic branches)
      # We turn it into a named list keyed by standardized city name.
      purrr::set_names(
        crime_geo,
        purrr::map_chr(
          crime_geo,
          ~ gsub(" ", "_", tolower(unique(.x$city)[1]))
        )
      )
    },
    iteration = "list"
  ),
  tar_target(
    clinic_chunks,
    {
      # unit_points and cities are lists of branches here (one per city)
      per_city_chunks <- purrr::map2(
        unit_points,
        cities_sample$city,
        function(pts, city_row) {
          city_name <- gsub(" ", "_", tolower(city_row))

          chunks <- create_spatial_chunks(points = pts, chunk_size = 20)

          purrr::imap(
            split(chunks, chunks$chunk_id),
            ~ list(
              city = city_name,
              chunk_id = .y,
              clinic_chunk = .x
            )
          )
        }
      )

      # Flatten across cities into a single list of chunk objects:
      # list(chunk1, chunk2, chunk3, ...)
      unlist(per_city_chunks, recursive = FALSE)
    },
    iteration = "list"
  ),
  tar_target(
    chunk_distances,
    {
      # 1. Identify the city and get its crimes
      city_name <- clinic_chunks$city
      crimes_city <- crime_by_city[[city_name]]

      if (is.null(crimes_city)) {
        stop("No crimes found for city: ", city_name)
      }

      # 2. filter by years relevant to this city (or chunk)
      city_years <- seq(
        min(crimes_city$year, na.rm = TRUE),
        max(crimes_city$year, na.rm = TRUE)
      )
      crimes_city <- dplyr::filter(crimes_city, year %in% city_years)

      # 3. Build bounding geometry around the chunk’s clinic points
      bbox_poly <- create_search_poly(
        chunk = clinic_chunks$clinic_chunk,
        crime_data = crimes_city,
        max_distance = max(buffers)
      )

      # 4. filter crimes by the above search area
      nearby <- sf::st_filter(crimes_city, bbox_poly)

      # 5. perform distance calculations using this nearby subset
      process_clinic_distances(
        clinic_chunk = clinic_chunks$clinic_chunk,
        nearby_crimes = nearby,
        city_years = unique(nearby$year),
        buffers = buffers,
        max_distance = max(buffers)
      )
    },
    pattern = map(clinic_chunks),
    iteration = "list"
  ),
  tar_target(
    included_cities,
    c(
      "Atlanta",
      #"Austin",
      "Baltimore",
      #"Boston",
      "Chicago",
      #"Cincinnati",
      #"Dallas",
      "Denver",
      #"Detroit",
      "Los Angeles",
      "New York",
      "Philadelphia",
      #"Raleigh",
      "San Francisco",
      "Seattle"
      #"Washington"
    )
  ),
  tar_target(
    clinics_changepoint_count, # Combining all branches into one! We will later split back out by city for the models
    merge_distance_changepoint(
      changept_df = clinics_changepoint %>% bind_rows(),
      distances_df = chunk_distances %>% bind_rows(),
      clinics_df = clinics_sample %>% bind_rows()
    ) %>%
      filter(
        city %in%
          included_cities
      )
  ),

  # ####################### SECTION 5: DIFF-IN-DIFF PREP #########################
  tar_target(
    clinics_open,
    command = clinics_changepoint_count %>%
      #filter(count >= 5) %>% # Keep clinics where we have >5 years of data observed (AKA we are reasonably sure it is a legit clinic, and we have enough time to observe effects)
      filter(
        ((MHSAF | SA | MH.SA | SACA | SAE | SAF | SSA) == 1) & Score >= 95
      ) %>% # Consited keeping only clinics which provide substance abuse treatment, and which were geocoded with >=95% accuracy
      filter(year <= last_open) %>% # Censor clinics after we stop observing them as "open", and they cannot then be re-treated as control units
      mutate(group = as.numeric(group), change = first_open) %>% # Making a "change" column so we can be agnostic to first vs last when mapping across open vs closure
      select(-c(counts, distances))
  ),
  tar_target(
    clinics_close,
    command = clinics_changepoint_count %>%
      #filter(count >= 5) %>% # Keep clinics where we have >5 years of data observed (AKA we are reasonably sure it is a legit clinic, and we have enough time to observe effects)
      filter(
        ((MHSAF | SA | MH.SA | SACA | SAE | SAF | SSA) == 1) & Score >= 95
      ) %>% # Consited keeping only clinics which provide substance abuse treatment, and which were geocoded with >=95% accuracy
      filter(year >= first_open) %>% # Censor clinics after we stop observing them as "open", and they cannot then be re-treated as control units
      mutate(group = as.numeric(group), change = last_open) %>% # Making a "change" column so we can be agnostic to first vs last when mapping across open vs closure
      select(-c(counts, distances))
  ),
  tar_target(
    clinic_change_dfs, # This is our list of opening and closure targets which we will cross over
    list(
      clinics_open,
      clinics_close
    )
  ),

  tar_target(
    selected_buffer, # Given that most crimes occurs within 550m buffer, we will use the 548.64m buffer as the "representative" buffer
    command = set_units(548.64, m)
  ),

  ####################### SECTION 6: DIFF-IN-DIFF #########################
  # Set up outcome variables of interest
  tar_target(
    count_outcome_categories,
    c(
      "violent_count",
      "person_count",
      "property_count"
    )
  ),
  tar_target(
    dist_outcome_categories,
    c(
      "violent_median_distance", # The majority of the variation in this is explained by
      "person_median_distance",
      "property_median_distance"
    )
  ),
  ######## SECTION 6.1 DID: OVER-ALL #########
  ### Buffer ring-based
  tar_target(
    att_buffer, # buffer based treatment effect estimate
    estimate_diff(
      buffer_size = buffers,
      outcome = count_outcome_categories,
      level = "all",
      df = as.data.frame(clinic_change_dfs) %>%
        filter(city %in% included_cities),
      range = 3,
      count = 3
    ),
    pattern = cross(clinic_change_dfs, buffers, count_outcome_categories), # Run estimate_diff for every combination of buffer and outcome
    error = "null"
  ),
  ### Direct distance to DTC based
  tar_target(
    att_dist, # ditance based treatment effect estimate
    estimate_diff(
      buffer_size = selected_buffer,
      outcome = dist_outcome_categories,
      level = "all",
      df = as.data.frame(clinic_change_dfs) %>%
        filter(city %in% included_cities),
      range = 3,
      count = 3
    ),
    pattern = cross(clinic_change_dfs, dist_outcome_categories), # Run estimate_diff for every combination of buffer and outcome
    error = "null"
  ),
  ######## SECTION 6.1 DID: BY CITY #########
  ### Buffer ring-based
  tar_target(
    att_buffer_city, # buffer based treatment effect estimate
    estimate_diff(
      buffer_size = buffers,
      outcome = count_outcome_categories,
      level = "city",
      df = as.data.frame(clinic_change_dfs) %>%
        filter(city %in% included_cities),
      range = 3,
      count = 3
    ),
    pattern = cross(
      included_cities,
      clinic_change_dfs,
      buffers,
      count_outcome_categories
    ), # Run estimate_diff for every combination of buffer and outcome
    error = "null"
  ),
  ### Direct distance to DTC based
  tar_target(
    att_dist_city, # ditance based treatment effect estimate
    estimate_diff(
      buffer_size = selected_buffer,
      outcome = dist_outcome_categories,
      level = "city",
      df = as.data.frame(clinic_change_dfs) %>%
        filter(city %in% included_cities),
      range = 3,
      count = 3
    ),
    pattern = cross(
      included_cities,
      clinic_change_dfs,
      dist_outcome_categories
    ), # Run estimate_diff for every combination of buffer and outcome
    error = "null"
  ),
  ########## SECTION 6.5: DID GRAPHS - Over-all ############
  tar_target(
    buffer_forest,
    att_buffer %>%
      arrange(outcome, buffer) %>%
      ggplot(aes(x = buffer, y = estimate)) +
      geom_point() +
      geom_errorbar(aes(ymin = ci_low, ymax = ci_high)) +
      geom_hline(yintercept = set_units(0, crimes / (km * km))) +
      facet_wrap(~ direction + crime_type, scales = "free_y") +
      theme_minimal() +
      labs(
        title = "Estimated Change in Crime Density",
        subtitle = "Clinic Opening vs Closure, by Crime Type"
      ) +
      xlab("Buffer") +
      ylab("Estimated Change")
  ),
  tar_target(
    dist_forest,
    att_dist %>%
      arrange(crime_type, buffer) %>%
      ggplot(aes(x = crime_type, y = estimate)) +
      geom_point() +
      geom_errorbar(aes(ymin = ci_low, ymax = ci_high)) +
      geom_hline(yintercept = set_units(0, m)) +
      facet_wrap(~direction) +
      theme_minimal() +
      labs(
        title = "Estimated Change in Crime Proximity",
        subtitle = "Clinic Opening vs Closure, by Crime Type"
      ) +
      xlab("Crime Type") +
      ylab("Estimated Change") +
      coord_flip()
  ),

  ########## SECTION 6.5: DID GRAPHS - Per City ############
  tar_target(
    buffer_forest_city,
    att_buffer_city %>%
      arrange(outcome, buffer) %>%
      ggplot(aes(
        x = buffer,
        y = estimate,
        group = crime_type,
        color = crime_type
      )) +
      geom_point(position = position_dodge(width = 75)) +
      geom_errorbar(
        aes(ymin = ci_low, ymax = ci_high),
        position = position_dodge(width = 75)
      ) +
      geom_hline(yintercept = set_units(0, crimes / (km * km))) +
      facet_wrap(~ direction + city, scales = "free_y") +
      theme_minimal() +
      labs(
        title = "Estimated Change in Crime Density",
        subtitle = "Clinic Opening vs Closure, by Crime Type"
      ) +
      xlab("Buffer") +
      ylab("Estimated Change")
  ),
  tar_target(
    dist_forest_city,
    att_dist_city %>%
      arrange(city, buffer) %>%
      ggplot(aes(x = city, y = estimate)) +
      geom_point() +
      geom_errorbar(
        aes(ymin = ci_low, ymax = ci_high)
      ) +
      geom_hline(yintercept = set_units(0, m)) +
      facet_wrap(~ direction + crime_type) +
      theme_minimal() +
      labs(
        title = "Estimated Change in Crime Proximity",
        subtitle = "Clinic Opening vs Closure, by Crime Type"
      ) +
      xlab("Crime Type") +
      ylab("Estimated Change") +
      coord_flip()
  ),
  ######################### MANUSCRIPT / PROJECT REPORTS ###################################
  tar_quarto(
    report,
    path = "report/bmin_report_benson.qmd",
    debug = TRUE,
    quiet = FALSE
  ),
  tar_quarto(
    presentation,
    path = "presentation/bmin_final_slides_benson.qmd",
    debug = TRUE,
    quiet = FALSE
  )
)
