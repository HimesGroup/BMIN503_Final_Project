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

# 4. Date variables processing  

  # PUB_DATE
  # Some observations only have month + year, and some only year. 
  # Fill in with the 15th day of each and June 15th. 
  # TODO: imputation for date missingness???
  data$PUB_DATE_addn <- ""
  data$PUB_DATE_addn[nchar(data$PUB_DATE) < 9 & nchar(data$PUB_DATE) > 4] <- " 15"
  data$PUB_DATE_addn[nchar(data$PUB_DATE) == 4] <- " Jun 15"
  data <- mutate(data, PUB_DATE = paste0(PUB_DATE, PUB_DATE_addn))
  data$PUB_DATE_addn <- NULL
  
    # TODO: There are many non-standard date formats in this variable (~40,000 rows)
    # Example: yyyy mmm-mmm (2001 Apr-May) and yyyy season-season (2002 Fall-Wi)
    # For expediency's sake, leave as missing for time being 
    data$PUB_DATE <- ymd(data$PUB_DATE)
    
  # BUDGET_START and BUDGET_END
  data$BUDGET_START <- mdy(data$BUDGET_START)
  data$BUDGET_END <- mdy(data$BUDGET_END)

# 5. Constructing new variables 
  
  # Publication counts 
  # NOTE: each APPLICATION_ID corresponds to a unique FULL_PROJECT_NUM.
  # We want the number of publications for each PI before a particular FULL_PROJECT_NUM
  # was funded. 
  pub_counts <- test %>%
    group_by(PI_IDS) %>%
    summarize(pub_counts = n())
  test <- full_join(test, pub_counts, by ="PI_IDS")  # Counts of publications per PI/Project combo
  
  # No... I think we want the count of ALL publications for a PI for a period defined by projects. 
  groups <- group_by(data, )