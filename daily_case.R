rm(list = ls())

library(ggplot2)

dates <- seq(as.Date("2020-06-04"), as.Date("2021-11-30"), by=1)

daily.case <- data.frame()

for (date in as.list(dates)){
  
  file.name = paste("data/cases_by_date/" , "covid_cases_by_date_" , date , ".csv", sep = "");
  print(file.name)
  df <- read.csv(file = file.name)
  #daily.case[nrow(daily.case)+1, "date"] = as.character(date);
  
  for(i in 1:nrow(df)) {
    row <- df[i,]
    new_row_num = nrow(daily.case) + 1
    if ("result_date" %in% colnames(df)) daily.case[new_row_num, "collection_date"] <- row$result_date;
    if ("collection_date" %in% colnames(df)) daily.case[new_row_num, "collection_date"] <- row$collection_date;
    daily.case[new_row_num, "negative"] <- row$negative;
    daily.case[new_row_num, "positive"] <- row$positive;
  }
  
}

print (daily.case)
write.csv(daily.case,"daily_case.csv", row.names = FALSE)