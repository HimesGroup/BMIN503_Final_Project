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
duplicates <- duplicated(data)
data <- col_bind(data, duplicates)
