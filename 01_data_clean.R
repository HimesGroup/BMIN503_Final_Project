####################
## Author: Stephanie Teeple
## Date: 4 December 2018
## Summary: This file cleans the merged
## NIH ExPORTER and SCImago data. 
####################

# rm(list = ls())

# libraries
library(dplyr)

# Check for duplicates
data <- select(data, -matches("poss_duplicates"), -duplicates_vector)
poss_duplicates <- select(data, FULL_PROJECT_NUM, PI_IDS, PUB_TITLE, SUBPROJECT_ID)
duplicates_vector <- as.data.frame(duplicated(poss_duplicates))
data <- bind_cols(data, duplicates_vector)
duplicates <- filter(data, duplicates_vector == TRUE)

# NOTE: 18958 duplicates on the basis of FULL_PROJECT_NUM, PI_IDS, PUB_TITLE,
# SUBPROJECT_ID. 
# NOTE: 3114 of the duplicates have "Special Emphasis Panel" in PI_IDS field. 


# Delimiting problems 
lengths <- as.data.frame(sapply(data, function(x) nchar(x)))
colnames(lengths) <- paste0("length_", colnames(lengths))

# NOTE: Max character lengths by potential problem variables:
# AFFILIATION = 3500
# AUTHOR_LIST = 3979
# PUB_TITLE = 1999
# NIH_SPENDING_CATS = 139639
# PI_IDS = 57609
# PI_NAMEs = 55953
# PROJECT_START = 66440
# PROJECT_END = 54902
# PROJECT_TITLE = 246486
# STUDY_SECTION = 171615
# STUDY_SECTION_NAME = 65696
# SUBPROJECT_ID = 46266
# SUPPORT_YEAR = 54974
# TOTAL_COST = 117634
# TOTAL_COST_SUB_PROJECT = 73011

length_NIH_SPENDING_CATS <- lengths$length_NIH_SPENDING_CATS
data <- cbind(data, length_NIH_SPENDING_CATS)
longest <- filter(data, length_NIH_SPENDING_CATS > 100000) # 38 observations
kinda_long <- filter(data, length_NIH_SPENDING_CATS > 5000) # 9551 observations 


# Size issues
# NOTE: data is 3769710912 bytes ~ 3.8 Gb
