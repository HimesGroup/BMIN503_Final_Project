rm(list = ls())

library(ggplot2)

dates <- seq(as.Date("2020-08-14"), as.Date("2020-11-30"), by=1)

sex <- data.frame(matrix(ncol = 5, nrow = 0))
colnames(sex) <- c("date","Male_yes","Female_yes","Male_no","Female_no")

for (date in as.list(dates)){
  
  file.name = paste("data/hospitalizations_by_sex/" , "covid_hospitalizations_by_sex_" , date , ".csv", sep = "");
  df <- read.csv(file = file.name)
  sex[nrow(sex)+1, 1] = as.character(date);
  sex[nrow(sex), 2] <- df[tolower(df$sex)=="male",3];
  sex[nrow(sex), 3] <- df[tolower(df$sex)=="female",3];
  
  sex[nrow(sex), 4] <- df[tolower(df$sex)=="male",4];
  sex[nrow(sex), 5] <- df[tolower(df$sex)=="female",4];
  
}

rownames(sex) <- sex$date
print (sex)
