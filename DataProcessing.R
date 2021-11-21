# Load Necessary Packages

library(readr)
library(dplyr)

# Download data from Vera Institute on Jail Admissions
jailDat <- read_csv("https://raw.githubusercontent.com/vera-institute/incarceration-trends/master/incarceration_trends.csv")

# Create different data sets by year and impute 5 year estimate of the number of jail admissions
jailDat2010thru2014 <- jailDat %>% filter(year >= 2010 & year <= 2014) %>% select(county_name, state, total_jail_adm) %>% rename(county = county_name, totalJailAdmit = total_jail_adm) %>% group_by(county, state) %>% summarize(totalJailAdmit = sum(totalJailAdmit, na.rm = TRUE)) %>% mutate(year = "2010-2014", county = gsub(pattern = " County", replacement = "", x = county, ignore.case = TRUE))
jailDat2015thru2019 <- jailDat %>% filter(year >= 2015 & year <= 2019) %>% select(county_name, state, total_jail_adm) %>% rename(county = county_name, totalJailAdmit = total_jail_adm) %>% group_by(county, state) %>% summarize(totalJailAdmit = sum(totalJailAdmit, na.rm = TRUE)) %>% mutate(year = "2015-2019", county = gsub(pattern = " County", replacement = "", x = county, ignore.case = TRUE), totalJailAdmit = totalJailAdmit/4*5)

# Combine the jail datasets
jailDatCleaned <- bind_rows(jailDat2010thru2014, jailDat2015thru2019)

# Create list of files in data folder
fileList <- list.files("./Data/")

# Create vectors containing the data for the corresponding 5 year period
years2010thru2014 <- fileList[grepl(pattern = "2010", x = fileList, ignore.case = TRUE) & grepl(pattern = "2014", x = fileList, ignore.case = TRUE)]
years2015thru2019 <- fileList[grepl(pattern = "2015", x = fileList, ignore.case = TRUE) & grepl(pattern = "2019", x = fileList, ignore.case = TRUE)]


# Create a list of data frames
dfList2010thru2014 <- list()
for(i in 1:15){
  dfList2010thru2014[[i]] <- read_csv(paste0("./Data/", years2010thru2014[i])) %>% mutate(year = "2010-2014")
}

# Take each data frame in the list and do an inner join and rename the variables to get a clean data frame.
df2010thru2014 <- select(dfList2010thru2014[[1]], -`Formatted FIPS`)
for(i in 2:length(dfList2010thru2014)){
  df2010thru2014 <- inner_join(df2010thru2014, select(dfList2010thru2014[[i]], -`Formatted FIPS`, -`FIPS Code`), by = c("County", "State", "year"))
}
colnames(df2010thru2014) <- c("county", "state", "fips", "meanHouseholdSize", "year", "prevDisabled", "gini", "prevHispanic", "medianAge", "prevMedicaid", "prevMinBachelors", "prevBlack", "prevWhite", "perCapIncome", "prevMen", "nPop", "prevPoverty", "medianRentCostBurden", "prevNoCar")

# Repeat above process for 2015-2019
dfList2015thru2019 <- list()
for(i in 1:15){
  dfList2015thru2019[[i]] <- read_csv(paste0("./Data/", years2015thru2019[i])) %>% mutate(year = "2015-2019")
}

df2015thru2019 <- select(dfList2015thru2019[[1]], -`Formatted FIPS`)
for(i in 2:length(dfList2015thru2019)){
  df2015thru2019 <- inner_join(df2015thru2019, select(dfList2015thru2019[[i]], -`Formatted FIPS`, -`FIPS Code`), by = c("County", "State", "year"))
}
colnames(df2015thru2019) <- c("county", "state", "fips", "meanHouseholdSize", "year", "prevDisabled", "gini", "prevHispanic", "medianAge", "prevMedicaid", "prevMinBachelors", "prevBlack", "prevWhite", "perCapIncome", "prevMen", "nPop", "prevPoverty", "medianRentCostBurden", "prevNoCar")

