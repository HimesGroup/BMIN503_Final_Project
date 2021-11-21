################################################
################################################
# Create dataset for BMIN503 Final Project
################################################
################################################

# load libraries
library(tidyverse)
library(lubridate)
library(MMWRweek)
library(data.table)
library(RSocrata)
library(magrittr)


##########################
##########################
# Explanatory variables
##########################
##########################

############################
# county-level vaccine data
############################

# downloaded from https://data.cdc.gov/Vaccinations/COVID-19-Vaccinations-in-the-United-States-County/8xkx-amqh

login <- readLines("../final_project_login.txt")
cdc_vacc <- read.socrata("https://data.cdc.gov/resource/8xkx-amqh.csv",
                       app_token = login[1],
                       email = login[2],
                       password = login[3]
)

# filter and reformat data
coun_name <- "phila|bucks|chester|montgom|dela|camden|burlin|glouc|new castle" # counties of interest
cdc_coun <- cdc_vacc %>%
  filter(recip_state %in% c("PA", "NJ", "DE") &
           (recip_county %ilike% coun_name | (recip_state == "NJ" & 
                                                recip_county %ilike% "Mercer"))) %>%
  mutate(series_complete_yes = as.numeric(series_complete_yes),
         date = date %>% ymd) %>%
  mutate(MMWRweek(date)) %>% # reformat based on MMWR week
  rename_at(.vars = vars(contains("MMWR")), .funs = ~ gsub("mmwr", "mmwr_",
                                                           tolower(.x))) %>%
  mutate(year_week = ifelse(mmwr_week < 10, paste0(mmwr_year, " - ", "0", mmwr_week),
                            paste0(mmwr_year, " - ", mmwr_week))) %>% # combine year with
                                                                      # MMWR week
  rename(fully_vaccinated = series_complete_yes,
         fully_vacc_per_pop = series_complete_pop_pct) %>%
  arrange(recip_county, desc(date)) %>%
  mutate(new_vaccinations = fully_vaccinated) %>%
  select(date, recip_county, fully_vacc_per_pop, fully_vaccinated, 
         new_vaccinations, year_week) 


# transform vaccine point prevalence data into time-series data
counties <- c("Philadelphia County", "Bucks County",
              "Chester County", "Delaware County",
              "Montgomery County", "Burlington County",
              "Gloucester County", "Camden County", 
              "Mercer County", "New Castle County")

county_new <- data.frame()
for (county in counties) {
  county_data <- cdc_coun %>% filter(recip_county == county)
  for (i in 1:nrow(county_data) - 1) {
    county_data$new_vaccinations[i] = county_data$fully_vaccinated[i] -  # subtracts yesterday's
      county_data$fully_vaccinated[i + 1]                                # vaccine numbers from today
  }                                                                      # to get n of new vaccinations
  county_new <- rbind(county_new, county_data)
}


# aggregate vaccine data by county and MMWR week 
county_agg <- county_new %>% 
  filter(between(date, "2020-02-15", "2021-10-09")) %>%
  group_by(recip_county, year_week) %>%
  summarize(vacc_incidence_n = mean(new_vaccinations), # var for mean of new fully vaccinated individuals that week
            mean_per_pop_fully_vacc = mean(fully_vacc_per_pop), # var for mean percent of population vaccinated that week 
            mean_fully_vacc_n = mean(fully_vaccinated)) %>% # var for mean fully vaccinated ind. that week 
  arrange(recip_county, year_week)


##############################
# Google social mobility data
##############################

import_google <- function(url) { # function to read and filter data from URLs
  df <- read_csv(url, col_types = cols(.default = col_character())) %>%
    filter(sub_region_1 %in% c("Pennsylvania", "New Jersey", "Delaware"))
  return(df)
}

# get data from 2020 and 2021 mobility reports
url1 <- "https://www.gstatic.com/covid19/mobility/2020_US_Region_Mobility_Report.csv"
url2 <- "https://www.gstatic.com/covid19/mobility/2021_US_Region_Mobility_Report.csv"

# combine dfs into one
google_df <- bind_rows(import_google(url1), import_google(url2))

# filter and reformat Google data
coun_g <- google_df %>% mutate(date = date %>% ymd) %>%
  filter(between(date, "2020-02-15", "2021-10-09") &
    (sub_region_2 %ilike% coun_name | (sub_region_1 == "New Jersey" & 
                                     sub_region_2 %ilike% "Mercer County"))) %>%
  mutate(MMWRweek(date)) %>%
  rename_at(.vars = vars(contains("MMWR")), .funs = ~ gsub("mmwr", "mmwr_",
                                                           tolower(.x))) %>%
  mutate(year_week = ifelse(mmwr_week < 10, paste0(mmwr_year, " - ", "0", mmwr_week),
                            paste0(mmwr_year, " - ", mmwr_week))) %>%
  select(sub_region_2, year_week, 
         retail_and_recreation_percent_change_from_baseline,
         grocery_and_pharmacy_percent_change_from_baseline,
         parks_percent_change_from_baseline,
         transit_stations_percent_change_from_baseline,
         workplaces_percent_change_from_baseline,
         residential_percent_change_from_baseline) %>%
  arrange(sub_region_2, year_week)

