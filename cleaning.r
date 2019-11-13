#cleanup languages
data <- languages(data)

#better column names
data <- dem_names(data)

#remove test patient
data <- subset(data, redcap_id != 'ce0b1de0534e326798805670fd231294')

#call function to recode data
data <- recoding(data, "pedsqlkids_01", "pedsqlkids_23", "'0'='100'; '1'='75'; '2'='50'; '3'='25'; '4'='0'")
temp <- recoding(data, "pedsqlparent_01", "pedsqlparent_23", "'0'='100'; '1'='75'; '2'='50'; '3'='25'; '4'='0'")

#summarize grade levels
data$dem_grade.f <- as.character(data$dem_grade.f)
data$dem_grade[(data$dem_grade == "Pre-K" | data$dem_grade.f == "Kindergarten" | data$dem_grade.f == "1" | data$dem_grade.f == "2" | data$dem_grade.f == "3" | data$dem_grade.f == "4" | data$dem_grade.f == "5")] <- "<= 5th Grade"
data$dem_grade.f[(data$dem_grade.f == "6" | data$dem_grade.f == "7" | data$dem_grade.f == "8")] <- "6-8th Grade"
data$dem_grade.f[(data$dem_grade.f == "9" | data$dem_grade.f == "10" | data$dem_grade.f == "11" | data$dem_grade.f == "12")] <- "9-12th Grade"

#remove unused levels
data <- droplevels(data)

#name columns
data <- labelling(data, "")
data <- labelling(data, ".f")

#combining columns together
data <- cleaner("tech_kid_brand___1.f", "tech_kid_brand___7.f", data)
data <- cleaner("tech_kid_os___1.f", "tech_kid_os___6.f", data)

#create subgroups for pedsql
data <- add_column(data, "qlPtTotal" = NA, .before = "pedsqlkids_01")
data <- add_column(data, "qlPtPhys" = NA, .before = "pedsqlkids_01")
data <- add_column(data, "qlPtEmotion" = NA, .before = "pedsqlkids_01")
data <- add_column(data, "qlPtSocial" = NA, .before = "pedsqlkids_01")
data <- add_column(data, "qlPtSchool" = NA, .before = "pedsqlkids_01")

data <- add_column(data, "qlParTotal" = NA, .before = "pedsqlparent_01")
data <- add_column(data, "qlParPhys" = NA, .before = "pedsqlparent_01")
data <- add_column(data, "qlParEmotion" = NA, .before = "pedsqlparent_01")
data <- add_column(data, "qlParSocial" = NA, .before = "pedsqlparent_01")
data <- add_column(data, "qlParSchool" = NA, .before = "pedsqlparent_01")


data$qlPtTotal <- rowMeans(data[grep("^pedsqlkids_01$", colnames(data)):grep("^pedsqlkids_23$", colnames(data))])
data$qlPtPhys <- rowMeans(data[grep("^pedsqlkids_01$", colnames(data)):grep("^pedsqlkids_08$", colnames(data))])
data$qlPtEmotion <- rowMeans(data[grep("^pedsqlkids_09$", colnames(data)):grep("^pedsqlkids_13$", colnames(data))])
data$qlPtSocial <- rowMeans(data[grep("^pedsqlkids_14$", colnames(data)):grep("^pedsqlkids_18$", colnames(data))])
data$qlPtSchool <- rowMeans(data[grep("^pedsqlkids_19$", colnames(data)):grep("^pedsqlkids_23$", colnames(data))])

#make dataframe for anyone completing at least 1 fu & demographics
#participants <- subset(data, data$redcap_id %in% data$redcap_id[which(data$redcap_event_name.f=="visit1")])
#participantsFirst <- subset(participants, participants$redcap_event_name.f=="visit1")
#participantsFirst <- demographics(participantsFirst)

#make dataframe for those that completed a final visit
complete <- subset(data, data$redcap_id %in% data$redcap_id[which(data$redcap_event_name.f=="visit6")])

#make dataframe from above of just the first visit (to evaluate demographics)
completeFirst <- droplevels(subset(complete, complete$redcap_event_name.f=="visit1"))
demoFirst <- droplevels(demographics(completeFirst))
completeLast <- droplevels(subset(complete, complete$redcap_event_name.f=="visit6"))

#merging the first and last dataset to make one that can be more easily compared (variables end in .x and .y)
combined <- merge(completeFirst, completeLast, by="redcap_id")

#Table with similar data as above, but for different purposes
firstLast <- complete[complete$redcap_event_name.f %in% c('visit1', 'visit6'),]