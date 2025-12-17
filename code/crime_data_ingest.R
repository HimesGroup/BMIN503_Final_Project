### Atlanta ####
load_atlanta_crime <- function(nibrs_crosswalk) {
  temp <- c("Crime_Data_1997_2008_-4810095850881058227.csv", "apd.csv")

  atlanta_crime = do.call(
    bind_rows,
    lapply(temp, function(x) {
      read.csv(paste0("data/crime/Atlanta/", x), colClasses = "character")
    })
  ) %>% # Import all CSVs, merge together
    select(
      Incident_.,
      Date_From1,
      UC2literal,
      UC2Literal,
      UC2,
      Longitude,
      Latitude,
      OffenseID,
      ReportDate,
      UCR,
      GeoLocation,
      UCGroup
    ) %>%
    mutate(
      id = case_when(
        is.na(OffenseID) & !is.na(Incident_.) ~ Incident_.,
        !is.na(OffenseID) & is.na(Incident_.) ~ OffenseID
      ),
      date = case_when(
        is.na(ReportDate) & !is.na(Date_From1) ~ parse_date_time(
          Date_From1,
          "mdY HMS"
        ),
        !is.na(ReportDate) & is.na(Date_From1) ~ parse_date_time(
          substr(ReportDate, 1, 10),
          "Ymd"
        )
      ),
      crime = case_when(
        is.na(UC2literal) & !is.na(UC2Literal) ~ UC2Literal,
        !is.na(UC2literal) & is.na(UC2Literal) ~ UC2literal
      ),
      ucr = case_when(
        is.na(UC2) & !is.na(UCR) ~ substr(UCR, 2, 2), # Atlanta only reports index Part I crimes, classified nicely. Can safely treat this as the UCR.
        !is.na(UC2) & is.na(UCR) ~ substr(UC2, 1, 1)
      ), # Same here!
      Latitude = case_when(
        !is.na(Latitude) ~ (Latitude),
        !is.na(GeoLocation) ~ substr(
          str_split(GeoLocation, ", ", simplify = T)[, 1],
          14,
          nchar(str_split(GeoLocation, ", ", simplify = T)[, 1])
        ),
        TRUE ~ Latitude
      ),
      Longitude = case_when(
        !is.na(Longitude) ~ (Longitude),
        !is.na(GeoLocation) ~
          substr(
            str_split(GeoLocation, ", ", simplify = T)[, 2],
            1,
            nchar(str_split(GeoLocation, ", ", simplify = T)[, 2]) - 2
          ),
        TRUE ~ Longitude
      )
    ) %>%
    rename(lat = Latitude, lon = Longitude) %>%
    select(id, date, crime, ucr, lat, lon) %>%
    mutate_if(is.character, ~ trimws(.)) %>% # Remove leading/trailing whitespace
    mutate(city = "Atlanta", year = year(date)) %>% # NOTE: ATLANTA DOES NOT INCLUDE RAPE DATA FOR 2009 to 2020!
    left_join(
      nibrs_crosswalk %>% distinct(ucr, ucr_description, part, against),
      by = "ucr"
    )

  # Filter to keep the years with enough data!
  # Atlanta we only have through 2016, so we will filter to 2016 and before
  atlanta_crime <- atlanta_crime %>% filter(year <= 2016)
  return(atlanta_crime)
}

### Austin ####
load_austin_crime <- function(nibrs_crosswalk) {
  temp = list.files("data/crime/Austin", pattern = "\\.csv$")
  austin_crime = do.call(
    bind_rows,
    lapply(temp, function(x) {
      read.csv(paste0("data/crime/Austin/", x), colClasses = "character")
    })
  ) %>% # Import all CSVs, merge together
    select(
      Incident.Number,
      Occurred.Date,
      Highest.Offense.Code,
      UCR.Category,
      Highest.Offense.Description,
      Latitude,
      Longitude
    ) %>%
    rename(
      lat = Latitude,
      lon = Longitude,
      id = Incident.Number,
      crime = Highest.Offense.Description,
      ucr = Highest.Offense.Code,
      nibrs = UCR.Category
    ) %>%
    mutate(
      city = "Austin",
      date = parse_date_time(Occurred.Date, "mdY"),
      year = year(date),
      ucr = substr(ucr, 1, nchar(ucr) - 2)
    ) %>%
    select(id, date, year, city, crime, ucr, nibrs, lat, lon) %>%
    mutate_if(is.character, ~ trimws(.)) %>% # Remove leading/trailing whitespace
    left_join(
      nibrs_crosswalk %>% distinct(ucr, ucr_description, part, against),
      by = "ucr"
    )

  return(austin_crime)
}

### Baltimore ####
load_baltimore_crime <- function(nibrs_crosswalk) {
  temp = list.files("data/crime/Baltimore", pattern = "\\.csv$")
  baltimore_crime = do.call(
    bind_rows,
    lapply(temp, function(x) {
      read.csv(paste0("data/crime/Baltimore/", x), colClasses = "character")
    })
  ) %>% # Import all CSVs, merge together
    select(
      CCNumber,
      CrimeDateTime,
      CrimeCode,
      Description,
      Latitude,
      Longitude
    ) %>%
    rename(
      lat = Latitude,
      lon = Longitude,
      id = CCNumber,
      crime = Description,
      ucr = CrimeCode
    ) %>%
    mutate(date = parse_date_time(CrimeDateTime, "mdY HMS")) %>%
    select(id, date, crime, ucr, lat, lon) %>%
    mutate(
      city = "Baltimore",
      nibrs = "",
      year = year(date),
      ucr = substr(
        case_when(
          ucr == "4E" ~ "9S", # 4E is simple assault, not aggravated, moving to "Other Assaults" category
          .default = ucr
        ),
        1,
        1
      )
    ) %>%
    mutate_if(is.character, ~ trimws(.)) %>% # Remove leading/trailing whitespace
    left_join(
      nibrs_crosswalk %>% distinct(ucr, ucr_description, part, against),
      by = "ucr"
    )

  # Filter to keep the years with enough data!
  # Baltimore has spotty coverage pre-2011, so we will filter to 2011 and later
  baltimore_crime <- baltimore_crime %>% filter(year >= 2011)

  return(baltimore_crime)
}

### Boston ####
load_boston_crime <- function(nibrs_crosswalk) {
  temp = list.files("data/crime/Boston", pattern = "\\.csv$")
  boston_crime = do.call(
    bind_rows,
    lapply(temp, function(x) {
      read.csv(paste0("data/crime/Boston/", x), colClasses = "character")
    })
  ) %>% # Import all CSVs, merge together
    select(
      INCIDENT_NUMBER,
      OCCURRED_ON_DATE,
      OFFENSE_CODE,
      OFFENSE_DESCRIPTION,
      Lat,
      Long
    ) %>%
    rename(
      lat = Lat,
      lon = Long,
      id = INCIDENT_NUMBER,
      date = OCCURRED_ON_DATE,
      crime = OFFENSE_DESCRIPTION,
      ucr = OFFENSE_CODE
    ) %>%
    select(id, date, crime, ucr, lat, lon) %>%
    mutate(
      city = "Boston",
      date = lubridate::as_datetime(date),
      year = year(date),
      ucr2 = case_when(
        nchar(ucr) == 5 ~ substr(ucr, 2, 3),
        nchar(ucr) == 4 ~ substr(ucr, 1, 2),
        nchar(ucr) == 3 ~ substr(ucr, 1, 1),
        crime == "ASSAULT - SIMPLE" | crime == "ASSAULT SIMPLE - BATTERY" ~ "9",
        crime == "ARSON" ~ "8",
        crime == "Justifiable Homicide" ~ "1"
      )
    ) %>%
    mutate(
      ucr = as.character(as.integer(case_when(
        !is.na(ucr2) ~ ucr2,
        is.na(ucr2) ~ ucr
      )))
    ) %>%
    select(-ucr2) %>%
    mutate_if(is.character, ~ trimws(.)) %>% # Remove leading/trailing whitespace
    left_join(
      nibrs_crosswalk %>% distinct(ucr, ucr_description, part, against),
      by = "ucr"
    )

  return(boston_crime)
}

