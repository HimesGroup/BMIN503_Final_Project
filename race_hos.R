rm(list = ls())

library(ggplot2)

dates <- seq(as.Date("2020-08-14"), as.Date("2021-11-30"), by=1)

race.hos <- data.frame()
race.nohos <- data.frame()

rate <- data.frame();

for (date in as.list(dates)){
  
  file.name = paste("data/hospitalizations_by_race/" , "covid_hospitalizations_by_race_" , date , ".csv", sep = "");
  df <- read.csv(file = file.name)
  race.hos[nrow(race.hos)+1, "date"] = as.character(date);
  race.nohos[nrow(race.nohos)+1, "date"] = as.character(date);
  rate[nrow(rate)+1, "date"] = as.character(date);
  
  for(i in 1:nrow(df)) {
    row <- df[i,]
    if (!is.na(row$racial_identity)){
      race.hos[nrow(race.hos), tolower(row$racial_identity)] <- row$Yes;
      race.nohos[nrow(race.nohos), tolower(row$racial_identity)] <- row$NO_UNKNOWN;
      rate[nrow(rate), tolower(row$racial_identity)] <- row$Yes/(row$Yes + row$NO_UNKNOWN);
    }
  }
}

rownames(race.hos) <- race.hos$date
rownames(race.nohos) <- race.nohos$date

race.hos$date <- as.Date(as.character(race.hos$date))
race.nohos$date <- as.Date(as.character(race.nohos$date))
rate$date <- as.Date(as.character(rate$date))

print (race.hos)
print (race.nohos)
print (rate)

colors <- c("White" = "brown4", "Hispanic" = "coral", "Asian" = "red", "African American"="blue")

rate_plot <- ggplot(rate, aes(x = date)) +  
  geom_smooth(aes(y = `white`, color = "White"), span = 0.1, se = FALSE) +
  geom_smooth(aes(y = `hispanic`, color = "Hispanic"), span = 0.1, se = FALSE) +
  geom_smooth(aes(y = `asian`, color = "Asian"), span = 0.1, se = FALSE) +
  geom_smooth(aes(y = `african american`, color = "African American"), span = 0.1, se = FALSE) +
  labs (x = 'date',
        y = 'rate',
        color = "Legend") +
  scale_color_manual(values = colors)

