#Setting Factors(will create new variable for factors)
data$redcap_event_name = factor(data$redcap_event_name,levels=c("initial_visit_arm_1","fu_visit_1_arm_1","fu_visit_2_arm_1","fu_visit_3_arm_1","fu_visit_4_arm_1","final_visit_arm_1"), labels = c("visit1","visit2","visit3","visit4","visit5","visit6"))
data$start_here_complete = factor(data$start_here_complete,levels=c("0","1","2"), labels = c("Incomplete","Unverified","Complete"))
data$Ethnicity = factor(data$Ethnicity,levels=c("1","2","3","4","5","6"), labels = c("Black, Non-Hispanic","White, Non-Hispanic","Asian or Pacific Islander","Native American or Alaskan Native","Hispanic","Otro"))
data$`Asthma?` = factor(data$`Asthma?`,levels=c("1","0"), labels = c("Yes","No"))
data$`Obese?` = factor(data$`Obese?`,levels=c("1","0"), labels = c("Yes","No"))
data$Gender = factor(data$Gender,levels=c("1","2"), labels = c("Girl","Boy"))
data$participating = factor(data$participating,levels=c("1","0"), labels = c("Yes","No"))
data$borinquen_info_release_complete = factor(data$borinquen_info_release_complete,levels=c("0","1","2"), labels = c("Incomplete","Unverified","Complete"))
data$parent_or_guardian___1 = factor(data$parent_or_guardian___1,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$parent_or_guardian___2 = factor(data$parent_or_guardian___2,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$consent_complete = factor(data$consent_complete,levels=c("0","1","2"), labels = c("Incomplete","Unverified","Complete"))
data$assent_complete = factor(data$assent_complete,levels=c("0","1","2"), labels = c("Incomplete","Unverified","Complete"))
data$parent_or_guardian_v2___1 = factor(data$parent_or_guardian_v2___1,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$parent_or_guardian_v2___2 = factor(data$parent_or_guardian_v2___2,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$consent_2_complete = factor(data$consent_2_complete,levels=c("0","1","2"), labels = c("Incomplete","Unverified","Complete"))
data$consent2_complete = factor(data$consent2_complete,levels=c("0","1","2"), labels = c("Incomplete","Unverified","Complete"))
data$worthtime = factor(data$worthtime,levels=c("1","0"), labels = c("Yes","No"))
data$tablet_v_drvisit___1 = factor(data$tablet_v_drvisit___1,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$tablet_v_drvisit___0 = factor(data$tablet_v_drvisit___0,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$tablet_v_telephone = factor(data$tablet_v_telephone,levels=c("1","0"), labels = c("Yes","No"))
data$parentchild = factor(data$parentchild,levels=c("1","0"), labels = c("Yes","No"))
data$frequency = factor(data$frequency,levels=c("1","2","3","4","5","6"), labels = c("Every 2 weeks","Every month","Every 2 months","Every 3 months","Every 6 months","Other"))
data$easy_tablet = factor(data$easy_tablet,levels=c("1","2","3","4","5"), labels = c("Very Easy","Easy","Neutral","Hard","Very Hard"))
data$wifi = factor(data$wifi,levels=c("1","0"), labels = c("Yes","No"))
data$fuze = factor(data$fuze,levels=c("1","0"), labels = c("Yes","No"))
data$appssites = factor(data$appssites,levels=c("1","2","3","4","5","6","7"), labels = c("Fooducate","Myfitnesspal","Sworkit","Choosemyplate.gov","CDC Bam Food & Nutrition","CDC Bam Physical Activity","None of the above"))
data$acad_accom = factor(data$acad_accom,levels=c("1","0"), labels = c("Yes","No"))
data$perception_complete = factor(data$perception_complete,levels=c("0","1","2"), labels = c("Incomplete","Unverified","Complete"))
data$dem_gender = factor(data$dem_gender,levels=c("1","2"), labels = c("Female","Male"))
data$dem_ethnicity = factor(data$dem_ethnicity,levels=c("1","2","3","4","5","6"), labels = c("Black, Non-Hispanic","White, Non-Hispanic","Asian or Pacific Islander","Native American or Alaskan Native","Hispanic","Other"))
data$dem_language_home = factor(data$dem_language_home,levels=c("1","2","3","4"), labels = c("English","Creole","Spanish","Other"))
data$dem_language_pref = factor(data$dem_language_pref,levels=c("1","2","3","4"), labels = c("English","Creole","Spanish","Other"))
data$demographics_patient_complete = factor(data$demographics_patient_complete,levels=c("0","1","2"), labels = c("Incomplete","Unverified","Complete"))
data$tech_kid_smart_device = factor(data$tech_kid_smart_device,levels=c("1","2","3","4"), labels = c("smart phone","tablet","both a smart phone and a tablet","neither"))
#data$tech_kid_brand___1 = factor(data$tech_kid_brand___1,levels=c("0","1"), labels = c(NA,"iPhone or iPad"))
#data$tech_kid_brand___2 = factor(data$tech_kid_brand___2,levels=c("0","1"), labels = c(NA,"Samsung"))
#data$tech_kid_brand___3 = factor(data$tech_kid_brand___3,levels=c("0","1"), labels = c(NA,"LG"))
#data$tech_kid_brand___4 = factor(data$tech_kid_brand___4,levels=c("0","1"), labels = c(NA,"HTC"))
#data$tech_kid_brand___5 = factor(data$tech_kid_brand___5,levels=c("0","1"), labels = c(NA,"Motorola"))
#data$tech_kid_brand___6 = factor(data$tech_kid_brand___6,levels=c("0","1"), labels = c(NA,"Other"))
#data$tech_kid_brand___7 = factor(data$tech_kid_brand___7,levels=c("0","1"), labels = c(NA,"Don't Know"))
#data$tech_kid_os___1 = factor(data$tech_kid_os___1,levels=c("0","1"), labels = c(NA,"iPhone or iPad"))
#data$tech_kid_os___2 = factor(data$tech_kid_os___2,levels=c("0","1"), labels = c(NA,"Android/Google"))
#data$tech_kid_os___3 = factor(data$tech_kid_os___3,levels=c("0","1"), labels = c(NA,"Windows"))
#data$tech_kid_os___4 = factor(data$tech_kid_os___4,levels=c("0","1"), labels = c(NA,"Blackberry"))
#data$tech_kid_os___5 = factor(data$tech_kid_os___5,levels=c("0","1"), labels = c(NA,"Other"))
#data$tech_kid_os___6 = factor(data$tech_kid_os___6,levels=c("0","1"), labels = c(NA,"Unsure"))
data$tech_kid_phone_service = factor(data$tech_kid_phone_service,levels=c("1","0","2"), labels = c("Yes","No"," Unsure or Not Applicable"))
data$tech_kid_disconnect = factor(data$tech_kid_disconnect,levels=c("1","2","3"), labels = c("1-2 times/year","3-4 times/year","More than 5 times/year"))
data$tech_kid_apps = factor(data$tech_kid_apps,levels=c("1","0"), labels = c("Yes","No"))
data$tech_kid_function___1 = factor(data$tech_kid_function___1,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$tech_kid_function___2 = factor(data$tech_kid_function___2,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$tech_kid_function___3 = factor(data$tech_kid_function___3,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$tech_kid_function___4 = factor(data$tech_kid_function___4,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$tech_kid_function___5 = factor(data$tech_kid_function___5,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$tech_kid_privileges = factor(data$tech_kid_privileges,levels=c("1","2","3","4","5"), labels = c("Never","Almost Never","Sometimes","Often","Almost Always"))
data$tech_kid_device_time = factor(data$tech_kid_device_time,levels=c("0","1","2","3","4","5","6","7"), labels = c("Less than 1 hour","1 hour","1 - 2 hours","2 - 3 hours","3 - 4 hours","4 - 5 hours","5 - 6 hours","More than 6 hours"))
data$tech_kid_given_device = factor(data$tech_kid_given_device,levels=c("1","2","3"), labels = c("Not Likely","Somewhat Likely","Very Likely"))
data$tech_patient_complete = factor(data$tech_patient_complete,levels=c("0","1","2"), labels = c("Incomplete","Unverified","Complete"))
data$pedsqlkids_01.f = factor(data$pedsqlkids_01,levels=c("0","1","2","3","4"))
data$pedsqlkids_02.f = factor(data$pedsqlkids_02,levels=c("0","1","2","3","4")) 
data$pedsqlkids_03.f = factor(data$pedsqlkids_03,levels=c("0","1","2","3","4")) 
data$pedsqlkids_04.f = factor(data$pedsqlkids_04,levels=c("0","1","2","3","4")) 
data$pedsqlkids_05.f = factor(data$pedsqlkids_05,levels=c("0","1","2","3","4")) 
data$pedsqlkids_06.f = factor(data$pedsqlkids_06,levels=c("0","1","2","3","4")) 
data$pedsqlkids_07.f = factor(data$pedsqlkids_07,levels=c("0","1","2","3","4")) 
data$pedsqlkids_08.f = factor(data$pedsqlkids_08,levels=c("0","1","2","3","4")) 
data$pedsqlkids_09.f = factor(data$pedsqlkids_09,levels=c("0","1","2","3","4")) 
data$pedsqlkids_10.f = factor(data$pedsqlkids_10,levels=c("0","1","2","3","4")) 
data$pedsqlkids_11.f = factor(data$pedsqlkids_11,levels=c("0","1","2","3","4")) 
data$pedsqlkids_12.f = factor(data$pedsqlkids_12,levels=c("0","1","2","3","4")) 
data$pedsqlkids_13.f = factor(data$pedsqlkids_13,levels=c("0","1","2","3","4")) 
data$pedsqlkids_14.f = factor(data$pedsqlkids_14,levels=c("0","1","2","3","4")) 
data$pedsqlkids_15.f = factor(data$pedsqlkids_15,levels=c("0","1","2","3","4")) 
data$pedsqlkids_16.f = factor(data$pedsqlkids_16,levels=c("0","1","2","3","4")) 
data$pedsqlkids_17.f = factor(data$pedsqlkids_17,levels=c("0","1","2","3","4")) 
data$pedsqlkids_18.f = factor(data$pedsqlkids_18,levels=c("0","1","2","3","4")) 
data$pedsqlkids_19.f = factor(data$pedsqlkids_19,levels=c("0","1","2","3","4")) 
data$pedsqlkids_20.f = factor(data$pedsqlkids_20,levels=c("0","1","2","3","4")) 
data$pedsqlkids_21.f = factor(data$pedsqlkids_21,levels=c("0","1","2","3","4")) 
data$pedsqlkids_22.f = factor(data$pedsqlkids_22,levels=c("0","1","2","3","4")) 
data$pedsqlkids_23.f = factor(data$pedsqlkids_23,levels=c("0","1","2","3","4")) 
data$pedsql_patient_complete = factor(data$pedsql_patient_complete,levels=c("0","1","2"), labels = c("Incomplete","Unverified","Complete"))
data$act_nutri_kids01.f = factor(data$act_nutri_kids01,levels=c("0","1","2","3","4","5","6","7")) 
data$act_nutri_kids02.f = factor(data$act_nutri_kids02,levels=c("0","1","2","3","4","5","6","7")) 
data$act_nutri_kids03.f = factor(data$act_nutri_kids03,levels=c("0","1","2","3","4","5","6","7")) 
data$act_nutri_kids04.f = factor(data$act_nutri_kids04,levels=c("00","0","1","2","3","4","5")) 
data$act_nutri_kids05.f = factor(data$act_nutri_kids05,levels=c("00","0","1","2","3","4","5")) 
data$act_nutri_kids06.f = factor(data$act_nutri_kids06,levels=c("00","0","1","2","3","4","5")) 
data$act_nutri_kids07.f = factor(data$act_nutri_kids07,levels=c("0","1","2","3","4")) 
data$act_nutri_kids08.f = factor(data$act_nutri_kids08,levels=c("0","1","2","3","4")) 
data$act_nutri_kids09.f = factor(data$act_nutri_kids09,levels=c("0","1","2","3","4")) 
data$act_nutri_kids10.f = factor(data$act_nutri_kids10,levels=c("0","1","2","3","4")) 
data$act_nutri_kids11.f = factor(data$act_nutri_kids11,levels=c("0","1","2","3","4","5","6")) 
data$act_nutri_kids12.f = factor(data$act_nutri_kids12,levels=c("0","1","2","3","4","5","6")) 
data$act_nutri_kids13.f = factor(data$act_nutri_kids13,levels=c("0","1","2","3","4","5","6")) 
data$act_nutri_kids14.f = factor(data$act_nutri_kids14,levels=c("0","1","2","3","4","5","6")) 
data$act_nutri_kids15.f = factor(data$act_nutri_kids15,levels=c("0","1","2","3","4","5","6")) 
data$act_nutri_kids16.f = factor(data$act_nutri_kids16,levels=c("0","1","2","3","4","5","6")) 
data$act_nutri_kids17.f = factor(data$act_nutri_kids17,levels=c("0","1","2","3","4","5","6")) 
data$act_nutri_kids18.f = factor(data$act_nutri_kids18,levels=c("0","1","2","3","4","5","6")) 
data$act_nutri_kids19.f = factor(data$act_nutri_kids19,levels=c("0","1","2","3","4","5","6")) 
data$act_nutri_kids20.f = factor(data$act_nutri_kids20,levels=c("0","1","2","3","4","5","6")) 
data$act_nutri_kids21.f = factor(data$act_nutri_kids21,levels=c("0","1","2","3","4","5","6")) 
data$act_nutri_kids22.f = factor(data$act_nutri_kids22,levels=c("0","1","2","3","4","5","6")) 
data$act_nutri_kids23.f = factor(data$act_nutri_kids23,levels=c("0","1","2","3","4","5","6","7")) 
data$act_nutri_kids24.f = factor(data$act_nutri_kids24,levels=c("0","1","2","3","4","5","6","7")) 
data$act_nutri_kids25.f = factor(data$act_nutri_kids25,levels=c("0","1","2","3","4","5","6","7")) 
data$act_nutri_kids26.f = factor(data$act_nutri_kids26,levels=c("0","1","2","3","4")) 
data$act_nutri_kids27.f = factor(data$act_nutri_kids27,levels=c("0","1","2","3","4")) 
data$physical_activity_nutrition_patient_complete = factor(data$physical_activity_nutrition_patient_complete,levels=c("0","1","2"), labels = c("Incomplete","Unverified","Complete"))
data$weight_01.f = factor(data$weight_01,levels=c("1","2","3","4","5","6","7")) 
data$weight_02.f = factor(data$weight_02,levels=c("1","2","3","4","5","6","7")) 
data$weight_03.f = factor(data$weight_03,levels=c("1","2","3","4","5","6","7")) 
data$weight_04.f = factor(data$weight_04,levels=c("1","2","3","4","5","6","7")) 
data$weight_05.f = factor(data$weight_05,levels=c("1","2","3","4","5","6","7")) 
data$weight_06.f = factor(data$weight_06,levels=c("1","2","3","4","5","6","7")) 
data$weight_07.f = factor(data$weight_07,levels=c("1","2","3","4","5","6","7")) 
data$weight_08.f = factor(data$weight_08,levels=c("1","2","3","4","5","6","7")) 
data$weight_09.f = factor(data$weight_09,levels=c("1","2","3","4","5","6","7")) 
data$weight_10.f = factor(data$weight_10,levels=c("1","2","3","4","5","6","7")) 
data$weight_11.f = factor(data$weight_11,levels=c("1","2","3","4","5","6","7")) 
data$weight_12.f = factor(data$weight_12,levels=c("1","2","3","4","5","6","7")) 
data$weight_13.f = factor(data$weight_13,levels=c("1","2","3","4","5","6","7")) 
data$weight_14.f = factor(data$weight_14,levels=c("1","2","3","4","5","6","7")) 
data$weight_15.f = factor(data$weight_15,levels=c("1","2","3","4","5","6","7")) 
data$weight_16.f = factor(data$weight_16,levels=c("1","2","3","4","5","6","7")) 
data$has_asthma = factor(data$has_asthma,levels=c("1","0"), labels = c("Yes ","No"))
data$weight_patient_complete = factor(data$weight_patient_complete,levels=c("0","1","2"), labels = c("Incomplete","Unverified","Complete"))
data$asthma01___0 = factor(data$asthma01___0,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma01___1 = factor(data$asthma01___1,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma01___11 = factor(data$asthma01___11,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma01___00 = factor(data$asthma01___00,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma01___000 = factor(data$asthma01___000,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma01___111 = factor(data$asthma01___111,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma01___0000 = factor(data$asthma01___0000,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma01___00000 = factor(data$asthma01___00000,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma01___000000 = factor(data$asthma01___000000,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma01___1111 = factor(data$asthma01___1111,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma02 = factor(data$asthma02,levels=c("0","1"), labels = c(" True"," False"))
data$asthma03 = factor(data$asthma03,levels=c("1","0"), labels = c(" True"," False"))
data$asthma04 = factor(data$asthma04,levels=c("0","1"), labels = c(" True"," False"))
data$asthma05 = factor(data$asthma05,levels=c("0","1"), labels = c(" True"," False"))
data$asthma07 = factor(data$asthma07,levels=c("1","0"), labels = c(" True"," False"))
data$asthma08 = factor(data$asthma08,levels=c("1","0"), labels = c(" True"," False"))
data$asthma09 = factor(data$asthma09,levels=c("0","1"), labels = c(" True"," False"))
data$asthma10___0 = factor(data$asthma10___0,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma10___00 = factor(data$asthma10___00,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma10___1 = factor(data$asthma10___1,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma10___000 = factor(data$asthma10___000,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma10___0000 = factor(data$asthma10___0000,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma10___11 = factor(data$asthma10___11,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma10___00000 = factor(data$asthma10___00000,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma10___000000 = factor(data$asthma10___000000,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma10___0000000 = factor(data$asthma10___0000000,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma10___00000000 = factor(data$asthma10___00000000,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma10___111 = factor(data$asthma10___111,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma10___000000000 = factor(data$asthma10___000000000,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma10___1111 = factor(data$asthma10___1111,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma10___0000000000 = factor(data$asthma10___0000000000,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma10___00000000000 = factor(data$asthma10___00000000000,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma10___11111 = factor(data$asthma10___11111,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma10___000000000000 = factor(data$asthma10___000000000000,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma10___0000000000000 = factor(data$asthma10___0000000000000,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma10___000000000000000 = factor(data$asthma10___000000000000000,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma10___0000000000000000 = factor(data$asthma10___0000000000000000,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma10___111111 = factor(data$asthma10___111111,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma11___1 = factor(data$asthma11___1,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma11___11 = factor(data$asthma11___11,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma11___0 = factor(data$asthma11___0,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma11___111 = factor(data$asthma11___111,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma11___00 = factor(data$asthma11___00,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma11___000 = factor(data$asthma11___000,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma11___0000 = factor(data$asthma11___0000,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma11___00000 = factor(data$asthma11___00000,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma11___000000 = factor(data$asthma11___000000,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma11___0000000 = factor(data$asthma11___0000000,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma11___00000000 = factor(data$asthma11___00000000,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma11___000000000 = factor(data$asthma11___000000000,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma11___0000000000 = factor(data$asthma11___0000000000,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma11___00000000000 = factor(data$asthma11___00000000000,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma11___1111 = factor(data$asthma11___1111,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma11___000000000000 = factor(data$asthma11___000000000000,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma11___0000000000000 = factor(data$asthma11___0000000000000,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma11___00000000000000 = factor(data$asthma11___00000000000000,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma11___000000000000000 = factor(data$asthma11___000000000000000,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma11___11111 = factor(data$asthma11___11111,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma11___0000000000000000 = factor(data$asthma11___0000000000000000,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma12 = factor(data$asthma12,levels=c("0","1"), labels = c(" True"," False"))
data$asthma13 = factor(data$asthma13,levels=c("0","1"), labels = c(" True"," False"))
data$asthma14 = factor(data$asthma14,levels=c("0","1"), labels = c(" True"," False"))
data$asthma15 = factor(data$asthma15,levels=c("0","1"), labels = c(" True"," False"))
data$asthma16 = factor(data$asthma16,levels=c("0","1"), labels = c(" True"," False"))
data$asthma17 = factor(data$asthma17,levels=c("0","1"), labels = c(" True"," False"))
data$asthma18 = factor(data$asthma18,levels=c("1","0"), labels = c(" True"," False"))
data$asthma19 = factor(data$asthma19,levels=c("0","1"), labels = c(" True"," False"))
data$asthma20 = factor(data$asthma20,levels=c("0","1"), labels = c(" True"," False"))
data$asthma22 = factor(data$asthma22,levels=c("0","1"), labels = c(" True"," False"))
data$asthma24 = factor(data$asthma24,levels=c("0","1"), labels = c(" True"," False"))
data$asthma25 = factor(data$asthma25,levels=c("0","1"), labels = c(" True"," False"))
data$asthma26 = factor(data$asthma26,levels=c("1","0"), labels = c(" True"," False"))
data$asthma27 = factor(data$asthma27,levels=c("1","0"), labels = c(" True"," False"))
data$asthma28 = factor(data$asthma28,levels=c("0","1"), labels = c(" True"," False"))
data$asthma29 = factor(data$asthma29,levels=c("1","0"), labels = c(" True"," False"))
data$asthma30 = factor(data$asthma30,levels=c("0","1"), labels = c(" True"," False"))
data$asthma31 = factor(data$asthma31,levels=c("1","0"), labels = c(" True"," False"))
data$asthma_knowledge_patient_complete = factor(data$asthma_knowledge_patient_complete,levels=c("0","1","2"), labels = c("Incomplete","Unverified","Complete"))
data$dem_parent_sex = factor(data$dem_parent_sex,levels=c("1","2"), labels = c("Female","Male"))
data$dem_parent_ethnicity = factor(data$dem_parent_ethnicity,levels=c("1","2","3","4","5","6"), labels = c("Black, Non-Hispanic","white, Non-Hispanic","Asian or Pacific Islander","Native American or Alaskan Native","Hispanic","Other"))
data$dem_parent_language_pref = factor(data$dem_parent_language_pref,levels=c("1","2","3","4"), labels = c("English","Creole","Spanish","Other"))
data$dem_parent_school = factor(data$dem_parent_school,levels=c("1","2","3","4","5","6","7"), labels = c("Never attended school","1st to 8th grade (elementary)","9th to 11th grade (some high school)","12th grade or GED (high school graduate)","1 to 3 years college (some college or technical school)","4 or more years college (college graduate)","Graduate training or professional degree"))
data$dem_parent_nationality = factor(data$dem_parent_nationality,levels=c("1","2","3","4","5"), labels = c("United States","Cuba","Mexico","Haiti","Other"))
data$dem_parent_us = factor(data$dem_parent_us,levels=c("1","2","3","4","5","6","7"), labels = c("Less than 1 year","1-3 years","4-6 years","7-9 years","10-12 years","13-15 years","More than 15 years"))
data$dem_kid_nationality = factor(data$dem_kid_nationality,levels=c("1","2","3","4","5"), labels = c("United States","Cuba","Mexico","Haiti","Other"))
data$dem_kid_us = factor(data$dem_kid_us,levels=c("1","2","3","4","5","6","7"), labels = c("Less than 1 year","1-3 years","4-6 years","7-9 years","10-12 years","13-15 years","More than 15 years"))
data$dem_parent_job = factor(data$dem_parent_job,levels=c("1","2","3","4"), labels = c("Full Time","Part Time","Retired","Unemployed"))
data$dem_parent_income = factor(data$dem_parent_income,levels=c("1","2","3","4","5","6","7"), labels = c("Below $10,000","$10,000 - $24,999","$25,000 - $39,999","$40,000 - $54,999","$55,000 - $69,999","$70,000 - $84,000","Over $85,000"))
data$dem_parent_marital = factor(data$dem_parent_marital,levels=c("1","2","3","4","5"), labels = c("Single","Married","Separated","Divorced","Widowed"))
data$dem_parent_habitants = factor(data$dem_parent_habitants,levels=c("2","3","4","5","6","7","8"), labels = c("2 people","3 people","4 people","5 people","6 people","7 people","More than 7 people"))
data$dem_kid_pmhx___1 = factor(data$dem_kid_pmhx___1,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$dem_kid_pmhx___2 = factor(data$dem_kid_pmhx___2,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$dem_kid_pmhx___3 = factor(data$dem_kid_pmhx___3,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$dem_kid_pmhx___4 = factor(data$dem_kid_pmhx___4,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$dem_kid_pmhx___5 = factor(data$dem_kid_pmhx___5,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$dem_kid_pmhx___6 = factor(data$dem_kid_pmhx___6,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$dem_kid_pmhx___7 = factor(data$dem_kid_pmhx___7,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$dem_kid_pmhx___8 = factor(data$dem_kid_pmhx___8,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$dem_kid_pmhx___9 = factor(data$dem_kid_pmhx___9,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$dem_kid_famhx___1 = factor(data$dem_kid_famhx___1,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$dem_kid_famhx___2 = factor(data$dem_kid_famhx___2,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$dem_kid_famhx___3 = factor(data$dem_kid_famhx___3,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$dem_kid_famhx___4 = factor(data$dem_kid_famhx___4,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$dem_kid_famhx___5 = factor(data$dem_kid_famhx___5,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$dem_kid_famhx___6 = factor(data$dem_kid_famhx___6,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$dem_kid_famhx___7 = factor(data$dem_kid_famhx___7,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$dem_kid_famhx___8 = factor(data$dem_kid_famhx___8,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$dem_kid_famhx___9 = factor(data$dem_kid_famhx___9,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$demographics_parent_complete = factor(data$demographics_parent_complete,levels=c("0","1","2"), labels = c("Incomplete","Unverified","Complete"))
data$tech_parent_device = factor(data$tech_parent_device,levels=c("1","2","3","4"), labels = c("smart phone","tablet","both a smart phone and a tablet","neither"))
#data$tech_parent_brand___1 = factor(data$tech_parent_brand___1,levels=c("0","1"), labels = c("Unchecked","Checked"))
#data$tech_parent_brand___2 = factor(data$tech_parent_brand___2,levels=c("0","1"), labels = c("Unchecked","Checked"))
#data$tech_parent_brand___3 = factor(data$tech_parent_brand___3,levels=c("0","1"), labels = c("Unchecked","Checked"))
#data$tech_parent_brand___4 = factor(data$tech_parent_brand___4,levels=c("0","1"), labels = c("Unchecked","Checked"))
#data$tech_parent_brand___5 = factor(data$tech_parent_brand___5,levels=c("0","1"), labels = c("Unchecked","Checked"))
#data$tech_parent_brand___6 = factor(data$tech_parent_brand___6,levels=c("0","1"), labels = c("Unchecked","Checked"))
#data$tech_parent_brand___7 = factor(data$tech_parent_brand___7,levels=c("0","1"), labels = c("Unchecked","Checked"))
#data$tech_parent_os___1 = factor(data$tech_parent_os___1,levels=c("0","1"), labels = c("Unchecked","Checked"))
#data$tech_parent_os___2 = factor(data$tech_parent_os___2,levels=c("0","1"), labels = c("Unchecked","Checked"))
#data$tech_parent_os___3 = factor(data$tech_parent_os___3,levels=c("0","1"), labels = c("Unchecked","Checked"))
#data$tech_parent_os___4 = factor(data$tech_parent_os___4,levels=c("0","1"), labels = c("Unchecked","Checked"))
#data$tech_parent_os___6 = factor(data$tech_parent_os___6,levels=c("0","1"), labels = c("Unchecked","Checked"))
#data$tech_parent_os___7 = factor(data$tech_parent_os___7,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$tech_parent_phone_service = factor(data$tech_parent_phone_service,levels=c("1","0","2"), labels = c("Yes","No"," Unsure or Not Applicable"))
data$tech_parent_disconnect = factor(data$tech_parent_disconnect,levels=c("1","2","3"), labels = c("1-2 times/year","3-4 times/year","More than 5 times/year"))
data$tech_parent_apps = factor(data$tech_parent_apps,levels=c("1","0"), labels = c("Yes","No"))
data$tech_parent_function___1 = factor(data$tech_parent_function___1,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$tech_parent_function___2 = factor(data$tech_parent_function___2,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$tech_parent_function___3 = factor(data$tech_parent_function___3,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$tech_parent_function___4 = factor(data$tech_parent_function___4,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$tech_parent_function___5 = factor(data$tech_parent_function___5,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$tech_parent_info___1 = factor(data$tech_parent_info___1,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$tech_parent_info___2 = factor(data$tech_parent_info___2,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$tech_parent_info___3 = factor(data$tech_parent_info___3,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$tech_parent_info___4 = factor(data$tech_parent_info___4,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$tech_parent_info___5 = factor(data$tech_parent_info___5,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$tech_parent_info___6 = factor(data$tech_parent_info___6,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$tech_parent_info___7 = factor(data$tech_parent_info___7,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$tech_parent_info___8 = factor(data$tech_parent_info___8,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$tech_kid_par_device = factor(data$tech_kid_par_device,levels=c("1","2","3","4"), labels = c("smart phone","tablet","both a smart phone and a tablet","neither"))
data$tech_kid_par_brand___1 = factor(data$tech_kid_par_brand___1,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$tech_kid_par_brand___2 = factor(data$tech_kid_par_brand___2,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$tech_kid_par_brand___3 = factor(data$tech_kid_par_brand___3,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$tech_kid_par_brand___4 = factor(data$tech_kid_par_brand___4,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$tech_kid_par_brand___5 = factor(data$tech_kid_par_brand___5,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$tech_kid_par_brand___6 = factor(data$tech_kid_par_brand___6,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$tech_kid_par_brand___7 = factor(data$tech_kid_par_brand___7,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$tech_kid_par_os___1 = factor(data$tech_kid_par_os___1,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$tech_kid_par_os___2 = factor(data$tech_kid_par_os___2,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$tech_kid_par_os___3 = factor(data$tech_kid_par_os___3,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$tech_kid_par_os___4 = factor(data$tech_kid_par_os___4,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$tech_kid_par_os___6 = factor(data$tech_kid_par_os___6,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$tech_kid_par_os___7 = factor(data$tech_kid_par_os___7,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$tech_kid_par_service = factor(data$tech_kid_par_service,levels=c("1","0","2"), labels = c("Yes","No","Unsure or Not Applicable"))
data$tech_kid_par_disconnected = factor(data$tech_kid_par_disconnected,levels=c("1","2","3"), labels = c("1-2 times/year","3-4 times/year","More than 5 times/year"))
data$tech_kid_par_app = factor(data$tech_kid_par_app,levels=c("1","0"), labels = c("Yes","No"))
data$tech_parent_privileges = factor(data$tech_parent_privileges,levels=c("1","2","3","4","5"), labels = c("Never","Almost Never","Sometimes","Often","Almost Always"))
data$tech_parent_uses = factor(data$tech_parent_uses,levels=c("1","2","3"), labels = c("Not Likely","Somewhat Likely","Very Likely"))
data$tech_parent_complete = factor(data$tech_parent_complete,levels=c("0","1","2"), labels = c("Incomplete","Unverified","Complete"))
data$pedsqlparent_01.f = factor(data$pedsqlparent_01,levels=c("0","1","2","3","4")) 
data$pedsqlparent_02.f = factor(data$pedsqlparent_02,levels=c("0","1","2","3","4")) 
data$pedsqlparent_03.f = factor(data$pedsqlparent_03,levels=c("0","1","2","3","4")) 
data$pedsqlparent_04.f = factor(data$pedsqlparent_04,levels=c("0","1","2","3","4")) 
data$pedsqlparent_05.f = factor(data$pedsqlparent_05,levels=c("0","1","2","3","4")) 
data$pedsqlparent_06.f = factor(data$pedsqlparent_06,levels=c("0","1","2","3","4")) 
data$pedsqlparent_07.f = factor(data$pedsqlparent_07,levels=c("0","1","2","3","4")) 
data$pedsqlparent_08.f = factor(data$pedsqlparent_08,levels=c("0","1","2","3","4")) 
data$pedsqlparent_09.f = factor(data$pedsqlparent_09,levels=c("0","1","2","3","4")) 
data$pedsqlparent_10.f = factor(data$pedsqlparent_10,levels=c("0","1","2","3","4")) 
data$pedsqlparent_11.f = factor(data$pedsqlparent_11,levels=c("0","1","2","3","4")) 
data$pedsqlparent_12.f = factor(data$pedsqlparent_12,levels=c("0","1","2","3","4")) 
data$pedsqlparent_13.f = factor(data$pedsqlparent_13,levels=c("0","1","2","3","4")) 
data$pedsqlparent_14.f = factor(data$pedsqlparent_14,levels=c("0","1","2","3","4")) 
data$pedsqlparent_15.f = factor(data$pedsqlparent_15,levels=c("0","1","2","3","4")) 
data$pedsqlparent_16.f = factor(data$pedsqlparent_16,levels=c("0","1","2","3","4")) 
data$pedsqlparent_17.f = factor(data$pedsqlparent_17,levels=c("0","1","2","3","4")) 
data$pedsqlparent_18.f = factor(data$pedsqlparent_18,levels=c("0","1","2","3","4")) 
data$pedsqlparent_19.f = factor(data$pedsqlparent_19,levels=c("0","1","2","3","4")) 
data$pedsqlparent_20.f = factor(data$pedsqlparent_20,levels=c("0","1","2","3","4")) 
data$pedsqlparent_21.f = factor(data$pedsqlparent_21,levels=c("0","1","2","3","4")) 
data$pedsqlparent_22.f = factor(data$pedsqlparent_22,levels=c("0","1","2","3","4")) 
data$pedsqlparent_23.f = factor(data$pedsqlparent_23,levels=c("0","1","2","3","4"))
data$pedsql_parent_complete = factor(data$pedsql_parent_complete,levels=c("0","1","2"), labels = c("Incomplete","Unverified","Complete"))
data$act_nutri_parent01.f = factor(data$act_nutri_parent01,levels=c("1","0")) 
data$act_nutri_parent02.f = factor(data$act_nutri_parent02,levels=c("0","1","2","3","4","5","6","7")) 
data$act_nutri_parent03.f = factor(data$act_nutri_parent03,levels=c("0","1","2","3","4","5","6","7")) 
data$act_nutri_parent04.f = factor(data$act_nutri_parent04,levels=c("0","1","2","3","4","5","6","7")) 
data$act_nutri_parent05.f = factor(data$act_nutri_parent05,levels=c("00","0","1","2","3","4","5")) 
data$act_nutri_parent06.f = factor(data$act_nutri_parent06,levels=c("00","0","1","2","3","4","5")) 
data$act_nutri_parent07.f = factor(data$act_nutri_parent07,levels=c("00","0","1","2","3","4","5")) 
data$act_nutri_parent08.f = factor(data$act_nutri_parent08,levels=c("0","1","2","3","4","5")) 
data$act_nutri_parent09.f = factor(data$act_nutri_parent09,levels=c("0","1","2","3","4","5")) 
data$act_nutri_parent10.f = factor(data$act_nutri_parent10,levels=c("1","2")) 
data$act_nutri_parent11.f = factor(data$act_nutri_parent11,levels=c("0","1","2","3","4","5")) 
data$act_nutri_parent12.f = factor(data$act_nutri_parent12,levels=c("0","1","2","3","4")) 
data$act_nutri_parent13.f = factor(data$act_nutri_parent13,levels=c("0","1","2","3","4")) 
data$act_nutri_parent14.f = factor(data$act_nutri_parent14,levels=c("0","1","2","3","4")) 
data$act_nutri_parent15.f = factor(data$act_nutri_parent15,levels=c("0","1","2","3","4")) 
data$act_nutri_parent16.f = factor(data$act_nutri_parent16,levels=c("0","1","2","3","4","5","6")) 
data$act_nutri_parent17.f = factor(data$act_nutri_parent17,levels=c("0","1","2","3","4","5","6")) 
data$act_nutri_parent18.f = factor(data$act_nutri_parent18,levels=c("0","1","2","3","4","5","6")) 
data$act_nutri_parent19.f = factor(data$act_nutri_parent19,levels=c("0","1","2","3","4","5","6")) 
data$act_nutri_parent20.f = factor(data$act_nutri_parent20,levels=c("0","1","2","3","4","5","6")) 
data$act_nutri_parent21.f = factor(data$act_nutri_parent21,levels=c("0","1","2","3","4","5","6")) 
data$act_nutri_parent22.f = factor(data$act_nutri_parent22,levels=c("0","1","2","3","4","5","6")) 
data$act_nutri_parent23.f = factor(data$act_nutri_parent23,levels=c("0","1","2","3","4","5","6")) 
data$act_nutri_parent24.f = factor(data$act_nutri_parent24,levels=c("0","1","2","3","4","5","6")) 
data$act_nutri_parent25.f = factor(data$act_nutri_parent25,levels=c("0","1","2","3","4","5","6")) 
data$act_nutri_parent26.f = factor(data$act_nutri_parent26,levels=c("0","1","2","3","4","5","6")) 
data$act_nutri_parent27.f = factor(data$act_nutri_parent27,levels=c("0","1","2","3","4","5","6")) 
data$act_nutri_parent28.f = factor(data$act_nutri_parent28,levels=c("0","1","2","3","4","5","6","7")) 
data$act_nutri_parent29.f = factor(data$act_nutri_parent29,levels=c("0","1","2","3","4","5")) 
data$act_nutri_parent30.f = factor(data$act_nutri_parent30,levels=c("0","1","2","3","4","5","6","7")) 
data$act_nutri_parent31.f = factor(data$act_nutri_parent31,levels=c("0","1","2","3","4")) 
data$physical_activity_nutrition_parent_complete = factor(data$physical_activity_nutrition_parent_complete,levels=c("0","1","2"), labels = c("Incomplete","Unverified","Complete"))
data$asthma_parent01___0 = factor(data$asthma_parent01___0,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma_parent01___1 = factor(data$asthma_parent01___1,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma_parent01___11 = factor(data$asthma_parent01___11,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma_parent01___00 = factor(data$asthma_parent01___00,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma_parent01___000 = factor(data$asthma_parent01___000,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma_parent01___111 = factor(data$asthma_parent01___111,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma_parent01___0000 = factor(data$asthma_parent01___0000,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma_parent01___00000 = factor(data$asthma_parent01___00000,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma_parent01___000000 = factor(data$asthma_parent01___000000,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma_parent01___1111 = factor(data$asthma_parent01___1111,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma_parent02 = factor(data$asthma_parent02,levels=c("0","1"), labels = c(" True"," False"))
data$asthma_parent03 = factor(data$asthma_parent03,levels=c("1","0"), labels = c(" True"," False"))
data$asthma_parent04 = factor(data$asthma_parent04,levels=c("0","1"), labels = c(" True"," False"))
data$asthma_parent05 = factor(data$asthma_parent05,levels=c("0","1"), labels = c(" True"," False"))
data$asthma_parent07 = factor(data$asthma_parent07,levels=c("1","0"), labels = c(" True"," False"))
data$asthma_parent08 = factor(data$asthma_parent08,levels=c("1","0"), labels = c(" True"," False"))
data$asthma_parent09 = factor(data$asthma_parent09,levels=c("0","1"), labels = c(" True"," False"))
data$asthma_parent10___0 = factor(data$asthma_parent10___0,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma_parent10___00 = factor(data$asthma_parent10___00,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma_parent10___1 = factor(data$asthma_parent10___1,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma_parent10___000 = factor(data$asthma_parent10___000,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma_parent10___0000 = factor(data$asthma_parent10___0000,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma_parent10___11 = factor(data$asthma_parent10___11,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma_parent10___00000 = factor(data$asthma_parent10___00000,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma_parent10___000000 = factor(data$asthma_parent10___000000,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma_parent10___0000000 = factor(data$asthma_parent10___0000000,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma_parent10___00000000 = factor(data$asthma_parent10___00000000,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma_parent10___111 = factor(data$asthma_parent10___111,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma_parent10___000000000 = factor(data$asthma_parent10___000000000,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma_parent10___1111 = factor(data$asthma_parent10___1111,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma_parent10___0000000000 = factor(data$asthma_parent10___0000000000,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma_parent10___00000000000 = factor(data$asthma_parent10___00000000000,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma_parent10___11111 = factor(data$asthma_parent10___11111,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma_parent10___000000000000 = factor(data$asthma_parent10___000000000000,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma_parent10___0000000000000 = factor(data$asthma_parent10___0000000000000,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma_parent10___000000000000000 = factor(data$asthma_parent10___000000000000000,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma_parent10___0000000000000000 = factor(data$asthma_parent10___0000000000000000,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma_parent10___111111 = factor(data$asthma_parent10___111111,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma_parent11___1 = factor(data$asthma_parent11___1,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma_parent11___11 = factor(data$asthma_parent11___11,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma_parent11___0 = factor(data$asthma_parent11___0,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma_parent11___111 = factor(data$asthma_parent11___111,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma_parent11___00 = factor(data$asthma_parent11___00,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma_parent11___000 = factor(data$asthma_parent11___000,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma_parent11___0000 = factor(data$asthma_parent11___0000,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma_parent11___00000 = factor(data$asthma_parent11___00000,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma_parent11___000000 = factor(data$asthma_parent11___000000,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma_parent11___0000000 = factor(data$asthma_parent11___0000000,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma_parent11___00000000 = factor(data$asthma_parent11___00000000,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma_parent11___000000000 = factor(data$asthma_parent11___000000000,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma_parent11___0000000000 = factor(data$asthma_parent11___0000000000,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma_parent11___00000000000 = factor(data$asthma_parent11___00000000000,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma_parent11___1111 = factor(data$asthma_parent11___1111,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma_parent11___000000000000 = factor(data$asthma_parent11___000000000000,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma_parent11___0000000000000 = factor(data$asthma_parent11___0000000000000,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma_parent11___00000000000000 = factor(data$asthma_parent11___00000000000000,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma_parent11___000000000000000 = factor(data$asthma_parent11___000000000000000,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma_parent11___11111 = factor(data$asthma_parent11___11111,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma_parent11___0000000000000000 = factor(data$asthma_parent11___0000000000000000,levels=c("0","1"), labels = c("Unchecked","Checked"))
data$asthma_parent12 = factor(data$asthma_parent12,levels=c("0","1"), labels = c(" True"," False"))
data$asthma_parent13 = factor(data$asthma_parent13,levels=c("0","1"), labels = c(" True"," False"))
data$asthma_parent14 = factor(data$asthma_parent14,levels=c("0","1"), labels = c(" True"," False"))
data$asthma_parent15 = factor(data$asthma_parent15,levels=c("0","1"), labels = c(" True"," False"))
data$asthma_parent16 = factor(data$asthma_parent16,levels=c("0","1"), labels = c(" True"," False"))
data$asthma_parent17 = factor(data$asthma_parent17,levels=c("0","1"), labels = c(" True"," False"))
data$asthma_parent18 = factor(data$asthma_parent18,levels=c("1","0"), labels = c(" True"," False"))
data$asthma_parent19 = factor(data$asthma_parent19,levels=c("0","1"), labels = c(" True"," False"))
data$asthma_parent20 = factor(data$asthma_parent20,levels=c("0","1"), labels = c(" True"," False"))
data$asthma_parent22 = factor(data$asthma_parent22,levels=c("0","1"), labels = c(" True"," False"))
data$asthma_parent24 = factor(data$asthma_parent24,levels=c("0","1"), labels = c(" True"," False"))
data$asthma_parent25 = factor(data$asthma_parent25,levels=c("0","1"), labels = c(" True"," False"))
data$asthma_parent26 = factor(data$asthma_parent26,levels=c("1","0"), labels = c(" True"," False"))
data$asthma_parent27 = factor(data$asthma_parent27,levels=c("1","0"), labels = c(" True"," False"))
data$asthma_parent28 = factor(data$asthma_parent28,levels=c("0","1"), labels = c(" True"," False"))
data$asthma_parent29 = factor(data$asthma_parent29,levels=c("1","0"), labels = c(" True"," False"))
data$asthma_parent30 = factor(data$asthma_parent30,levels=c("0","1"), labels = c(" True"," False"))
data$asthma_parent31 = factor(data$asthma_parent31,levels=c("1","0"), labels = c(" True"," False"))
data$asthma_knowledge_parent_complete = factor(data$asthma_knowledge_parent_complete,levels=c("0","1","2"), labels = c("Incomplete","Unverified","Complete"))
data$usherwood_01.f = factor(data$usherwood_01,levels=c("0","1","2","3","4")) 
data$usherwood_02.f = factor(data$usherwood_02,levels=c("0","1","2","3","4")) 
data$usherwood_03.f = factor(data$usherwood_03,levels=c("0","1","2","3","4")) 
data$usherwood_04.f = factor(data$usherwood_04,levels=c("0","1","2","3","4")) 
data$usherwood_05.f = factor(data$usherwood_05,levels=c("0","1","2","3","4")) 
data$usherwood_06.f = factor(data$usherwood_06,levels=c("0","1","2","3","4")) 
data$usherwood_07.f = factor(data$usherwood_07,levels=c("0","1","2","3","4")) 
data$usherwood_08.f = factor(data$usherwood_08,levels=c("0","1","2","3","4")) 
data$usherwood_09.f = factor(data$usherwood_09,levels=c("0","1","2","3","4")) 
data$usherwood_10.f = factor(data$usherwood_10,levels=c("0","1","2","3","4")) 
data$usherwood_11.f = factor(data$usherwood_11,levels=c("0","1","2","3","4")) 
data$usherwood_12.f = factor(data$usherwood_12,levels=c("0","1","2","3","4")) 
data$usherwood_13.f = factor(data$usherwood_13,levels=c("0","1","2","3","4")) 
data$usherwood_14.f = factor(data$usherwood_14,levels=c("0","1","2","3","4")) 
data$usherwood_15.f = factor(data$usherwood_15,levels=c("0","1","2","3","4")) 
data$usherwood_16.f = factor(data$usherwood_16,levels=c("0","1","2","3","4")) 
data$usherwood_17.f = factor(data$usherwood_17,levels=c("0","1","2","3","4")) 
data$usherwood_complete = factor(data$usherwood_complete,levels=c("0","1","2"), labels = c("Incomplete","Unverified","Complete"))
data$tablet_group = factor(data$tablet_group,levels=c("1","0"), labels = c("Yes","No"))
data$equipment_signout_complete = factor(data$equipment_signout_complete,levels=c("0","1","2"), labels = c("Incomplete","Unverified","Complete"))
data$gift_receipt_complete = factor(data$gift_receipt_complete,levels=c("0","1","2"), labels = c("Incomplete","Unverified","Complete"))

#Extra levels for the surveys
levels(data$pedsqlkids_01.f)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$pedsqlkids_02.f)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$pedsqlkids_03.f)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$pedsqlkids_04.f)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$pedsqlkids_05.f)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$pedsqlkids_06.f)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$pedsqlkids_07.f)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$pedsqlkids_08.f)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$pedsqlkids_09.f)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$pedsqlkids_10.f)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$pedsqlkids_11.f)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$pedsqlkids_12.f)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$pedsqlkids_13.f)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$pedsqlkids_14.f)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$pedsqlkids_15.f)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$pedsqlkids_16.f)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$pedsqlkids_17.f)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$pedsqlkids_18.f)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$pedsqlkids_19.f)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$pedsqlkids_20.f)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$pedsqlkids_21.f)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$pedsqlkids_22.f)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$pedsqlkids_23.f)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$act_nutri_kids01.f)=c(" 0 days"," 1 day"," 2 days "," 3 days "," 4 days "," 5 days "," 6 days "," 7 days ")
levels(data$act_nutri_kids02.f)=c(" 0 days"," 1 day"," 2 days "," 3 days "," 4 days "," 5 days "," 6 days "," 7 days ")
levels(data$act_nutri_kids03.f)=c(" 0 days"," 1 day"," 2 days "," 3 days "," 4 days "," 5 days "," 6 days "," 7 days ")
levels(data$act_nutri_kids04.f)=c(" I do not play video or computer games or use a computer for something that is not school work","Less than 1 hour per day","1 hour per day ","2 hours per day ","3 hours per day ","4 hours per day","5 or more hours per day")
levels(data$act_nutri_kids05.f)=c("I do not watch DVDs or videos on an average school day","Less than 1 hour per day","1 hour per day ","2 hours per day ","3 hours per day ","4 hours per day","5 or more hours per day")
levels(data$act_nutri_kids06.f)=c("I do not watch TV on an average school day","Less than 1 hour per day","1 hour per day ","2 hours per day ","3 hours per day ","4 hours per day","5 or more hours per day")
levels(data$act_nutri_kids07.f)=c("Never","1-2 times per week","3-4 times per week","5-6 times per week","Daily")
levels(data$act_nutri_kids08.f)=c("Never","1-2 times per week","3-4 times per week","5-6 times per week","Daily")
levels(data$act_nutri_kids09.f)=c("Never","1-2 times per week","3-4 times per week","5-6 times per week","Daily")
levels(data$act_nutri_kids10.f)=c("Never","1-2 times per week","3-4 times per week","5-6 times per week","Daily")
levels(data$act_nutri_kids11.f)=c(" I did not eat fruit during the past 7 days"," 1 to 3 times during the past 7 days"," 4 to 6 times during the past 7 days "," 1 time per day"," 2 times per day"," 3 times per day"," 4 or more times per day")
levels(data$act_nutri_kids12.f)=c(" I did not eat green salad during the past 7 days"," 1 to 3 times during the past 7 days  "," 4 to 6 times during the past 7 days "," 1 time per day"," 2 times per day"," 3 times per day"," 4 or more times per day")
levels(data$act_nutri_kids13.f)=c(" I did not eat potatoes during the past 7 days"," 1 to 3 times during the past 7 days  "," 4 to 6 times during the past 7 days "," 1 time per day"," 2 times per day"," 3 times per day"," 4 or more times per day")
levels(data$act_nutri_kids14.f)=c(" I did not eat carrots during the past 7 days"," 1 to 3 times during the past 7 days  "," 4 to 6 times during the past 7 days "," 1 time per day"," 2 times per day"," 3 times per day"," 4 or more times per day")
levels(data$act_nutri_kids15.f)=c(" I did not eat other vegetables during the past 7 days"," 1 to 3 times during the past 7 days  "," 4 to 6 times during the past 7 days "," 1 time per day"," 2 times per day"," 3 times per day"," 4 or more times per day")
levels(data$act_nutri_kids16.f)=c(" I did not eat pizza during the past 7 days"," 1 to 3 times during the past 7 days  "," 4 to 6 times during the past 7 days "," 1 time per day"," 2 times per day"," 3 times per day"," 4 or more times per day")
levels(data$act_nutri_kids17.f)=c(" I did not drink 100% fruit juice during the past 7 days"," 1 to 3 times during the past 7 days  "," 4 to 6 times during the past 7 days "," 1 time per day"," 2 times per day"," 3 times per day"," 4 or more times per day")
levels(data$act_nutri_kids18.f)=c(" I did not drink soda or pop during the past 7 days"," 1 to 3 times during the past 7 days  "," 4 to 6 times during the past 7 days "," 1 time per day"," 2 times per day"," 3 times per day"," 4 or more times per day")
levels(data$act_nutri_kids19.f)=c(" I did not drink sugar-sweetened beverages  during the past 7 days"," 1 to 3 times during the past 7 days  "," 4 to 6 times during the past 7 days "," 1 time per day"," 2 times per day"," 3 times per day"," 4 or more times per day")
levels(data$act_nutri_kids20.f)=c(" I did not drink water during the past 7 daysNo he bebido agua "," 1 to 3 times during the past 7 days  "," 4 to 6 times during the past 7 days "," 1 time per day"," 2 times per day"," 3 times per day"," 4 or more times per day")
levels(data$act_nutri_kids21.f)=c(" None"," 1/2 cup or less"," 1/2 cup to 1 cup"," 1 to 2 cups"," 2 to 3 cups"," 3 to 4 cups"," 4 or more cups")
levels(data$act_nutri_kids22.f)=c(" None"," 1/2 cup or less"," 1/2 cup to 1 cup"," 1 to 2 cups"," 2 to 3 cups"," 3 to 4 cups"," 4 or more cups")
levels(data$act_nutri_kids23.f)=c(" 0 days"," 1 day"," 2 days "," 3 days "," 4 days "," 5 days "," 6 days "," 7 days ")
levels(data$act_nutri_kids24.f)=c(" 0 days"," 1 day"," 2 days "," 3 days "," 4 days "," 5 days "," 6 days "," 7 days ")
levels(data$act_nutri_kids25.f)=c(" 0 days"," 1 day"," 2 days "," 3 days "," 4 days "," 5 days "," 6 days "," 7 days ")
levels(data$act_nutri_kids26.f)=c(" Never"," Rarely"," Sometimes"," Most of the time"," Always")
levels(data$act_nutri_kids27.f)=c(" Never"," Rarely"," Sometimes"," Most of the time"," Always")
levels(data$weight_01.f)=c("Not True At All 1","2","3","Somewhat True4","5","6","Very True7")
levels(data$weight_02.f)=c("Not True At All 1","2","3","Somewhat True4","5","6","Very True7")
levels(data$weight_03.f)=c("Not True At All 1","2","3","Somewhat True4","5","6","Very True7")
levels(data$weight_04.f)=c("Not True At All 1","2","3","Somewhat True4","5","6","Very True7")
levels(data$weight_05.f)=c("Not True At All 1","2","3","Somewhat True4","5","6","Very True7")
levels(data$weight_06.f)=c("Not True At All 1","2","3","Somewhat True4","5","6","Very True7")
levels(data$weight_07.f)=c("Not True At All 1","2","3","Somewhat True4","5","6","Very True7")
levels(data$weight_08.f)=c("Not True At All 1","2","3","Somewhat True4","5","6","Very True7")
levels(data$weight_09.f)=c("Not True At All1","2","3","Somewhat True4","5","6","Very True7")
levels(data$weight_10.f)=c("Not True At All1","2","3","Somewhat True4","5","6","Very True7")
levels(data$weight_11.f)=c("Not True At All1","2","3","Somewhat True4","5","6","Very True7")
levels(data$weight_12.f)=c("Not True At All1","2","3","Somewhat True4","5","6","Very True7")
levels(data$weight_13.f)=c("Not True At All1","2","3","Somewhat True4","5","6","Very True7")
levels(data$weight_14.f)=c("Not True At All1","2","3","Somewhat True4","5","6","Very True7")
levels(data$weight_15.f)=c("Not True At All1","2","3","Somewhat True4","5","6","Very True7")
levels(data$weight_16.f)=c("Not True At All1","2","3","Somewhat True4","5","6","Very True7")
levels(data$pedsqlparent_01.f)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$pedsqlparent_02.f)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$pedsqlparent_03.f)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$pedsqlparent_04.f)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$pedsqlparent_05.f)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$pedsqlparent_06.f)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$pedsqlparent_07.f)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$pedsqlparent_08.f)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$pedsqlparent_09.f)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$pedsqlparent_10.f)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$pedsqlparent_11.f)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$pedsqlparent_12.f)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$pedsqlparent_13.f)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$pedsqlparent_14.f)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$pedsqlparent_15.f)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$pedsqlparent_16.f)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$pedsqlparent_17.f)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$pedsqlparent_18.f)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$pedsqlparent_19.f)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$pedsqlparent_20.f)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$pedsqlparent_21.f)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$pedsqlparent_22.f)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$pedsqlparent_23.f)=c("Never","Almost Never","Sometimes","Often","Almost Always")
levels(data$act_nutri_parent01.f)=c("YesSi","No")
levels(data$act_nutri_parent02.f)=c(" 0 days"," 1 day"," 2 days "," 3 days "," 4 days "," 5 days "," 6 days "," 7 days ")
levels(data$act_nutri_parent03.f)=c(" 0 days"," 1 day"," 2 days "," 3 days "," 4 days "," 5 days "," 6 days "," 7 days ")
levels(data$act_nutri_parent04.f)=c(" 0 days"," 1 day"," 2 days "," 3 days "," 4 days "," 5 days "," 6 days "," 7 days ")
levels(data$act_nutri_parent05.f)=c("o He/she does not play video or computer games or use a computer for something that is not schoolwork","Less than 1 hour per day","1 hour per day ","2 hours per day ","3 hours per day ","4 hours per day","5 or more hours per day")
levels(data$act_nutri_parent06.f)=c("o He/she does not watch DVDs or videos on an average school day","Less than 1 hour per day","1 hour per day ","2 hours per day ","3 hours per day ","4 hours per day","5 or more hours per day")
levels(data$act_nutri_parent07.f)=c(" He/she does not watch television on an average school day","Less than 1 hour per day","1 hour per day ","2 hours per day ","3 hours per day ","4 hours per day","5 or more hours per day")
levels(data$act_nutri_parent08.f)=c(" 0 days"," 1 day"," 2 days "," 3 days "," 4 days "," 5 days ")
levels(data$act_nutri_parent09.f)=c("0","1","2","3","4","5 or more")
levels(data$act_nutri_parent10.f)=c("Yes","No")
levels(data$act_nutri_parent11.f)=c(" 0 days"," 1 day"," 2 days "," 3 days "," 4 days "," 5 days ")
levels(data$act_nutri_parent12.f)=c("Never","1-2 times per week","3-4 times per week","5-6 times per week","Daily")
levels(data$act_nutri_parent13.f)=c("Never","1-2 times per week","3-4 times per week","5-6 times per week","Daily")
levels(data$act_nutri_parent14.f)=c("Never","1-2 times per week","3-4 times per week","5-6 times per week","Daily")
levels(data$act_nutri_parent15.f)=c("Never","1-2 times per week","3-4 times per week","5-6 times per week","Daily")
levels(data$act_nutri_parent16.f)=c(" I did not eat fruit during the past 7 days"," 1 to 3 times during the past 7 days"," 4 to 6 times during the past 7 days "," 1 time per day"," 2 times per day","3 times per day","4 or more times per day")
levels(data$act_nutri_parent17.f)=c(" I did not eat green salad during the past 7 days"," 1 to 3 times during the past 7 days  "," 4 to 6 times during the past 7 days "," 1 time per day"," 2 times per day"," 3 times per day"," 4 or more times per day")
levels(data$act_nutri_parent18.f)=c(" I did not eat potatoes during the past 7 days"," 1 to 3 times during the past 7 days  "," 4 to 6 times during the past 7 days "," 1 time per day"," 2 times per day"," 3 times per day"," 4 or more times per day")
levels(data$act_nutri_parent19.f)=c(" I did not eat carrots during the past 7 days"," 1 to 3 times during the past 7 days  "," 4 to 6 times during the past 7 days "," 1 time per day"," 2 times per day"," 3 times per day"," 4 or more times per day")
levels(data$act_nutri_parent20.f)=c(" I did not eat other vegetables during the past 7 days"," 1 to 3 times during the past 7 days  "," 4 to 6 times during the past 7 days "," 1 time per day"," 2 times per day"," 3 times per day"," 4 or more times per day")
levels(data$act_nutri_parent21.f)=c(" I did not eat pizza during the past 7 days"," 1 to 3 times during the past 7 days  "," 4 to 6 times during the past 7 days "," 1 time per day"," 2 times per day"," 3 times per day"," 4 or more times per day")
levels(data$act_nutri_parent22.f)=c(" I did not drink soda or pop during the past 7 days"," 1 to 3 times during the past 7 days  "," 4 to 6 times during the past 7 days "," 1 time per day"," 2 times per day"," 3 times per day"," 4 or more times per day")
levels(data$act_nutri_parent23.f)=c(" I did not drink diet soda or pop during the past 7 days"," 1 to 3 times during the past 7 days  "," 4 to 6 times during the past 7 days "," 1 time per day"," 2 times per day"," 3 times per day"," 4 or more times per day")
levels(data$act_nutri_parent24.f)=c(" I did not drink sugar-sweetened beverages  during the past 7 days"," 1 to 3 times during the past 7 days  "," 4 to 6 times during the past 7 days "," 1 time per day"," 2 times per day"," 3 times per day"," 4 or more times per day")
levels(data$act_nutri_parent25.f)=c(" I did not drink water during the past 7 days"," 1 to 3 times during the past 7 days","4 to 6 times during the past 7 days "," 1 time per day"," 2 times per day"," 3 times per day"," 4 or more times per day")
levels(data$act_nutri_parent26.f)=c(" None"," 1/2 cup or less"," 1/2 cup to 1 cup"," 1 to 2 cups"," 2 to 3 cups"," 3 to 4 cups"," 4 or more cups")
levels(data$act_nutri_parent27.f)=c(" None"," 1/2 cup or less"," 1/2 cup to 1 cup"," 1 to 2 cups"," 2 to 3 cups"," 3 to 4 cups"," 4 or more cups")
levels(data$act_nutri_parent28.f)=c(" 0 days"," 1 day"," 2 days "," 3 days "," 4 days "," 5 days "," 6 days "," 7 days ")
levels(data$act_nutri_parent29.f)=c("S/he does not eat dinner at home"," Never"," Rarely"," Sometimes"," Most of the time"," Always")
levels(data$act_nutri_parent30.f)=c(" 0 days"," 1 day"," 2 days "," 3 days "," 4 days "," 5 days "," 6 days "," 7 days ")
levels(data$act_nutri_parent31.f)=c(" Never"," Rarely"," Sometimes"," Most of the time"," Always")
levels(data$usherwood_01.f)=c("Not at all","A few days","Some days","Most days","Every day")
levels(data$usherwood_02.f)=c("Not at all","A few days","Some days","Most days","Every day")
levels(data$usherwood_03.f)=c("Not at all","A few days","Some days","Most days","Every day")
levels(data$usherwood_04.f)=c("Not at all","A few days","Some days","Most days","Every day")
levels(data$usherwood_05.f)=c("Not at all","A few days","Some days","Most days","Every day")
levels(data$usherwood_06.f)=c("Not at all","A few days","Some days","Most days","Every day")
levels(data$usherwood_07.f)=c("Not at all","A few days","Some days","Most days","Every day")
levels(data$usherwood_08.f)=c("Not at all","A few days","Some days","Most days","Every day")
levels(data$usherwood_09.f)=c("Not at all","A few days","Some days","Most days","Every day")
levels(data$usherwood_10.f)=c("Not at all","A few days","Some days","Most days","Every day")
levels(data$usherwood_11.f)=c("Not at all","A few days","Some days","Most days","Every day")
levels(data$usherwood_12.f)=c("Not at all","A few days","Some days","Most days","Every day")
levels(data$usherwood_13.f)=c("Not at all","A few days","Some days","Most days","Every day")
levels(data$usherwood_14.f)=c("Not at all","A few days","Some days","Most days","Every day")
levels(data$usherwood_15.f)=c("Not at all","A few days","Some days","Most days","Every day")
levels(data$usherwood_16.f)=c("Not at all","A few days","Some days","Most days","Every day")
levels(data$usherwood_17.f)=c("Not at all","A few days","Some days","Most days","Every day")

#label all columns
#label(data$redcap_id)="REDCap ID"
label(data$redcap_event_name)="Event Name"
#label(data$start_here_timestamp)="Survey Timestamp"
label(data$start_here_complete)="Complete?"
#label(data$borinquen_info_release_timestamp)="Survey Timestamp"
#label(data$today_date)="Todays Date:La Fecha de Hoy"
label(data$participating)="Are you interested in participating in this study?"
#label(data$first_date)="This consent is granted for:  A  Continuing disclosure  (expires 12 month form the date I sign this form) or upon termination of treatment, whichever occurs first.  Todays Date:"
label(data$borinquen_info_release_complete)="Complete?"
#label(data$consent_timestamp)="Survey Timestamp"
label(data$parent_or_guardian___1)=" (choice=Parent)"
label(data$parent_or_guardian___2)=" (choice=Individual legally authorized to consent to the childs general medical care)"
label(data$consent_complete)="Complete?"
#label(data$assent_timestamp)="Survey Timestamp"
label(data$assent_complete)="Complete?"
#label(data$consent_2_timestamp)="Survey Timestamp"
label(data$parent_or_guardian_v2___1)=" (choice=Parent)"
label(data$parent_or_guardian_v2___2)=" (choice=Individual legally authorized to consent to the childs general medical care)"
label(data$consent_2_complete)="Complete?"
#label(data$consent2_timestamp)="Survey Timestamp"
label(data$consent2_complete)="Complete?"
#label(data$perception_timestamp)="Survey Timestamp"
label(data$worthtime)="Did you feel the FitTech program was worth your time?"
label(data$tablet_v_drvisit___1)="Did you prefer the tablet session to a regular doctors office visit? (choice=Yes)"
label(data$tablet_v_drvisit___0)="Did you prefer the tablet session to a regular doctors office visit? (choice=No)"
label(data$tablet_v_telephone)="Do you think telephone calls would be better than video conferencing?"
label(data$parentchild)="Do you think it would have worked better if we conducted part of the session with you (parent) and part with your child?"
label(data$frequency)="How often do you think the online sessions should be?"
label(data$easy_tablet)="How easy was the tablet to use?"
label(data$wifi)=" Does your family have access to wifi?"
label(data$fuze)="Would you recommend Fuze (the video conferencing app) for other studies like this one?"
label(data$appssites)="Which apps/websites did you like or find useful?"
label(data$acad_accom)=" Does your child receive any academic accommodations?"
label(data$perception_complete)="Complete?"
#label(data$demographics_patient_timestamp)="Survey Timestamp"
label(data$dem_gender)="What is your gender?"
label(data$dem_ethnicity)="What is your ethnic group or race?"
label(data$dem_language_home)="What language is spoken at home?"
label(data$dem_language_pref)="What language do you prefer to speak?"
label(data$dem_grade)="What grade are you in this year?"
label(data$demographics_patient_complete)="Complete?"
#label(data$tech_patient_timestamp)="Survey Timestamp"
label(data$tech_kid_smart_device)="Do you have a smart phone or tablet? (e.g. iPhone/iPad, Samsung Galaxy, etc)?"
#label(data$tech_kid_brand___1)="What brand of smart phone or tablet do you have? (Select all that apply)(choice=iPhone or iPad)"
#label(data$tech_kid_brand___2)="What brand of smart phone or tablet do you have? (Select all that apply)(choice=Samsung)"
#label(data$tech_kid_brand___3)="What brand of smart phone or tablet do you have? (Select all that apply)(choice=LG)"
#label(data$tech_kid_brand___4)="What brand of smart phone or tablet do you have? (Select all that apply)(choice=HTC)"
#label(data$tech_kid_brand___5)="What brand of smart phone or tablet do you have? (Select all that apply)(choice=Motorola)"
#label(data$tech_kid_brand___6)="What brand of smart phone or tablet do you have? (Select all that apply)(choice=OtherOtro)"
#label(data$tech_kid_brand___7)="What brand of smart phone or tablet do you have? (Select all that apply)(choice=UnsureNo estoy serguro)"
#label(data$tech_kid_os___1)="What type of smart phone or tablet do you have? (Select all that apply)(choice=iPhone or iPadiPhone o iPad)"
#label(data$tech_kid_os___2)="What type of smart phone or tablet do you have? (Select all that apply)  (choice=Android/Google)"
#label(data$tech_kid_os___3)="What type of smart phone or tablet do you have? (Select all that apply)  (choice=Windows)"
#label(data$tech_kid_os___4)="What type of smart phone or tablet do you have? (Select all that apply)  (choice=Blackberry)"
#label(data$tech_kid_os___5)="What type of smart phone or tablet do you have? (Select all that apply)  (choice=OtherOtro)"
#label(data$tech_kid_os___6)="What type of smart phone or tablet do you have? (Select all that apply)  (choice=Unsure)"
label(data$tech_kid_phone_service)="Does your smart phone ever get disconnected (turned off) because the monthly bill has not been paid?)"
label(data$tech_kid_disconnect)="How many times per year does your smart phone get disconnected (turned off) because the monthly bill has not been paid?)"
label(data$tech_kid_apps)="Do you use any applications (app) or websites on your smart phone or tablet to help you with your health (e.g., exercise, eating)?)"
label(data$tech_kid_function___1)="What do the health apps or websites help you do? (choice=Keep track of your exercise)"
label(data$tech_kid_function___2)="What do the health apps or websites help you do? (choice=Keep track of what you eat)"
label(data$tech_kid_function___3)="What do the health apps or websites help you do? (choice=Keep track of your weight)"
label(data$tech_kid_function___4)="What do the health apps or websites help you do? (choice=Look up information about exercise)"
label(data$tech_kid_function___5)="What do the health apps or websites help you do? (choice=Look up information about healthy eating)"
label(data$tech_kid_privileges)="How often do you lose your technology privileges (e.g., have your smart phone or tablet taken away as punishment)?"
label(data$tech_kid_device_time)="How much time do you usually spend in total on your smart phone or tablet each day?"
label(data$tech_kid_given_device)="If you were provided a tablet, would you use the tablet to help you be healthier?"
label(data$tech_patient_complete)="Complete?"
#label(data$pedsql_patient_timestamp)="Survey Timestamp"
label(data$pedsqlkids_01)="It is hard for me to walk more than one block"
label(data$pedsqlkids_02)="It is hard for me to run"
label(data$pedsqlkids_03)="It is hard for me to do sports activity or exercise"
label(data$pedsqlkids_04)="It is hard for me to lift something heavy"
label(data$pedsqlkids_05)="It is hard for me to take a bath or shower by myself"
label(data$pedsqlkids_06)="It is hard for me to do chores around the house"
label(data$pedsqlkids_07)="I hurt or ache"
label(data$pedsqlkids_08)="I have low energy"
label(data$pedsqlkids_09)="I feel afraid or scared"
label(data$pedsqlkids_10)="I feel sad or blue"
label(data$pedsqlkids_11)="I feel angry"
label(data$pedsqlkids_12)="I have trouble sleeping"
label(data$pedsqlkids_13)="I worry about what will happen to me"
label(data$pedsqlkids_14)="I have trouble getting along with other kids"
label(data$pedsqlkids_15)="Other kids do not want to be my friend"
label(data$pedsqlkids_16)="Other kids tease me"
label(data$pedsqlkids_17)="I cannot do things that other kids my age can do"
label(data$pedsqlkids_18)="It is hard to keep up when I play with other kids"
label(data$pedsqlkids_19)="It is hard to pay attention in class"
label(data$pedsqlkids_20)="I forget things"
label(data$pedsqlkids_21)="I have trouble keeping up with my schoolwork"
label(data$pedsqlkids_22)="I miss school because of not feeling well"
label(data$pedsqlkids_23)="I miss school to go to the doctor or hospital"
label(data$pedsql_patient_complete)="Complete?"
#label(data$physical_activity_nutrition_patient_timestamp)="Survey Timestamp"
label(data$act_nutri_kids01)="Number of the last 7 days where physically active for at least 60 minutes"
label(data$act_nutri_kids02)="Number of the last 7 days exercised or participated in physical activity for at least 20 minutes"
label(data$act_nutri_kids03)="Number of the last 7 days exercised to strengthen or tone muscles"
label(data$act_nutri_kids04)="Average school day: hours playing video games/using computer for non-school activities"
label(data$act_nutri_kids05)="Average school day: hours watching DVDs or videos"
label(data$act_nutri_kids06)="Average school day: hours watching TV?"
label(data$act_nutri_kids07)="Encourage you to do physical activities or play sports?"
label(data$act_nutri_kids08)="During a typical week, how often does an adult in your household do a physical activity or play sports with you?"
label(data$act_nutri_kids09)="Provide transportation to a place where you can do physical activities or play sports?"
label(data$act_nutri_kids10)="Watch you participate in physical activities or play sports?"
label(data$act_nutri_kids11)="Number of the last 7 days ate fruit"
label(data$act_nutri_kids12)="Number of the last 7 days ate green salad"
label(data$act_nutri_kids13)="Number of the last 7 days ate French fries or other fried potatoes"
label(data$act_nutri_kids14)="Number of the last 7 days ate carrots?"
label(data$act_nutri_kids15)="Number of the last 7 days ate other vegetables"
label(data$act_nutri_kids16)="Number of the last 7 days ate pizza"
label(data$act_nutri_kids17)="Number of the last 7 days drank 100% fruit juice"
label(data$act_nutri_kids18)="Number of the last 7 days drank a can, bottle, or glass of soda"
label(data$act_nutri_kids19)="Number of the last 7 days drank a can, bottle, or glass of a sugar-sweetened beverage"
label(data$act_nutri_kids20)="Number of the last 7 days drank a bottle or glass of plain water"
label(data$act_nutri_kids21)="About how many cups of fruit (including frozen, canned, and dried fruit and 100% fruit juice) do you eat or drink each day?"
label(data$act_nutri_kids22)="About how many cups of vegetables (including frozen and canned vegetables and 100% vegetable juice) do you eat or drink each day?"
label(data$act_nutri_kids23)="Number of the last 7 days ate breakfast or a morning meal?"
label(data$act_nutri_kids24)="Number of the last 7 days ate dinner at home with at least one of your parents or guardians?"
label(data$act_nutri_kids25)="Number of the last 7 days ate at least one meal or snack from a fast food restaurant"
label(data$act_nutri_kids26)="How often are there fruits or vegetables to snack on in your home, such as carrots, celery, apples, bananas, or melon?"
label(data$act_nutri_kids27)="How often are there foods such as chips, cookies, or cakes to snack on in your home?"
label(data$physical_activity_nutrition_patient_complete)="Complete?"
#label(data$weight_patient_timestamp)="Survey Timestamp"
label(data$weight_01)="I think I am pretty good at managing my weight."
label(data$weight_02)="Compared to other kids, I think I do pretty well when it comes to managing my weight."
label(data$weight_03)="I am satisfied with my ability to manage my weight."
label(data$weight_04)="I am pretty skilled at managing my weight."
label(data$weight_05)="Managing my diet is something that I can't do well."
label(data$weight_06)="I put a lot of effort into managing my weight."
label(data$weight_07)="I try very hard to manage my weight by having healthy eating habits."
label(data$weight_08)="I try very hard to manage my weight by being physically activity."
label(data$weight_09)="It is important for me to do well at managing my weight."
label(data$weight_10)="Overall, having a healthy diet is very important to me, a priority in my life."
label(data$weight_11)="Overall, I feel confident in being able to manage my diet so that my weight will be healthy."
label(data$weight_12)="Overall, I feel confident in being physically active so that my weight will be healthy."
label(data$weight_13)="Overall, doing physical activity is very important to me, a priority in my life."
label(data$weight_14)="I put a lot of effort into managing my diet and eating right."
label(data$weight_15)="I put a lot of effort into not being inactive and being more physically active."
label(data$weight_16)="Compared to other kids, I think I do pretty well when it comes to being physically active."
label(data$has_asthma)="Does [first_name] [last_name] have asthma?"
label(data$weight_patient_complete)="Complete?"
#label(data$asthma_knowledge_patient_timestamp)="Survey Timestamp"
label(data$asthma01___0)="What are the 3 main symptoms of asthma? (choice= sneezing)"
label(data$asthma01___1)="What are the 3 main symptoms of asthma? (choice= shortness of breath)"
label(data$asthma01___11)="What are the 3 main symptoms of asthma? (choice= coughing)"
label(data$asthma01___00)="What are the 3 main symptoms of asthma? (choice= skin rash)"
label(data$asthma01___000)="What are the 3 main symptoms of asthma? (choice= fever)"
label(data$asthma01___111)="What are the 3 main symptoms of asthma? (choice= wheezing)"
label(data$asthma01___0000)="What are the 3 main symptoms of asthma? (choice= nausea/vomiting)"
label(data$asthma01___00000)="What are the 3 main symptoms of asthma? (choice= runny nose)"
label(data$asthma01___000000)="What are the 3 main symptoms of asthma? (choice= headache)"
label(data$asthma01___1111)="What are the 3 main symptoms of asthma? (choice= chest tightness)"
label(data$asthma02)=" More than 1 in 10 children will have asthma at some time during their childhood."
label(data$asthma03)="Children with asthma have overly sensitive air passages in their lungs."
label(data$asthma04)="If one child in a family has asthma, then all his/her brothers and sisters are almost certain to have asthma."
label(data$asthma05)=" 5. Most children with asthma have an increase in mucus when they drink cows milk."
label(data$asthma07)="Wheezing from asthma can be caused by muscle tightening in the wall of the air passages in the lungs."
label(data$asthma08)="Wheezing from asthma can be caused by swelling in the lining of the air passages in the lungs."
label(data$asthma09)=" 9. Asthma damages the heart."
label(data$asthma10___0)="Select two asthma treatments (medicines) that are taken every day on a regular basis to PREVENT attacks of asthma from occurring. (choice=Albuterol)"
label(data$asthma10___00)="Select two asthma treatments (medicines) that are taken every day on a regular basis to PREVENT attacks of asthma from occurring. (choice=Ventolin)"
label(data$asthma10___1)="Select two asthma treatments (medicines) that are taken every day on a regular basis to PREVENT attacks of asthma from occurring. (choice=Pulmicort)"
label(data$asthma10___000)="Select two asthma treatments (medicines) that are taken every day on a regular basis to PREVENT attacks of asthma from occurring. (choice=Decadron)"
label(data$asthma10___0000)="Select two asthma treatments (medicines) that are taken every day on a regular basis to PREVENT attacks of asthma from occurring. (choice=Abilify)"
label(data$asthma10___11)="Select two asthma treatments (medicines) that are taken every day on a regular basis to PREVENT attacks of asthma from occurring. (choice=Montelukast)"
label(data$asthma10___00000)="Select two asthma treatments (medicines) that are taken every day on a regular basis to PREVENT attacks of asthma from occurring. (choice=Lexapro)"
label(data$asthma10___000000)="Select two asthma treatments (medicines) that are taken every day on a regular basis to PREVENT attacks of asthma from occurring. (choice=Benadryl)"
label(data$asthma10___0000000)="Select two asthma treatments (medicines) that are taken every day on a regular basis to PREVENT attacks of asthma from occurring. (choice=Claritin)"
label(data$asthma10___00000000)="Select two asthma treatments (medicines) that are taken every day on a regular basis to PREVENT attacks of asthma from occurring. (choice=Amoxicillin)"
label(data$asthma10___111)="Select two asthma treatments (medicines) that are taken every day on a regular basis to PREVENT attacks of asthma from occurring. (choice=Singulair)"
label(data$asthma10___000000000)="Select two asthma treatments (medicines) that are taken every day on a regular basis to PREVENT attacks of asthma from occurring. (choice=Zoloft)"
label(data$asthma10___1111)="Select two asthma treatments (medicines) that are taken every day on a regular basis to PREVENT attacks of asthma from occurring. (choice=Budesonide)"
label(data$asthma10___0000000000)="Select two asthma treatments (medicines) that are taken every day on a regular basis to PREVENT attacks of asthma from occurring. (choice=Effexor)"
label(data$asthma10___00000000000)="Select two asthma treatments (medicines) that are taken every day on a regular basis to PREVENT attacks of asthma from occurring. (choice=Atrovent)"
label(data$asthma10___11111)="Select two asthma treatments (medicines) that are taken every day on a regular basis to PREVENT attacks of asthma from occurring. (choice=Flovent)"
label(data$asthma10___000000000000)="Select two asthma treatments (medicines) that are taken every day on a regular basis to PREVENT attacks of asthma from occurring. (choice=Metformin)"
label(data$asthma10___0000000000000)="Select two asthma treatments (medicines) that are taken every day on a regular basis to PREVENT attacks of asthma from occurring. (choice=Zithromax)"
label(data$asthma10___000000000000000)="Select two asthma treatments (medicines) that are taken every day on a regular basis to PREVENT attacks of asthma from occurring. (choice=Zyrtec)"
label(data$asthma10___0000000000000000)="Select two asthma treatments (medicines) that are taken every day on a regular basis to PREVENT attacks of asthma from occurring. (choice=Prednisone)"
label(data$asthma10___111111)="Select two asthma treatments (medicines) that are taken every day on a regular basis to PREVENT attacks of asthma from occurring. (choice=Qvar)"
label(data$asthma11___1)="What are the three asthma treatments (medicines) that are useful DURING an attack of asthma?  (choice=Albuterol)"
label(data$asthma11___11)="What are the three asthma treatments (medicines) that are useful DURING an attack of asthma?  (choice=Ventolin)"
label(data$asthma11___0)="What are the three asthma treatments (medicines) that are useful DURING an attack of asthma?  (choice=Pulmicort)"
label(data$asthma11___111)="What are the three asthma treatments (medicines) that are useful DURING an attack of asthma?  (choice=Decadron)"
label(data$asthma11___00)="What are the three asthma treatments (medicines) that are useful DURING an attack of asthma?  (choice=Abilify)"
label(data$asthma11___000)="What are the three asthma treatments (medicines) that are useful DURING an attack of asthma?  (choice=Montelukast)"
label(data$asthma11___0000)="What are the three asthma treatments (medicines) that are useful DURING an attack of asthma?  (choice=Lexapro)"
label(data$asthma11___00000)="What are the three asthma treatments (medicines) that are useful DURING an attack of asthma?  (choice=Benadryl)"
label(data$asthma11___000000)="What are the three asthma treatments (medicines) that are useful DURING an attack of asthma?  (choice=Claritin)"
label(data$asthma11___0000000)="What are the three asthma treatments (medicines) that are useful DURING an attack of asthma?  (choice=Amoxicillin)"
label(data$asthma11___00000000)="What are the three asthma treatments (medicines) that are useful DURING an attack of asthma?  (choice=Singulair)"
label(data$asthma11___000000000)="What are the three asthma treatments (medicines) that are useful DURING an attack of asthma?  (choice=Zoloft)"
label(data$asthma11___0000000000)="What are the three asthma treatments (medicines) that are useful DURING an attack of asthma?  (choice=Budesonide)"
label(data$asthma11___00000000000)="What are the three asthma treatments (medicines) that are useful DURING an attack of asthma?  (choice=Effexor)"
label(data$asthma11___1111)="What are the three asthma treatments (medicines) that are useful DURING an attack of asthma?  (choice=Atrovent)"
label(data$asthma11___000000000000)="What are the three asthma treatments (medicines) that are useful DURING an attack of asthma?  (choice=Flovent)"
label(data$asthma11___0000000000000)="What are the three asthma treatments (medicines) that are useful DURING an attack of asthma?  (choice=Metformin)"
label(data$asthma11___00000000000000)="What are the three asthma treatments (medicines) that are useful DURING an attack of asthma?  (choice=Zithromax)"
label(data$asthma11___000000000000000)="What are the three asthma treatments (medicines) that are useful DURING an attack of asthma?  (choice=Zyrtec)"
label(data$asthma11___11111)="What are the three asthma treatments (medicines) that are useful DURING an attack of asthma?  (choice=Prednisone)"
label(data$asthma11___0000000000000000)="What are the three asthma treatments (medicines) that are useful DURING an attack of asthma?  (choice=Qvar)"
label(data$asthma12)="Antibiotics are an important part of treatment for most children with asthma."
label(data$asthma13)="Most children with asthma should not eat dairy products."
label(data$asthma15)="If a child dies from an asthma attack, this usually means that there was no time to start any treatment."
label(data$asthma16)="Children with asthma usually have emotional problems."
label(data$asthma17)="You can catch asthma from another person."
label(data$asthma18)="Inhaled medications for asthma (for example, Ventolin puffers, Rotacaps) have fewer side effects than tablets."
label(data$asthma19)="Short courses of oral steroids (such as prednisone) usually cause significant side effects."
label(data$asthma20)="Some asthma treatments (such as Ventolin) damage the heart."
label(data$asthma22)="During an attack of asthma at home, you need your  nebulizer (mask) every 2 hours. You gain benefit but are very out of breath after 2 hours. Provided that you dont get any worse, its fine to continue with 2-hourly treatments."
label(data$asthma24)="Children with asthma become addicted to their asthma drugs."
label(data$asthma25)="Swimming is the only good exercise for children with asthma."
label(data$asthma26)="A parents smoking in the home may make the childs asthma worse."
label(data$asthma27)="With the right treatment most children with asthma live a normal life with no restriction on activity."
label(data$asthma28)="The best way to measure how bad a childs asthma is is for the doctor to listen to his/her chest."
label(data$asthma29)="Asthma symptoms usually occur more frequently at night than during the day."
label(data$asthma30)="Most children with asthma will have stunted growth."
label(data$asthma31)="Children who frequently have asthma symptoms should have preventative drugs."
label(data$asthma_knowledge_patient_complete)="Complete?"
#label(data$demographics_parent_timestamp)="Survey Timestamp"
label(data$dem_parent_sex)="What is your gender?"
label(data$dem_parent_ethnicity)="What is your ethnic group or race?"
label(data$dem_parent_language_pref)="What language do you prefer to speak?"
label(data$dem_parent_school)="What is the highest grade or level of education you have completed?"
label(data$dem_parent_nationality)="What is your country of origin/birth?"
label(data$dem_parent_us)="How long have you lived in the United States?"
label(data$dem_kid_nationality)="What is your childs country of origin/birth?"
label(data$dem_kid_us)="If not born in the United States, how long has your child been in the United States?"
label(data$dem_parent_job)="What is your current employment status?"
label(data$dem_parent_income)="What is your household yearly income (before taxes)?"
label(data$dem_parent_marital)="What is your marital status?"
label(data$dem_parent_habitants)="How many people live in the primary house of the youth (including the youth)?"
label(data$dem_kid_pmhx___1)="Does your child have a history of any medical or mental health conditions? (check all that apply) (choice=Asthma)"
label(data$dem_kid_pmhx___2)="Does your child have a history of any medical or mental health conditions? (check all that apply) (choice=Sleep Apnea)"
label(data$dem_kid_pmhx___3)="Does your child have a history of any medical or mental health conditions? (check all that apply) (choice=Anxiety)"
label(data$dem_kid_pmhx___4)="Does your child have a history of any medical or mental health conditions? (check all that apply) (choice=Cancer)"
label(data$dem_kid_pmhx___5)="Does your child have a history of any medical or mental health conditions? (check all that apply) (choice=Learning Disorder)"
label(data$dem_kid_pmhx___6)="Does your child have a history of any medical or mental health conditions? (check all that apply) (choice=Depression)"
label(data$dem_kid_pmhx___7)="Does your child have a history of any medical or mental health conditions? (check all that apply) (choice=Heart Disease)"
label(data$dem_kid_pmhx___8)="Does your child have a history of any medical or mental health conditions? (check all that apply) (choice=ADHD/ADD)"
label(data$dem_kid_pmhx___9)="Does your child have a history of any medical or mental health conditions? (check all that apply) (choice=Other)"
label(data$dem_kid_famhx___1)="Does anyone in your childs family have a history of any medical or mental health conditions? (check all that apply)nda) (choice=Asthma)"
label(data$dem_kid_famhx___2)="Does anyone in your childs family have a history of any medical or mental health conditions? (check all that apply)nda) (choice=Sleep Apnea)"
label(data$dem_kid_famhx___3)="Does anyone in your childs family have a history of any medical or mental health conditions? (check all that apply)nda) (choice=Anxiety)"
label(data$dem_kid_famhx___4)="Does anyone in your childs family have a history of any medical or mental health conditions? (check all that apply)nda) (choice=Cancer)"
label(data$dem_kid_famhx___5)="Does anyone in your childs family have a history of any medical or mental health conditions? (check all that apply)nda) (choice=Learning Disorder)"
label(data$dem_kid_famhx___6)="Does anyone in your childs family have a history of any medical or mental health conditions? (check all that apply)nda) (choice=Depression)"
label(data$dem_kid_famhx___7)="Does anyone in your childs family have a history of any medical or mental health conditions? (check all that apply)nda) (choice=Heart Disease)"
label(data$dem_kid_famhx___8)="Does anyone in your childs family have a history of any medical or mental health conditions? (check all that apply)nda) (choice=ADHD/ADD)"
label(data$dem_kid_famhx___9)="Does anyone in your childs family have a history of any medical or mental health conditions? (check all that apply)nda) (choice=Other)"
label(data$demographics_parent_complete)="Complete?"
#label(data$tech_parent_timestamp)="Survey Timestamp"
label(data$tech_parent_device)="Do you have a smart phone or tablet? (e.g. iPhone/iPad, Samsung Galaxy, etc)?"
label(data$tech_parent_brand___1)="What brand of smart phone or tablet do you have? (Select all that apply)(choice=iPhone or iPad)"
label(data$tech_parent_brand___2)="What brand of smart phone or tablet do you have? (Select all that apply)(choice=Samsung)"
label(data$tech_parent_brand___3)="What brand of smart phone or tablet do you have? (Select all that apply)(choice=LG)"
label(data$tech_parent_brand___4)="What brand of smart phone or tablet do you have? (Select all that apply)(choice=HTC)"
label(data$tech_parent_brand___5)="What brand of smart phone or tablet do you have? (Select all that apply)(choice=Motorola)"
label(data$tech_parent_brand___6)="What brand of smart phone or tablet do you have? (Select all that apply)(choice=OtherOtro)"
label(data$tech_parent_brand___7)="What brand of smart phone or tablet do you have? (Select all that apply)(choice=Unsure)"
label(data$tech_parent_os___1)="What type of smart phone or tablet do you have? (Select all that apply)  (choice=iPhone or iPad)"
label(data$tech_parent_os___2)="What type of smart phone or tablet do you have? (Select all that apply)  (choice=Android/Google)"
label(data$tech_parent_os___3)="What type of smart phone or tablet do you have? (Select all that apply)  (choice=Windows)"
label(data$tech_parent_os___4)="What type of smart phone or tablet do you have? (Select all that apply)  (choice=Blackberry)"
label(data$tech_parent_os___6)="What type of smart phone or tablet do you have? (Select all that apply)  (choice=OtherOtro)"
label(data$tech_parent_os___7)="What type of smart phone or tablet do you have? (Select all that apply)  (choice=Unsure)"
label(data$tech_parent_phone_service)="Does your smart phone ever get disconnected (turned off) because the monthly bill has not been paid?"
label(data$tech_parent_disconnect)="How many times per year does your smart phone get disconnected (turned off) because the monthly bill has not been paid?"
label(data$tech_parent_apps)="Do you use any applications (app) or websites on your smart phone or tablet to help you with your health (e.g., exercise, eating)?"
label(data$tech_parent_function___1)="What do the health apps or websites help you do?(choice=Keep track of your exercise"
label(data$tech_parent_function___2)="What do the health apps or websites help you do?(choice=Keep track of what you eat"
label(data$tech_parent_function___3)="What do the health apps or websites help you do?(choice=Keep track of your weight"
label(data$tech_parent_function___4)="What do the health apps or websites help you do?(choice=Look up information about exercise"
label(data$tech_parent_function___5)="What do the health apps or websites help you do?(choice=Look up information about healthy eating"
label(data$tech_parent_info___1)="Where do you get health information (e.g., eating/dieting, exercise, diseases/disorders/conditions)?es)? (choice=Friends or Family"
label(data$tech_parent_info___2)="Where do you get health information (e.g., eating/dieting, exercise, diseases/disorders/conditions)?es)? (choice= Doctor or other health professional"
label(data$tech_parent_info___3)="Where do you get health information (e.g., eating/dieting, exercise, diseases/disorders/conditions)?es)? (choice= Health app or website"
label(data$tech_parent_info___4)="Where do you get health information (e.g., eating/dieting, exercise, diseases/disorders/conditions)?es)? (choice=General or personal website (e.g., blog, Pinterest, social media such as Facebook or Twitter)"
label(data$tech_parent_info___5)="Where do you get health information (e.g., eating/dieting, exercise, diseases/disorders/conditions)?es)? (choice=Health-related printed material (e.g., book, health magazine)"
label(data$tech_parent_info___6)="Where do you get health information (e.g., eating/dieting, exercise, diseases/disorders/conditions)?es)? (choice=General printed material (e.g., magazine, newspaper)"
label(data$tech_parent_info___7)="Where do you get health information (e.g., eating/dieting, exercise, diseases/disorders/conditions)?es)? (choice= Television (news, afternoon program, talk show)"
label(data$tech_parent_info___8)="Where do you get health information (e.g., eating/dieting, exercise, diseases/disorders/conditions)?"
label(data$tech_kid_par_device)="Does your youth have a smart phone or tablet? (e.g. iPhone/iPad, Samsung Galaxy, etc)?"
label(data$tech_kid_par_brand___1)="What brand of smart phone or tablet does your youth have? (Select all that apply)  (choice=iPhone or iPadiPhone o iPad )"
label(data$tech_kid_par_brand___2)="What brand of smart phone or tablet does your youth have? (Select all that apply)  (choice=Samsung)"
label(data$tech_kid_par_brand___3)="What brand of smart phone or tablet does your youth have? (Select all that apply)  (choice=LG)"
label(data$tech_kid_par_brand___4)="What brand of smart phone or tablet does your youth have? (Select all that apply)  (choice=HTC)"
label(data$tech_kid_par_brand___5)="What brand of smart phone or tablet does your youth have? (Select all that apply)  (choice=Motorola)"
label(data$tech_kid_par_brand___6)="What brand of smart phone or tablet does your youth have? (Select all that apply)  (choice=OtherOtro)"
label(data$tech_kid_par_brand___7)="What brand of smart phone or tablet does your youth have? (Select all that apply)  (choice=UnsureNo estoy serguro)"
label(data$tech_kid_par_os___1)="What type of smart phone or tablet does your youth have? (Select all that apply)(choice=iPhone or iPad)"
label(data$tech_kid_par_os___2)="What type of smart phone or tablet does your youth have? (Select all that apply)(choice=Android/Google)"
label(data$tech_kid_par_os___3)="What type of smart phone or tablet does your youth have? (Select all that apply)(choice=Windows)"
label(data$tech_kid_par_os___4)="What type of smart phone or tablet does your youth have? (Select all that apply)(choice=Blackberry)"
label(data$tech_kid_par_os___6)="What type of smart phone or tablet does your youth have? (Select all that apply)(choice=OtherOtro)"
label(data$tech_kid_par_os___7)="What type of smart phone or tablet does your youth have? (Select all that apply)(choice=Unsure)"
label(data$tech_kid_par_service)="Does your youths smart phone ever get disconnected (turned off) because the monthly bill has not been paid?"
label(data$tech_kid_par_disconnected)="How many times per year does your youths smart phone get disconnected (turned off) because the monthly bill has not been paid?"
label(data$tech_kid_par_app)="Does your youth use any applications (app) or websites on your smart phone or tablet to help him/her with health (e.g., exercise, eating)?"
label(data$tech_parent_privileges)="How often does your youth lose their technology privileges (e.g., have their smart phone or tablet taken away as punishment)?"
label(data$tech_parent_uses)="If your youth was provided with a tablet, would they use the tablet to help them be healthier?"
label(data$tech_parent_complete)="Complete?"
#label(data$pedsql_parent_timestamp)="Survey Timestamp"
label(data$pedsqlparent_01)="1.Walking more than one block"
label(data$pedsqlparent_02)="2.Running"
label(data$pedsqlparent_03)="3.Participating in sports activity or exercise"
label(data$pedsqlparent_04)="4.Lifting something heavy"
label(data$pedsqlparent_05)="5.Taking a bath or shower by him or herself"
label(data$pedsqlparent_06)="6.Doing chores around the house"
label(data$pedsqlparent_07)="7.Having hurts or aches"
label(data$pedsqlparent_08)="8.Low energy level"
label(data$pedsqlparent_09)="9.Feeling afraid or scared"
label(data$pedsqlparent_10)="10.Feeling sad or blue"
label(data$pedsqlparent_11)="11.Feeling angry"
label(data$pedsqlparent_12)="12.Trouble sleeping"
label(data$pedsqlparent_13)="13.Worrying about what will happen to him or her"
label(data$pedsqlparent_14)="14.Getting along with other kids"
label(data$pedsqlparent_15)="Other kids not wanting to be his or her friend"
label(data$pedsqlparent_16)="16.Getting teased by other teens"
label(data$pedsqlparent_17)="17.Not able to do things that other kids his or her age can do"
label(data$pedsqlparent_18)="18.Keeping up with other kids"
label(data$pedsqlparent_19)="19.Paying attention in class"
label(data$pedsqlparent_20)="20.Forgetting things"
label(data$pedsqlparent_21)="21.Keeping up with schoolwork"
label(data$pedsqlparent_22)="22.Missing school because of not feeling well"
label(data$pedsqlparent_23)="23.Missing school to go to the doctor or hospital"
label(data$pedsql_parent_complete)="Complete?"
#label(data$physical_activity_nutrition_parent_timestamp)="Survey Timestamp"
label(data$act_nutri_parent01)="Yesterday, was your child physically active for a total of at least 60 minutes? (Add up all the time he/she spent in any kind of physical activity that increased their heart rate and made them breathe hard some of the time.)"
label(data$act_nutri_parent02)="During the past 7 days, on how many days was your child physically active for a total of at least 60 minutes per day? (Add up all the time he/she spent in any kind of physical activity that increased their heart rate and made them breathe hard some of the time.)"
label(data$act_nutri_parent03)="On how many of the past 7 days did your child exercise or participate in physical activity for at least 20 minutes that made him/her sweat and breathe hard, such as basketball, soccer, running, swimming laps, fast bicycling, fast dancing, or similar aerobic activities?"
label(data$act_nutri_parent04)="On how many of the past 7 days did your child do exercises to strengthen or tone their muscles, such as push-ups, sit-ups, or weight lifting?"
label(data$act_nutri_parent05)="On an average school day, how many hours does your child play video or computer games or use a computer for something that is not school work? (Include activities such as Nintendo, Game Boy, PlayStation, Xbox, computer games, and the Internet.)"
label(data$act_nutri_parent06)="On an average school day, how many hours does your child spend watching DVDs or videos? Include DVDs or videos you watch on a TV, computer, iPod, or other portable device."
label(data$act_nutri_parent07)="On an average school day, how many hours does your child watch TV?"
label(data$act_nutri_parent08)="In an average week when your child is in school, on how many days does he/she go to physical education (PE) classes?"
label(data$act_nutri_parent09)="How many TVs are in your home? (If you sleep in more than one home, answer based on the home you sleep in most.)"
label(data$act_nutri_parent10)="Does your child have a TV in his/her bedroom? (If they have more than one bedroom, answer based on the bedroom they sleep in most.)"
label(data$act_nutri_parent11)=" In an average week when your child is in school, on how many days does he/she walk or ride his/her bike to school when weather allows him/her to do so?"
label(data$act_nutri_parent12)="Encourage your child to do physical activities or play sports?"
label(data$act_nutri_parent13)="Do a physical activity or play sports with your child?"
label(data$act_nutri_parent14)="Provide transportation to a place where your child can do physical activities or play sports?"
label(data$act_nutri_parent15)="Watch your child participate in physical activities or play sports"
label(data$act_nutri_parent16)="During the past 7 days, how many times did your child eat fruit? (Do not count fruit juice.)"
label(data$act_nutri_parent17)="During the past 7 days, how many times did your child eat green salad?"
label(data$act_nutri_parent18)="During the past 7 days, how many times did your child eat French fries or other fried potatoes, such as home fries, hash browns or tater tots? (Do not count potato chips.)"
label(data$act_nutri_parent19)="During the past 7 days, how many times did your child eat carrots?"
label(data$act_nutri_parent20)="During the past 7 days, how many times did your child eat other vegetables? (Do not count green salad, potatoes, or carrots.)"
label(data$act_nutri_parent21)="During the past 7 days, how many times did your child eat pizza?"
label(data$act_nutri_parent22)="During the past 7 days, how many times did your child drink a can, bottle, or glass of soda or pop, such as Coke, Pepsi, or Sprite?"
label(data$act_nutri_parent23)="During the past 7 days, how many times did your child drink a can, bottle, or glass of diet soda or pop, such as Diet Coke, Diet Pepsi, or Sprite Zero?"
label(data$act_nutri_parent24)="During the past 7 days, how many times did your child drink a can, bottle, or glass of a sugar-sweetened beverage such as lemonade, sweetened tea or coffee drinks, flavored milk, Snapple, or Sunny Delight? (Do not count soda or pop, sports drinks, energy drinks, or 100% fruit juice.)"
label(data$act_nutri_parent25)="During the past 7 days, how many times did your child drink a bottle or glass of plain water? Count tap, bottled, and unflavored sparkling water."
label(data$act_nutri_parent26)="About how many cups of fruit (including frozen, canned, and dried fruit and 100% fruit juice) does your child eat or drink each day?"
label(data$act_nutri_parent27)="About how many cups of vegetables (including frozen, canned, and vegetables and 100% vegetable juice) does your child eat or drink each day?"
label(data$act_nutri_parent28)="During the past 7 days, on how many days did your child eat breakfast or a morning meal?"
label(data$act_nutri_parent29)="During the last 7 days, when your child eats dinner at home, how often is a television on while he/ she is eating?"
label(data$act_nutri_parent30)="During the past 7 days, on how many days did your child eat at least one meal or snack from a fast food restaurant such as McDonalds, Taco Bell, or KFC?"
label(data$act_nutri_parent31)="How often are there fruits or vegetables to snack on in your home, such as carrots, celery, apples, bananas, or melon?"
label(data$physical_activity_nutrition_parent_complete)="Complete?"
#label(data$asthma_knowledge_parent_timestamp)="Survey Timestamp"
label(data$asthma_parent01___0)="What are the 3 main symptoms of asthma? (choice= sneezing)"
label(data$asthma_parent01___1)="What are the 3 main symptoms of asthma? (choice= shortness of breath)"
label(data$asthma_parent01___11)="What are the 3 main symptoms of asthma? (choice= coughing)"
label(data$asthma_parent01___00)="What are the 3 main symptoms of asthma? (choice= skin rash)"
label(data$asthma_parent01___000)="What are the 3 main symptoms of asthma? (choice= fever)"
label(data$asthma_parent01___111)="What are the 3 main symptoms of asthma? (choice= wheezing)"
label(data$asthma_parent01___0000)="What are the 3 main symptoms of asthma? (choice= nausea/vomiting)"
label(data$asthma_parent01___00000)="What are the 3 main symptoms of asthma? (choice= runny nose)"
label(data$asthma_parent01___000000)="What are the 3 main symptoms of asthma? (choice= headache)"
label(data$asthma_parent01___1111)="What are the 3 main symptoms of asthma? (choice= chest tightness)"
label(data$asthma_parent02)=" More than 1 in 10 children will have asthma at some time during their childhood."
label(data$asthma_parent03)="Children with asthma have overly sensitive air passages in their lungs."
label(data$asthma_parent04)="If one child in a family has asthma, then all his/her brothers and sisters are almost certain to have asthma."
label(data$asthma_parent05)=" 5. Most children with asthma have an increase in mucus when they drink cows milk."
label(data$asthma_parent07)="Wheezing from asthma can be caused by muscle tightening in the wall of the air passages in the lungs."
label(data$asthma_parent08)="Wheezing from asthma can be caused by swelling in the lining of the air passages in the lungs."
label(data$asthma_parent09)=" 9. Asthma damages the heart."
label(data$asthma_parent10___0)="Select two asthma treatments (medicines) that are taken every day on a regular basis to prevent attacks of asthma from occurring. (choice=Albuterol)"
label(data$asthma_parent10___00)="Select two asthma treatments (medicines) that are taken every day on a regular basis to prevent attacks of asthma from occurring. (choice=Ventolin)"
label(data$asthma_parent10___1)="Select two asthma treatments (medicines) that are taken every day on a regular basis to prevent attacks of asthma from occurring. (choice=Pulmicort)"
label(data$asthma_parent10___000)="Select two asthma treatments (medicines) that are taken every day on a regular basis to prevent attacks of asthma from occurring. (choice=Decadron)"
label(data$asthma_parent10___0000)="Select two asthma treatments (medicines) that are taken every day on a regular basis to prevent attacks of asthma from occurring. (choice=Abilify)"
label(data$asthma_parent10___11)="Select two asthma treatments (medicines) that are taken every day on a regular basis to prevent attacks of asthma from occurring. (choice=Montelukast)"
label(data$asthma_parent10___00000)="Select two asthma treatments (medicines) that are taken every day on a regular basis to prevent attacks of asthma from occurring. (choice=Lexapro)"
label(data$asthma_parent10___000000)="Select two asthma treatments (medicines) that are taken every day on a regular basis to prevent attacks of asthma from occurring. (choice=Benadryl)"
label(data$asthma_parent10___0000000)="Select two asthma treatments (medicines) that are taken every day on a regular basis to prevent attacks of asthma from occurring. (choice=Claritin)"
label(data$asthma_parent10___00000000)="Select two asthma treatments (medicines) that are taken every day on a regular basis to prevent attacks of asthma from occurring. (choice=Amoxicillin)"
label(data$asthma_parent10___111)="Select two asthma treatments (medicines) that are taken every day on a regular basis to prevent attacks of asthma from occurring. (choice=Singulair)"
label(data$asthma_parent10___000000000)="Select two asthma treatments (medicines) that are taken every day on a regular basis to prevent attacks of asthma from occurring. (choice=Zoloft)"
label(data$asthma_parent10___1111)="Select two asthma treatments (medicines) that are taken every day on a regular basis to prevent attacks of asthma from occurring. (choice=Budesonide)"
label(data$asthma_parent10___0000000000)="Select two asthma treatments (medicines) that are taken every day on a regular basis to prevent attacks of asthma from occurring. (choice=Effexor)"
label(data$asthma_parent10___00000000000)="Select two asthma treatments (medicines) that are taken every day on a regular basis to prevent attacks of asthma from occurring. (choice=Atrovent)"
label(data$asthma_parent10___11111)="Select two asthma treatments (medicines) that are taken every day on a regular basis to prevent attacks of asthma from occurring. (choice=Flovent)"
label(data$asthma_parent10___000000000000)="Select two asthma treatments (medicines) that are taken every day on a regular basis to prevent attacks of asthma from occurring. (choice=Metformin)"
label(data$asthma_parent10___0000000000000)="Select two asthma treatments (medicines) that are taken every day on a regular basis to prevent attacks of asthma from occurring. (choice=Zithromax)"
label(data$asthma_parent10___000000000000000)="Select two asthma treatments (medicines) that are taken every day on a regular basis to prevent attacks of asthma from occurring. (choice=Zyrtec)"
label(data$asthma_parent10___0000000000000000)="Select two asthma treatments (medicines) that are taken every day on a regular basis to prevent attacks of asthma from occurring. (choice=Prednisone)"
label(data$asthma_parent10___111111)="Select two asthma treatments (medicines) that are taken every day on a regular basis to prevent attacks of asthma from occurring. (choice=Qvar)"
label(data$asthma_parent11___1)="What are the three asthma treatments (medicines) that are useful during an attack of asthma?  (choice=Albuterol)"
label(data$asthma_parent11___11)="What are the three asthma treatments (medicines) that are useful during an attack of asthma?  (choice=Ventolin)"
label(data$asthma_parent11___0)="What are the three asthma treatments (medicines) that are useful during an attack of asthma?  (choice=Pulmicort)"
label(data$asthma_parent11___111)="What are the three asthma treatments (medicines) that are useful during an attack of asthma?  (choice=Decadron)"
label(data$asthma_parent11___00)="What are the three asthma treatments (medicines) that are useful during an attack of asthma?  (choice=Abilify)"
label(data$asthma_parent11___000)="What are the three asthma treatments (medicines) that are useful during an attack of asthma?  (choice=Montelukast)"
label(data$asthma_parent11___0000)="What are the three asthma treatments (medicines) that are useful during an attack of asthma?  (choice=Lexapro)"
label(data$asthma_parent11___00000)="What are the three asthma treatments (medicines) that are useful during an attack of asthma?  (choice=Benadryl)"
label(data$asthma_parent11___000000)="What are the three asthma treatments (medicines) that are useful during an attack of asthma?  (choice=Claritin)"
label(data$asthma_parent11___0000000)="What are the three asthma treatments (medicines) that are useful during an attack of asthma?  (choice=Amoxicillin)"
label(data$asthma_parent11___00000000)="What are the three asthma treatments (medicines) that are useful during an attack of asthma?  (choice=Singulair)"
label(data$asthma_parent11___000000000)="What are the three asthma treatments (medicines) that are useful during an attack of asthma?  (choice=Zoloft)"
label(data$asthma_parent11___0000000000)="What are the three asthma treatments (medicines) that are useful during an attack of asthma?  (choice=Budesonide)"
label(data$asthma_parent11___00000000000)="What are the three asthma treatments (medicines) that are useful during an attack of asthma?  (choice=Effexor)"
label(data$asthma_parent11___1111)="What are the three asthma treatments (medicines) that are useful during an attack of asthma?  (choice=Atrovent)"
label(data$asthma_parent11___000000000000)="What are the three asthma treatments (medicines) that are useful during an attack of asthma?  (choice=Flovent)"
label(data$asthma_parent11___0000000000000)="What are the three asthma treatments (medicines) that are useful during an attack of asthma?  (choice=Metformin)"
label(data$asthma_parent11___00000000000000)="What are the three asthma treatments (medicines) that are useful during an attack of asthma?  (choice=Zithromax)"
label(data$asthma_parent11___000000000000000)="What are the three asthma treatments (medicines) that are useful during an attack of asthma?  (choice=Zyrtec)"
label(data$asthma_parent11___11111)="What are the three asthma treatments (medicines) that are useful during an attack of asthma?  (choice=Prednisone)"
label(data$asthma_parent11___0000000000000000)="What are the three asthma treatments (medicines) that are useful during an attack of asthma?  (choice=Qvar)"
label(data$asthma_parent12)="Antibiotics are an important part of treatment for most children with asthma."
label(data$asthma_parent13)="Most children with asthma should not eat dairy products."
label(data$asthma_parent14)=" 14.Allergy injections cure asthma."
label(data$asthma_parent15)="If a child dies from an asthma attack, this usually means that there was no time to start any treatment."
label(data$asthma_parent16)="Children with asthma usually have emotional problems."
label(data$asthma_parent17)="You can catch asthma from another person. "
label(data$asthma_parent18)="Inhaled medications for asthma (for example, Ventolin puffers, Rotacaps) have fewer side effects than tablets."
label(data$asthma_parent19)="Short courses of oral steroids (such as prednisone) usually cause significant side effects."
label(data$asthma_parent20)="Some asthma treatments (such as Ventolin) damage the heart."
label(data$asthma_parent22)="During an attack of asthma that you are managing at home, your child is requesting the nebulizer (mask) every 2 hours. He/she is gaining benefit but is very breathless after 2 hours. Provided that he/she doesnt get any worse, its fine to continue with 2-hourly treatments."
label(data$asthma_parent24)="Children with asthma become addicted to their asthma drugs."
label(data$asthma_parent25)="Swimming is the only good exercise for children with asthma."
label(data$asthma_parent26)="A parents smoking in the home may make the childs asthma worse."
label(data$asthma_parent27)="With the right treatment most children with asthma live a normal life with no restriction on activity."
label(data$asthma_parent28)="The best way to measure how bad a childs asthma is is for the doctor to listen to his/her chest."
label(data$asthma_parent29)="Asthma symptoms usually occur more frequently at night than during the day."
label(data$asthma_parent30)="Most children with asthma will have stunted growth."
label(data$asthma_parent31)="Children who frequently have asthma symptoms should have preventative drugs."
label(data$asthma_knowledge_parent_complete)="Complete?"
#label(data$usherwood_timestamp)="Survey Timestamp"
label(data$usherwood_01)="Your child has been wheezy during the day"
label(data$usherwood_02)="Your child has coughed during the day"
label(data$usherwood_03)="Your child has complained of being short of breath"
label(data$usherwood_04)="Your child has complained of a pain in the chest"
label(data$usherwood_05)="Exertion (e.g., running) has made your child breathless"
label(data$usherwood_06)="Your child has stayed indoors because of wheezing or coughing"
label(data$usherwood_07)="His/her asthma has stopped your child from playing with his or her friends"
label(data$usherwood_08)="During term time, your childs education has suffered due to his or her asthma"
label(data$usherwood_09)="Asthma has stopped your child from doing all the things that a boy or girl should at his or her age"
label(data$usherwood_10)="Your childs asthma has interfered with his or her life"
label(data$usherwood_11)="Asthma has limited your childs activities"
label(data$usherwood_12)="Taking his or her inhaler or other treatment has interrupted your childs life"
label(data$usherwood_13)="Your childs asthma has limited your activities"
label(data$usherwood_14)="You have had to make adjustments to family life because of your childs asthma"
label(data$usherwood_15)="Your child has coughed at night"
label(data$usherwood_16)="Your childs sleep has been disturbed by wheezing or coughing"
label(data$usherwood_17)="Your child has been woken up by wheezing or coughing"
label(data$usherwood_complete)="Complete?"
#label(data$equipment_signout_timestamp)="Survey Timestamp"
label(data$tablet_group)="Were you randomized to the tablet group?"
label(data$equipment_signout_complete)="Complete?"
#label(data$gift_receipt_timestamp)="Survey Timestamp"
label(data$gift_receipt_complete)="Complete?"
label(data$qlPtTotal)="Patient's total score for the PedsQL Survey"
label(data$qlPtPhys)="Patient's score for the physical subsection of the PedsQL Survey"
label(data$qlPtEmotion)="Patient's score for the emotional subsection of the PedsQL Survey"
label(data$qlPtSocial)="Patient's score for the social subsection of the PedsQL Survey"
label(data$qlPtSchool)="Patient's score for the school subsection of the PedsQL Survey"
label(data$qlParTotal)="Parent's total score for the PedsQL Survey"
label(data$qlParPhys)="Parent's score for the physical subsection of the PedsQL Survey"
label(data$qlParEmotion)="Parent's score for the emotional subsection of the PedsQL Survey"
label(data$qlParSocial)="Parent's score for the social subsection of the PedsQL Survey"
label(data$qlParSchool)="Parent's score for the school subsection of the PedsQL Survey"