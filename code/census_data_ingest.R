## Load city / county geometries

# Function to filter sf objects by a bounding box-- will use this to clip features from city geometries I do not need (small islands that are not residential), and to remove rare crimes with wildly incorrect lat/lon information.
# filter_sf <- function(city_name,feature=NULL, data = NULL,xmin = NULL, xmax = NULL, ymin = NULL, ymax = NULL) {
#   if(is.null(feature)){
#     city_data <- (data %>% filter(city == city_name))
#     filt_data <- st_crop(city_data,c(xmin = xmin, xmax = xmax, ymin = ymin, ymax = ymax))
#     return(filt_data)
#   }
#   if(feature=="point"){
#     crime_data <- (data %>% filter(city == city_name))
#     filt_data <- st_crop(crime_data,c(xmin = xmin, xmax = xmax, ymin = ymin, ymax = ymax))
#
#     return(filt_data)
#
#   }
# }

# Load shapefile, project to CRS
load_sf <- function(path, crs) {
  df <- read_sf(path) %>%
    st_transform(crs = crs)
}

# Filter to specific county
filter_county <- function(counties) {
  counties %>%
    mutate(
      city = case_when(
        (grepl("District of Columbia", NAME) &
          STATE == "DC") ~ "Washington",
        (grepl("King", NAME) & STATE == "WA") ~ "Seattle",
        (grepl("San Francisco", NAME) & STATE == "CA") ~ "San Francisco",
        (grepl("(Wake)|(Durham)", NAME) & STATE == "NC") ~ "Raleigh",
        (grepl("Philadelphia", NAME) & STATE == "PA") ~ "Philadelphia",
        (grepl("(New York)|(Kings)|(Queens)|(Richmond)", NAME) &
          STATE == "NY") ~ "New York",
        (grepl("Los Angeles", NAME) & STATE == "CA") ~ "Los Angeles",
        (grepl("(Wayne)", NAME) & STATE == "MI") ~ "Detroit",
        (grepl("(Denver)|(Adams)|(Arapahoe)|(Jefferson)", NAME) &
          STATE == "CO") ~ "Denver",
        (grepl("Dallas", NAME) & STATE == "TX") ~ "Dallas",
        (grepl("(Hamilton)|(Clermont)|(Butler)", NAME) &
          STATE == "OH") ~ "Cincinnati",
        (grepl("Cook", NAME) & STATE == "IL") ~ "Chicago",
        (grepl("Suffolk", NAME) & STATE == "MA") ~ "Boston",
        (grepl("Baltimore", NAME) & STATE == "MD") ~ "Baltimore",
        (grepl("(Austin)|(Travis)|(Hays)|(Williamson)", NAME) &
          STATE == "TX") ~ "Austin",
        (grepl("(Fulton)|(Dekalb)|(Cobb)|(Clayton)", NAME) &
          STATE == "GA") ~ "Atlanta",
        .default = NA_character_
      )
    ) %>%
    filter(!is.na(city)) %>%
    mutate(name = paste(city, STATE, sep = ", ")) %>%
    st_as_sf()
}

# Load ACS variables
load_acs <- function(vintage, countyname, stateabbrev) {
  acs_df <- get_acs(
    geography = "cbg",
    state = stateabbrev,
    county = countyname,
    year = vintage,
    geometry = FALSE,
    variables = c(
      tot_pop = "B01001_001",
      race_white = "B02001_002",
      race_black = "B02001_003",
      race_aian = "B02001_004",
      race_asian = "B02001_005",
      race_nhopi = "B02001_006",
      race_other = "B02001_007",
      race_mult = "B02001_008",
      hisplat = "B03002_001",
      hisplat_white = "B03002_013",
      nhisplat_white = "B03002_004",
      hisplat_black = "B03002_014",
      nhisplat_black = "B03002_005",
      hisplat_aian = "B03002_015",
      hisplat_asian = "B03002_016",
      hisplat_nhopi = "B03002_017",
      hisplat_other = "B03002_018",
      hisplat_mult = "B03002_019",
      hh_count = "B11015_001",
      hhf_chld = "B11003_015",
      ind_inc_pov = "B17010_002",
      edu_25_male_tot = "B15002_002",
      edu_25_male_assoc = "B15002_014",
      edu_25_male_bach = "B15002_015",
      edu_25_male_mast = "B15002_016",
      edu_25_male_prof = "B15002_017",
      edu_25_male_doct = "B15002_018",
      edu_25_female_tot = "B15002_019",
      edu_25_female_assoc = "B15002_031",
      edu_25_female_bach = "B15002_032",
      edu_25_female_mast = "B15002_033",
      edu_25_female_prof = "B15002_034",
      edu_25_female_doct = "B15002_035",
      housing_total = "B25008_001",
      housing_owner_occ = "B25008_002",
      housing_rent_median = "B25064_001",
      housing_median_value = "B25077_001"
    )
  )
}

