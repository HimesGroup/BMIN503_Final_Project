read_clinic_geo <- function(df) {
  clinics_sf <- read_sf(
    "data/ArcGIS/Output_Combined_DF_Geocoded/Combined_df_geocoded.shp"
  ) %>% # Load in the geocoded results from ArcGIS
    st_transform(crs = projcrs) %>%
    mutate(clinic_id = paste0(USER_year, USER_clini)) # Rename the clinic ID to match the clinic data
  clinics_sf2 <- read_sf("data/ArcGIS-2024/Geocoded/Geocode_2024.shp") %>% # Load in the geocoded results from ArcGIS for 2024 file
    st_transform(crs = projcrs) %>%
    mutate(clinic_id = as.character(USER_clini)) # Rename the clinic ID to match the clinic data
  clinics_sf <- bind_rows(clinics_sf, clinics_sf2)

  clinics <- right_join(
    clinics_sf,
    df %>% mutate(clinic_id = paste0(year, clinic_id)),
    by = "clinic_id"
  ) %>%
    select(
      clinic_id,
      X,
      Y.x,
      Status,
      Score,
      Match_type,
      Place_addr,
      StAddr,
      SubAddr,
      City.x,
      State,
      Subregion,
      Region,
      RegionAbbr,
      Country,
      CntryName,
      year:MWS,
      -City.y
    ) %>%
    rename(lon = X, lat = Y.x, City = City.x)

  return(clinics)
}

prob_link_clean_addr <- function(df) {
  #1) Prepare fields for linkage / string similarity detection, strip out extraneous information (Capitalization / punctuation, etc)
  clin_norm <- df %>%
    mutate(
      Subregion = ifelse(
        is.na(Subregion) | Subregion == "",
        "Unknown",
        Subregion
      ),
      Name_Combine = str_to_lower(Name_Combine %||% ""),
      Name1 = str_to_lower(Name1 %||% ""),
      Name2 = str_to_lower(Name2 %||% ""),
      StAddr = str_to_lower(StAddr %||% ""),
      Street1 = str_to_lower(Street1 %||% ""),
      Address_Combine = str_to_lower(Address_Combine %||% ""),
      Phone1_clean = str_replace_all(Phone1 %>% coalesce(""), "[^0-9]", ""),
      URL1_clean = str_replace_all(
        URL1 %>% coalesce(""),
        "^(https?://)?(www\\.)?",
        ""
      ) %>%
        str_remove_all("/.*$"),
      Keys_clean = str_replace_all(Keys %||% "", "[^a-z0-9 ]", "")
    ) %>%
    # ensure geometry is sfc, then set CRS to WGS84 lon/lat if not set, as it this is what Arc set it to
    st_as_sf()

  if (is.null(st_crs(df))) {
    st_crs(df) <- 4326L
  }

  # Use s2/geodesic distance
  # Using EPSG:5070 (US National Albers equal area / conic)
  clin_proj <- st_transform(clin_norm, 5070)
  return(clin_proj)
}

prob_link_pair_gen <- function(clin_proj, region) {
  candidate_radius_m <- set_units(500, "m") # candidate clinic selection radius

  # 2) Generate candidate pairs via spatial join
  # Use st_is_within_distance on projected coordinates
  # block candidate index by county to reduce memory
  subset_sr <- clin_proj %>% filter(Subregion == region)
  if (nrow(subset_sr) < 2) {
    return(NULL)
  }
  # Use st_is_within_distance to get neighbors within candidate radius
  idx_list <- st_is_within_distance(
    subset_sr,
    subset_sr,
    dist = as.numeric(candidate_radius_m)
  )
  # convert idx_list to tidy pairs (i < j)
  tibble(
    i = rep(seq_along(idx_list), lengths(idx_list)),
    j = unlist(idx_list)
  ) %>%
    filter(i < j) %>%
    mutate(
      id_i = subset_sr$clinic_id[i],
      id_j = subset_sr$clinic_id[j]
    ) %>%
    select(id_i, id_j)
}

