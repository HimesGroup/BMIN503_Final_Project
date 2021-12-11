rm(list = ls())

library(ggplot2)

dates <- seq(as.Date("2020-06-04"), as.Date("2021-11-30"), by=1)

age <- data.frame()
# colnames(age) <- c("date","0_19","20_34","35_54","55_74","74+")

for (date in as.list(dates)){
  
  file.name = paste("data/cases_by_age/" , "covid_cases_by_age_" , date , ".csv", sep = "");
  df <- read.csv(file = file.name)
  age[nrow(age)+1, "date"] = as.character(date);
  
  for(i in 1:nrow(df)) {
    row <- df[i,]
    age[nrow(age), row$age] <- row$count;
  }
  
}
age$date <- as.Date(as.character(age$date))

rownames(age) <- age$date
# print (age)

colors <- c("<20" = "green1", "20-34" = "red", "35-54" = "deepskyblue1", "55-74"="sienna4", "75+"="purple")

age_plot <- ggplot(age, aes(x = date)) +  
  geom_smooth(aes(y = `<20`, color = "<20"), span = 0.1) +
  geom_smooth(aes(y = `20-34`, color = "20-34"), span = 0.1) +
  geom_smooth(aes(y = `35-54`, color = "35-54"), span = 0.1) +
  geom_smooth(aes(y = `55-74`, color = "55-74"), span = 0.1) +
  geom_smooth(aes(y = `75+`, color = "75+"), span = 0.1) +
  labs (x = 'Time',
        y = 'count',
        color = "Legend") +
  scale_color_manual(values = colors)