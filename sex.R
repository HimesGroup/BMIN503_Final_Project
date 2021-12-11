rm(list = ls())

library(ggplot2)

dates <- seq(as.Date("2020-06-04"), as.Date("2020-11-30"), by=1)

sex <- data.frame(matrix(ncol = 4, nrow = 0))
colnames(sex) <- c("date","Male","Female","unknown")

for (date in as.list(dates)){
  
  file.name = paste("data/cases_by_sex/" , "covid_cases_by_sex_" , date , ".csv", sep = "");
  df <- read.csv(file = file.name)
  sex[nrow(sex)+1, 1] = as.character(date);
  sex[nrow(sex), 2] <- df[tolower(df$sex)=="male",2];
  sex[nrow(sex), 3] <- df[tolower(df$sex)=="female",2];
  sex[nrow(sex), 4] <- df[tolower(df$sex)=="unknown",2];
  
}

rownames(sex) <- sex$date
print (sex)
