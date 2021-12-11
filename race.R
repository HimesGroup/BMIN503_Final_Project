rm(list = ls())

library(ggplot2)

dates <- seq(as.Date("2020-08-14"), as.Date("2021-11-30"), by=1)

race <- data.frame()

for (date in as.list(dates)){
  
  file.name = paste("data/cases_by_race/" , "covid_cases_by_race_" , date , ".csv", sep = "");
  df <- read.csv(file = file.name)
  race[nrow(race)+1, "date"] = as.character(date);
  
  for(i in 1:nrow(df)) {
    row <- df[i,]
    if (!is.na(row$racial_identity))
      race[nrow(race), tolower(row$racial_identity)] <- row$count;
  }
}

race$date <- as.Date(as.character(race$date))
rownames(race) <- race$date
# print (race)

colors <- c("White" = "brown4", "Hispanic" = "coral", "Asian" = "red", "African American"="blue")

race_plot <- ggplot(race, aes(x = date)) +  
  geom_smooth(aes(y = `white`, color = "White"), span = 0.1) +
  geom_smooth(aes(y = `hispanic`, color = "Hispanic"), span = 0.1) +
  geom_smooth(aes(y = `asian`, color = "Asian"), span = 0.1) +
  geom_smooth(aes(y = `african american`, color = "African American"), span = 0.1) +
  labs (x = 'date',
        y = 'count',
        color = "Legend") +
  scale_color_manual(values = colors)

race_plot