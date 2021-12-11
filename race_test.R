rm(list = ls())

library(ggplot2)

dates <- seq(as.Date("2020-08-14"), as.Date("2020-11-30"), by=1)

race <- data.frame(matrix(ncol = 15, nrow = 0))
colnames(race) <- c("date","White","American_Indian","African","Pacific_Islander", 
                    "Native_American", "Asian", "Hispanic", "African_Amarican", "Black", 
                    "NA", "OTHER", "DECLINE", "UNKNOWN", "Declined_to_specify")

print (race)

for (date in as.list(dates)){
  
  file.name = paste("data/cases_by_race/" , "covid_cases_by_race_" , date , ".csv", sep = "");
  df <- read.csv(file = file.name)
  race[nrow(race)+1, 1] = as.character(date);
  
  white <- df[tolower(df$racial_identity)=="white" & !is.na(df$racial_identity),];
  american_indian <- df[tolower(df$racial_identity)=="american indian" & !is.na(df$racial_identity),];
  african <- df[tolower(df$racial_identity)=="african" & !is.na(df$racial_identity),];
  pacific_islander <- df[tolower(df$racial_identity)=="pacific islander" & !is.na(df$racial_identity),];
  native_american <- df[tolower(df$racial_identity)=="native american" & !is.na(df$racial_identity),];
  asian <- df[tolower(df$racial_identity)=="asian" & !is.na(df$racial_identity),];
  hispanic <- df[tolower(df$racial_identity)=="hispanic" & !is.na(df$racial_identity),];
  african_amarican <- df[tolower(df$racial_identity)=="african amarican" & !is.na(df$racial_identity),];
  black <- df[tolower(df$racial_identity)=="black" & !is.na(df$racial_identity),];
  na <- df[is.na(df$racial_identity),];
  other <- df[tolower(df$racial_identity)=="other" & !is.na(df$racial_identity),];
  decline <- df[tolower(df$racial_identity)=="decline" & !is.na(df$racial_identity),];
  unknown <- df[tolower(df$racial_identity)=="unknown" & !is.na(df$racial_identity),];
  declined_to_specify <- df[tolower(df$racial_identity)=="White" & !is.na(df$racial_identity),];
  
  if (nrow(white) != 0) race[nrow(race), 2] <- white[1,2];
  if (nrow(american_indian) != 0) race[nrow(race), 3] <- american_indian[1,2];
  if (nrow(african) != 0) race[nrow(race), 4] <- african[1,2];
  if (nrow(pacific_islander) != 0) race[nrow(race), 5] <- pacific_islander[1,2];
  
  if (nrow(native_american) != 0) race[nrow(race), 6] <- native_american[1,2];
  if (nrow(asian) != 0) race[nrow(race), 7] <- asian[1,2];
  if (nrow(hispanic) != 0) race[nrow(race), 8] <- hispanic[1,2];
  if (nrow(african_amarican) != 0) race[nrow(race), 9] <- african_amarican[1,2];
  if (nrow(black) != 0) race[nrow(race), 10] <- black[1,2];
  if (nrow(na) != 0) race[nrow(race), 11] <- na[1,2];
  
  if (nrow(other) != 0) race[nrow(race), 12] <- other[1,2];
  if (nrow(decline) != 0) race[nrow(race), 13] <- decline[1,2];
  if (nrow(unknown) != 0) race[nrow(race), 14] <- unknown[1,2];
  if (nrow(declined_to_specify) != 0) race[nrow(race), 15] <- declined_to_specify[1,2];
  
  #print(race)
}

rownames(race) <- race$date
print (race)

race.plot = ggplot(data = race, aes(x = date, y = White)) +
  geom_boxplot()

