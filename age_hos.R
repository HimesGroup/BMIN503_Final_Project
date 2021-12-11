rm(list = ls())

library(tidyverse)
library(ggplot2)

dates <- seq(as.Date("2020-08-14"), as.Date("2021-11-30"), by=1)

age <- data.frame(matrix(ncol = 11, nrow = 0))
colnames(age) <- c("date","0_19_yes","20_34_yes","35_54_yes","55_74_yes","74+_yes",
                   "0_19_no","20_34_no","35_54_no","55_74_no","74+_no")

for (date in as.list(dates)){
  
  file.name = paste("data/hospitalizations_by_age/" , "covid_hospitalizations_by_age_" , date , ".csv", sep = "");
  df <- read.csv(file = file.name)
  print(df)
  age[nrow(age)+1, "date"] = as.character(date);
  age[nrow(age), 2] <- df[df$age=="<20","Yes"]
  age[nrow(age), 3] <- df[df$age=="20-34","Yes"]
  age[nrow(age), 4] <- df[df$age=="35-54","Yes"]
  age[nrow(age), 5] <- df[df$age=="55-74","Yes"]
  age[nrow(age), 6] <- df[df$age=="75+","Yes"]
  
  age[nrow(age), 7] <- df[df$age=="<20","NO_UNKNOWN"];
  age[nrow(age), 8] <- df[df$age=="20-34","NO_UNKNOWN"];
  age[nrow(age), 9] <- df[df$age=="35-54","NO_UNKNOWN"];
  age[nrow(age), 10] <- df[df$age=="55-74","NO_UNKNOWN"];
  age[nrow(age), 11] <- df[df$age=="75+","NO_UNKNOWN"];
  
  
}

age$date <- as.Date(as.character(age$date))
rownames(age) <- age$date

age <- age %>% 
  mutate(rate1 = age$"0_19_yes" / (age$"0_19_yes" + age$"0_19_no")) %>% 
  mutate(rate2 = age$"20_34_yes" / (age$"20_34_yes" + age$"20_34_no")) %>% 
  mutate(rate3 = age$"35_54_yes" / (age$"35_54_yes" + age$"35_54_no")) %>% 
  mutate(rate4 = age$"55_74_yes" / (age$"55_74_yes" + age$"55_74_no")) %>% 
  mutate(rate5 = age$"74+_yes" / (age$"74+_yes" + age$"74+_no"))


print (age)

colors <- c("<20" = "green1", "20-34" = "red", "35-54" = "deepskyblue1", "55-74"="sienna4", "75+"="purple")

age_plot <- ggplot(age, aes(x = date)) +  
  geom_smooth(aes(y = `rate1`, color = "<20"), span = 0.1, se = FALSE) +
  geom_smooth(aes(y = `rate2`, color = "20-34"), span = 0.1, se = FALSE ) +
  geom_smooth(aes(y = `rate3`, color = "35-54"), span = 0.1, se = FALSE) +
  geom_smooth(aes(y = `rate4`, color = "55-74"), span = 0.1, se = FALSE) +
  geom_smooth(aes(y = `rate5`, color = "75+"), span = 0.1, se = FALSE) +
  labs (x = 'Time',
        y = 'Hospitalization Rate',
        color = "Legend") +
  scale_color_manual(values = colors)