### Chicago ####
load_chicago_crime <- function(nibrs_crosswalk) {
  temp = list.files("data/crime/Chicago", pattern = "\\.csv$")
  chicago_crime = do.call(
    bind_rows,
    lapply(temp, function(x) {
      read.csv(paste0("data/crime/Chicago/", x), colClasses = "character")
    })
  ) %>% # Import all CSVs, merge together
    select(
      ID,
      Date,
      Primary.Type,
      Description,
      FBI.Code,
      Latitude,
      Longitude
    ) %>%
    mutate(crime = paste0(Primary.Type, " ", Description)) %>%
    rename(lat = Latitude, lon = Longitude, id = ID, ucr = FBI.Code) %>%
    mutate(
      city = "Chicago",
      date = parse_date_time(Date, "mdY HMS"),
      year = year(date)
    ) %>%
    select(id, date, year, crime, city, ucr, lat, lon) %>%
    mutate(
      ucr = substr(
        case_when(
          ucr == "08A" ~ "9", # These were all misclassified upon reading the descriptions, reassigning
          ucr == "08B" ~ "9",
          ucr == "09" ~ "8",
          .default = ucr
        ),
        1,
        2
      )
    ) %>%
    mutate_if(is.character, ~ trimws(.)) %>% # Remove leading/trailing whitespace
    left_join(
      nibrs_crosswalk %>% distinct(ucr, ucr_description, part, against),
      by = "ucr"
    )

  return(chicago_crime)
}

### Cincinnati ####
load_cincinnati_crime <- function(nibrs_crosswalk) {
  temp = list.files("data/crime/Cincinnati", pattern = "\\.csv$")
  cincinnati_crime = do.call(
    bind_rows,
    lapply(temp, function(x) {
      read.csv(paste0("data/crime/Cincinnati/", x), colClasses = "character")
    })
  ) %>% # Import all CSVs, merge together
    select(
      INCIDENT_NO,
      DATE_FROM,
      UCR,
      UCR_GROUP,
      OFFENSE,
      LATITUDE_X,
      LONGITUDE_X
    ) %>%
    rename(
      lat = LATITUDE_X,
      lon = LONGITUDE_X,
      id = INCIDENT_NO,
      date = DATE_FROM,
      crime = OFFENSE,
      part = UCR_GROUP,
      ucr = UCR
    ) %>%
    select(id, date, crime, ucr, part, lat, lon) %>%
    mutate(
      city = "Cincinnati",
      date = parse_date_time(date, "Ymd HMS"),
      year = year(date),
      ucr = case_when(
        part == "HOMICIDE" ~ "1",
        part == "RAPE" ~ "2",
        part == "ROBBERY" ~ "3",
        part == "AGGRAVATED ASSAULTS" ~ "4",
        part == "BURGLARY/BREAKING ENTERING" ~ "5",
        part == "THEFT" ~ "6",
        part == "UNAUTHORIZED USE" ~ "7",
        part == "PART 2 MINOR" & ucr %in% c("901", "920") ~ "8",
        part == "PART 2 MINOR" &
          substr(ucr, 1, 1) == "8" &
          nchar(ucr) == 3 ~ "9",
        part == "PART 2 MINOR" & nchar(ucr) == 4 ~ substr(ucr, 1, 2)
      )
    ) %>%
    select(-part) %>%
    mutate_if(is.character, ~ trimws(.)) %>% # Remove leading/trailing whitespace
    left_join(
      nibrs_crosswalk %>% distinct(ucr, ucr_description, part, against),
      by = "ucr"
    )

  cincinnati_crime_24_25 = read.csv(
    paste0(
      "data/crime/Cincinnati/2024-2025/Reported_Crime_(STARS_Category_Offenses)_on_or_after_6_3_2024_20250908.csv"
    ),
    colClasses = "character"
  ) %>% # Import all CSVs, merge together
    select(
      INCIDENT_NO,
      DateFrom,
      STARS_Category,
      type,
      LATITUDE_X,
      LONGITUDE_X
    ) %>%
    rename(
      lat = LATITUDE_X,
      lon = LONGITUDE_X,
      id = INCIDENT_NO,
      date = DateFrom,
      crime = STARS_Category,
      part = type
    ) %>%
    select(id, date, crime, part, lat, lon) %>%
    mutate(
      city = "Cincinnati",
      date = parse_date_time(date, "Ymd HMS"),
      year = year(date),
      ucr = case_when(
        part == "Part 2" ~ "26", # Other UCR Part 2 unknown
        crime == "Homicide" ~ "1",
        crime == "Rape" ~ "2",
        crime == "Robbery" ~ "3",
        crime == "Agg Assault" ~ "4",
        crime == "Strangulation" ~ "4",
        crime == "Burglary/BE" ~ "5",
        crime == "Personal/Other Theft" ~ "6",
        crime == "Theft from Auto" ~ "6",
        crime == "Auto Theft" ~ "7"
      )
    ) %>%
    select(-part) %>%
    mutate_if(is.character, ~ trimws(.)) %>% # Remove leading/trailing whitespace
    left_join(
      nibrs_crosswalk %>% distinct(ucr, ucr_description, part, against),
      by = "ucr"
    )

  # Filter to keep the years with enough data!
  # Cincinnati has spotty coverage pre-2011, so we will filter to 2011 and later
  cincinnati_crime <- cincinnati_crime %>%
    bind_rows(cincinnati_crime_24_25) %>%
    filter(year >= 2011)

  return(cincinnati_crime)
}

### Dallas ####
load_dallas_crime <- function(nibrs_crosswalk) {
  # we are missing data early in their reporting period (pre-2015)
  temp = list.files("data/crime/Dallas", pattern = "\\.csv$")
  dallas_crime = do.call(
    bind_rows,
    lapply(temp, function(x) {
      read.csv(paste0("data/crime/Dallas/", x), colClasses = "character")
    })
  ) %>% # Import all CSVs, merge together
    select(
      Incident.Number.w.year,
      Date1.of.Occurrence,
      NIBRS.Crime.Category,
      X.UCR.Code,
      NIBRS.Code,
      X.Coordinate,
      Y.Cordinate
    ) %>%
    rename(
      lat = X.Coordinate,
      lon = Y.Cordinate,
      id = Incident.Number.w.year,
      date = Date1.of.Occurrence,
      crime = NIBRS.Crime.Category,
      ucr = X.UCR.Code,
      nibrs = NIBRS.Code
    ) %>%
    select(id, date, crime, ucr, nibrs, lat, lon) %>%
    mutate(
      city = "Dallas",
      date = parse_date_time(substr(date, 1, 10), "Ymd"),
      year = year(date)
    ) %>%
    filter(lat != "" & lon != "") %>% #4092 cases are missing lat/lon, and 257499 are missing crime type
    st_as_sf(coords = c("lat", "lon"), crs = "ESRI:103545") %>%
    st_transform(crs = projcrs) %>% # Convert to project CRS
    mutate(lat = st_coordinates(.)[, 2], lon = st_coordinates(.)[, 1]) %>%
    st_drop_geometry() %>%
    mutate(
      ucr_clean = case_when(
        nchar(ucr) == 3 ~ substr(ucr, 1, 1),
        nchar(ucr) == 4 ~ substr(ucr, 1, nchar(ucr) - 3),
        .default = ucr
      )
    ) %>%
    select(-ucr) %>%
    left_join(nibrs_crosswalk, by = "nibrs") %>%
    mutate(
      ucr = case_when(
        is.na(ucr) ~ ucr_clean,
        !is.na(ucr) ~ ucr
      )
    )

  return(dallas_crime)
}

