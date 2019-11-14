#cleanup languages
data <- languages(data)

#better column names
data <- dem_names(data)

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