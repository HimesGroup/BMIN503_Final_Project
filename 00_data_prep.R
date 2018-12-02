####################
## Author: Stephanie Teeple
## Date: 1 December 2018
## Summary: This file merges NIH ExPORTER 
## project and publication data for upload 
## into IRIS' VDE. 
####################

rm(list = ls())

# libraries
# devtools::install_github("jayhesselberth/nihexporter")
# libraries(nihexporter) #ExPORTER data through 2016
library(dplyr)


# 1. Download data from ExPORTER and rowbind it 
setwd("C:/Users/steeple/Dropbox/EPID_600/final_project_data")

  # Project data 
  projects <- NULL
  for (i in 2001:2017) {
      temp <- tempfile()
      urli <- paste0("https://exporter.nih.gov/CSVs/final/RePORTER_PRJ_C_FY", i, ".zip")
      filenamei <- paste0("RePORTER_PRJ_C_FY", i, ".csv")
      download.file(urli, temp, mode = "wb")
      print(paste("download", i))
      unzip(temp, filenamei)
      print(paste("unzip", i))
      projects <- bind_rows(projects, read.table(filenamei, sep = ",", header = TRUE, fill = TRUE, comment.char = "", colClasses = "character", row.names = NULL))
  }
      
      
  # Publication data
  pubs <- NULL
  for (i in 2001:2017) {
    temp <- tempfile()
    urli <- paste0("https://exporter.nih.gov/CSVs/final/RePORTER_PUB_C_", i, ".zip")
    filenamei <- paste0("RePORTER_PUB_C_", i, ".csv")
    download.file(urli, temp, mode = "wb")
    print(paste("download", i))
    unzip(temp, filenamei)
    print(paste("unzip", i))
    pubs <- bind_rows(pubs, read.table(filenamei, sep = ",", header = TRUE, fill = TRUE, comment.char = "", colClasses = "character", row.names = NULL))
  }
  
  # Project-publication linkage tables
  link <- NULL
  for (i in 2001:2017) {
    temp <- tempfile()
    urli <- paste0("https://exporter.nih.gov/CSVs/final/RePORTER_PUBLNK_C_", i, ".zip")
    filenamei <- paste0("RePORTER_PUBLNK_C_", i, ".csv")
    download.file(urli, temp, mode = "wb")
    print(paste("download", i))
    unzip(temp, filenamei)
    print(paste("unzip", i))
    link <- bind_rows(link, read.table(filenamei, sep = ",", header = TRUE, fill = TRUE, comment.char = "", colClasses = "character", row.names = NULL)
  } 
  
# 2. Merge projects and publications data set using link keys
data <- inner_join(pubs, link, by = "PMID")
data <- inner_join(data, projects, by = c("PROJECT_NUMBER" = "CORE_PROJECT_NUM"))



projects <- NULL
pubs <- NULL
link <- NULL
data <- list()
for (i in 2001:2017) {
  
  # Projects
  temp <- tempfile()
  urli <- paste0("https://exporter.nih.gov/CSVs/final/RePORTER_PRJ_C_FY", i, ".zip")
  filenamei <- paste0("RePORTER_PRJ_C_FY", i, ".csv")
  download.file(urli, temp, mode = "wb")
  print(paste("download projects", i))
  unzip(temp, filenamei)
  print(paste("unzip projects", i))
  projects <- read.table(filenamei, sep = ",", header = TRUE, fill = TRUE, comment.char = "", colClasses = "character", row.names = NULL)

  # Pubs 
  temp <- tempfile()
  urli <- paste0("https://exporter.nih.gov/CSVs/final/RePORTER_PUB_C_", i, ".zip")
  filenamei <- paste0("RePORTER_PUB_C_", i, ".csv")
  download.file(urli, temp, mode = "wb")
  print(paste("download pubs", i))
  unzip(temp, filenamei)
  print(paste("unzip pubs", i))
  pubs <- read.table(filenamei, sep = ",", header = TRUE, fill = TRUE, comment.char = "", colClasses = "character", row.names = NULL)
  
  # Links
  temp <- tempfile()
  urli <- paste0("https://exporter.nih.gov/CSVs/final/RePORTER_PUBLNK_C_", i, ".zip")
  filenamei <- paste0("RePORTER_PUBLNK_C_", i, ".csv")
  download.file(urli, temp, mode = "wb")
  print(paste("download links", i))
  unzip(temp, filenamei)
  print(paste("unzip links", i))
  link <- read.table(filenamei, sep = ",", header = TRUE, fill = TRUE, comment.char = "", colClasses = "character", row.names = NULL)
                    

  # Merge
  link <- inner_join(pubs, link, by = "PMID")
  data[[i]] <- inner_join(link, projects, by = c("PROJECT_NUMBER" = "CORE_PROJECT_NUM"))

}