prob_link_pair_distance <- function(clin_proj, candidate_pairs) {
  # 3) Attach attributes for both records and compute geodesic distance
  clin_attrs <- clin_proj %>%
    st_drop_geometry() %>%
    select(
      clinic_id,
      year,
      Name1,
      Name2,
      Address_Combine,
      StAddr,
      Street1,
      Phone1_clean,
      URL1_clean,
      Keys_clean
    )

  pairs_attrs <- candidate_pairs %>%
    left_join(clin_attrs, by = c("id_i" = "clinic_id")) %>%
    left_join(clin_attrs, by = c("id_j" = "clinic_id"), suffix = c("_i", "_j"))

  # join geometries to compute distance in next step
  geom_tbl <- clin_proj %>% select(clinic_id, geometry)

  pairs_geom <- pairs_attrs %>%
    left_join(
      geom_tbl %>% st_set_geometry(NULL),
      by = c("id_i" = "clinic_id")
    ) %>%
    left_join(geom_tbl %>% st_set_geometry(NULL), by = c("id_j" = "clinic_id"))

  # build a dataframe with just the two geometries for each clinic pair
  geom_join <- clin_proj %>%
    filter(clinic_id %in% unique(c(pairs_attrs$id_i, pairs_attrs$id_j))) %>%
    select(clinic_id, geometry)

  # Convert to a named list of geometries (faster search)
  geom_lookup <- set_names(st_geometry(geom_join), geom_join$clinic_id)

  # compute distances (in meters) using st_distance with s2==TRUE (geographic)
  geom_i <- st_sfc(geom_lookup[pairs_geom$id_i], crs = st_crs(geom_lookup))
  geom_j <- st_sfc(geom_lookup[pairs_geom$id_j], crs = st_crs(geom_lookup))

  pairs_geom <- pairs_geom %>%
    mutate(
      dist_m = as.numeric(st_distance(geom_i, geom_j, by_element = TRUE))
    )

  return(pairs_geom)
}

prob_link_pairs <- function(pairs_geom, candidate_pairs, clin_proj) {
  # 4) Compute text similarity features for the candidate pairs identified above
  # Jaro-Winkler for names, address; token-based measures for keys
  pairs_geom <- pairs_geom %>%
    mutate(
      name1_jw = 1 -
        stringdist(Name1_i %||% "", Name1_j %||% "", method = "jw"),
      addr_jw = 1 -
        stringdist(
          Address_Combine_i %||% "",
          Address_Combine_j %||% "",
          method = "jw"
        ),
      staddr_jw = 1 -
        stringdist(StAddr_i %||% "", StAddr_j %||% "", method = "jw"),
      phone_exact = (Phone1_clean_i != "" & Phone1_clean_i == Phone1_clean_j),
      url_exact = (!is.na(URL1_clean_i) &
        URL1_clean_i != "" &
        URL1_clean_i == URL1_clean_j),
      keys_jw = 1 -
        stringdist(Keys_clean_i %||% "", Keys_clean_j %||% "", method = "jw"),
      year_gap = abs(year_i - year_j)
    )

  # 5) Definite matches, where:
  #  - exact phone match (non-empty) => same clinic (unless distance > threshold, then treat as different)
  #  - exact URL match similarly => same clinic (unless distance > threshold, then treat as different)
  #  - extremely high name+address jw (>= .98 and dist <= distance threshold)
  pairs_geom <- pairs_geom %>%
    mutate(
      definite_match = (phone_exact | url_exact) |
        (name1_jw >= 0.98 & (addr_jw >= 0.95 | staddr_jw >= 0.95))
    )

  threshold_m <- set_units(60.96, "m") # 200ft in meters-- clinics within this distance of each other are considered the same
  # But if we found it was a definite match above, but dist_m > threshold_m, override to FALSE (not a match)
  pairs_geom <- pairs_geom %>%
    mutate(
      definite_match = ifelse(
        dist_m > as.numeric(threshold_m),
        FALSE,
        definite_match
      )
    )

  # Step 1: Define rules for a confident match for those which did not match via the above screening
  pairs_geom <- pairs_geom %>%
    mutate(
      rule_strong = phone_exact |
        (name1_jw > 0.95 & addr_jw > 0.95 & dist_m < 60.96 & year_gap <= 2), # We allow for a bit more laxity here, but still require clinics to be within 200ft, and to have been open within 2 years of one another

      rule_possible = !rule_strong &
        ((name1_jw > 0.9 & addr_jw > 0.9 & dist_m < 200) | # Allow a little more laxity, within ~600ft now, and a bit less similar name/address combo
          (keys_jw > 0.9 & year_gap <= 2))
    )

  # Step 2: Assign match status
  pairs_geom <- pairs_geom %>%
    mutate(
      match_status = case_when(
        rule_strong ~ "match",
        rule_possible ~ "possible",
        TRUE ~ "non-match"
      )
    )

  table(pairs_geom$match_status)

  # Step 3: one-to-one linkage (best link per id_i)
  pairs_best <- pairs_geom %>%
    filter(match_status %in% c("match", "possible")) %>%
    group_by(id_i) %>%
    slice_max(
      order_by = name1_jw + addr_jw + keys_jw - log1p(dist_m) - year_gap,
      n = 1
    ) %>%
    ungroup()

  # First, keep only intra-year duplicates, where a clinic had say multiple records listed at the same exact location for a single year, but one was an adult program, one was a program for pregnant women, etc.
  intra_year_dups <- pairs_geom %>%
    filter(year_i == year_j, match_status == "match") %>%
    select(id_i, id_j, year = year_i)

  # build equivalence classes of duplicates (using igraph)
  g_intra <- graph_from_data_frame(intra_year_dups, directed = FALSE)
  comp_intra <- components(g_intra)

  # map each clinic ID to a deduplicated ID
  dedup_map <- tibble(
    clinic_id = names(comp_intra$membership),
    dedup_id = paste0("dedup_", comp_intra$membership)
  )

  # keep only cross-year matches, so we have one clinic observation per year per clinic
  cross_year_links <- pairs_geom %>%
    filter(year_i != year_j, match_status == "match") %>%
    select(id_i, id_j)

  # build equivalence classes across years
  g_cross <- graph_from_data_frame(cross_year_links, directed = FALSE)
  comp_cross <- components(g_cross)

  # map dedup_ids to an entity_id
  entity_map <- tibble(
    clinic_id = names(comp_cross$membership),
    entity_id = paste0("entity_", comp_cross$membership)
  )

  clinics_clean <- clin_proj %>%
    left_join(dedup_map, by = c("clinic_id" = "clinic_id")) %>%
    left_join(entity_map, by = c("clinic_id" = "clinic_id")) %>%
    group_by(entity_id, year) %>%
    slice(1) %>% # keep only one row per entity/year
    ungroup()

  clinics_clean %>%
    rename(group = entity_id)
}