### Denver ####
load_denver_crime <- function(nibrs_crosswalk) {
  temp = list.files("data/crime/Denver", pattern = "\\.csv$")
  denver_crosswalk <- read.csv(
    "data/crime/Denver/Crosswalk/ucr_ext.csv",
    colClasses = "character"
  ) %>%
    rename(offense_code = ucr, offense_code_extension = ext, nibrs = ibr_code)

  denver_crime_10_19 = do.call(
    bind_rows,
    lapply(temp, function(x) {
      read.csv(
        paste0("data/crime/Denver/", x),
        col.names = c(
          "incident_id",
          "offense_id",
          "offense_code",
          "offense_code_extension",
          "offense_type_id",
          "offense_category_id",
          "first_occurrence_date",
          "last_occurrence_date",
          "reported_date",
          "incident_address",
          "geo_x",
          "geo_y",
          "geo_lon",
          "geo_lat",
          "district_id",
          "precinct_id",
          "neighborhood_id",
          "is_crime",
          "is_traffic",
          "victim_count"
        ),
        colClasses = "character"
      )
    })
  ) %>% # Import all CSVs, merge together
    select(
      incident_id,
      offense_code,
      offense_code_extension,
      offense_type_id,
      offense_category_id,
      first_occurrence_date,
      geo_lon,
      geo_lat
    ) %>%
    left_join(
      denver_crosswalk,
      by = c("offense_code", "offense_code_extension")
    ) %>%
    rename(
      lat = geo_lat,
      lon = geo_lon,
      id = incident_id,
      date = first_occurrence_date,
      crime = exp_translation
    ) %>%
    select(id, date, crime, nibrs, lat, lon) %>%
    mutate(
      city = "Denver",
      date = parse_date_time(date, "mdY HMS"),
      year = year(date),
      nibrs = trimws(nibrs)
    ) %>%
    mutate_if(is.character, ~ trimws(.)) %>% # Remove leading/trailing whitespace
    left_join(nibrs_crosswalk, by = "nibrs")

  denver_crime_20_25 <- read.csv(
    "data/crime/Denver/data_2020_2025/ODC_CRIME_OFFENSES_P_-3254178225590307312.csv",
    col.names = c(
      "objectid",
      "incident_id",
      "offense_id",
      "offense_code",
      "offense_code_extension",
      "offense_type_id",
      "offense_category_id",
      "first_occurrence_date",
      "last_occurrence_date",
      "reported_date",
      "incident_address",
      "geo_x",
      "geo_y",
      "geo_lon",
      "geo_lat",
      "district_id",
      "precinct_id",
      "neighborhood_id",
      "is_crime",
      "is_traffic",
      "victim_count",
      "x",
      "y"
    ),
    colClasses = "character"
  ) %>% # Import all CSVs, merge together
    select(
      incident_id,
      offense_code,
      offense_code_extension,
      offense_type_id,
      offense_category_id,
      first_occurrence_date,
      geo_lon,
      geo_lat
    ) %>%
    left_join(
      denver_crosswalk,
      by = c("offense_code", "offense_code_extension")
    ) %>%
    rename(
      lat = geo_lat,
      lon = geo_lon,
      id = incident_id,
      date = first_occurrence_date,
      crime = exp_translation
    ) %>%
    select(id, date, crime, nibrs, lat, lon) %>%
    mutate(
      city = "Denver",
      date = parse_date_time(date, "mdY HMS"),
      year = year(date),
      nibrs = trimws(nibrs)
    ) %>%
    mutate_if(is.character, ~ trimws(.)) %>% # Remove leading/trailing whitespace
    left_join(nibrs_crosswalk, by = "nibrs")

  denver_crime <- denver_crime_10_19 %>%
    bind_rows(denver_crime_20_25) %>%
    distinct(id, .keep_all = TRUE) # Remove duplicates

  return(denver_crime)
}

### Detroit ####
load_detroit_crime <- function(nibrs_crosswalk) {
  ## Excluding for now, only have data for 2017 onwards really, and the data is not making much sense
  detroit_codes <- read_xlsx("data/crime/Detroit/offense_codes.xlsx") %>%
    mutate(arrest_charge = as.character(arrest_charge))
  arrest_codes <- read_xlsx("data/crime/Detroit/arrest_code_crosswalk.xlsx")

  temp = list.files("data/crime/Detroit", pattern = "\\.csv$")
  detroit_crime = do.call(
    bind_rows,
    lapply(temp, function(x) {
      read.csv(paste0("data/crime/Detroit/", x), colClasses = "character")
    })
  ) %>% # Import all CSVs, merge together
    select(
      crime_id,
      offense_description,
      state_offense_code,
      arrest_charge,
      incident_occurred_at,
      longitude,
      latitude
    ) %>%
    rename(
      lat = latitude,
      lon = longitude,
      id = crime_id,
      date = incident_occurred_at,
      crime = offense_description
    ) %>%
    mutate(
      date = substr(date, 1, 19),
      arrest_charge = str_replace_all(arrest_charge, "[^[:alnum:]]", ""),
      state_offense_code = str_replace_all(
        state_offense_code,
        "[^[:alnum:]]",
        ""
      )
    ) %>%
    select(id, date, crime, state_offense_code, arrest_charge, lat, lon) %>%
    mutate(city = "Detroit") %>%
    left_join(detroit_codes, by = c("arrest_charge"))

  # Detroit has 14K records w/ missing NIBRS codes, so we will try to match them up, using the state offense codes matching to the arrest charges
  detroit_miss <- detroit_crime %>%
    ungroup() %>%
    filter(is.na(nibrs)) %>%
    select(-nibrs, -arrest_charge) %>%
    left_join(arrest_codes, by = "state_offense_code") %>%
    left_join(detroit_codes, by = c("arrest_charge")) %>% # This takes care of all but 2,253!
    mutate(
      nibrs = case_when(
        crime == "AGGRAVATED / FELONIOUS ASSAULT" & is.na(nibrs) ~ "13A",
        crime == "ASSAULT AND BATTERY/SIMPLE ASSAULT" & is.na(nibrs) ~ "13B",
        crime == "BURGLARY - FORCED ENTRY" & is.na(nibrs) ~ "220",
        crime == "BURGLARY - FORCED ENTRY -  RESIDENCE" & is.na(nibrs) ~ "220",
        crime == "CHILD NEGLECT" & is.na(nibrs) ~ "90F",
        crime == "COCAINE - POSSESS" & is.na(nibrs) ~ "35A",
        crime == "COMPUTER USED IN THE COMMISION OF CRIME" &
          is.na(nibrs) ~ "90Z",
        crime == "DAMAGE TO PRIVATE PROPERTY" & is.na(nibrs) ~ "90Z",
        crime == "DAMAGE TO PUBLIC PROPERTY" & is.na(nibrs) ~ "90Z",
        crime == "HEROIN - POSSESS" & is.na(nibrs) ~ "35A",
        crime == "HEROIN - SELL / MANUFACTURE" & is.na(nibrs) ~ "35A",
        crime == "HOMICIDE - JUSTIFIABLE" & is.na(nibrs) ~ "09C",
        crime == "LOST & FOUND PROPERTY" & is.na(nibrs) ~ "90Z",
        crime == "MARIJUANA - DELIVER" & is.na(nibrs) ~ "35B",
        crime == "MARIJUANA -POSSESS" & is.na(nibrs) ~ "35B",
        crime == "MURDER / NON-NEGLIGENT MANSLAUGHTER (VOLUNTARY)" &
          is.na(nibrs) ~ "09A",
        crime == "NEGLIGENT HOMICIDE - VEHICLE / BOAT / SNOWMOBILE / ORV" &
          is.na(nibrs) ~ "09B",
        crime == "NEGLIGENT HOMICIDE / MANSLAUGHTER (INVOLUNTARY)" &
          is.na(nibrs) ~ "09B",
        .default = nibrs
      )
    )

  detroit_crime <- detroit_crime %>%
    filter(!is.na(nibrs)) %>%
    bind_rows(detroit_miss) %>%
    mutate(date = parse_date_time(date, "Ymd HMS"), year = year(date)) %>%
    select(id, date, year, crime, nibrs, lat, lon) %>%
    mutate_if(is.character, ~ trimws(.)) %>% # Remove leading/trailing whitespace
    left_join(nibrs_crosswalk, by = "nibrs") %>%
    filter(year >= 2017) %>% # This is the year we start having solid data for Detroit
    mutate(city = "Detroit")

  return(detroit_crime)
}

