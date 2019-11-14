#cleanup languages
data <- languages(data)

#better column names
data <- dem_names(data)

#remove test patient
data <- subset(data, redcap_id != 'ce0b1de0534e326798805670fd231294')

#call function to recode data
data <- recoding(data, "pedsqlkids_01", "pedsqlkids_23", "'0'='100'; '1'='75'; '2'='50'; '3'='25'; '4'='0'")
data <- recoding(data, "pedsqlparent_01", "pedsqlparent_23", "'0'='100'; '1'='75'; '2'='50'; '3'='25'; '4'='0'")

#summarize grade levels
data$dem_grade <- as.character(data$dem_grade)
data$dem_grade[(data$dem_grade == "Pre-K" | data$dem_grade == "Kindergarten" | data$dem_grade == "1" | data$dem_grade == "2" | data$dem_grade == "3" | data$dem_grade == "4" | data$dem_grade == "5")] <- "<= 5th Grade"
data$dem_grade[(data$dem_grade == "6" | data$dem_grade == "7" | data$dem_grade == "8")] <- "6-8th Grade"
data$dem_grade[(data$dem_grade == "9" | data$dem_grade == "10" | data$dem_grade == "11" | data$dem_grade == "12")] <- "9-12th Grade"

#remove unused levels
data <- droplevels(data)

#combining columns together
data <- cleaner("tech_kid_brand___1", "tech_kid_brand___7", data)
data <- cleaner("tech_kid_os___1", "tech_kid_os___6", data)

#create subgroups for pedsql
data <- survey_columns(info = data, list = c("qlPtTotal", "qlPtPhys",  "qlPtEmotion", "qlPtSocial", "qlPtSchool", "qlParTotal", "qlParPhys", "qlParEmotion", "qlParSocial", "qlParSchool"))

#calculate summary calculation for pedsql filled out by the patients
data$qlPtTotal <- rowmeaning(data, "pedsqlkids_01", "pedsqlkids_23")
data$qlPtPhys <- rowmeaning(data,"pedsqlkids_01","pedsqlkids_08")
data$qlPtEmotion <- rowmeaning(data, "pedsqlkids_09", "pedsqlkids_13")
data$qlPtSocial <- rowmeaning(data, "pedsqlkids_14", "pedsqlkids_18")
data$qlPtSchool <- rowmeaning(data, "pedsqlkids_19", "pedsqlkids_23")

#calculate summary calculation for pedsql filled out by the parents
data$qlParTotal <- rowmeaning(data, "pedsqlparent_01", "pedsqlparent_23")
data$qlParPhys <- rowmeaning(data,"pedsqlparent_01","pedsqlparent_08")
data$qlParEmotion <- rowmeaning(data, "pedsqlparent_09", "pedsqlparent_13")
data$qlParSocial <- rowmeaning(data, "pedsqlparent_14", "pedsqlparent_18")
data$qlParSchool <- rowmeaning(data, "pedsqlparent_19", "pedsqlparent_23")

#make dataframe for those that completed a final visit
complete <- subset(data, data$redcap_id %in% data$redcap_id[which(data$redcap_event_name=="visit6")])

#make dataframe from above of just the first visit (to evaluate demographics)
completeFirst <- droplevels(subset(complete, complete$redcap_event_name=="visit1"))
completeLast <- droplevels(subset(complete, complete$redcap_event_name=="visit6"))

#merging the first and last dataset to make one that can be more easily compared (variables end in .x and .y)
combined <- merge(completeFirst, completeLast, by="redcap_id")

#Table with similar data as above, but formatted differently
firstLast <- complete[complete$redcap_event_name %in% c('visit1', 'visit6'),]