# Combine into big data frame of all the covariates from the Census Bureau
censusCovariates <- bind_rows(df2010thru2014, df2015thru2019)

# Create data frame of covariates by combining Census information with jail admission information
covariateDf <- inner_join(censusCovariates, jailDatCleaned, by = c("county", "state", "year"))


# Process data from CDC on cocaine overdose deaths

# Create list of cocaine overdose datasets
cocaineList <- fileList[grepl(x = fileList, pattern = "cocaine", ignore.case = TRUE)]

# Create a list with a data frame of each year of deaths from 2010-2014 similar to process above for census data
cocaineYears2010thru2014 <- cocaineList[1:5]

cocaineDfList2010thru2014 <- list()
for(i in 1:length(cocaineYears2010thru2014)){
  cocaineDfList2010thru2014[[i]] <- read_csv(paste0("./Data/", cocaineYears2010thru2014[i])) 
  colnames(cocaineDfList2010thru2014[[i]])[5] <- "cocaineDeath"
}

cocaineDf2010thru2014 <- select(cocaineDfList2010thru2014[[1]], -`Formatted FIPS`)
for(i in 2:length(cocaineDfList2010thru2014)){
  cocaineDf2010thru2014 <- bind_rows(cocaineDf2010thru2014, select(cocaineDfList2010thru2014[[i]], -`Formatted FIPS`, -`FIPS Code`))
}
colnames(cocaineDf2010thru2014) <- c("county", "state", "fips", "cocaineDeath")
cocaineDf2010thru2014$cocaineDeath <- as.numeric(cocaineDf2010thru2014$cocaineDeath)

# Impute estimate for total number of cocaine deaths over 5 year period
cocaineDf2010thru2014 <- cocaineDf2010thru2014 %>% filter(!is.na(cocaineDeath)) %>% group_by(county, state) %>% summarise(cocaineDeath = mean(cocaineDeath)*5) %>% mutate(year = "2010-2014")

# Repeat above for 2015-2019
cocaineYears2015thru2019 <- cocaineList[6:10]

cocaineDfList2015thru2019 <- list()
for(i in 1:length(cocaineYears2015thru2019)){
  cocaineDfList2015thru2019[[i]] <- read_csv(paste0("./Data/", cocaineYears2015thru2019[i])) 
  colnames(cocaineDfList2015thru2019[[i]])[5] <- "cocaineDeath"
}

cocaineDf2015thru2019 <- select(cocaineDfList2015thru2019[[1]], -`Formatted FIPS`, -`FIPS Code`)
for(i in 2:length(cocaineDfList2015thru2019)){
  cocaineDf2015thru2019 <- bind_rows(cocaineDf2015thru2019, select(cocaineDfList2015thru2019[[i]], -`Formatted FIPS`, -`FIPS Code`))
}
colnames(cocaineDf2015thru2019) <- c("county", "state", "cocaineDeath")
cocaineDf2015thru2019$cocaineDeath <- as.numeric(cocaineDf2015thru2019$cocaineDeath)

cocaineDf2015thru2019 <- cocaineDf2015thru2019 %>% filter(!is.na(cocaineDeath)) %>% group_by(county, state) %>% summarise(cocaineDeath = mean(cocaineDeath)*5) %>% mutate(year = "2015-2019")

cocaineDf <- bind_rows(cocaineDf2010thru2014, cocaineDf2015thru2019)

# Create final data set by merging outcomes with covariates. Also, transform the population variable to a numeric and create a jail admission rate 
finalData <- inner_join(cocaineDf, covariateDf, by = c("county", "state", "year"))

finalData$nPop <- as.numeric(finalData$nPop)

finalData <- mutate(finalData, jailAdmit100k = totalJailAdmit/nPop*100000)

# Save Final Data
write_csv(finalData, "./finalData.csv")