### Los Angeles ####
load_los_angeles_crime <- function(nibrs_crosswalk) {
  # temp = list.files("Data/Crime/Los_Angeles",pattern="\\.csv$")
  # la_crime = do.call(bind_rows,lapply(temp, function(x) {read.csv(paste0("Data/Crime/Los_Angeles/",x),colClasses = "character")})) %>% # Import all CSVs, merge together
  #   select(DR_NO,DATE.OCC,Crm.Cd.Desc,LAT,LON) %>%
  #   rename(lat = LAT,
  #          lon = LON,
  #          id = DR_NO,
  #          date = DATE.OCC,
  #          crime = Crm.Cd.Desc) %>%
  #   select(id,date,crime,lat,lon) %>%
  #   mutate(city = "Los Angeles")

  # Switched to a new dataset, which contains 5 additional years of information, and filters to only Part I and II UCR crimes
  temp = list.files("data/crime/Los_Angeles/New", pattern = "\\.csv$")
  la_crime = do.call(
    bind_rows,
    lapply(temp, function(x) {
      read.csv(
        paste0("data/crime/Los_Angeles/New/", x),
        colClasses = "character"
      )
    })
  ) %>% # Import all CSVs, merge together
    select(
      INCIDENT_ID,
      INCIDENT_DATE,
      STAT_DESC,
      CATEGORY,
      CITY,
      LONGITUDE,
      LATITUDE
    ) %>%
    rename(
      lat = LATITUDE,
      lon = LONGITUDE,
      city = CITY,
      id = INCIDENT_ID,
      date = INCIDENT_DATE,
      crime = STAT_DESC,
      ucr = CATEGORY
    ) %>%
    select(id, date, crime, ucr, city, lat, lon) %>%
    #filter(city == "LOS ANGELES") %>% # This includes the whole LA county, uncomment to limit to just LA proper for now.
    mutate(city_orig = city, city = "Los Angeles") %>%
    mutate(
      ucr = case_when(
        ucr == "CRIMINAL HOMICIDE" ~ "1",
        ucr == "FORCIBLE RAPE" ~ "2",
        ucr == "ROBBERY" ~ "3",
        ucr == "AGGRAVATED ASSAULT" ~ "4",
        ucr == "BURGLARY" ~ "5",
        ucr == "LARCENY THEFT" ~ "6",
        ucr == "GRAND THEFT AUTO" ~ "7",
        ucr == "ARSON" ~ "8",
        ucr == "DISORDERLY CONDUCT" ~ "24",
        ucr == "DRUNK / ALCOHOL / DRUGS" ~ "18",
        ucr == "DRUNK DRIVING VEHICLE / BOAT" ~ "21",
        ucr == "FEDERAL OFFENSES W/O MONEY" ~ "26",
        ucr == "FEDERAL OFFENSES WITH MONEY" ~ "26",
        ucr == "FELONIES MISCELLANEOUS" ~ "26",
        ucr == "FORGERY" ~ "10",
        ucr == "FRAUD AND NSF CHECKS" ~ "11",
        ucr == "GAMBLING" ~ "19",
        ucr == "LIQUOR LAWS" ~ "22",
        ucr == "MISDEMEANORS MISCELLANEOUS" ~ "26",
        ucr == "NARCOTICS" ~ "18",
        ucr == "NON-AGGRAVATED ASSAULTS" ~ "9",
        ucr == "OFFENSES AGAINST FAMILY" ~ "20",
        ucr == "RECEIVING STOLEN PROPERTY" ~ "13",
        ucr == "SEX OFFENSES FELONIES" ~ "17",
        ucr == "SEX OFFENSES MISDEMEANORS" ~ "17",
        ucr == "VAGRANCY" ~ "25",
        ucr == "VANDALISM" ~ "14",
        ucr == "VEHICLE / BOATING LAWS" ~ "21",
        ucr == "WARRANTS" ~ "26",
        ucr == "WEAPON LAWS" ~ "15",
        .default = ucr
      )
    ) %>%
    mutate(date = parse_date_time(date, "mdY HMS"), year = year(date)) %>%
    mutate_if(is.character, ~ trimws(.)) %>% # Remove leading/trailing whitespace
    left_join(
      nibrs_crosswalk %>% distinct(ucr, ucr_description, part, against),
      by = "ucr"
    ) %>%
    filter(year >= 2005 & year <= 2023) # This is the year we start having solid data for LA

  return(la_crime)
}

