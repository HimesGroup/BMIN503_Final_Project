library(tidyverse)
library(lubridate)
library(EpiEstim)

# Daily case count by test result date
incidence_data <- list.files(path = "data/cases_by_date", full.names = TRUE) %>% 
  last %>% 
  read_csv(col_types = cols(collection_date = col_character(),
                            etl_timestamp = col_skip(),
                            negative = col_integer(),
                            positive = col_integer())) %>% 
  filter(!is.na(positive) & (date(collection_date) >= date("2020-03-16"))) %>%
  mutate(dates = date(collection_date)) %>%
  arrange(dates) %>%
  mutate(positivity_rate = positive / (positive + negative)) %>%
  select(dates, positive, negative, positivity_rate) %>%
  filter(dates <= last(dates) - 3) # remove last 3 days considering lag in test results

# Plot incidence and effective reproductive number over time
# Serial interval mean and std estimates from: https://www.dhs.gov/publication/st-master-question-list-covid-19
res_parametric_si <- estimate_R(incidence_data %>% 
                                  select(dates, I = positive),
                                method="parametric_si",
                                config = make_config(list(mean_si = 5.29, std_si = 5.32)))
plot(res_parametric_si, legend = FALSE)