# calculate mean social mobility score by week
coun_g[3:8] <- sapply(coun_g[3:8], as.numeric) # convert social mobility vars to numeric

google_week <- coun_g %>% 
  rename(retail_rec = retail_and_recreation_percent_change_from_baseline,
         grocery_pharm = grocery_and_pharmacy_percent_change_from_baseline,
         parks = parks_percent_change_from_baseline,
         transit_stations = transit_stations_percent_change_from_baseline,
         workplaces = workplaces_percent_change_from_baseline,
         residential = residential_percent_change_from_baseline) %>%
  group_by(sub_region_2, year_week) %>%
  summarize(across(everything(), mean, na.rm = TRUE, # compute mean for each col
                   .names = "mean_{.col}")) %>% # add "mean" to each col name
  arrange(sub_region_2, year_week)
  
### Mean_parks and mean_transit_stations contain NAs.
# [Missing values are a result of activity being too 
# low upon a specific day and therefore not achieving the 
# anonymity threshold set by Google](https://support.google.com/covid19-mobility/answer/9825414?hl=en)

# identify counties with missing data
google_miss <- google_week %>%
  filter(mean_parks == "NaN" | mean_transit_stations == "NaN")

# identify minimum absolute value of observed values for each county
coun_min <- google_week %>% filter(mean_parks != "NaN",
                                   mean_transit_stations != "Nan") %>%
  mutate(mean_parks = abs(mean_parks),
         mean_transit_stations = abs(mean_transit_stations)) %>%
  group_by(sub_region_2) %>%
  summarize(parks_min = min(mean_parks),
            transit_min = min(mean_transit_stations))

# replace NAs with county-level minimum absolute value
google_na <- google_week %>% 
  mutate(mean_parks = ifelse(sub_region_2 == "Bucks County" & 
                                 mean_parks == "NaN", 0.5714286,
                      ifelse(sub_region_2 == "Burlington County" &
                                 mean_parks == "NaN", 0.0000000,
                      ifelse(sub_region_2 == "Camden County" &
                                 mean_parks == "NaN", 0.0000000,
                      ifelse(sub_region_2 == "Chester County" &
                                 mean_parks == "NaN", 0.8571429,
                      ifelse(sub_region_2 == "Delaware County" &
                                 mean_parks == "NaN", 0.5714286,
                      ifelse(sub_region_2 == "Gloucester County" &
                                 mean_parks == "NaN", 3.4285714,
                      ifelse(sub_region_2 == "Mercer County" & 
                                 mean_parks == "NaN", 1.7142857,
                      ifelse(sub_region_2 == "Montgomery County" &
                                 mean_parks == "NaN", 0.5714286,
                      ifelse(sub_region_2 == "New Castle County" &
                                 mean_parks == "NaN", 1.4285714,
                      ifelse(sub_region_2 == "Philadelphia County" &
                                 mean_parks == "NaN", 0.5714286, mean_parks))))))))))) %>%
  mutate(mean_parks = as.numeric(mean_parks)) %>%
  mutate(mean_transit_stations = ifelse(sub_region_2 == "Bucks County" & 
                                 mean_transit_stations == "NaN", 1.0000000,
                       ifelse(sub_region_2 == "Chester County" & 
                                 mean_transit_stations == "NaN", 2.1428571,
                       ifelse(sub_region_2 == "Gloucester County" &
                                 mean_transit_stations == "NaN", 1.7142857, mean_transit_stations)))) %>%
  mutate(mean_transit_stations = as.numeric(mean_transit_stations))




################################################
# combine vaccine and social mobility data
################################################

### Google Social Mobility data starts 2/15/2021. 
# Counts for fully vaccinated individuals do not appear until early January 2021. 
# Add rows of 0s for vaccination variables prior to MMWR week 2020-51

add_vacc <- coun_g %>% distinct(sub_region_2, year_week) %>%
  filter(between(year_week, "2020 - 07", "2020 - 50")) %>%
  rename(recip_county = sub_region_2) %>%
  mutate(vacc_incidence_n = 0,
         mean_per_pop_fully_vacc = 0,
         mean_fully_vacc_n = 0)
  
all_vacc <- add_vacc %>% bind_rows(county_agg) %>%
  arrange(recip_county, year_week)

# join vaccine and Google social mobility data
explan <- all_vacc %>% 
  inner_join(google_na, by = c("recip_county" = "sub_region_2",
                                 "year_week" = "year_week")) %>%
  arrange(recip_county, year_week)


#############################################
#############################################
# Outcome data
# Case data by county
# one file for each county (10 total)
# downloaded from CDC website
#############################################
#############################################

# read in all CDC case files
case_files <- list.files(pattern = "cdc_cases.*\\.csv") 
cdc_cases <- lapply(case_files, fread, sep = ",")
cdc_case_data <- rbindlist(cdc_cases) # combine all county files into single df

