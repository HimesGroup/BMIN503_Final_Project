####################
## Author: Stephanie Teeple
## Date: 4 December 2018
## Summary: This file cleans the merged
## NIH ExPORTER and SCImago data. 
####################

# rm(list = ls())

# libraries
library(dplyr)
library(tidyr)
library(lubridate)
library(data.table)
library(RcppRoll)

# 1. Check for duplicates
# NOTE: At last count there are 3126 in terms of FULL_PROJECT_NUM, PI_IDS, PUB_
# TITLE, and SUBPROJECT_ID

  poss_duplicates <- select(data, FULL_PROJECT_NUM, PI_IDS, PUB_TITLE)
  duplicates_vector <- as.data.frame(duplicated(poss_duplicates))
  data <- bind_cols(data, duplicates_vector)
  duplicates <- filter(data, duplicates_vector == TRUE)
  
  # Remove duplicates
  data <- distinct(data, FULL_PROJECT_NUM, PI_IDS, PUB_TITLE, 
                   .keep_all = TRUE)
  
  
# 2. Relabel variables 
# TODO: undoubtedly there is redundancy in the ORG_NAME variable. Ex: 'Albert 
# Einstein College of Medicine' and 'Albert Einstein College of Medicine, INC'
# However, a quick glance shows it is not egregious and largely 
# will be skipped for now. 

  # STUDY_SECTION_NAME  
  data$STUDY_SECTION_NAME <- gsub(" $", "", data$STUDY_SECTION_NAME)
  
  # PI_IDS
  data$PI_IDS <- gsub(";", "", data$PI_IDS) # some only contain ';'
  data$PI_IDS <- gsub(" ", "", data$PI_IDS) # some have random spaces
  

# 3. Check for missingness
# NOTE: Only missingness is for records that didn't have SCImago data (about 1/3)
data[sapply(data, function(x) as.character(x)=="")] <- NA
sapply(data, function(x) sum(is.na(x)))

  # Drop observations that have missing PI_IDS (n = 11)
  data <- filter(data, !is.na(PI_IDS))
  
  # There are ~500 observations that have 


# 4. Fix classes 
# NOTE: ISSNs have characters, sometimes (ex: 1931857X)
# Interestingly, sapply used too much memory. 
numeric_vars <- c(3, 4, 7, 10, 14, 16, 19, 20, 21, 22, 25, 26)
for (i in numeric_vars){ 
  data[,i] <- as.numeric(data[,i])
}
sapply(data, function(x) sum(is.na(x)))


# 5. Date variables processing  

  # PUB_DATE
  # Some observations only have month + year, and some only year. 
  # Fill in with the 15th day of each and June 15th. 
  # TODO: imputation for date missingness?
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
  
    # Drop publications attributed to grants that started before 2001-01-01
    data <- filter(data, BUDGET_START > "2001-01-01")
    
    # Drop publications attributed to grants that will start after 2017-12-31
    data <- filter(data, BUDGET_START < "2017-12-31")

# 6. Constructing new variables 
  
  # Publication counts 
  # NOTE: each APPLICATION_ID corresponds to a unique FULL_PROJECT_NUM.
  # We want the number of publications for each PI before a particular
  # FULL_PROJECT_NUM was funded. 
  data <- data[!is.na(data$PUB_DATE),]
  data$pubs <- 1
  data <- as.data.table(data)
  data <- data[order(data$PUB_DATE)]
  data[, total_pubs := cumsum(pubs), by="PI_IDS"]
  data[, pubs_to_date := min(total_pubs)-1, by = "FULL_PROJECT_NUM"]
  
  # Max impact factor of all publications up to each FULL_PROJECT_NUM start
  data$impact_factor <- replace_na(data$impact_factor, 0)
  data[, max_impact_factor := cummax(impact_factor), by="PI_IDS"]
  data[, max_impact_factor := min(max_impact_factor), by="FULL_PROJECT_NUM"]
  
  # Previous grant count
  # Collapse down to desired analytic level (one obs per PI_ID-FULL_PROJECT_NUM)
  data <- distinct(data, PI_IDS, FULL_PROJECT_NUM, .keep_all = TRUE)
  data$grants <- 1
  data[, count_grants := cumsum(grants)-1, by = "PI_IDS"]
  
  # Log-transformed outcome variable TOTAL_COST
  # TODO: ~500 observations have TOTAL_COST = 1, need to find documentation
  data <- filter(data, TOTAL_COST > 1)
  data <- mutate(data, TOTAL_COST_log = log(TOTAL_COST))
  
  
# 7. Remove unnecessary variables, objects
data <- select(data, BUDGET_START, FULL_PROJECT_NUM, ORG_NAME, PI_IDS, 
               STUDY_SECTION_NAME, TOTAL_COST, pubs_to_date, 
               max_impact_factor, count_grants, TOTAL_COST_log)
rm(projects)
rm(link)
rm(pubs)
rm(scimago)
rm(duplicates)
rm(duplicates_vector)
rm(poss_duplicates)
rm(temp)
rm(urli)
rm(filename)
rm(filenamei)
rm(i)