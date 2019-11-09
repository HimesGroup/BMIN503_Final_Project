#selects columns for demographics
demographics <- function(info) {
  info <- info[c(1:2, 
                 which(colnames(info)=="Patient's Language"):which(colnames(info)=="Parent's Language"),
                 which(colnames(info)=="Ethnicity"):which(colnames(info)=="Obese?"),
                 which(colnames(info)=="Ethnicity"):which(colnames(info)=="Gender"),
                 which(colnames(info)=="parent_or_guardian___1"):which(colnames(info)=="parent_or_guardian___2"),
                 which(colnames(info)=="dem_gender"):which(colnames(info)=="dem_grade"),
                 which(colnames(info)=="dem_parent_sex"):which(colnames(info)=="demographics_parent_complete"))]
  return(info)
}

#this takes as arguments name of first and last column to combine, then loops through, seeing which columns are empty, and collecting them all in first column, then deleting it.
cleaner <- function(string1, string2, info){
  cols <- which(colnames(info)==string1):which(colnames(info)==string2) #get col numbers for first and last string
  info[cols] <- sapply(info[cols], as.character)
  for(j in 1:nrow(info)){
    for(i in cols){
      info[cols[1]][[1]][j] <- paste(if_else(is.na(info[cols[1]][[1]][j]), "", info[cols[1]][[1]][j]),
                                     if_else(is.na(info[i][[1]][j]), "", info[i][[1]][j]), sep="") #combine the current first column with any others that aren't null
    }
  }
  info[cols[1]][[1]] <- na_if(info[cols[1]][[1]], "") #replace all "" with NA
  info[cols[-1]] <- NULL
  return(info)
}

pedsql <- function(info) {
  info <- info[c(1:2, 
                 which(colnames(info)=="pedsql_patient_timestamp"):which(colnames(info)=="pedsql_patient_complete"),
                 which(colnames(info)=="pedsql_parent_timestamp"):which(colnames(info)=="pedsql_parent_complete"))]
  return(info)
}

#identify which columns were changed into factors and defined to be read more easily, if they were changed, choose that column to include, otherwise keep the original (which are mainly things like dates)
temp <- c()
for(i in 1:472){
  name <- paste(colnames(data)[i], ".factor", sep="")
  if(name %in% colnames(data)) {
    temp <- c(temp, which(colnames(data)==name))
    label(data[[which(colnames(data)==name)]]) <- label(data[[i]])
    }
  else{
    temp <- c(temp, i)
  }
}

#remove '.factor' from names
data <- data[c(temp)]
names(data) <- gsub(".factor", "", names(data), fixed = TRUE)

#collect the 4 columns on language preference into 2
data <- add_column(data, "Patient's Language" = NA, .before = "eng")
data$`Patient's Language` <- case_when(
  data$eng == 1 ~ "English",
  data$esp == 1 ~ "Spanish",
  TRUE ~ NA_character_
)
data <- add_column(data, "Parent's Language" = NA, .before = "eng")
data$`Parent's Language` <- case_when(
  data$eng2 == 1 ~ "English",
  data$esp2 == 1 ~ "Spanish",
  TRUE ~ NA_character_
)
data[6:9] <- NULL

#make some better column names
colnames(data)[colnames(data)=="not_part_ethnicity"] <- "Ethnicity"
colnames(data)[colnames(data)=="not_part_asthma"] <- "Asthma?"
colnames(data)[colnames(data)=="not_part_gender"] <- "Gender"
colnames(data)[colnames(data)=="not_part_obese"] <- "Obese?"

#remove test patient
data <- subset(data, redcap_id != 'ce0b1de0534e326798805670fd231294')

#summarize grade levels
data$dem_grade <- as.character(data$dem_grade)
data$dem_grade[(data$dem_grade == "Pre-K" | data$dem_grade == "Kindergarten" | data$dem_grade == "1" | data$dem_grade == "2" | data$dem_grade == "3" | data$dem_grade == "4" | data$dem_grade == "5")] <- "<= 5th Grade"
data$dem_grade[(data$dem_grade == "6" | data$dem_grade == "7" | data$dem_grade == "8")] <- "6-8th Grade"
data$dem_grade[(data$dem_grade == "9" | data$dem_grade == "10" | data$dem_grade == "11" | data$dem_grade == "12")] <- "9-12th Grade"

#remove unused levels
data <- droplevels(data)

#name columns
data <- labelling(data)

#combining columns together
data <- cleaner("tech_kid_brand___1", "tech_kid_brand___7", data)
data <- cleaner("tech_kid_os___1", "tech_kid_os___6", data)