# filter and reformat case data
clean_case <- cdc_case_data %>% rename(state = "State Abbreviation",
                                  county = "County",
                                  cases_7d_avg = "Cases 7-day rolling average",
                                  date = "Date") %>%
  mutate(date = date %>% mdy) %>%
  filter(between(date, "2020-02-15", "2021-10-09")) %>%
  mutate(MMWRweek(date)) %>%
  rename_at(.vars = vars(contains("MMWR")), .funs = ~ gsub("mmwr", "mmwr_",
                                                           tolower(.x))) %>%
  mutate(year_week = ifelse(mmwr_week < 10, paste0(mmwr_year, " - ", "0", mmwr_week),
                            paste0(mmwr_year, " - ", mmwr_week))) %>%
  select(state, county, year_week, date, cases_7d_avg) %>%
  #mutate(cases_7d_avg = as.numeric(str_replace_all(cases_7d_avg, "suppressed", "0"))) %>%
  arrange(county, year_week)

### Suppressed cells need to be replaced with minimum observed cases by county.
# 0 values are not included when considering minimum number of cases.
supp <- clean_case %>% filter(cases_7d_avg != "suppressed" &
                                cases_7d_avg != 0) %>%
  mutate(cases_7d_avg = as.numeric(cases_7d_avg)) %>%
  group_by(county) %>%
  summarize(min_val = min(cases_7d_avg))
supp

# replace suppressed cells with values from supp
case_na <- clean_case %>% 
  mutate(cases_7d_avg = ifelse(county == "Bucks County" & 
                                 cases_7d_avg == "suppressed", 1.42857,
                        ifelse(county == "Burlington County" &
                                 cases_7d_avg == "suppressed", 1.57143,
                        ifelse(county == "Camden County" &
                                 cases_7d_avg == "suppressed", 1.42857,
                        ifelse(county == "Chester County" &
                                 cases_7d_avg == "suppressed", 1.42857,
                        ifelse(county == "Delaware County" &
                                  cases_7d_avg == "suppressed", 1.85714,
                        ifelse(county == "Gloucester County" &
                                 cases_7d_avg == "suppressed", 1.85714,
                        ifelse(county == "Mercer County" & 
                                 cases_7d_avg == "suppressed", 2.14286,
                        ifelse(county == "Montgomery County" &
                                 cases_7d_avg == "suppressed", 1.85714,
                        ifelse(county == "New Castle County" &
                                 cases_7d_avg == "suppressed", 2.14286,
                        ifelse(county == "Philadelphia County" &
                                 cases_7d_avg == "suppressed", 2.28571, cases_7d_avg))))))))))) %>%
  mutate(cases_7d_avg = as.numeric(cases_7d_avg))

# calculate mean of 7-day rolling case average by county and week
weekly_case <- case_na %>% group_by(county, year_week) %>%
  summarize(case_mean = mean(cases_7d_avg)) %>%
  arrange(county, year_week)

# transform data to get case_mean for next week
# so that this week can be compared to next week
next_case <- weekly_case %>%
  ungroup() %>%
  mutate(next_week_mean = lead(case_mean, 1), # use dplyr::lead to return next week's value
         next_week_mean = replace_na(next_week_mean, 0))
           
# add county population data to case data (based on 2019 U.S. Census estimates)
all_coun <- read_csv("all_counties_population.csv")
next_case_fi <- next_case %>% inner_join(all_coun, by = "county")

###############################################
# combine explanatory and outcome variables
# to create complete data set for analysis
###############################################
full_df <- next_case_fi %>% mutate(county_pop = population) %>%
  inner_join(explan, by = c("county" = "recip_county",
                            "year_week" = "year_week")) %>%
  mutate(vacc_incidence_per100thou = vacc_incidence_n / county_pop * 100000, 
         case_mean_per100thou = case_mean / county_pop * 100000, # rolling 7-day average of new cases per 100,000 population
         next_week_per100thou = next_week_mean / county_pop * 100000, # rolling 7-day average of next week's new cases per 100,000 population
         vacc_prevalence_per100thou = mean_fully_vacc_n / county_pop * 100000,
         next_week_increase = ifelse(next_week_per100thou > case_mean_per100thou, 1, 0)) %>% # is next week's mean greater than this week's mean?
  select(county, year_week, case_mean, case_mean_per100thou, next_week_mean,
         next_week_per100thou, next_week_increase, vacc_incidence_n,
         vacc_incidence_per100thou, mean_per_pop_fully_vacc, mean_fully_vacc_n, 
         vacc_prevalence_per100thou, mean_retail_rec, mean_grocery_pharm, mean_parks, 
         mean_transit_stations, mean_workplaces, mean_residential) %>%
  arrange(county, year_week) %>%
  filter(year_week != "2021 - 40") # this is first week of October; it was needed for 
                                   # comparing the final week of the study (2021-39) to 
                                   # next week, but it will not be included in analysis

write_csv(full_df, "bmin503_final_data_20211121.csv")
