#cleanup languages
data <- languages(data)

#better column names
data <- dem_names(data)

#call function to recode data
data <- recoding(data, "pedsqlkids_01", "pedsqlkids_23", "'0'='100'; '1'='75'; '2'='50'; '3'='25'; '4'='0'")
data <- recoding(data, "pedsqlparent_01", "pedsqlparent_23", "'0'='100'; '1'='75'; '2'='50'; '3'='25'; '4'='0'")

#summarize grade levels
data$dem_grade = factor(data$dem_grade,levels=c("00","0","1","2","3","4","5","6","7","8","9","10","11","12","13"), labels = c("Pre-K","Kindergarten","1","2","3","4","5","6","7","8","9","10","11","12","Other/Otro"))
data$dem_grade <- as.character(data$dem_grade)
data$dem_grade[(data$dem_grade == "Pre-K" | data$dem_grade == "Kindergarten" | data$dem_grade == "1" | data$dem_grade == "2" | data$dem_grade == "3" | data$dem_grade == "4" | data$dem_grade == "5")] <- "<= 5th Grade"
data$dem_grade[(data$dem_grade == "6" | data$dem_grade == "7" | data$dem_grade == "8")] <- "6-8th Grade"
data$dem_grade[(data$dem_grade == "9" | data$dem_grade == "10" | data$dem_grade == "11" | data$dem_grade == "12")] <- "9-12th Grade"

#remove unused levels
data <- droplevels(data)

#combining columns together
data$tech_kid_brand___1 = factor(data$tech_kid_brand___1,levels=c("0","1"), labels = c(NA,"iPhone or iPad"))
data$tech_kid_brand___2 = factor(data$tech_kid_brand___2,levels=c("0","1"), labels = c(NA,"Samsung"))
data$tech_kid_brand___3 = factor(data$tech_kid_brand___3,levels=c("0","1"), labels = c(NA,"LG"))
data$tech_kid_brand___4 = factor(data$tech_kid_brand___4,levels=c("0","1"), labels = c(NA,"HTC"))
data$tech_kid_brand___5 = factor(data$tech_kid_brand___5,levels=c("0","1"), labels = c(NA,"Motorola"))
data$tech_kid_brand___6 = factor(data$tech_kid_brand___6,levels=c("0","1"), labels = c(NA,"Other"))
data$tech_kid_brand___7 = factor(data$tech_kid_brand___7,levels=c("0","1"), labels = c(NA,"Don't Know"))
data$tech_kid_os___1 = factor(data$tech_kid_os___1,levels=c("0","1"), labels = c(NA,"iPhone or iPad"))
data$tech_kid_os___2 = factor(data$tech_kid_os___2,levels=c("0","1"), labels = c(NA,"Android/Google"))
data$tech_kid_os___3 = factor(data$tech_kid_os___3,levels=c("0","1"), labels = c(NA,"Windows"))
data$tech_kid_os___4 = factor(data$tech_kid_os___4,levels=c("0","1"), labels = c(NA,"Blackberry"))
data$tech_kid_os___5 = factor(data$tech_kid_os___5,levels=c("0","1"), labels = c(NA,"Other"))
data$tech_kid_os___6 = factor(data$tech_kid_os___6,levels=c("0","1"), labels = c(NA,"Unsure"))
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