calc_nds <- function(acs_df) {
  nds_df <- acs_df %>%
    pivot_wider(
      names_from = variable,
      values_from = c(estimate, moe),
      names_glue = "{variable}_{.value}"
    ) %>%
    rowwise() %>%
    mutate(
      nds_a_edu_25_college_perc = sum(c_across(c(
        edu_25_male_assoc_estimate,
        edu_25_male_bach_estimate,
        edu_25_male_mast_estimate,
        edu_25_male_prof_estimate,
        edu_25_male_doct_estimate,
        edu_25_female_assoc_estimate,
        edu_25_female_bach_estimate,
        edu_25_female_mast_estimate,
        edu_25_female_prof_estimate,
        edu_25_female_doct_estimate
      ))) /
        sum(c_across(c(
          edu_25_male_tot_estimate,
          edu_25_female_tot_estimate
        ))) *
        100,
      nds_b_housing_owner_occ_perc = housing_owner_occ_estimate /
        housing_total_estimate *
        100,
      nds_c_housing_inc_pov_perc = ind_inc_pov_estimate /
        tot_pop_estimate *
        100,
      nds_d_fem_household_child_perc = hhf_chld_estimate /
        hh_count_estimate *
        100,
      nds = ((nds_c_housing_inc_pov_perc /
        10 +
        nds_d_fem_household_child_perc / 10) -
        (nds_a_edu_25_college_perc / 10 + nds_b_housing_owner_occ_perc / 10)) /
        4, # Neighborhood disadvantage score
      ice = (nhisplat_white_estimate - nhisplat_black_estimate) /
        tot_pop_estimate # Index of concentration at the extremes
    ) %>%
    ungroup()

  return(nds_df)
}

### Merge cities
filter_merge_cities <- function(cities, places, counties, projcrs) {
  df <- left_join(
    cities,
    places, # Bring in Census place data if we want to link back to the city data (note: for those cities which are not contiguous with their counties the place IDs do not represent the whole picture!)
    by = c("city", "st_fips")
  ) %>%
    filter(!city %in% c("Chicago", "Los Angeles")) %>% # These we have full county info for, so we will use their counties instead
    bind_rows(
      left_join(
        cities %>% filter(city %in% c("Chicago", "Los Angeles")),
        counties,
        by = "city"
      )
    ) %>%
    st_as_sf() %>%
    arrange(city) %>%
    distinct()

  # Now, we will do some clipping. This is a bit much for one target, but we'll keep it here for now.
  df$geometry[df$city == "San Francisco"] <- df$geometry[
    df$city == "San Francisco"
  ] %>%
    st_transform(crs = "EPSG:4326") %>%
    st_crop(
      c(
        xmin = -122.55, # Lat/Lon coordinates to filter to. NOTE: This assumes a decimal degrees projection! This function will take the input data and reproject it just in case.
        xmax = -122.32768,
        ymin = 37.69306,
        ymax = 37.86343
      )
    ) %>%
    st_transform(crs = projcrs)

  df$geometry[df$city == "Los Angeles"] <- df$geometry[
    df$city == "Los Angeles"
  ] %>%
    st_transform(crs = "EPSG:4326") %>%
    st_crop(
      c(
        xmin = -120,
        xmax = -117,
        ymin = 33.5,
        ymax = 35
      )
    ) %>%
    st_transform(crs = projcrs)

  df$geometry[df$city == "Seattle"] <- df$geometry[
    df$city == "Seattle"
  ] %>%
    st_transform(crs = "EPSG:4326") %>%
    st_crop(
      c(
        xmin = -123,
        xmax = -121,
        ymin = 47,
        ymax = 48
      )
    ) %>%
    st_transform(crs = projcrs)

  return(df)
}