### New York ####
load_new_york_crime <- function(nibrs_crosswalk) {
  # NYPD made my life very difficult by not providing a clean data set, so I had to do some manual work to get this to work
  # Mostly, they did not provide any kind of standardized UCR / NIBRS code, so I had to manually link the laws to the crime data, via a codebook which I thankfully found
  nyc_laws <- read_excel(
    "data/crime/New_York/Excel Listing of NYS Laws-January 2025.xlsx",
    col_types = c("text"),
    skip = 2
  ) %>%
    mutate(
      repeal = parse_date_time(REPEAL_DATE, "dby"),
      effective = parse_date_time(EFFECTIVE_DATE, "dby")
    ) %>%
    mutate(
      repeal = case_when(
        repeal > parse_date_time("01-JAN-2050", "dbY") ~ repeal - years(100),
        repeal < parse_date_time("01-JAN-2050", "dbY") ~ repeal,
        .default = NA
      ),
      effective = case_when(
        effective > parse_date_time("01-JAN-2050", "dbY") ~ effective -
          years(100),
        effective < parse_date_time("01-JAN-2050", "dbY") ~ effective,
        .default = NA
      )
    ) %>% # Correct for the 1900s
    filter(
      repeal > parse_date_time("01-JAN-2005", "dbY") | is.na(REPEAL_DATE)
    ) %>% # Keep only the laws which were in effect at least at the start of 2005
    rename(
      #ucr = `UCR Code`, # Not an accurate UCR code!
      nibrs = `IBR Code`
    ) %>%
    mutate(
      LAW_CODE = paste0(Title, " ", Section13, `Sub Section13`),
      LAW_CODE_alt = paste0(Title, " ", Section13),
      LAW_CODE_alt2 = substr(LAW_CODE_alt, 1, nchar(LAW_CODE_alt) - 1)
    ) %>%
    #group_by(LAW_CODE) %>%
    # mutate(ucr = min(ucr)) %>% # For laws which had been repealed with sub-sub-sections, assign the old "worst" crime classification value
    #  ungroup() %>%
    distinct(LAW_CODE, nibrs, .keep_all = TRUE) %>%
    left_join(nibrs_crosswalk, by = "nibrs")

  temp = list.files("data/crime/New_York", pattern = "\\.csv$")
  nyc_crime = do.call(
    bind_rows,
    lapply(temp, function(x) {
      read.csv(paste0("data/crime/New_York/", x), colClasses = "character")
    })
  ) %>% # Import all CSVs, merge together
    select(
      ARREST_KEY,
      ARREST_DATE,
      ARREST_BORO,
      LAW_CODE,
      OFNS_DESC,
      Latitude,
      Longitude
    ) %>%
    rename(
      lat = Latitude,
      lon = Longitude,
      id = ARREST_KEY,
      date = ARREST_DATE,
      crime = OFNS_DESC
    ) %>%
    select(id, date, crime, LAW_CODE, ARREST_BORO, lat, lon) %>%
    mutate(city = "New York")

  df_linked <- nyc_crime %>%
    left_join(nyc_laws, by = "LAW_CODE", relationship = "many-to-many") %>% # Match the NIBRS code by the NYS Law Code -- there will be dupes! Because laws change.
    select(
      id,
      date,
      LAW_CODE,
      ARREST_BORO,
      crime,
      nibrs,
      ucr,
      effective,
      repeal
    ) %>%
    group_by(id) %>%
    mutate(n = n())

  df_linked_miss <- df_linked %>%
    filter(is.na(nibrs)) %>% # These are the ones that didn't match, we will try to match them loosely
    mutate(
      LAW_CODE_spaced = case_when(
        LAW_CODE == "" | LAW_CODE == "(null)" ~ "",
        !grepl(" ", LAW_CODE, perl = TRUE) ~ paste0(
          substr(LAW_CODE, 1, 3),
          " ",
          substr(LAW_CODE, 4, nchar(LAW_CODE))
        ),
        .default = ""
      )
    )

  df_linked_miss_found <- df_linked_miss %>% # This contains the ones that just needed a space added, and matched successfully
    filter(LAW_CODE_spaced != "") %>%
    select(id, date, ARREST_BORO, LAW_CODE_spaced, crime) %>%
    rename(LAW_CODE = LAW_CODE_spaced) %>%
    left_join(nyc_laws, by = "LAW_CODE") %>%
    select(
      id,
      date,
      LAW_CODE,
      ARREST_BORO,
      crime,
      nibrs,
      ucr,
      effective,
      repeal
    ) %>%
    mutate(found = ifelse(is.na(nibrs), 0, 1)) %>%
    group_by(id) %>%
    mutate(n = n()) %>%
    ungroup()

  df_linked_miss_clean <- df_linked_miss_found %>% filter(found == 1) # Keep the matches here, will merge back in later, and will deal with duplicates later on
  df_linked_miss_step2 <- df_linked_miss_found %>%
    filter(found == 0) %>% # Separate out and deal with the non-matches here, merging back in the others that needed more than just a space added.
    bind_rows(df_linked_miss %>% filter(LAW_CODE_spaced == "")) %>%
    mutate(LAW_CODE_alt = substr(LAW_CODE, 1, nchar(LAW_CODE) - 2)) %>%
    select(id, date, ARREST_BORO, LAW_CODE_alt, LAW_CODE, crime)

  df_linked_miss_step2_found <- df_linked_miss_step2 %>%
    left_join(nyc_laws, by = "LAW_CODE_alt", relationship = "many-to-many") %>%
    rename(LAW_CODE = LAW_CODE.x) %>%
    select(
      id,
      date,
      LAW_CODE,
      ARREST_BORO,
      LAW_CODE_alt,
      crime,
      nibrs,
      ucr,
      effective,
      repeal
    ) %>%
    mutate(found = ifelse(is.na(nibrs), 0, 1)) %>%
    distinct(id, nibrs, .keep_all = TRUE) %>% # We only care about NIBRS class, so we can drop the dupes
    group_by(id) %>%
    mutate(n = n()) %>%
    ungroup()

  df_linked_miss_clean <- df_linked_miss_clean %>%
    bind_rows(df_linked_miss_step2_found %>% filter(found == 1)) # Keep the matches here, will merge back in later, and will deal with duplicates later on
  df_linked_miss_step3 <- df_linked_miss_step2_found %>%
    filter(found == 0) %>% # Separate out and deal with the non-matches here, merging back in the others that needed more than just a space added.
    mutate(LAW_CODE_alt2 = substr(LAW_CODE, 1, nchar(LAW_CODE) - 3)) %>% # Go even more general, up one level of classification
    select(id, date, ARREST_BORO, LAW_CODE_alt2, LAW_CODE, crime)

  df_linked_miss_step3_found <- df_linked_miss_step3 %>%
    left_join(nyc_laws, by = "LAW_CODE_alt2", relationship = "many-to-many") %>%
    rename(LAW_CODE = LAW_CODE.x) %>%
    select(
      id,
      date,
      LAW_CODE,
      ARREST_BORO,
      LAW_CODE_alt2,
      crime,
      nibrs,
      ucr,
      effective,
      repeal
    ) %>%
    mutate(found = ifelse(is.na(nibrs), 0, 1)) %>%
    distinct(id, nibrs, .keep_all = TRUE) %>% # We only care about NIBRS class, so we can drop the dupes
    group_by(id) %>%
    mutate(n = n()) %>%
    ungroup()

  df_linked_miss_clean <- df_linked_miss_clean %>%
    bind_rows(df_linked_miss_step3_found %>% filter(found == 1)) # Keep the matches here, will merge back in later, and will deal with duplicates later on

  # NOTE: There are still 39,000 cases that did not match. I manually reviewed them, they all appear to be administrative codes / cases that are not Category I/II index crimes, so we can safely ignore for this study.

  df_linked_clean <- df_linked %>%
    filter(!is.na(nibrs)) %>% # Filter to complete cases, so we can add in the cleaned cases below
    bind_rows(
      df_linked_miss_clean %>%
        select(
          id,
          date,
          LAW_CODE,
          ARREST_BORO,
          crime,
          nibrs,
          ucr,
          effective,
          repeal
        )
    ) %>% # Bring on the ones that are good to go and cleaned!
    group_by(id) %>%
    mutate(n = n())

  # Next I will take the ones that don't have a space and add a space at the 3rd character, then try to match again
  # Then, I will do a few rounds of taking off characters from the end of the string until I get a match
  # Then we re-combine, and proceed with the filtering as below

  df_linked_n1 <- df_linked_clean %>% filter(n == 1) # Keep the 1:1 matches here, will merge back in later
  df_linked_n2 <- df_linked_clean %>% # Separate out and deal with the M:M matches here
    filter(n > 1) %>%
    mutate(date = parse_date_time(date, "mdy")) %>%
    mutate(
      drop = case_when(
        (date < effective | date > repeal) ~ 1, # Keep the dupe that is in the effective/repeal range, drop if the law does not apply due to timing
        .default = 0
      )
    ) %>%
    group_by(id) %>%
    mutate(drop_sum = sum(drop))

  df_linked_n2_good <- df_linked_n2 %>%
    filter((drop_sum == 1 & drop == 0 & n == 2)) # These are no longer dupes, we were ablel to deal with them just by date filtering for applicable laws
  df_linked_n2_dupes <- df_linked_n2 %>%
    filter(!(drop_sum == 1 & n == 2)) %>% # These are still dupes, we will need to filter them further. Using the standard UCR method, we will assign the "Worst" crime within each, as reasonable.
    group_by(id) %>%
    mutate(
      min_ucr = min(ucr),
      max_effective = max(effective),
      drop = case_when(
        ucr != min_ucr ~ 1,
        ucr == min_ucr & effective != max_effective ~ 1,
        .default = 0
      ),
      drop_sum = sum(drop)
    ) %>%
    ungroup()

  df_linked_n2_good <- df_linked_n2_good %>%
    rbind(df_linked_n2_dupes %>% filter(drop_sum == 1 & drop == 0)) # These are no longer dupes, we were able to deal with them just by date filtering for applicable laws
  df_linked_n3_dupes <- df_linked_n2_dupes %>%
    filter(drop_sum != 1) %>% # These are still dupes, and they occurred in a window between when changed laws were enacted. So we need to pick one. Going with the "worse crime" per UCR.
    group_by(id) %>%
    mutate(
      min_ucr = min(ucr),
      max_effective = max(effective),
      drop = case_when(
        ucr != min_ucr ~ 1,
        ucr == min_ucr & nibrs == "13B" ~ 1, # Where there are UCR ties, we use the worse NIBRS classification
        ucr == min_ucr & nibrs == "26B" ~ 1, # Same as above
        crime == "PROSTITUTION & RELATED OFFENSES" & nibrs != "40B" ~ 1, # Special case w/ prostitution. Not an index crime, but still cleaning it.
        .default = 0
      ),
      drop_sum = sum(drop)
    ) %>%
    ungroup()

  df_linked_n2_n3_good <- df_linked_n2_good %>%
    rbind(df_linked_n3_dupes %>% filter(drop == 0)) %>% # These are no longer dupes!
    mutate(date = as.character(date))

  df_linked_flat <- rbind(df_linked_n1, df_linked_n2_n3_good) %>% # Combine back together, now we have 1 record per match!
    select(id, nibrs) # Combine back together, now we have 1 record per match! Some didn't match still though, we will now loosely match the remaining.

  nyc_crime <- nyc_crime %>%
    left_join(df_linked_flat, by = "id") %>% # Merge back in the 1:1 matches!
    mutate(
      date = parse_date_time(date, "mdy"),
      year = year(date),
      crime = case_when(
        is.na(crime) ~ LAW_CODE, # Assign the law code here when the crime category is missing
        !is.na(crime) ~ crime,
        crime == "" ~ LAW_CODE
      ),
      nibrs = case_when(
        is.na(nibrs) ~ "999", # Assign missing value here
        !is.na(nibrs) ~ nibrs
      )
    ) %>% # Keep the matched value
    select(id, date, year, ARREST_BORO, crime, nibrs, city, lat, lon) %>%
    mutate_if(is.character, ~ trimws(.)) %>% # Remove leading/trailing whitespace
    left_join(nibrs_crosswalk, by = "nibrs", relationship = "many-to-many") # FINAL dataset for NYC! Phew!

  return(nyc_crime)
}

