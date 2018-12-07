####################
## Author: Stephanie Teeple
## Date: 4 December 2018
## Summary: This file cleans the merged
## NIH ExPORTER and SCImago data. 
####################

# rm(list = ls())

# libraries
library(dplyr)
library(lubridate)

# 1. Check for duplicates
# NOTE: At last count there are 3126 in terms of FULL_PROJECT_NUM, PI_IDS, PUB_
# TITLE, and SUBPROJECT_ID

  data <- select(data, -matches("poss_duplicates"), -duplicates_vector)
  poss_duplicates <- select(data, FULL_PROJECT_NUM, PI_IDS, PUB_TITLE)
  duplicates_vector <- as.data.frame(duplicated(poss_duplicates))
  data <- bind_cols(data, duplicates_vector)
  duplicates <- filter(data, duplicates_vector == TRUE)
  
  # Remove duplicates
  data <- distinct(data, FULL_PROJECT_NUM, PI_IDS, PUB_TITLE, 
                   .keep_all = TRUE)

# 2. Check for missingness
# NOTE: Only missingness is for records that didn't have SCImago data (about 1/3)
data[sapply(data, function(x) as.character(x)=="")] <- NA
sapply(data, function(x) sum(is.na(x)))

# 3. Fix classes 
# NOTE: ISSNs have characters, sometimes (ex: 1931857X)
# Interestingly, sapply used too much memory 
data$PI_IDS <- gsub(";", "", data$PI_IDS)
numeric_vars <- c(3, 4, 7, 10, 14, 16, 19, 20, 21, 22, 25, 26)
for (i in numeric_vars){ 
  data[,i] <- as.numeric(data[,i])
}
sapply(data, function(x) sum(is.na(x)))

# 4. Check distributions 
summary(data)


