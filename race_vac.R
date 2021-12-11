rm(list = ls())

library(ggplot2)

dates <- seq(as.Date("2021-03-21"), as.Date("2021-11-30"), by=1)

race.count <- data.frame()
race.fully <- data.frame()
race.partial <- data.frame()

for (date in as.list(dates)){
  
  file.name = paste("data/vaccinations_by_race/" , "covid_vaccinations_by_race_" , date , ".csv", sep = "");
  df <- read.csv(file = file.name)
  race.count[nrow(race.count)+1, "date"] = as.character(date);
  race.fully[nrow(race.fully)+1, "date"] = as.character(date);
  race.partial[nrow(race.partial)+1, "date"] = as.character(date);
  
  if (nrow(df) != 0){
    for(i in 1:nrow(df)) {
      row <- df[i,]
      
      if (!is.na(row$racial_identity)){
        if ("count" %in% colnames(df)) race.count[nrow(race.count), tolower(row$racial_identity)] <- row$count;
        if ("partially_vaccinated" %in% colnames(df)) race.partial[nrow(race.partial), tolower(row$racial_identity)] <- row$partially_vaccinated;
        if ("fully_vaccinated" %in% colnames(df)) race.fully[nrow(race.fully), tolower(row$racial_identity)] <- row$fully_vaccinated;
      }
    }
      
  }
}

rownames(race.count) <- race.count$date
rownames(race.fully) <- race.fully$date
rownames(race.partial) <- race.partial$date

print (race.count)
print (race.fully)
print (race.partial)