### Philadelphia ####
load_philadelphia_crime <- function(nibrs_crosswalk) {
  temp = list.files("data/crime/Philadelphia", pattern = "\\.csv$")
  philadelphia_crime = do.call(
    bind_rows,
    lapply(temp, function(x) {
      read.csv(paste0("data/crime/Philadelphia/", x), colClasses = "character")
    })
  ) %>% # Import all CSVs, merge together
    select(
      objectid,
      dispatch_date,
      text_general_code,
      ucr_general,
      lat,
      lng
    ) %>%
    rename(
      crime = text_general_code,
      ucr = ucr_general,
      lon = lng,
      date = dispatch_date,
      id = objectid
    ) %>%
    mutate(
      city = "Philadelphia",
      ucr = case_when(
        ucr == "800" & crime == "Other Assaults" ~ "9",
        ucr == "900" & crime == "Arson" ~ "8",
        .default = substr(ucr, 1, nchar(ucr) - 2)
      )
    ) %>%
    mutate(date = parse_date_time(date, "Ymd"), year = year(date)) %>%
    mutate_if(is.character, ~ trimws(.)) %>% # Remove leading/trailing whitespace
    left_join(
      nibrs_crosswalk %>% distinct(ucr, ucr_description, part, against),
      by = "ucr"
    )

  return(philadelphia_crime)
}

### Raleigh ####
load_raleigh_crime <- function(nibrs_crosswalk) {
  raleigh_crosswalk <- read_xlsx("data/crime/Raleigh/RPD_LCRtoNIBRS.xlsx") %>%
    rename(nibrs = NIBRS_CODE, crime_code = CRIME_CODE) %>%
    select(crime_code, nibrs)

  temp = list.files("data/crime/Raleigh", pattern = "\\.csv$")
  raleigh_crime = do.call(
    bind_rows,
    lapply(temp, function(x) {
      read.csv(paste0("data/crime/Raleigh/", x), colClasses = "character")
    })
  ) %>% # Import all CSVs, merge together
    select(
      OBJECTID,
      crime_code,
      crime_description,
      crime_type,
      reported_date,
      latitude,
      longitude
    ) %>%
    left_join(raleigh_crosswalk, by = "crime_code") %>%
    rename(
      lat = latitude,
      lon = longitude,
      id = OBJECTID,
      date = reported_date,
      crime = crime_description
    ) %>%
    mutate(
      #date = substr(date,1,19),
      crime = toupper(crime)
    ) %>%
    mutate(
      city = "Raleigh",
      date = parse_date_time(date, "mdY HMS"),
      year = year(date)
    ) %>%
    mutate_if(is.character, ~ trimws(.)) %>% # Remove leading/trailing whitespace
    left_join(nibrs_crosswalk, by = "nibrs") %>%
    select(
      id,
      date,
      year,
      crime,
      nibrs,
      city,
      lat,
      lon,
      ucr,
      ucr_description,
      part,
      against
    )

  return(raleigh_crime)
}

