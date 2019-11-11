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

#cleanup languages
data <- languages(data)
data.original <- languages(data.original)

#better column names
data <- dem_names(data)
data.original <- dem_names(data.original)

#remove test patient
data <- subset(data, redcap_id != 'ce0b1de0534e326798805670fd231294')
data.original <- subset(data.original, redcap_id != 'ce0b1de0534e326798805670fd231294')

#summarize grade levels
data$dem_grade <- as.character(data$dem_grade)
data$dem_grade[(data$dem_grade == "Pre-K" | data$dem_grade == "Kindergarten" | data$dem_grade == "1" | data$dem_grade == "2" | data$dem_grade == "3" | data$dem_grade == "4" | data$dem_grade == "5")] <- "<= 5th Grade"
data$dem_grade[(data$dem_grade == "6" | data$dem_grade == "7" | data$dem_grade == "8")] <- "6-8th Grade"
data$dem_grade[(data$dem_grade == "9" | data$dem_grade == "10" | data$dem_grade == "11" | data$dem_grade == "12")] <- "9-12th Grade"

#remove unused levels
data <- droplevels(data)
data.original <- droplevels(data.original)

#name columns
data <- labelling(data)
data.original <- labelling(data.original)

#combining columns together
data <- cleaner("tech_kid_brand___1", "tech_kid_brand___7", data)
data <- cleaner("tech_kid_os___1", "tech_kid_os___6", data)

#make dataframe for anyone completing at least 1 fu
participants <- subset(data, data$redcap_id %in% data$redcap_id[which(data$redcap_event_name=="visit1")])

#make dataframe from above of just the first visit (to evaluate demographics)
participantsFirst <- subset(participants, participants$redcap_event_name=="visit1")
participantsFirst <- demographics(participantsFirst)

#make dataframe for those that completed a final visit
complete <- subset(data, data$redcap_id %in% data$redcap_id[which(data$redcap_event_name=="visit6")])
complete.original <- subset(data.original, data.original$redcap_id %in% data.original$redcap_id[which(data.original$redcap_event_name=="final_visit_arm_1")])

#make dataframe from above of just the first visit (to evaluate demographics)
completeFirst <- subset(complete, complete$redcap_event_name=="visit1")
completeFirst <- droplevels(completeFirst)
demoFirst <- demographics(completeFirst)
demoFirst <- droplevels(demoFirst)
completeLast <- subset(complete, complete$redcap_event_name=="visit6")
completeLast <- droplevels(completeLast)