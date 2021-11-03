#####################################
#####################################
# BMIN503
# Create final dataset
# All Delval counties 
# 11/2/2021
#####################################
#####################################

library(tidyverse)


###########################
# reformatted CDC case data
###########################

case_df <- read_csv("cdc_county_case_data.csv")


##########################
# aggregate by MMWR week
##########################

weekly_case <- case_df %>% group_by(county, year_week, yearweek) %>%
  summarize(case_mean = mean(cases_7d_avg)) %>%
  arrange(county, yearweek)


###########################
# create next week case up
###########################

weekly_case %>% mutate(case_up = case_mean > lag(case_mean, 1))

# why does this return NAs?
# running R version 4.1.1 and dplyr 1.0.7