rm(list = ls())

library(tidyverse)

# Stack daily files within folder and keep distinct records
build_historical_dataset <- function(data_folder) {
  list.files(path = data_folder, full.names = TRUE) %>%
    map_dfr(read_csv) %>%
    distinct() # duplicates occur when there is an extract but no data update
}

# Cases by zip code and reporting date
cases_by_zipcode <- build_historical_dataset("data/cases_by_zipcode")
print(cases_by_zipcode)