### San Francisco ####
load_san_francisco_crime <- function(nibrs_crosswalk) {
  sf_crosswalk <- read_csv(
    "data/crime/San_Francisco/Crosswalk/Reference__Police_Department_Incident_Code_Crosswalk_20250306.csv"
  ) %>%
    rename(
      inc_code = INC_CODE,
      ucr_cat = CATEGORY,
      ucr_subcat = SUBCATEGORY
    ) %>%
    mutate(
      ucr = case_when(
        ucr_cat == "arson" & ucr_subcat == "arson" ~ "8",
        ucr_cat == "assault" & ucr_subcat == "aggravated assault" ~ "4",
        ucr_cat == "assault" & ucr_subcat == "simple assault" ~ "9",
        ucr_cat == "burglary" & ucr_subcat == "burglary - commercial" ~ "5",
        ucr_cat == "burglary" & ucr_subcat == "burglary - hot prowl" ~ "5",
        ucr_cat == "burglary" & ucr_subcat == "burglary - other" ~ "5",
        ucr_cat == "burglary" & ucr_subcat == "burglary - residential" ~ "5",
        ucr_cat == "case closure" & ucr_subcat == "case closure" ~ "26",
        ucr_cat == "civil sidewalks" & ucr_subcat == "other" ~ "26",
        ucr_cat == "courtesy report" & ucr_subcat == "courtesy report" ~ "26",
        ucr_cat == "disorderly conduct" &
          ucr_subcat == "disorderly conduct" ~ "24",
        ucr_cat == "disorderly conduct" & ucr_subcat == "drug violation" ~ "24",
        ucr_cat == "disorderly conduct" & ucr_subcat == "drunkenness" ~ "24",
        ucr_cat == "disorderly conduct" & ucr_subcat == "intimidation" ~ "24",
        ucr_cat == "disorderly conduct" & ucr_subcat == "loitering" ~ "24",
        ucr_cat == "disorderly conduct" & ucr_subcat == "other" ~ "24",
        ucr_cat == "disorderly conduct" & ucr_subcat == "trespass" ~ "24",
        ucr_cat == "disorderly conduct" &
          ucr_subcat == "weapons offense" ~ "15",
        ucr_cat == "drug offense" & ucr_subcat == "drug violation" ~ "18",
        ucr_cat == "drug violation" & ucr_subcat == "drug violation" ~ "18",
        ucr_cat == "embezzlement" & ucr_subcat == "embezzlement" ~ "12",
        ucr_cat == "family offense" & ucr_subcat == "child abuse" ~ "20",
        ucr_cat == "fire report" & ucr_subcat == "fire report" ~ "26",
        ucr_cat == "forgery and counterfeiting" &
          ucr_subcat == "forgery and counterfeiting" ~ "10",
        ucr_cat == "fraud" & ucr_subcat == "bad checks" ~ "11",
        ucr_cat == "fraud" & ucr_subcat == "fraud" ~ "11",
        ucr_cat == "gambling" & ucr_subcat == "gambling" ~ "19",
        ucr_cat == "homicide" & ucr_subcat == "homicide" ~ "1",
        ucr_cat == "homicide" & ucr_subcat == "homicide - excusable" ~ "26", # Not a crime
        ucr_cat == "homicide" & ucr_subcat == "homicide - justifiable" ~ "26", # Not a crime
        ucr_cat == "homicide" & ucr_subcat == "manslaughter" ~ "1",
        ucr_cat == "human trafficking (a), commercial sex acts" &
          ucr_subcat == "human trafficking (a), commercial sex act" ~ "16",
        ucr_cat == "human trafficking (a), commercial sex acts" &
          ucr_subcat == "human trafficking (a), commercial sex acts" ~ "16",
        ucr_cat == "human trafficking (a), commercial sex acts" &
          ucr_subcat == "human trafficking, commercial sex acts" ~ "16",
        ucr_cat == "human trafficking (b), involuntary servitude" &
          ucr_subcat == "human trafficking, involuntary servitude" ~ "16",
        ucr_cat == "human trafficking, commercial sex acts" &
          ucr_subcat == "human trafficking, commercial sex acts" ~ "16",
        ucr_cat == "human trafficking, involuntary servitude" &
          ucr_subcat == "human trafficking, involuntary servitude" ~ "16",
        ucr_cat == "juvenile offenses" & ucr_subcat == "family offenses" ~ "20",
        ucr_cat == "juvenile offenses" & ucr_subcat == "other" ~ "26",
        ucr_cat == "juvenile offenses" & ucr_subcat == "runaway" ~ "29",
        ucr_cat == "larceny theft" & ucr_subcat == "larceny - auto parts" ~ "6",
        ucr_cat == "larceny theft" &
          ucr_subcat == "larceny - from vehicle" ~ "6",
        ucr_cat == "larceny theft" &
          ucr_subcat == "larceny theft - bicycle" ~ "6",
        ucr_cat == "larceny theft" &
          ucr_subcat == "larceny theft - from building" ~ "6",
        ucr_cat == "larceny theft" &
          ucr_subcat == "larceny theft - other" ~ "6",
        ucr_cat == "larceny theft" &
          ucr_subcat == "larceny theft - pickpocket" ~ "6",
        ucr_cat == "larceny theft" &
          ucr_subcat == "larceny theft - purse snatch" ~ "6",
        ucr_cat == "larceny theft" &
          ucr_subcat == "larceny theft - shoplifting" ~ "6",
        ucr_cat == "larceny theft" & ucr_subcat == "theft from vehicle" ~ "6",
        ucr_cat == "liquor laws" & ucr_subcat == "liquor law violation" ~ "22",
        ucr_cat == "lost property" & ucr_subcat == "lost property" ~ "26",
        ucr_cat == "malicious mischief" & ucr_subcat == "other" ~ "26",
        ucr_cat == "malicious mischief" & ucr_subcat == "vandalism" ~ "14",
        ucr_cat == "miscellaneous investigation" &
          ucr_subcat == "miscellaneous investigation" ~ "26",
        ucr_cat == "miscellaneous investigation" & ucr_subcat == "other" ~ "26",
        ucr_cat == "missing person" & ucr_subcat == "missing adult" ~ "26",
        ucr_cat == "missing person" & ucr_subcat == "missing juvenile" ~ "26",
        ucr_cat == "missing person" & ucr_subcat == "missing person" ~ "26",
        ucr_cat == "motor vehicle theft" &
          ucr_subcat == "motor vehicle theft" ~ "7",
        ucr_cat == "motor vehicle theft" &
          ucr_subcat == "motor vehicle theft (attempted)" ~ "7",
        ucr_cat == "motor vehicle theft?" &
          ucr_subcat == "motor vehicle theft" ~ "7",
        ucr_cat == "non-criminal" & ucr_subcat == "non-criminal" ~ "26",
        ucr_cat == "non-criminal" & ucr_subcat == "other" ~ "26",
        ucr_cat == "offences against the family and children" &
          ucr_subcat == "drug violation" ~ "20",
        ucr_cat == "offences against the family and children" &
          ucr_subcat == "family offenses" ~ "20",
        ucr_cat == "offences against the family and children" &
          ucr_subcat == "intimidation" ~ "20",
        ucr_cat == "offences against the family and children" &
          ucr_subcat == "kidnapping" ~ "20",
        ucr_cat == "offences against the family and children" &
          ucr_subcat == "loitering" ~ "20",
        ucr_cat == "offences against the family and children" &
          ucr_subcat == "other" ~ "20",
        ucr_cat == "offences against the family and children" &
          ucr_subcat == "stalking" ~ "20",
        ucr_cat == "other" & ucr_subcat == "other" ~ "26",
        ucr_cat == "other miscellaneous" & ucr_subcat == "arrest" ~ "26",
        ucr_cat == "other miscellaneous" & ucr_subcat == "bribery" ~ "26",
        ucr_cat == "other miscellaneous" &
          ucr_subcat == "disorderly conduct" ~ "24",
        ucr_cat == "other miscellaneous" & ucr_subcat == "fraud" ~ "11",
        ucr_cat == "other miscellaneous" &
          ucr_subcat == "extortion-blackmail" ~ "26",
        ucr_cat == "other miscellaneous" & ucr_subcat == "intimidation" ~ "26",
        ucr_cat == "other miscellaneous" &
          ucr_subcat == "larceny theft - other" ~ "6",
        ucr_cat == "other miscellaneous" & ucr_subcat == "kidnapping" ~ "26",
        ucr_cat == "other miscellaneous" &
          ucr_subcat == "liquor law violation" ~ "22",
        ucr_cat == "other miscellaneous" & ucr_subcat == "loitering" ~ "25",
        ucr_cat == "other miscellaneous" & ucr_subcat == "simple assault" ~ "9",
        ucr_cat == "other miscellaneous" & ucr_subcat == "other" ~ "26",
        ucr_cat == "other miscellaneous" &
          ucr_subcat == "suspicious occ" ~ "26",
        ucr_cat == "other miscellaneous" &
          ucr_subcat == "weapons offense" ~ "15",
        ucr_cat == "other miscellaneous" & ucr_subcat == "trespass" ~ "26",
        ucr_cat == "other offenses" & ucr_subcat == "other" ~ "26",
        ucr_cat == "other offenses" & ucr_subcat == "other offenses" ~ "26",
        ucr_cat == "rape" & ucr_subcat == "rape" ~ "2",
        ucr_cat == "rape" & ucr_subcat == "rape - attempted" ~ "2",
        ucr_cat == "prostitution" & ucr_subcat == "prostitution" ~ "16",
        ucr_cat == "robbery" & ucr_subcat == "robbery - carjacking" ~ "3",
        ucr_cat == "robbery" & ucr_subcat == "robbery - commercial" ~ "3",
        ucr_cat == "robbery" & ucr_subcat == "robbery - other" ~ "3",
        ucr_cat == "robbery" & ucr_subcat == "robbery - residential" ~ "3",
        ucr_cat == "robbery" & ucr_subcat == "robbery - street" ~ "3",
        ucr_cat == "recovered vehicle" &
          ucr_subcat == "recovered vehicle" ~ "26",
        ucr_cat == "sex offense" & ucr_subcat == "child abuse" ~ "20",
        ucr_cat == "sex offense" & ucr_subcat == "prostitution" ~ "16",
        ucr_cat == "sex offense" & ucr_subcat == "sex offense" ~ "17",
        ucr_cat == "stolen property" & ucr_subcat == "stolen property" ~ "6",
        ucr_cat == "sex offense" & ucr_subcat == "sex offense, child" ~ "17",
        ucr_cat == "suicide" & ucr_subcat == "suicide" ~ "26",
        ucr_cat == "suspicious" & ucr_subcat == "suspicious package" ~ "26",
        ucr_cat == "suspicious occ" & ucr_subcat == "suspicious occ" ~ "26",
        ucr_cat == "traffic collision" &
          ucr_subcat == "traffic collision" ~ "26",
        ucr_cat == "traffic collision" &
          ucr_subcat == "traffic collision - hit & run" ~ "26",
        ucr_cat == "vandalism" & ucr_subcat == "vandalism" ~ "14",
        ucr_cat == "traffic violation arrest" &
          ucr_subcat == "traffic violation arrest" ~ "26",
        ucr_cat == "vehicle impounded" &
          ucr_subcat == "vehicle impounded" ~ "26",
        ucr_cat == "vehicle misplaced" &
          ucr_subcat == "vehicle misplaced" ~ "26",
        ucr_cat == "warrant" & ucr_subcat == "other" ~ "26",
        ucr_cat == "weapons carrying etc" &
          ucr_subcat == "weapons offense" ~ "15",
        ucr_cat == "weapons offence" & ucr_subcat == "weapons offense" ~ "15",
        ucr_cat == "weapons offense" & ucr_subcat == "weapons offense" ~ "15",
        ucr_cat == "warrant" & ucr_subcat == "warrant" ~ "26"
      )
    )

  temp = list.files("data/crime/San_Francisco", pattern = "\\.csv$")
  sf_crime = do.call(
    bind_rows,
    lapply(temp, function(x) {
      read.csv(paste0("data/crime/San_Francisco/", x), colClasses = "character")
    })
  ) %>% # Import all CSVs, merge together
    select(
      Incident.ID,
      IncidntNum,
      Incident.Code,
      Incident.Date,
      Date,
      Incident.Description,
      Descript,
      Latitude,
      Longitude,
      X,
      Y
    ) %>%
    mutate(
      id = case_when(
        is.na(Incident.ID) & !is.na(IncidntNum) ~ IncidntNum,
        !is.na(Incident.ID) & is.na(IncidntNum) ~ Incident.ID
      ),
      date = case_when(
        is.na(Incident.Date) & !is.na(Date) ~ Date,
        !is.na(Incident.Date) & is.na(Date) ~ Incident.Date
      ),
      crime = case_when(
        is.na(Incident.Description) & !is.na(Descript) ~ Descript,
        !is.na(Incident.Description) & is.na(Descript) ~ Incident.Description
      ),
      inc_code = Incident.Code,
      lat = case_when(
        is.na(Latitude) & !is.na(Y) ~ Y,
        !is.na(Latitude) & is.na(Y) ~ Latitude
      ),
      lon = case_when(
        is.na(Longitude) & !is.na(X) ~ X,
        !is.na(Longitude) & is.na(X) ~ Longitude
      )
    ) %>%
    mutate(city = "San Francisco") %>%
    left_join(sf_crosswalk, by = "inc_code") %>%
    select(id, date, crime, ucr, lat, lon, city) %>%
    mutate(
      dt = date,
      src = case_when(
        substr(date, 5, 5) == "/" ~ 1,
        substr(date, 3, 3) == "/" ~ 0
      ),
      date = case_when(
        substr(date, 5, 5) == "/" ~ parse_date_time(date, "Ymd"),
        substr(date, 3, 3) == "/" ~ parse_date_time(date, "mdY")
      ),
      year = year(date)
    ) %>%
    filter(!(src == 0 & year == 2018)) %>% # Filter out the 2018 data that is doubly counted by the second file
    mutate_if(is.character, ~ trimws(.)) %>% # Remove leading/trailing whitespace
    left_join(
      nibrs_crosswalk %>% distinct(ucr, ucr_description, part, against),
      by = "ucr"
    ) %>%
    select(-dt, -src)

  return(sf_crime)
}

