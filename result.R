rm(list = ls())

library(ggplot2)

dates <- seq(as.Date("2020-06-04"), as.Date("2020-11-30"), by=1)

outcome <- data.frame(matrix(ncol = 4, nrow = 0))
colnames(outcome) <- c("date","pos_died","pos_pos","neg_neg")

for (date in as.list(dates)){
  
  file.name = paste("data/cases_by_outcome/" , "covid_cases_by_outcome_" , date , ".csv", sep = "");
  df <- read.csv(file = file.name)
  outcome[nrow(outcome)+1, 1] = as.character(date);
  outcome[nrow(outcome), 2] <- df[df$test_result=="positive" & df$covid_outcome=="died",3];
  outcome[nrow(outcome), 3] <- df[df$test_result=="positive" & df$covid_outcome=="positive",3];
  outcome[nrow(outcome), 4] <- df[df$test_result=="negative" & df$covid_outcome=="negative",3];
  
}

rownames(outcome) <- outcome$date
print (outcome)