mode_coords_clinics <- function(clinic_pairs, projcrs) {
  # 6) Clean up slight variation in address coding / clinics which we matched as identical, but had different coordinates across years due to moving down the street-- very minor changes in distance (~30-50ft)
  mode_coords <- clinic_pairs %>%
    group_by(group) %>%
    st_drop_geometry() %>%
    mutate(latlon = paste0(lat, ",", lon)) %>% # Create one variable with the lat lon pair
    count(latlon, sort = TRUE) %>% # Count unique lat lon pairs within clincs across years
    slice(1) %>% # Keep the most common one
    select(-n) %>%
    right_join(
      clinic_pairs %>% # Bring back the other variables from the main dataframe, so we have a new frame with the clinic ID and the most common lat/lon pair
        st_drop_geometry(),
      by = c("group")
    ) %>%
    mutate(
      lat_mode = as.numeric(str_split_i(latlon, ",", 1)),
      lon_mode = as.numeric(str_split_i(latlon, ",", 2))
    ) %>%
    select(group, lat_mode, lon_mode, lat, lon) %>%
    st_drop_geometry() %>%
    rowwise() %>%
    mutate(
      d = as.numeric(distm(
        c(lon, lat), # Calculate the error in distance introduced by changing the clinic to use the most common lat/lon pair for each year
        c(lon_mode, lat_mode),
        fun = distHaversine
      ))
    ) %>%
    distinct() %>%
    group_by(group) %>%
    mutate(d = max(d)) # Assign the worst error introduced to each clinic

  clinics_linked <- clinic_pairs %>%
    left_join(mode_coords, by = c("group", "lat", "lon")) %>%
    select(-c(lat, lon)) %>%
    st_drop_geometry() %>%
    rename(
      lat = lat_mode, # Merging back in with original data, replace the lat/lon originals with the new, most common coords
      lon = lon_mode
    ) %>%
    st_as_sf(coords = c("lon", "lat"), crs = "+proj=longlat +datum=WGS84") %>%
    st_transform(crs = projcrs) %>%
    mutate(
      lon = st_coordinates(geometry)[, 1], # Recreate columns from geometry column for later processing
      lat = st_coordinates(geometry)[, 2],
      group = substr(group, 8, length(group))
    ) # Change group ID to just be numbers, leftover from matching process

  return(clinics_linked)
}