### Seattle ####
load_seattle_crime <- function(nibrs_crosswalk) {
  temp = list.files("data/crime/Seattle", pattern = "\\.csv$")
  seattle_crime = do.call(
    bind_rows,
    lapply(temp, function(x) {
      read.csv(paste0("data/crime/Seattle/", x), colClasses = "character")
    })
  ) %>% # Import all CSVs, merge together
    select(
      Offense.ID,
      NIBRS_offense_code,
      Offense.Date,
      NIBRS.Offense.Code.Description,
      Latitude,
      Longitude
    ) %>%
    rename(
      lat = Latitude,
      lon = Longitude,
      id = Offense.ID,
      date = Offense.Date,
      nibrs = NIBRS_offense_code,
      crime = NIBRS.Offense.Code.Description
    ) %>%
    select(id, date, crime, nibrs, lat, lon) %>%
    mutate(city = "Seattle") %>%
    mutate(date = parse_date_time(date, "Ymd HMS"), year = year(date)) %>%
    select(id, date, year, crime, city, nibrs, lat, lon) %>%
    mutate_if(is.character, ~ trimws(.)) %>% # Remove leading/trailing whitespace
    left_join(nibrs_crosswalk, by = "nibrs")

  # Filter to keep the years with enough data!
  # Seattle has spotty coverage pre-2008, so we will filter to 2008 and later
  seattle_crime <- seattle_crime %>% filter(year >= 2008)

  return(seattle_crime)
}

### Washington DC ####
load_washington_crime <- function(nibrs_crosswalk) {
  temp = list.files("data/crime/Washington_DC", pattern = "\\.csv$")
  washington_dc_crime = do.call(
    bind_rows,
    lapply(temp, function(x) {
      read.csv(paste0("data/crime/Washington_DC/", x), colClasses = "character")
    })
  ) %>% # Import all CSVs, merge together
    select(OBJECTID, START_DATE, LATITUDE, LONGITUDE, OFFENSE) %>%
    rename(
      lat = LATITUDE,
      lon = LONGITUDE,
      id = OBJECTID,
      date = START_DATE,
      crime = OFFENSE
    ) %>%
    select(id, date, crime, lat, lon) %>%
    mutate(
      city = "Washington",
      ucr = case_when(
        crime == "HOMICIDE" ~ "1",
        crime == "SEX ABUSE" ~ "2",
        crime == "ROBBERY" ~ "3",
        crime == "ASSAULT W/DANGEROUS WEAPON" ~ "4",
        crime == "BURGLARY" ~ "5",
        crime == "THEFT/OTHER" ~ "6",
        crime == "THEFT F/AUTO" ~ "6",
        crime == "MOTOR VEHICLE THEFT" ~ "7",
        crime == "ARSON" ~ "8",
      )
    ) %>%
    mutate(date = lubridate::as_datetime(date), year = year(date)) %>%
    select(id, date, year, crime, ucr, city, lat, lon) %>%
    mutate_if(is.character, ~ trimws(.)) %>% # Remove leading/trailing whitespace
    left_join(nibrs_crosswalk %>% distinct(ucr, .keep_all = TRUE), by = "ucr")

  # Filter to keep the years with enough data!
  # washington_dc has spotty coverage pre-2008, so we will filter to 2008 and later
  washington_dc_crime <- washington_dc_crime %>%
    filter(year >= 2008 & year <= 2024)

  return(washington_dc_crime)
}

######## Crime Geography Filtering
crime_geo_filter <- function(ingested_crimes, nibrs_crosswalk, projcrs) {
  ingested_crimes %>% # Clear obs w/ missing data, filter to only >= 2004 & <= 2024
    filter(is.na(drop)) %>%
    mutate(lat = as.numeric(lat), lon = as.numeric(lon)) %>%
    filter(!is.na(lat) & !is.na(lon)) %>%
    mutate(crime = toupper(crime)) %>%
    filter(
      date >= parse_date_time("01/01/2004 00:00:00", orders = c("mdyHMS")) &
        date < parse_date_time("01/01/2025 00:00:00", orders = c("mdyHMS"))
    ) %>%
    mutate(ucr = as.numeric(ucr)) %>%
    filter(ucr < 9) %>% # We only want index crimes! Comment this out to include all crime
    group_by(city, id) %>% # Deduplicate incidents with multiple records (post-NIBRS transition) -- keeping the one with the worst crime (UCR classification)
    mutate(n = n(), min_ucr = min(ucr)) %>%
    ungroup() %>%
    arrange(id, ucr) %>%
    filter(n == 1 | (n > 1 & ucr == min(ucr))) %>% # This will keep those with 1 incident record per ID, OR it will select the incident record with the worst associated crime per incident, where there are mismatched UCRs.
    distinct(city, id, .keep_all = TRUE) %>% # We still have some ties with multiple crimes per incident scored at the same UCR, so we randomly keep one of them.
    select(-n, -min_ucr) %>%
    select(-ucr_description, -part, -against) %>% # Reassign UCR classes in case any didn't transfer over
    left_join(
      nibrs_crosswalk %>%
        distinct(ucr, ucr_description, part, against) %>%
        mutate(ucr = as.numeric(ucr)),
      by = "ucr"
    ) %>%
    mutate(
      homicide = ifelse(ucr == 1, 1, 0),
      rape = ifelse(ucr == 2, 1, 0),
      robbery = ifelse(ucr == 3, 1, 0),
      agg_assault = ifelse(ucr == 4, 1, 0),
      burglary = ifelse(ucr == 5, 1, 0),
      larceny = ifelse(ucr == 6, 1, 0),
      mv_theft = ifelse(ucr == 7, 1, 0),
      arson = ifelse(ucr == 8, 1, 0),
      part2 = ifelse(ucr > 9, 1, 0)
    ) %>%
    mutate(
      person = ifelse(against == "Person", 1, 0), # Converting against to be a category of its own, so we can count crimes using it
      property = ifelse(against == "Property", 1, 0),
      violent = 1 # This is for later use grouping all crimes together, as we have by definition filtered to only violent crimes
    ) %>%
    st_as_sf(., coords = c("lon", "lat"), crs = "EPSG:4269") %>%
    st_transform(crs = projcrs) %>% # Reproject to equal area coords
    filter(
      (city == "Atlanta" & (year %in% 2005:2016)) |
        (city == "Austin" & (year %in% 2004:2023)) |
        (city == "Baltimore" & (year %in% 2011:2023)) |
        (city == "Boston" & (year %in% 2015:2023)) |
        (city == "Chicago" & (year %in% 2004:2023)) |
        (city == "Cincinnati" & (year %in% 2011:2023)) |
        (city == "Dallas" & (year %in% 2015:2024)) |
        (city == "Denver" & (year %in% 2010:2023)) |
        (city == "Detroit" & (year %in% 2017:2023)) |
        (city == "Los Angeles" & (year %in% 2005:2023)) |
        (city == "New York" & (year %in% 2006:2023)) |
        (city == "Philadelphia" & (year %in% 2006:2023)) |
        (city == "Raleigh" & (year %in% 2016:2023)) |
        (city == "Seattle" & (year %in% 2008:2023)) |
        (city == "San Francisco" & (year %in% 2004:2023)) |
        (city == "Washington" & (year %in% 2008:2023))
    )
}
