rm(list = ls())

library(ggplot2)

dates <- seq(as.Date("2021-03-21"), as.Date("2021-11-30"), by=1)

age.count <- data.frame()
age.fully <- data.frame()
age.partial <- data.frame()

for (date in as.list(dates)){
  
  file.name = paste("data/vaccinations_by_age/" , "covid_vaccinations_by_age_" , date , ".csv", sep = "");
  df <- read.csv(file = file.name)
  #print(df)
  age.count[nrow(age.count)+1, "date"] = as.character(date);
  age.fully[nrow(age.fully)+1, "date"] = as.character(date);
  age.partial[nrow(age.partial)+1, "date"] = as.character(date);
  
  for(i in 1:nrow(df)) {
    row <- df[i,]
    if (nrow(df) != 0){
      if ("count" %in% colnames(df)) age.count[nrow(age.count), row$age] <- row$count;
      if ("partially_vaccinated" %in% colnames(df)) age.partial[nrow(age.partial), row$age] <- row$partially_vaccinated;
      if ("fully_vaccinated" %in% colnames(df)) age.fully[nrow(age.fully), row$age] <- row$fully_vaccinated;
    }
    
  }
  
}

rownames(age.count) <- age.count$date
rownames(age.fully) <- age.fully$date
rownames(age.partial) <- age.partial$date

print (age.count)
print (age.fully)
print (age.partial)