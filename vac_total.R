rm(list = ls())

library(ggplot2)

dates <- seq(as.Date("2021-03-21"), as.Date("2021-11-30"), by=1)

vac <- data.frame()

for (date in as.list(dates)){
  
  file.name = paste("data/vaccinations_total/" , "covid_vaccinations_total_" , date , ".csv", sep = "");
  df <- read.csv(file = file.name)
  vac[nrow(vac)+1, "date"] = as.character(date);
  
  if (nrow(df) != 0){
    if ("total_count" %in% colnames(df)) vac[nrow(vac), "total_count"] <- df$total_count;
    if ("first_dose" %in% colnames(df)) vac[nrow(vac), "first_dose"] <- df$first_dose;
    if ("second_dose" %in% colnames(df)) vac[nrow(vac), "second_dose"] <- df$second_dose;
    if ("partially_vaccinated" %in% colnames(df)) vac[nrow(vac), "partially_vaccinated"] <- df$partially_vaccinated;
    if ("fully_vaccinated" %in% colnames(df)) vac[nrow(vac), "fully_vaccinated"] <- df$fully_vaccinated;
  }
  
}

rownames(vac) <- vac$date
print (vac)