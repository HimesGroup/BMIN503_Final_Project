
library(Hmisc)
library(feather)

if (refresh){
  load_demo_data <- function(csv){
    data=read.csv(csv)
    
    #Setting Labels
    label(data$record_id)="Record ID"
    label(data$redcap_repeat_instrument)="Repeat Instrument"
    label(data$redcap_repeat_instance)="Repeat Instance"
    label(data$prov_nm)="Provider name"
    label(data$nt_auth)="Note author"
    label(data$pat_id)="Patient ID"
    label(data$gender)="Gender"
    label(data$age)="Age"
    label(data$weight)="Weight in kilograms"
    label(data$ethnicity)="Patients Ethnicity:"
    label(data$race)="Patients Race Category:"
    label(data$pt_ha_quest_yn)="Did the patient fill out the Headache Questionnaire form?"
    label(data$prov_ha_quest_yn)="Did the provider fill out the Headache Questionnaire form?"
    label(data$prov_action)="Actions taken for the patient answers"
    label(data$prob_fill_form_yn)="NEURO WEL HEADACHE - problem with form"
    label(data$prob_fill_form_oth)="NEURO WEL HEADACHE - problem with form (comments)"
    label(data$pt_ha_quest_compl_yn)="Did the patient completed the Headache Questionnaire form? (p_current_ha_pattern is filled)"
    label(data$demographics_complete)="Complete?"
    
    #Setting Units
    
    
    #Setting Factors(will create new variable for factors)
    data$redcap_repeat_instrument.factor = factor(data$redcap_repeat_instrument,levels=c("visit_diagnoses","lab","prior_labs","all_problems","imaging"))
    data$gender.factor = factor(data$gender,levels=c("1","2","99"))
    data$ethnicity.factor = factor(data$ethnicity,levels=c("hisp","no_hisp","unk","no_answer"))
    data$race.factor = factor(data$race,levels=c("am_indian","asian","black","pacific_island","white","multi","unk","no_answer"))
    data$pt_ha_quest_yn.factor = factor(data$pt_ha_quest_yn,levels=c("1","0"))
    data$prov_ha_quest_yn.factor = factor(data$prov_ha_quest_yn,levels=c("1","0"))
    data$prov_action.factor = factor(data$prov_action,levels=c("1","2","3"))
    data$prob_fill_form_yn.factor = factor(data$prob_fill_form_yn,levels=c("0","1","99"))
    data$pt_ha_quest_compl_yn.factor = factor(data$pt_ha_quest_compl_yn,levels=c("0","1"))
    data$demographics_complete.factor = factor(data$demographics_complete,levels=c("0","1","2"))
    
    levels(data$redcap_repeat_instrument.factor)=c("Visit Diagnoses","Lab","Prior Labs","All Problems","Imaging")
    levels(data$gender.factor)=c("Female","Male","Other")
    levels(data$ethnicity.factor)=c("Hispanic or Latino","Not Hispanic or Latino","Dont know","Prefer not to answer")
    levels(data$race.factor)=c("American Indian or Alaska Native","Asian","Black or African-American","Native Hawaiian or Other Pacific Islander","White","Multiple Races","Dont know","Prefer not to answer")
    levels(data$pt_ha_quest_yn.factor)=c("Yes","No")
    levels(data$prov_ha_quest_yn.factor)=c("Yes","No")
    levels(data$prov_action.factor)=c("Accept","Reject","Remove")
    levels(data$prob_fill_form_yn.factor)=c("No","Yes","Comments")
    levels(data$pt_ha_quest_compl_yn.factor)=c("No","Yes")
    levels(data$demographics_complete.factor)=c("Incomplete","Unverified","Complete")
    
    return(data)
  }
  
  load_ha_data <- function(csv) {
    #Read Data
    data=read.csv(csv)
    #Setting Labels
    
    label(data$record_id)="Record ID"
    label(data$redcap_repeat_instrument)="Repeat Instrument"
    label(data$redcap_repeat_instance)="Repeat Instance"
    label(data$relation___mom)="What is your relationship to the patient? (choice=Mother)"
    label(data$relation___dad)="What is your relationship to the patient? (choice=Father)"
    label(data$relation___self)="What is your relationship to the patient? (choice=Self (I am the patient))"
    label(data$relation___interpret)="What is your relationship to the patient? (choice=Interpreter assisted)"
    label(data$relation___m_grandma)="What is your relationship to the patient? (choice=Maternal Grandmother)"
    label(data$relation___m_grandpa)="What is your relationship to the patient? (choice=Maternal Grandfather)"
    label(data$relation___p_grandma)="What is your relationship to the patient? (choice=Paternal Grandmother)"
    label(data$relation___p_grandpa)="What is your relationship to the patient? (choice=Paternal Grandfather)"
    label(data$relation___aunt_unc)="What is your relationship to the patient? (choice=Aunt or Uncle)"
    label(data$relation___stepma)="What is your relationship to the patient? (choice=Stepmother)"
    label(data$relation___steppa)="What is your relationship to the patient? (choice=Stepfather)"
    label(data$relation___guard)="What is your relationship to the patient? (choice=Gaurdian)"
    label(data$relation___fosterma)="What is your relationship to the patient? (choice=Foster Mother)"
    label(data$relation___fosterpa)="What is your relationship to the patient? (choice=Foster Father)"
    label(data$relation___provider)="What is your relationship to the patient? (choice=Childcare provider)"
    label(data$relation___facility)="What is your relationship to the patient? (choice=Residential Facility Staff)"
    label(data$relation___oth)="What is your relationship to the patient? (choice=Other)"
    label(data$p_prov_seen___none)="Have you seen other health care providers for headaches and related conditions? (choice=None)"
    label(data$p_prov_seen___pcp)="Have you seen other health care providers for headaches and related conditions? (choice=Primary Care Clinician)"
    label(data$p_prov_seen___neuro)="Have you seen other health care providers for headaches and related conditions? (choice=Neurologist)"
    label(data$p_prov_seen___eye)="Have you seen other health care providers for headaches and related conditions? (choice=Eye doctor)"
    label(data$p_prov_seen___ent)="Have you seen other health care providers for headaches and related conditions? (choice=Ear, Nose, Throat (ENT))"
    label(data$p_prov_seen___allergy)="Have you seen other health care providers for headaches and related conditions? (choice=Allergist)"
    label(data$p_prov_seen___conc)="Have you seen other health care providers for headaches and related conditions? (choice=concion or Sports Medicine)"
    label(data$p_prov_seen___nsg)="Have you seen other health care providers for headaches and related conditions? (choice=Neurosurgeon)"
    label(data$p_prov_seen___gi)="Have you seen other health care providers for headaches and related conditions? (choice=Gastroenterologist)"
    label(data$p_prov_seen___osteo)="Have you seen other health care providers for headaches and related conditions? (choice=Osteopathic/Integrative Doctor)"
    label(data$p_prov_seen___onco)="Have you seen other health care providers for headaches and related conditions? (choice=Oncologist)"
    label(data$p_prov_seen___cardio)="Have you seen other health care providers for headaches and related conditions? (choice=Cardiologist)"
    label(data$p_prov_seen___psych)="Have you seen other health care providers for headaches and related conditions? (choice=Psychiatrist)"
    label(data$p_prov_seen___psychol)="Have you seen other health care providers for headaches and related conditions? (choice=psychologist)"
    label(data$p_prov_seen___couns)="Have you seen other health care providers for headaches and related conditions? (choice=Counselor)"
    label(data$p_prov_seen___ed)="Have you seen other health care providers for headaches and related conditions? (choice=Emergency Department)"
    label(data$p_prov_seen___oth)="Have you seen other health care providers for headaches and related conditions? (choice=Other)"
    label(data$p_stud_eval___none)="Have any tests been performed?   (choice=None)"
    label(data$p_stud_eval___brain)="Have any tests been performed?   (choice=MRI of Brain)"
    label(data$p_stud_eval___spine)="Have any tests been performed?   (choice=MRI of Spine)"
    label(data$p_stud_eval___ct)="Have any tests been performed?   (choice=CT of Brain)"
    label(data$p_stud_eval___eeg)="Have any tests been performed?   (choice=EEG (brain wave test))"
    label(data$p_stud_eval___emg)="Have any tests been performed?   (choice=EMG (muscle/nerve test))"
    label(data$p_stud_eval___genetic)="Have any tests been performed?   (choice=Genetic Testing)"
    label(data$p_stud_eval___lp)="Have any tests been performed?   (choice=Lumbar Puncture/Spinal tap)"
    label(data$p_stud_eval___npsych)="Have any tests been performed?   (choice=Neuropsych Testing)"
    label(data$p_stud_eval___metabolic)="Have any tests been performed?   (choice=Metabolic Disorders testing)"
    label(data$p_stud_eval___blood)="Have any tests been performed?   (choice=Blood Work)"
    label(data$p_stud_eval___notsure)="Have any tests been performed?   (choice=Not sure)"
    label(data$p_stud_eval___oth)="Have any tests been performed?   (choice=Other)"
    label(data$p_age_first_ha)="How old were you when you had your first headache?   We are asking about any headaches, not just the bad or recent ones."
    label(data$p_ha_in_lifetime)="How many headaches have you had in your lifetime?"
    label(data$p_current_ha_pattern)="What is the current pattern of your headaches?"
    label(data$p_epi_prec___none)="The arrow in the image above shows the time that your headaches started. Did anything happen around the time your headaches started? (choice=None)"
    label(data$p_epi_prec___conc)="The arrow in the image above shows the time that your headaches started. Did anything happen around the time your headaches started? (choice=Head trauma or concussion)"
    label(data$p_epi_prec___oth_inj)="The arrow in the image above shows the time that your headaches started. Did anything happen around the time your headaches started? (choice=Other injury)"
    label(data$p_epi_prec___sxg)="The arrow in the image above shows the time that your headaches started. Did anything happen around the time your headaches started? (choice=Surgery)"
    label(data$p_epi_prec___infect)="The arrow in the image above shows the time that your headaches started. Did anything happen around the time your headaches started? (choice=Infection)"
    label(data$p_epi_prec___oth_ill)="The arrow in the image above shows the time that your headaches started. Did anything happen around the time your headaches started? (choice=Other illness)"
    label(data$p_epi_prec___mens)="The arrow in the image above shows the time that your headaches started. Did anything happen around the time your headaches started? (choice=Menstrual periods started)"
    label(data$p_epi_prec___stress)="The arrow in the image above shows the time that your headaches started. Did anything happen around the time your headaches started? (choice=Stressful life event)"
    label(data$p_epi_prec___oth)="The arrow in the image above shows the time that your headaches started. Did anything happen around the time your headaches started? (choice=Other)"
    label(data$p_epi_conc_date)="On what date(s) did your concussion/trauma occur?"
    label(data$p_epi_pattern_change___often)="Have any of the following happened recently? (choice=Headaches come more often than they used to)"
    label(data$p_epi_pattern_change___longer)="Have any of the following happened recently? (choice=Headaches last longer than they used to)"
    label(data$p_epi_pattern_change___none)="Have any of the following happened recently? (choice=No recent change in headache pattern.)"
    label(data$p_epi_inc_fre_prec___none)="Did anything happen around the time your headaches became more freuent? (choice=None)"
    label(data$p_epi_inc_fre_prec___conc)="Did anything happen around the time your headaches became more freuent? (choice=Head trauma or concussion)"
    label(data$p_epi_inc_fre_prec___oth_inj)="Did anything happen around the time your headaches became more freuent? (choice=Other injury)"
    label(data$p_epi_inc_fre_prec___sxg)="Did anything happen around the time your headaches became more freuent? (choice=Surgery)"
    label(data$p_epi_inc_fre_prec___infect)="Did anything happen around the time your headaches became more freuent? (choice=Infection)"
    label(data$p_epi_inc_fre_prec___oth_ill)="Did anything happen around the time your headaches became more freuent? (choice=Other illness)"
    label(data$p_epi_inc_fre_prec___mens)="Did anything happen around the time your headaches became more freuent? (choice=Menstrual periods started)"
    label(data$p_epi_inc_fre_prec___stress)="Did anything happen around the time your headaches became more freuent? (choice=Stressful life event)"
    label(data$p_epi_inc_fre_prec___oth)="Did anything happen around the time your headaches became more freuent? (choice=Other)"
    label(data$p_epi_inc_fre_time)="Over how much time did the headaches become more frequent?"
    label(data$p_epi_fre)="How often are the headaches now?"
    label(data$p_epi_fre_dur)="For how long have the headaches been more than 3 days per week?"
    label(data$p_pattern_to_con)="How did the pain get to this pattern where there is at least some headache all the time?"
    label(data$p_con_st_epi_prec_ep___none)="The arrow in the image above shows the time that your headaches started. Did anything happen around the time your headaches started? (choice=None)"
    label(data$p_con_st_epi_prec_ep___conc)="The arrow in the image above shows the time that your headaches started. Did anything happen around the time your headaches started? (choice=Head trauma or concussion)"
    label(data$p_con_st_epi_prec_ep___oth_inj)="The arrow in the image above shows the time that your headaches started. Did anything happen around the time your headaches started? (choice=Other injury)"
    label(data$p_con_st_epi_prec_ep___sxg)="The arrow in the image above shows the time that your headaches started. Did anything happen around the time your headaches started? (choice=Surgery)"
    label(data$p_con_st_epi_prec_ep___infect)="The arrow in the image above shows the time that your headaches started. Did anything happen around the time your headaches started? (choice=Infection)"
    label(data$p_con_st_epi_prec_ep___oth_ill)="The arrow in the image above shows the time that your headaches started. Did anything happen around the time your headaches started? (choice=Other illness)"
    label(data$p_con_st_epi_prec_ep___mens)="The arrow in the image above shows the time that your headaches started. Did anything happen around the time your headaches started? (choice=Menstrual periods started)"
    label(data$p_con_st_epi_prec_ep___stress)="The arrow in the image above shows the time that your headaches started. Did anything happen around the time your headaches started? (choice=Stressful life event)"
    label(data$p_con_st_epi_prec_ep___oth)="The arrow in the image above shows the time that your headaches started. Did anything happen around the time your headaches started? (choice=Other)"
    label(data$p_con_prec___none)="The arrow in the image above shows the time that your constant pain started. Did anything of the following happen at that time? (choice=None)"
    label(data$p_con_prec___conc)="The arrow in the image above shows the time that your constant pain started. Did anything of the following happen at that time? (choice=Head trauma or concussion)"
    label(data$p_con_prec___oth_inj)="The arrow in the image above shows the time that your constant pain started. Did anything of the following happen at that time? (choice=Other injury)"
    label(data$p_con_prec___sxg)="The arrow in the image above shows the time that your constant pain started. Did anything of the following happen at that time? (choice=Surgery)"
    label(data$p_con_prec___infect)="The arrow in the image above shows the time that your constant pain started. Did anything of the following happen at that time? (choice=Infection)"
    label(data$p_con_prec___oth_ill)="The arrow in the image above shows the time that your constant pain started. Did anything of the following happen at that time? (choice=Other illness)"
    label(data$p_con_prec___mens)="The arrow in the image above shows the time that your constant pain started. Did anything of the following happen at that time? (choice=Menstrual periods started)"
    label(data$p_con_prec___stress)="The arrow in the image above shows the time that your constant pain started. Did anything of the following happen at that time? (choice=Stressful life event)"
    label(data$p_con_prec___oth)="The arrow in the image above shows the time that your constant pain started. Did anything of the following happen at that time? (choice=Other)"
    label(data$p_con_conc_date)="On what date(s) did your concussion/trauma occur?"
    label(data$p_con_start_epi_time)="How long did it take to go from infreuent headaches (1 time per week or less) to constant headache?    In other words, how much time passed between the 2 arrows?"
    label(data$p_con_pattern_duration)="For approximately how long have you had a constant headache?"
    label(data$p_con_start_date)="When?"
    label(data$p_con_start_age)="If you do not know exactly when your constant headache started, about how old were you when the constant headache began? "
    label(data$p_fre_bad)="How often do the headaches get in the way of what you want to do?"
    label(data$p_timing___none)="Do bad headaches occur at a particular time (time of day, season, or day of the week)? (choice=No)"
    label(data$p_timing___wake)="Do bad headaches occur at a particular time (time of day, season, or day of the week)? (choice=waking up)"
    label(data$p_timing___morning)="Do bad headaches occur at a particular time (time of day, season, or day of the week)? (choice=morning)"
    label(data$p_timing___noon)="Do bad headaches occur at a particular time (time of day, season, or day of the week)? (choice=afternoon)"
    label(data$p_timing___evening)="Do bad headaches occur at a particular time (time of day, season, or day of the week)? (choice=evening)"
    label(data$p_timing___night)="Do bad headaches occur at a particular time (time of day, season, or day of the week)? (choice=night)"
    label(data$p_timing___sleep)="Do bad headaches occur at a particular time (time of day, season, or day of the week)? (choice=while asleep)"
    label(data$p_timing___spring)="Do bad headaches occur at a particular time (time of day, season, or day of the week)? (choice=spring)"
    label(data$p_timing___summer)="Do bad headaches occur at a particular time (time of day, season, or day of the week)? (choice=summer)"
    label(data$p_timing___fall)="Do bad headaches occur at a particular time (time of day, season, or day of the week)? (choice=fall)"
    label(data$p_timing___winter)="Do bad headaches occur at a particular time (time of day, season, or day of the week)? (choice=winter)"
    label(data$p_timing___mon)="Do bad headaches occur at a particular time (time of day, season, or day of the week)? (choice=Monday)"
    label(data$p_timing___tue)="Do bad headaches occur at a particular time (time of day, season, or day of the week)? (choice=Tuesday)"
    label(data$p_timing___wed)="Do bad headaches occur at a particular time (time of day, season, or day of the week)? (choice=Wednesday)"
    label(data$p_timing___thur)="Do bad headaches occur at a particular time (time of day, season, or day of the week)? (choice=Thursday)"
    label(data$p_timing___fri)="Do bad headaches occur at a particular time (time of day, season, or day of the week)? (choice=Friday)"
    label(data$p_timing___sat)="Do bad headaches occur at a particular time (time of day, season, or day of the week)? (choice=Saturday)"
    label(data$p_timing___sun)="Do bad headaches occur at a particular time (time of day, season, or day of the week)? (choice=Sunday)"
    label(data$p_timing_wake_up)="Do headaches wake you from sleep?"
    label(data$p_ha_quality___throb)="Which of the following best describes your headache when it is very bad? (choice=Throbbing)"
    label(data$p_ha_quality___pound)="Which of the following best describes your headache when it is very bad? (choice=Pounding)"
    label(data$p_ha_quality___stab)="Which of the following best describes your headache when it is very bad? (choice=Stabbing)"
    label(data$p_ha_quality___pushin)="Which of the following best describes your headache when it is very bad? (choice=Pressure pushing in (squeezing))"
    label(data$p_ha_quality___pushout)="Which of the following best describes your headache when it is very bad? (choice=Pressure pushing out)"
    label(data$p_ha_quality___dull)="Which of the following best describes your headache when it is very bad? (choice=Dull)"
    label(data$p_ha_quality___burn)="Which of the following best describes your headache when it is very bad? (choice=Burning)"
    label(data$p_ha_quality___sharp)="Which of the following best describes your headache when it is very bad? (choice=Sharp)"
    label(data$p_ha_quality___tight)="Which of the following best describes your headache when it is very bad? (choice=Tightness)"
    label(data$p_ha_quality___pinch)="Which of the following best describes your headache when it is very bad? (choice=Pinching)"
    label(data$p_ha_quality___pulse)="Which of the following best describes your headache when it is very bad? (choice=Pulsating)"
    label(data$p_ha_quality___cant_desc)="Which of the following best describes your headache when it is very bad? (choice=Unable to describe)"
    label(data$p_ha_quality___oth)="Which of the following best describes your headache when it is very bad? (choice=Other)"
    label(data$p_location_side___right)="On which side do you feel headache pain? (choice=Right side only)"
    label(data$p_location_side___left)="On which side do you feel headache pain? (choice=Left side only)"
    label(data$p_location_side___both)="On which side do you feel headache pain? (choice=Both sides at the same time)"
    label(data$p_location_side___cant_desc)="On which side do you feel headache pain? (choice=Unable to describe)"
    label(data$p_location_area___sides)="Where on your head do you feel pain? (choice=Temples/sides)"
    label(data$p_location_area___front)="Where on your head do you feel pain? (choice=Front/Forehead)"
    label(data$p_location_area___top)="Where on your head do you feel pain? (choice=Top)"
    label(data$p_location_area___back)="Where on your head do you feel pain? (choice=Back of head)"
    label(data$p_location_area___neck)="Where on your head do you feel pain? (choice=Neck)"
    label(data$p_location_area___around)="Where on your head do you feel pain? (choice=Around eyes)"
    label(data$p_location_area___behind)="Where on your head do you feel pain? (choice=Behind the eyes)"
    label(data$p_location_area___allover)="Where on your head do you feel pain? (choice=All over)"
    label(data$p_location_area___oth)="Where on your head do you feel pain? (choice=Other)"
    label(data$p_location_area___cant_desc)="Where on your head do you feel pain? (choice=Unable to describe)"
    label(data$p_sev_overall)="Overall, how bad are the headaches?"
    label(data$p_sev_usual)="Your usual headache level:"
    label(data$p_sev_morning)="Your headache when you first wake up, before you get out of bed:"
    label(data$p_sev_hr_after_bed)="Your headache an hour after getting out of bed:"
    label(data$p_sev_rate_rise)="When the pain goes up, how long does it take for the pain to get bad?"
    label(data$p_sev_dur)="How long do bad headaches usually last?"
    label(data$p_relief_sleep)="Do you want to sleep when you get a headache?"
    label(data$p_relief___no)="Do any of the following make your headaches better? (choice=None)"
    label(data$p_relief___ice)="Do any of the following make your headaches better? (choice=Ice)"
    label(data$p_relief___heat)="Do any of the following make your headaches better? (choice=Heat)"
    label(data$p_relief___sunglasses)="Do any of the following make your headaches better? (choice=Sunglasses)"
    label(data$p_relief___caffeine)="Do any of the following make your headaches better? (choice=Caffeine)"
    label(data$p_relief___quiet)="Do any of the following make your headaches better? (choice=Quiet)"
    label(data$p_relief___lying_down)="Do any of the following make your headaches better? (choice=Lying down)"
    label(data$p_relief___active)="Do any of the following make your headaches better? (choice=Staying active)"
    label(data$p_relief___oth)="Do any of the following make your headaches better? (choice=Other)"
    label(data$p_trigger___none)="Are there triggers that bring on headaches or make them worse? (choice=none)"
    label(data$p_trigger___period)="Are there triggers that bring on headaches or make them worse? (choice=menstrual cycle)"
    label(data$p_trigger___much_sleep)="Are there triggers that bring on headaches or make them worse? (choice=too much sleep)"
    label(data$p_trigger___little_sleep)="Are there triggers that bring on headaches or make them worse? (choice=too little sleep)"
    label(data$p_trigger___fatigue)="Are there triggers that bring on headaches or make them worse? (choice=fatigue)"
    label(data$p_trigger___exercise)="Are there triggers that bring on headaches or make them worse? (choice=exercising)"
    label(data$p_trigger___overheat)="Are there triggers that bring on headaches or make them worse? (choice=becoming overheated)"
    label(data$p_trigger___dehyd)="Are there triggers that bring on headaches or make them worse? (choice=dehydration)"
    label(data$p_trigger___skip_meals)="Are there triggers that bring on headaches or make them worse? (choice=skipping meals)"
    label(data$p_trigger___food)="Are there triggers that bring on headaches or make them worse? (choice=specific foods)"
    label(data$p_trigger___meds)="Are there triggers that bring on headaches or make them worse? (choice=medications)"
    label(data$p_trigger___chew)="Are there triggers that bring on headaches or make them worse? (choice=chewing)"
    label(data$p_trigger___stress)="Are there triggers that bring on headaches or make them worse? (choice=stress)"
    label(data$p_trigger___let_down)="Are there triggers that bring on headaches or make them worse? (choice=stress let-down)"
    label(data$p_trigger___screen)="Are there triggers that bring on headaches or make them worse? (choice=screen time)"
    label(data$p_trigger___concentrate)="Are there triggers that bring on headaches or make them worse? (choice=concentration)"
    label(data$p_trigger___read)="Are there triggers that bring on headaches or make them worse? (choice=reading)"
    label(data$p_trigger___light)="Are there triggers that bring on headaches or make them worse? (choice=light)"
    label(data$p_trigger___noises)="Are there triggers that bring on headaches or make them worse? (choice=noises)"
    label(data$p_trigger___smells)="Are there triggers that bring on headaches or make them worse? (choice=smells)"
    label(data$p_trigger___smoke)="Are there triggers that bring on headaches or make them worse? (choice=smoke)"
    label(data$p_trigger___weather)="Are there triggers that bring on headaches or make them worse? (choice=weather)"
    label(data$p_trigger___high_alt)="Are there triggers that bring on headaches or make them worse? (choice=higher altitude)"
    label(data$p_trigger___oth)="Are there triggers that bring on headaches or make them worse? (choice=other)"
    label(data$p_allodynia_hurt___none)="Do any of the following hurt? (choice=none)"
    label(data$p_allodynia_hurt___ponytail)="Do any of the following hurt? (choice=wearing your hair in a ponytail)"
    label(data$p_allodynia_hurt___comb)="Do any of the following hurt? (choice=combing or brushing your hair)"
    label(data$p_allodynia_hurt___hat)="Do any of the following hurt? (choice=wearing a hat)"
    label(data$p_allodynia_hurt___headphones)="Do any of the following hurt? (choice=wearing headphones)"
    label(data$p_valsalva_position___none)="Do any of these make headaches much worse?  (choice=none)"
    label(data$p_valsalva_position___sneeze)="Do any of these make headaches much worse?  (choice=sneezing)"
    label(data$p_valsalva_position___cough)="Do any of these make headaches much worse?  (choice=coughing)"
    label(data$p_valsalva_position___laugh)="Do any of these make headaches much worse?  (choice=laughing)"
    label(data$p_valsalva_position___stand)="Do any of these make headaches much worse?  (choice=standing up)"
    label(data$p_valsalva_position___lie)="Do any of these make headaches much worse?  (choice=lying down)"
    label(data$p_valsalva_dur)="How long does the increased pain last?"
    label(data$p_activity)="Does activity or playing impact headaches?"
    label(data$p_assoc_sx_vis___none)="Changes in vision: (choice=None)"
    label(data$p_assoc_sx_vis___spot)="Changes in vision: (choice=Spots)"
    label(data$p_assoc_sx_vis___star)="Changes in vision: (choice=Stars)"
    label(data$p_assoc_sx_vis___light)="Changes in vision: (choice=Lights)"
    label(data$p_assoc_sx_vis___zigzag)="Changes in vision: (choice=Zigzag lines)"
    label(data$p_assoc_sx_vis___blur)="Changes in vision: (choice=blurred vision)"
    label(data$p_assoc_sx_vis___double_vis)="Changes in vision: (choice=Double vision)"
    label(data$p_assoc_sx_vis___heat)="Changes in vision: (choice=Heat waves)"
    label(data$p_assoc_sx_vis___loss_vis)="Changes in vision: (choice=Loss of vision)"
    label(data$p_assoc_sx_vis___oth)="Changes in vision: (choice=Other)"
    label(data$p_assoc_sx_vis___cant_desc)="Changes in vision: (choice=Unable to describe)"
    label(data$p_assoc_sx_neur_bil___none)="Do you have any of these symptoms on BOTH SIDES of your body? (choice=None)"
    label(data$p_assoc_sx_neur_bil___weak)="Do you have any of these symptoms on BOTH SIDES of your body? (choice=Weakness)"
    label(data$p_assoc_sx_neur_bil___numb)="Do you have any of these symptoms on BOTH SIDES of your body? (choice=Numbness)"
    label(data$p_assoc_sx_neur_bil___tingle)="Do you have any of these symptoms on BOTH SIDES of your body? (choice=Tingling)"
    label(data$p_assoc_sx_neur_bil___run_nose)="Do you have any of these symptoms on BOTH SIDES of your body? (choice=Runny nose)"
    label(data$p_assoc_sx_neur_bil___tear)="Do you have any of these symptoms on BOTH SIDES of your body? (choice=Eye tearing)"
    label(data$p_assoc_sx_neur_bil___ptosis)="Do you have any of these symptoms on BOTH SIDES of your body? (choice=Droopy eyelid)"
    label(data$p_assoc_sx_neur_bil___red_eye)="Do you have any of these symptoms on BOTH SIDES of your body? (choice=Red eye)"
    label(data$p_assoc_sx_neur_bil___puff_eye)="Do you have any of these symptoms on BOTH SIDES of your body? (choice=Puffy eyelid)"
    label(data$p_assoc_sx_neur_bil___flush)="Do you have any of these symptoms on BOTH SIDES of your body? (choice=Forehead and facial flushing)"
    label(data$p_assoc_sx_neur_bil___sweat)="Do you have any of these symptoms on BOTH SIDES of your body? (choice=Forehead and facial sweating)"
    label(data$p_assoc_sx_neur_bil___full_ear)="Do you have any of these symptoms on BOTH SIDES of your body? (choice=Sensation of fullness in the ear)"
    label(data$p_assoc_sx_neur_bil___oth)="Do you have any of these symptoms on BOTH SIDES of your body? (choice=Other)"
    label(data$p_assoc_sx_neur_bil___)="Do you have any of these symptoms on BOTH SIDES of your body? (choice=)"
    label(data$p_assoc_sx_neur_uni___none)="Do you experience any of these symptoms on ONE SIDE of your body? (choice=None)"
    label(data$p_assoc_sx_neur_uni___weak)="Do you experience any of these symptoms on ONE SIDE of your body? (choice=Weakness)"
    label(data$p_assoc_sx_neur_uni___numb)="Do you experience any of these symptoms on ONE SIDE of your body? (choice=Numbness)"
    label(data$p_assoc_sx_neur_uni___tingle)="Do you experience any of these symptoms on ONE SIDE of your body? (choice=Tingling)"
    label(data$p_assoc_sx_neur_uni___run_nose)="Do you experience any of these symptoms on ONE SIDE of your body? (choice=Runny nose)"
    label(data$p_assoc_sx_neur_uni___tear)="Do you experience any of these symptoms on ONE SIDE of your body? (choice=Eye tearing)"
    label(data$p_assoc_sx_neur_uni___ptosis)="Do you experience any of these symptoms on ONE SIDE of your body? (choice=Droopy eyelid)"
    label(data$p_assoc_sx_neur_uni___red_eye)="Do you experience any of these symptoms on ONE SIDE of your body? (choice=Red eye)"
    label(data$p_assoc_sx_neur_uni___puff_eye)="Do you experience any of these symptoms on ONE SIDE of your body? (choice=Puffy eyelid)"
    label(data$p_assoc_sx_neur_uni___pupilbig)="Do you experience any of these symptoms on ONE SIDE of your body? (choice=One pupilbig bigger than the other)"
    label(data$p_assoc_sx_neur_uni___flush)="Do you experience any of these symptoms on ONE SIDE of your body? (choice=Forehead and facial flushing)"
    label(data$p_assoc_sx_neur_uni___sweat)="Do you experience any of these symptoms on ONE SIDE of your body? (choice=Forehead and facial sweathing)"
    label(data$p_assoc_sx_neur_uni___full_ear)="Do you experience any of these symptoms on ONE SIDE of your body? (choice=Sensation of fullness in the ear)"
    label(data$p_assoc_sx_neur_uni___oth)="Do you experience any of these symptoms on ONE SIDE of your body? (choice=Other)"
    label(data$p_assoc_sx_gi___none)="Stomach changes: (choice=none)"
    label(data$p_assoc_sx_gi___decreased_app)="Stomach changes: (choice=decreased appetite)"
    label(data$p_assoc_sx_gi___diarr)="Stomach changes: (choice=diarrhea)"
    label(data$p_assoc_sx_gi___naus)="Stomach changes: (choice=nausea)"
    label(data$p_assoc_sx_gi___stom_pain)="Stomach changes: (choice=stomach pain)"
    label(data$p_assoc_sx_gi___vomiting)="Stomach changes: (choice=vomiting)"
    label(data$p_assoc_sx_gi___oth)="Stomach changes: (choice=other)"
    label(data$p_assoc_sx_oth_sx___none)="Other symptoms: (choice=None)"
    label(data$p_assoc_sx_oth_sx___light)="Other symptoms: (choice=Sensitivity to light)"
    label(data$p_assoc_sx_oth_sx___smell)="Other symptoms: (choice=Sensitivity to smells)"
    label(data$p_assoc_sx_oth_sx___sound)="Other symptoms: (choice=Sensitivity to sounds)"
    label(data$p_assoc_sx_oth_sx___lighthead)="Other symptoms: (choice=lightheadness)"
    label(data$p_assoc_sx_oth_sx___spinning)="Other symptoms: (choice=Spinning sensation)"
    label(data$p_assoc_sx_oth_sx___balance)="Other symptoms: (choice=Balance problems)"
    label(data$p_assoc_sx_oth_sx___hear)="Other symptoms: (choice=Trouble hearing)"
    label(data$p_assoc_sx_oth_sx___ringing)="Other symptoms: (choice=Ringing in ear)"
    label(data$p_assoc_sx_oth_sx___unrespons)="Other symptoms: (choice=Unresponsive)"
    label(data$p_assoc_sx_oth_sx___neck_pain)="Other symptoms: (choice=Neck pain or stiffness)"
    label(data$p_assoc_sx_oth_sx___think)="Other symptoms: (choice=Trouble thinking)"
    label(data$p_assoc_sx_oth_sx___talk)="Other symptoms: (choice=Trouble talking)"
    label(data$p_assoc_sx_oth_sx___oth)="Other symptoms: (choice=Other)"
    label(data$p_assoc_sx_pul_ear___none)="Do you ever hear your pulse in your ears (sounds like whoosh-whoosh-whoosh)?  (choice=None)"
    label(data$p_assoc_sx_pul_ear___standing)="Do you ever hear your pulse in your ears (sounds like whoosh-whoosh-whoosh)?  (choice=When standing up)"
    label(data$p_assoc_sx_pul_ear___lying)="Do you ever hear your pulse in your ears (sounds like whoosh-whoosh-whoosh)?  (choice=When lying down or at night)"
    label(data$p_assoc_sx_pul_ear___ha_bad)="Do you ever hear your pulse in your ears (sounds like whoosh-whoosh-whoosh)?  (choice=When the headache is very bad)"
    label(data$p_assoc_sx_pul_ear___oth)="Do you ever hear your pulse in your ears (sounds like whoosh-whoosh-whoosh)?  (choice=Other times)"
    label(data$p_midas_1)="On how many days in the last 3 months did you miss work or school because of your headaches?"
    label(data$p_midas_2)="How many days in the last 3 months was your productivity at work or school reduced by half or more because of your headaches? (Do not include days you counted in question 1 where you missed work or school.)"
    label(data$p_midas_3)="On how many days in the last 3 months did you not do household work (such as housework,  home repairs and maintenance, caring for children and relatives) because of your headaches? "
    label(data$p_midas_4)="How many days in the last 3 months was your productivity in household work reduced by half or more because of your headaches? (Do not include days you counted in question 3 where you did not do household work.)"
    label(data$p_midas_5)="On how many days in the last 3 months did you miss family, social, or leisure activities because of your headaches?"
    label(data$p_midas_score)="Total MIDAS Score"
    label(data$p_pedmidas_1)="How many full school days of school were missed in the last 3 months due to headaches?"
    label(data$p_pedmidas_2)="How many partial days of school were missed in the last 3 months due to headaches (do not include full days counted in the first question)?"
    label(data$p_pedmidas_3)="How many days in the last 3 months did you function at less than half your ability in school because of a headache (do not include days counted in the first two questions)?"
    label(data$p_pedmidas_4)="How many days were you not able to do things at home (i.e., chores, homework, etc.) due to a headache?"
    label(data$p_pedmidas_5)="How many days did you not participate in other activities due to headaches (i.e., play, go out, sports, etc.)?"
    label(data$p_pedmidas_6)="How many days did you participate in these activities, but functioned at less than half your ability (do not include days counted in the 5th question above)?"
    label(data$p_pedmidas_score)="Total PedMIDAS Score"
    label(data$p_med_stop_ha___none)="Medications to STOP headaches (choice=None)"
    label(data$p_med_stop_ha___apap)="Medications to STOP headaches (choice=Acetaminophen (Tylenol))"
    label(data$p_med_stop_ha___ibupro)="Medications to STOP headaches (choice=Ibuprofen (Motrin/Advil))"
    label(data$p_med_stop_ha___naprox)="Medications to STOP headaches (choice=Naproxen (Aleve/Naprosyn))"
    label(data$p_med_stop_ha___asp)="Medications to STOP headaches (choice=Aspirin)"
    label(data$p_med_stop_ha___ketorolac)="Medications to STOP headaches (choice=Ketorolac (Toradol/Sprix))"
    label(data$p_med_stop_ha___ketoprof)="Medications to STOP headaches (choice=Ketoprofen (Relafen))"
    label(data$p_med_stop_ha___diclof)="Medications to STOP headaches (choice=Diclofenac (Voltaren))"
    label(data$p_med_stop_ha___celec)="Medications to STOP headaches (choice=Celecoxib (Celebrex))"
    label(data$p_med_stop_ha___exced)="Medications to STOP headaches (choice=Excedrin (Excedrin Migraine/Excedrin Tension))"
    label(data$p_med_stop_ha___butal)="Medications to STOP headaches (choice=Butalbital (Fioricet/Fiorinal))"
    label(data$p_med_stop_ha___midrin)="Medications to STOP headaches (choice=Midrin)"
    label(data$p_med_stop_ha___methylpred)="Medications to STOP headaches (choice=Methylprednisolone (Medrol Pack))"
    label(data$p_med_stop_ha___pred)="Medications to STOP headaches (choice=Prednisone/Prednisolone)"
    label(data$p_med_stop_ha___suma)="Medications to STOP headaches (choice=Sumatriptan (Imitrex/Treximet))"
    label(data$p_med_stop_ha___riza)="Medications to STOP headaches (choice=Rizatriptan (Maxalt))"
    label(data$p_med_stop_ha___nara)="Medications to STOP headaches (choice=Naratriptan (Amerge))"
    label(data$p_med_stop_ha___almo)="Medications to STOP headaches (choice=Almotriptan (Axert))"
    label(data$p_med_stop_ha___frova)="Medications to STOP headaches (choice=Frovatriptan (Frova))"
    label(data$p_med_stop_ha___eletrip)="Medications to STOP headaches (choice=Eletriptan (Relpax))"
    label(data$p_med_stop_ha___zolmit)="Medications to STOP headaches (choice=Zolmitriptan (Zomig))"
    label(data$p_med_stop_ha___metoclop)="Medications to STOP headaches (choice=Metoclopramide (Reglan))"
    label(data$p_med_stop_ha___proch)="Medications to STOP headaches (choice=Prochlorperazine (Compazine))"
    label(data$p_med_stop_ha___prometh)="Medications to STOP headaches (choice=Promethazine (Phenergan))"
    label(data$p_med_stop_ha___ond)="Medications to STOP headaches (choice=Ondansetron (Zofran))"
    label(data$p_med_stop_ha___diphen)="Medications to STOP headaches (choice=Diphenhydramine (Benadryl))"
    label(data$p_med_stop_ha___dhe)="Medications to STOP headaches (choice=DHE (Migranal))"
    label(data$p_med_stop_ha___tram)="Medications to STOP headaches (choice=Tramadol (Ultram/Ultracet))"
    label(data$p_med_stop_ha___t3)="Medications to STOP headaches (choice=Tylenol #3/Tylenol with Codeine)"
    label(data$p_med_stop_ha___morph)="Medications to STOP headaches (choice=Morphine)"
    label(data$p_med_stop_ha___hydromor)="Medications to STOP headaches (choice=Hydromorphone (Dilaudid))"
    label(data$p_med_stop_ha___nb)="Medications to STOP headaches (choice=Nerve block or Trigger Point Injection)"
    label(data$p_med_stop_ha___oth)="Medications to STOP headaches (choice=Other)"
    label(data$p_when_take_med)="When do you usually take the medication to stop a headache?"
    label(data$p_how_oft_med)="How often do you take a medication to stop a headache?"
    label(data$p_duration_overuse)="For how long have you been taking an acute medicine more than 3 days per week?"
    label(data$p_med_prev_ha___none)="Prescribed treatments to PREVENT headaches or make the freuency or severity better (choice=None)"
    label(data$p_med_prev_ha___acetaz)="Prescribed treatments to PREVENT headaches or make the freuency or severity better (choice=Acetazolamide (Diamox))"
    label(data$p_med_prev_ha___amitrip)="Prescribed treatments to PREVENT headaches or make the freuency or severity better (choice=Amitriptyline (Elavil))"
    label(data$p_med_prev_ha___ateno)="Prescribed treatments to PREVENT headaches or make the freuency or severity better (choice=Atenolol (Tenormin))"
    label(data$p_med_prev_ha___botox)="Prescribed treatments to PREVENT headaches or make the freuency or severity better (choice=Botox injections)"
    label(data$p_med_prev_ha___cefaly)="Prescribed treatments to PREVENT headaches or make the freuency or severity better (choice=Cefaly device)"
    label(data$p_med_prev_ha___cypro)="Prescribed treatments to PREVENT headaches or make the freuency or severity better (choice=Cyproheptadine (Periactin))"
    label(data$p_med_prev_ha___doxy)="Prescribed treatments to PREVENT headaches or make the freuency or severity better (choice=Doxycycline)"
    label(data$p_med_prev_ha___dulox)="Prescribed treatments to PREVENT headaches or make the freuency or severity better (choice=Duloxetine (Cymbalta))"
    label(data$p_med_prev_ha___fluox)="Prescribed treatments to PREVENT headaches or make the freuency or severity better (choice=Fluoxetine (Prozac))"
    label(data$p_med_prev_ha___gaba)="Prescribed treatments to PREVENT headaches or make the freuency or severity better (choice=Gabapentin (Neurontin))"
    label(data$p_med_prev_ha___lamotrig)="Prescribed treatments to PREVENT headaches or make the freuency or severity better (choice=Lamotrigine (Lamictal))"
    label(data$p_med_prev_ha___lisin)="Prescribed treatments to PREVENT headaches or make the freuency or severity better (choice=Lisinopril (Zestril))"
    label(data$p_med_prev_ha___lvt)="Prescribed treatments to PREVENT headaches or make the freuency or severity better (choice=Levetiracetam (Keppra))"
    label(data$p_med_prev_ha___metopro)="Prescribed treatments to PREVENT headaches or make the freuency or severity better (choice=Metoprolol (Toprol))"
    label(data$p_med_prev_ha___minocy)="Prescribed treatments to PREVENT headaches or make the freuency or severity better (choice=Minocycline)"
    label(data$p_med_prev_ha___nb)="Prescribed treatments to PREVENT headaches or make the freuency or severity better (choice=Nerve block or Trigger point injections)"
    label(data$p_med_prev_ha___nebivo)="Prescribed treatments to PREVENT headaches or make the freuency or severity better (choice=Nebivolol (Bystolic))"
    label(data$p_med_prev_ha___nortrip)="Prescribed treatments to PREVENT headaches or make the freuency or severity better (choice=Nortriptyline (Pamelor))"
    label(data$p_med_prev_ha___pregab)="Prescribed treatments to PREVENT headaches or make the freuency or severity better (choice=Pregabalin (Lyrica))"
    label(data$p_med_prev_ha___propano)="Prescribed treatments to PREVENT headaches or make the freuency or severity better (choice=Propanolol (Inderal))"
    label(data$p_med_prev_ha___sertra)="Prescribed treatments to PREVENT headaches or make the freuency or severity better (choice=Sertraline (Zoloft))"
    label(data$p_med_prev_ha___topa)="Prescribed treatments to PREVENT headaches or make the freuency or severity better (choice=Topiramate (Topamax))"
    label(data$p_med_prev_ha___vpa)="Prescribed treatments to PREVENT headaches or make the freuency or severity better (choice=Valproic Acid (Depakote))"
    label(data$p_med_prev_ha___venla)="Prescribed treatments to PREVENT headaches or make the freuency or severity better (choice=Venlafaxine (Effexor))"
    label(data$p_med_prev_ha___verap)="Prescribed treatments to PREVENT headaches or make the freuency or severity better (choice=Verapamil (Calan))"
    label(data$p_med_prev_ha___zonis)="Prescribed treatments to PREVENT headaches or make the freuency or severity better (choice=Zonisamide (Zonegran))"
    label(data$p_med_prev_ha___oth)="Prescribed treatments to PREVENT headaches or make the freuency or severity better (choice=Other)"
    label(data$p_vit_sup_ha___none)="Vitamins and Supplements (choice=None)"
    label(data$p_vit_sup_ha___vitb2)="Vitamins and Supplements (choice=Vitamin B2 (Riboflavin))"
    label(data$p_vit_sup_ha___vitd)="Vitamins and Supplements (choice=Vitamin D)"
    label(data$p_vit_sup_ha___mag)="Vitamins and Supplements (choice=Magnesium)"
    label(data$p_vit_sup_ha___fishoil)="Vitamins and Supplements (choice=Fish Oil)"
    label(data$p_vit_sup_ha___coenzq10)="Vitamins and Supplements (choice=CoEnzyme Q10)"
    label(data$p_vit_sup_ha___feverfew)="Vitamins and Supplements (choice=Feverfew)"
    label(data$p_vit_sup_ha___melatonin)="Vitamins and Supplements (choice=Melatonin)"
    label(data$p_vit_sup_ha___butterbur)="Vitamins and Supplements (choice=Butterbur (Petadolex))"
    label(data$p_vit_sup_ha___oth)="Vitamins and Supplements (choice=Other)"
    label(data$p_non_med_trea_ha___none)="Non-Medication Treatments (choice=none)"
    label(data$p_non_med_trea_ha___acupunc)="Non-Medication Treatments (choice=acupuncture)"
    label(data$p_non_med_trea_ha___biofeed)="Non-Medication Treatments (choice=biofeedback)"
    label(data$p_non_med_trea_ha___chirop)="Non-Medication Treatments (choice=chiropractic manipulation)"
    label(data$p_non_med_trea_ha___counsel)="Non-Medication Treatments (choice=counseling or psychotherapy)"
    label(data$p_non_med_trea_ha___exercise)="Non-Medication Treatments (choice=intensive exercise)"
    label(data$p_non_med_trea_ha___massage)="Non-Medication Treatments (choice=massage therapy)"
    label(data$p_non_med_trea_ha___ot)="Non-Medication Treatments (choice=occupational therapy)"
    label(data$p_non_med_trea_ha___osteo)="Non-Medication Treatments (choice=osteopathic manipulation)"
    label(data$p_non_med_trea_ha___pt)="Non-Medication Treatments (choice=physical therapy)"
    label(data$p_non_med_trea_ha___vision)="Non-Medication Treatments (choice=vision therapy)"
    label(data$p_non_med_trea_ha___oth)="Non-Medication Treatments (choice=other)"
    label(data$p_iv_med_ha___none)="Intravenous (IV) or Intramuscular (IM) Medications: (choice=None)"
    label(data$p_iv_med_ha___ketorolac)="Intravenous (IV) or Intramuscular (IM) Medications: (choice=Ketorolac (Toradol))"
    label(data$p_iv_med_ha___metoclop)="Intravenous (IV) or Intramuscular (IM) Medications: (choice=Metoclopramide (Reglan))"
    label(data$p_iv_med_ha___prochlor)="Intravenous (IV) or Intramuscular (IM) Medications: (choice=Prochlorperazine (Compazine))"
    label(data$p_iv_med_ha___methylpred)="Intravenous (IV) or Intramuscular (IM) Medications: (choice=Methylprednisolone)"
    label(data$p_iv_med_ha___dexameth)="Intravenous (IV) or Intramuscular (IM) Medications: (choice=Dexamethasone)"
    label(data$p_iv_med_ha___mag)="Intravenous (IV) or Intramuscular (IM) Medications: (choice=Magnesium)"
    label(data$p_iv_med_ha___vpa)="Intravenous (IV) or Intramuscular (IM) Medications: (choice=Valproic Acid (Depakote))"
    label(data$p_iv_med_ha___diphen)="Intravenous (IV) or Intramuscular (IM) Medications: (choice=Diphenhydramine (Benadryl))"
    label(data$p_iv_med_ha___opio)="Intravenous (IV) or Intramuscular (IM) Medications: (choice=Opioids (Morphine/Dilaudid))"
    label(data$p_iv_med_ha___lvt)="Intravenous (IV) or Intramuscular (IM) Medications: (choice=Levetiracetam (Keppra))"
    label(data$p_iv_med_ha___dhe)="Intravenous (IV) or Intramuscular (IM) Medications: (choice=DHE (Dihydroergotamine))"
    label(data$p_iv_med_ha___ond)="Intravenous (IV) or Intramuscular (IM) Medications: (choice=Ondansetron (Zofran))"
    label(data$p_iv_med_ha___oth)="Intravenous (IV) or Intramuscular (IM) Medications: (choice=Other)"
    label(data$p_prob_preg_birth)="Were there complications during pregnancy, labor, or delivery?"
    label(data$p_prob_preg_birth_yes)="If yes, please describe."
    label(data$p_preg_full_term)="Was the patient born full term?"
    label(data$p_birth_lbs)="Babys birth weight in pounds?"
    label(data$p_birth_oz)="Babys birth weight in ounces?"
    label(data$p_mom_age_delivery)="What was the age of the patients MOTHER at delivery?"
    label(data$p_early_dev_concerns)="Have there been concerns about the patients development?"
    label(data$p_lost_dev_skill)="Has the patient ever lost development skills?"
    label(data$p_behav_diff)="Have you ever been concerned that the patient behaves very differently than other children his or her age?"
    label(data$p_dom_hand)="Is the patient right handed or left handed?"
    label(data$p_dom_hand_age)="How old was the patient when you were certain of this?"
    label(data$p_hosp_overnt)="Has the patient ever been admitted overnight to a hospital?"
    label(data$p_surgery)="Has the patient ever had surgery?"
    label(data$p_surgery_yes)="If yes, please list the procedures."
    label(data$p_immun_up_date)="Are immunizations up-to-date?"
    label(data$p_overall_prob___none)="General: (choice=None)"
    label(data$p_overall_prob___wt_loss)="General: (choice=Weight loss)"
    label(data$p_overall_prob___wt_gain)="General: (choice=Weight gain)"
    label(data$p_overall_prob___fever)="General: (choice=Fever)"
    label(data$p_overall_prob___fatigue)="General: (choice=Tired all the time (fatigued))"
    label(data$p_overall_prob___ftt)="General: (choice=Failure to thrive)"
    label(data$p_overall_prob___oth)="General: (choice=Other)"
    label(data$p_eye_prob___none)="Eyes: (choice=None)"
    label(data$p_eye_prob___glasses)="Eyes: (choice=Wears glasses or contacts)"
    label(data$p_eye_prob___outward_eyes)="Eyes: (choice=outward turning eye(s))"
    label(data$p_eye_prob___inward_eyes)="Eyes: (choice=inward turning eye(s) (crossed eyes))"
    label(data$p_eye_prob___eye_movt)="Eyes: (choice=eye movement problems)"
    label(data$p_eye_prob___prob_seeing)="Eyes: (choice=problems seeing)"
    label(data$p_eye_prob___blind)="Eyes: (choice=blindness)"
    label(data$p_eye_prob___oth)="Eyes: (choice=Other)"
    label(data$p_ent_prob___none)="Ear, Nose, Throat: (choice=None)"
    label(data$p_ent_prob___hearing)="Ear, Nose, Throat: (choice=hearing problem)"
    label(data$p_ent_prob___deafness)="Ear, Nose, Throat: (choice=deaf- ness)"
    label(data$p_ent_prob___ear_infec)="Ear, Nose, Throat: (choice=ear infection)"
    label(data$p_ent_prob___sinus_infec)="Ear, Nose, Throat: (choice=sinus infection)"
    label(data$p_ent_prob___ringing)="Ear, Nose, Throat: (choice=ringing in ears)"
    label(data$p_ent_prob___dizzy)="Ear, Nose, Throat: (choice=dizzi- ness)"
    label(data$p_ent_prob___tracheo)="Ear, Nose, Throat: (choice=trache- ostomy)"
    label(data$p_ent_prob___nose_bleed)="Ear, Nose, Throat: (choice=nose bleeds)"
    label(data$p_ent_prob___mouth_sore)="Ear, Nose, Throat: (choice=mouth sores)"
    label(data$p_ent_prob___oth)="Ear, Nose, Throat: (choice=Other)"
    label(data$p_heart_prob___none)="Heart: (choice=None)"
    label(data$p_heart_prob___murmur)="Heart: (choice=Murmur)"
    label(data$p_heart_prob___chd)="Heart: (choice=Congenital Heart Disease)"
    label(data$p_heart_prob___high_blood)="Heart: (choice=high blood pressure)"
    label(data$p_heart_prob___faint)="Heart: (choice=fainting (syncope))"
    label(data$p_heart_prob___irreg_beat)="Heart: (choice=irregular heartbeat)"
    label(data$p_heart_prob___easy_tired)="Heart: (choice=easily tired with exercise)"
    label(data$p_heart_prob___pots)="Heart: (choice=POTS)"
    label(data$p_heart_prob___chest_pain)="Heart: (choice=chest pain/ pressure)"
    label(data$p_heart_prob___oth)="Heart: (choice=Other)"
    label(data$p_lung_prob___none)="Lungs: (choice=None)"
    label(data$p_lung_prob___asthma)="Lungs: (choice=asthma)"
    label(data$p_lung_prob___apnea)="Lungs: (choice=breathing pauses (apnea))"
    label(data$p_lung_prob___pneum)="Lungs: (choice=pneumonia)"
    label(data$p_lung_prob___cough)="Lungs: (choice=cough)"
    label(data$p_lung_prob___sob)="Lungs: (choice=shortness of breath)"
    label(data$p_lung_prob___cpap)="Lungs: (choice=CPAP/BiPAP)"
    label(data$p_lung_prob___oth)="Lungs: (choice=Other)"
    label(data$p_sleep_prob___none)="Sleep: (choice=None)"
    label(data$p_sleep_prob___apnea)="Sleep: (choice=sleep apnea)"
    label(data$p_sleep_prob___snore)="Sleep: (choice=loud snoring)"
    label(data$p_sleep_prob___fall_asleep)="Sleep: (choice=trouble falling asleep)"
    label(data$p_sleep_prob___stay_asleep)="Sleep: (choice=trouble staying asleep)"
    label(data$p_sleep_prob___pm_terror)="Sleep: (choice=night terrors)"
    label(data$p_sleep_prob___day_drowsy)="Sleep: (choice=drowsy in daytime)"
    label(data$p_sleep_prob___oth)="Sleep: (choice=Other)"
    label(data$p_gi_prob___none)="Abdomen:  (choice=None)"
    label(data$p_gi_prob___reflux)="Abdomen:  (choice=Reflux (heartburn))"
    label(data$p_gi_prob___nausea)="Abdomen:  (choice=nausea)"
    label(data$p_gi_prob___constipa)="Abdomen:  (choice=Constipa- tion)"
    label(data$p_gi_prob___diarrhea)="Abdomen:  (choice=Diarrhea)"
    label(data$p_gi_prob___abd_pain)="Abdomen:  (choice=Stomach or abdominal pain)"
    label(data$p_gi_prob___tube)="Abdomen:  (choice=NG-tube, G-tube, J-tube)"
    label(data$p_gi_prob___oth)="Abdomen:  (choice=Other)"
    label(data$p_gu_prob___none)="Urinary:  (choice=None)"
    label(data$p_gu_prob___kidney)="Urinary:  (choice=Kidney problem)"
    label(data$p_gu_prob___fre_uti)="Urinary:  (choice=freuent urinary tract infection)"
    label(data$p_gu_prob___urine_prob)="Urinary:  (choice=Urinary problem)"
    label(data$p_gu_prob___menstrual)="Urinary:  (choice=Problems with menstrual period)"
    label(data$p_gu_prob___enuresis)="Urinary:  (choice=bedwetting)"
    label(data$p_gu_prob___incont)="Urinary:  (choice=daytime incontinence)"
    label(data$p_gu_prob___oth)="Urinary:  (choice=Other)"
    label(data$p_musc_prob___none)="Musculoskeletal: (choice=None)"
    label(data$p_musc_prob___joint_pain)="Musculoskeletal: (choice=Joint or muscle pain)"
    label(data$p_musc_prob___neck_pain)="Musculoskeletal: (choice=Neck pain)"
    label(data$p_musc_prob___back_pain)="Musculoskeletal: (choice=Back pain)"
    label(data$p_musc_prob___scolio)="Musculoskeletal: (choice=Scoliosis)"
    label(data$p_musc_prob___muscle_weak)="Musculoskeletal: (choice=Muscle weakness)"
    label(data$p_musc_prob___osteopenia)="Musculoskeletal: (choice=Bone Density problem (osteopenia))"
    label(data$p_musc_prob___oth)="Musculoskeletal: (choice=Other)"
    label(data$p_skin_prob___none)="Skin: (choice=None)"
    label(data$p_skin_prob___eczema)="Skin: (choice=Eczema)"
    label(data$p_skin_prob___birthmark)="Skin: (choice=Birthmarks)"
    label(data$p_skin_prob___rash)="Skin: (choice=Rash)"
    label(data$p_skin_prob___acne)="Skin: (choice=Acne)"
    label(data$p_skin_prob___oth)="Skin: (choice=Other)"
    label(data$p_endo_prob___none)="Endocrine: (choice=None)"
    label(data$p_endo_prob___thyroid)="Endocrine: (choice=Thyroid problems)"
    label(data$p_endo_prob___diab)="Endocrine: (choice=Diabetes)"
    label(data$p_endo_prob___grow_prob)="Endocrine: (choice=Growth problems)"
    label(data$p_endo_prob___puberty)="Endocrine: (choice=early puberty)"
    label(data$p_endo_prob___oth)="Endocrine: (choice=Other)"
    label(data$p_hema_prob___none)="Hematology: (choice=None)"
    label(data$p_hema_prob___sickle)="Hematology: (choice=Sickle cell disease or trait)"
    label(data$p_hema_prob___anemia)="Hematology: (choice=Anemia)"
    label(data$p_hema_prob___abnl_bleed)="Hematology: (choice=Blood clotting problems)"
    label(data$p_hema_prob___bruise)="Hematology: (choice=Easy bruising)"
    label(data$p_hema_prob___bleed)="Hematology: (choice=Easy bleeding)"
    label(data$p_hema_prob___cancer)="Hematology: (choice=Cancer)"
    label(data$p_hema_prob___oth)="Hematology: (choice=Other)"
    label(data$p_hema_prob___)="Hematology: (choice=)"
    label(data$p_immu_prob___none)="Immune: (choice=None)"
    label(data$p_immu_prob___allergies)="Immune: (choice=Seasonal allergies)"
    label(data$p_immu_prob___lupus)="Immune: (choice=lupus)"
    label(data$p_immu_prob___arth)="Immune: (choice=Arthrities)"
    label(data$p_immu_prob___imm_def)="Immune: (choice=Immuno- deficiency)"
    label(data$p_immu_prob___fre_ill)="Immune: (choice=freuent illness)"
    label(data$p_immu_prob___autoimmune)="Immune: (choice=Autoimmune disease)"
    label(data$p_immu_prob___oth)="Immune: (choice=Other)"
    label(data$p_psych_prob___none)="Behavioral Health (choice=None)"
    label(data$p_psych_prob___adhd)="Behavioral Health (choice=Attention deficit disorder (ADHD or ADD))"
    label(data$p_psych_prob___anxiety)="Behavioral Health (choice=Anxiety/ Panic attacks)"
    label(data$p_psych_prob___depress)="Behavioral Health (choice=Depression)"
    label(data$p_psych_prob___behavior)="Behavioral Health (choice=behavior problems)"
    label(data$p_psych_prob___odd)="Behavioral Health (choice=Oppositional Defiant Disorder (ODD))"
    label(data$p_psych_prob___ocd)="Behavioral Health (choice=Obsessive Compulsive Disorder (OCD))"
    label(data$p_psych_prob___pdd)="Behavioral Health (choice=Autism Spectrum or PDD)"
    label(data$p_psych_prob___sw)="Behavioral Health (choice=Social Worker Involved)"
    label(data$p_psych_prob___psychol)="Behavioral Health (choice=Psychologist Involved)"
    label(data$p_psych_prob___psychi)="Behavioral Health (choice=Psychiatrist involved)"
    label(data$p_psych_prob___oth)="Behavioral Health (choice=Other)"
    label(data$p_psych_prob___)="Behavioral Health (choice=)"
    label(data$p_neur_prob___none)="Neurology: (choice=None)"
    label(data$p_neur_prob___seiz_epil)="Neurology: (choice=Seizure(s) or epilepsy)"
    label(data$p_neur_prob___ha)="Neurology: (choice=Headaches or migraines)"
    label(data$p_neur_prob___tics)="Neurology: (choice=Tics)"
    label(data$p_neur_prob___stroke)="Neurology: (choice=Stroke)"
    label(data$p_neur_prob___learn)="Neurology: (choice=Learning problem(s))"
    label(data$p_neur_prob___neuromus)="Neurology: (choice=Neuromuscular problem(s))"
    label(data$p_neur_prob___devt_prob)="Neurology: (choice=Developmental problem(s))"
    label(data$p_neur_prob___concentrate)="Neurology: (choice=Trouble concentrating)"
    label(data$p_neur_prob___balance)="Neurology: (choice=Balance problem)"
    label(data$p_neur_prob___mening)="Neurology: (choice=Meningitis)"
    label(data$p_neur_prob___conc)="Neurology: (choice=Head Trauma or Concussion)"
    label(data$p_neur_prob___enceph)="Neurology: (choice=Encephalitis)"
    label(data$p_neur_prob___numb)="Neurology: (choice=Numbness/ tingling)"
    label(data$p_neur_prob___motion_sick)="Neurology: (choice=Motion or Car Sickness)"
    label(data$p_neur_prob___oth)="Neurology: (choice=Other)"
    label(data$p_other_prob_spec)="Please describe any OTHER relevant health conditions that were not listed above. "
    label(data$p_curr_interven___none)="Do you currently receive any intervention therapies? (choice=None)"
    label(data$p_curr_interven___pt)="Do you currently receive any intervention therapies? (choice=PT)"
    label(data$p_curr_interven___ot)="Do you currently receive any intervention therapies? (choice=OT)"
    label(data$p_curr_interven___speech)="Do you currently receive any intervention therapies? (choice=Speech therapy)"
    label(data$p_curr_interven___behavior)="Do you currently receive any intervention therapies? (choice=Behavior therapy)"
    label(data$p_curr_interven___vision)="Do you currently receive any intervention therapies? (choice=Vision therapy)"
    label(data$p_curr_interven___feeding)="Do you currently receive any intervention therapies? (choice=Feeding therapy)"
    label(data$p_curr_interven___develop)="Do you currently receive any intervention therapies? (choice=Developmental therapy)"
    label(data$p_past_interven___none)="In the PAST, have you received any intervention therapies? (choice=None)"
    label(data$p_past_interven___pt)="In the PAST, have you received any intervention therapies? (choice=PT)"
    label(data$p_past_interven___ot)="In the PAST, have you received any intervention therapies? (choice=OT)"
    label(data$p_past_interven___speech)="In the PAST, have you received any intervention therapies? (choice=Speech therapy)"
    label(data$p_past_interven___behavior)="In the PAST, have you received any intervention therapies? (choice=Behavior therapy)"
    label(data$p_past_interven___vision)="In the PAST, have you received any intervention therapies? (choice=Vision therapy)"
    label(data$p_past_interven___feeding)="In the PAST, have you received any intervention therapies? (choice=Feeding therapy)"
    label(data$p_past_interven___develop)="In the PAST, have you received any intervention therapies? (choice=Developmental therapy)"
    label(data$p_ha_psych_ques)="We have a headache psychologist who teaches pain coping strategies, which have been proven to help children and teens with headaches.  She sees all new patients in the Multidisciplinary Headache Clinic and is available for all headache patients as schedule allows (but only at the main campus in Philadelphia).  Behavioral health services are usually covered by insurance. Would you like to schedule an appointment with our psychologist?"
    label(data$p_fam_hist_dev___none)="Does anyone in the patients family have these development problems? (choice=None)"
    label(data$p_fam_hist_dev___devt_delay)="Does anyone in the patients family have these development problems? (choice=Development delay)"
    label(data$p_fam_hist_dev___learn)="Does anyone in the patients family have these development problems? (choice=learning problems)"
    label(data$p_fam_hist_dev___mental)="Does anyone in the patients family have these development problems? (choice=Mental Retardation)"
    label(data$p_fam_hist_dev___autistic)="Does anyone in the patients family have these development problems? (choice=Autistic Spectrum Disorder)"
    label(data$p_fam_hist_dev___oth)="Does anyone in the patients family have these development problems? (choice=Other development disorder)"
    label(data$p_fam_hist_behav___none)="Does anyone in the patients family have these behavioral health problems? (choice=None)"
    label(data$p_fam_hist_behav___add)="Does anyone in the patients family have these behavioral health problems? (choice=Attention Deficit Disorder (ADD, ADHD))"
    label(data$p_fam_hist_behav___depress)="Does anyone in the patients family have these behavioral health problems? (choice=Depression)"
    label(data$p_fam_hist_behav___anx)="Does anyone in the patients family have these behavioral health problems? (choice=Anxiety)"
    label(data$p_fam_hist_behav___sub_abuse)="Does anyone in the patients family have these behavioral health problems? (choice=Substance abuse)"
    label(data$p_fam_hist_behav___bipolar)="Does anyone in the patients family have these behavioral health problems? (choice=Bipolar disorder)"
    label(data$p_fam_hist_behav___oth)="Does anyone in the patients family have these behavioral health problems? (choice=Other psychiatric/psychological problem)"
    label(data$p_fam_hist_neuro___none)="Does anyone in the patients family have these neurologic problems?  (choice=None)"
    label(data$p_fam_hist_neuro___ha)="Does anyone in the patients family have these neurologic problems?  (choice=Headaches)"
    label(data$p_fam_hist_neuro___mig)="Does anyone in the patients family have these neurologic problems?  (choice=Migraine Headache)"
    label(data$p_fam_hist_neuro___seiz)="Does anyone in the patients family have these neurologic problems?  (choice=Seizures)"
    label(data$p_fam_hist_neuro___epi)="Does anyone in the patients family have these neurologic problems?  (choice=Epilepsy)"
    label(data$p_fam_hist_neuro___tics)="Does anyone in the patients family have these neurologic problems?  (choice=Tics)"
    label(data$p_fam_hist_neuro___tourette)="Does anyone in the patients family have these neurologic problems?  (choice=Tourette Syndrome)"
    label(data$p_fam_hist_neuro___ms)="Does anyone in the patients family have these neurologic problems?  (choice=Multiple Sclerosis)"
    label(data$p_fam_hist_neuro___neuromus)="Does anyone in the patients family have these neurologic problems?  (choice=Neuromuscular Disorder)"
    label(data$p_fam_hist_neuro___aneurysm)="Does anyone in the patients family have these neurologic problems?  (choice=Brain aneurysms)"
    label(data$p_fam_hist_neuro___vascular)="Does anyone in the patients family have these neurologic problems?  (choice=Vascular malformation)"
    label(data$p_fam_hist_neuro___stroke)="Does anyone in the patients family have these neurologic problems?  (choice=Stroke (prior to age 60))"
    label(data$p_fam_hist_neuro___tumor)="Does anyone in the patients family have these neurologic problems?  (choice=Brain tumor)"
    label(data$p_fam_hist_neuro___oth)="Does anyone in the patients family have these neurologic problems?  (choice=Other neurologic problem)"
    label(data$p_fam_hist_med___none)="Does anyone in the patients family have these medical problems? (choice=None)"
    label(data$p_fam_hist_med___bleed)="Does anyone in the patients family have these medical problems? (choice=Bleeding or Clotting Disorder)"
    label(data$p_fam_hist_med___venous_throm)="Does anyone in the patients family have these medical problems? (choice=Deep venous thrombosis)"
    label(data$p_fam_hist_med___pulm_emb)="Does anyone in the patients family have these medical problems? (choice=Pulmonary Embolism)"
    label(data$p_fam_hist_med___miscarriage)="Does anyone in the patients family have these medical problems? (choice=Pregnancy miscarriages)"
    label(data$p_fam_hist_med___autoimmune)="Does anyone in the patients family have these medical problems? (choice=Autoimmune Disease)"
    label(data$p_fam_hist_med___gene)="Does anyone in the patients family have these medical problems? (choice=Genetic disorder)"
    label(data$p_fam_hist_med___early_deaths)="Does anyone in the patients family have these medical problems? (choice=Early deaths (children & young adults))"
    label(data$p_fam_hist_med___hear_loss)="Does anyone in the patients family have these medical problems? (choice=Hearing loss (children & young adults))"
    label(data$p_fam_hist_med___vision_loss)="Does anyone in the patients family have these medical problems? (choice=Vision problems or loss (children & young adults))"
    label(data$p_fam_hist_med___heart_disease)="Does anyone in the patients family have these medical problems? (choice=Heart disease)"
    label(data$p_fam_hist_med___pots)="Does anyone in the patients family have these medical problems? (choice=Syncope/POTS)"
    label(data$p_fam_hist_med___high_blood)="Does anyone in the patients family have these medical problems? (choice=High blood pressure)"
    label(data$p_fam_hist_med___high_choles)="Does anyone in the patients family have these medical problems? (choice=High Cholesterol)"
    label(data$p_fam_hist_med___obese)="Does anyone in the patients family have these medical problems? (choice=Obesity)"
    label(data$p_fam_hist_med___cancer)="Does anyone in the patients family have these medical problems? (choice=Cancer)"
    label(data$p_fam_hist_med___thyroid)="Does anyone in the patients family have these medical problems? (choice=Thyroid Disease)"
    label(data$p_fam_hist_med___oth)="Does anyone in the patients family have these medical problems? (choice=Other)"
    label(data$p_lives_w_child___mom)="Who lives with the patient? (choice=Mother)"
    label(data$p_lives_w_child___dad)="Who lives with the patient? (choice=Father)"
    label(data$p_lives_w_child___sibling)="Who lives with the patient? (choice=Sibling(s))"
    label(data$p_lives_w_child___grand_par)="Who lives with the patient? (choice=Grandparent(s))"
    label(data$p_lives_w_child___aunt_unc)="Who lives with the patient? (choice=Aunt or Uncle)"
    label(data$p_lives_w_child___step_par)="Who lives with the patient? (choice=Stepparent)"
    label(data$p_lives_w_child___foster_par)="Who lives with the patient? (choice=Foster Parents(s))"
    label(data$p_lives_w_child___facility)="Who lives with the patient? (choice=Lives at Residential Facility)"
    label(data$p_lives_w_child___oth)="Who lives with the patient? (choice=Other people)"
    label(data$p_legal_decision___parent)="Who is legally able to make medical decisions for the patient? (choice=Parents)"
    label(data$p_legal_decision___mom)="Who is legally able to make medical decisions for the patient? (choice=Mother)"
    label(data$p_legal_decision___dad)="Who is legally able to make medical decisions for the patient? (choice=Father)"
    label(data$p_legal_decision___grandma)="Who is legally able to make medical decisions for the patient? (choice=Grandmother)"
    label(data$p_legal_decision___grandpa)="Who is legally able to make medical decisions for the patient? (choice=Grandfather)"
    label(data$p_legal_decision___grandprnt)="Who is legally able to make medical decisions for the patient? (choice=Grandparents)"
    label(data$p_legal_decision___fosterpar)="Who is legally able to make medical decisions for the patient? (choice=Foster parents)"
    label(data$p_legal_decision___dhs_dyfs)="Who is legally able to make medical decisions for the patient? (choice=DHS/DYFS)"
    label(data$p_legal_decision___oth)="Who is legally able to make medical decisions for the patient? (choice=Other)"
    label(data$p_prim_care_occ)="What is the occupation of the patients primary caregiver(s)?  Please also provide relationship to the parent. (add note: If completing at the providers office, click on Other to enter information (example: Mother is teacher, Father is contractor)"
    label(data$p_recent_change)="Are there any recent changes at home (job changes, recent moves, new family members, new social stressors, etc)?"
    label(data$p_recent_change_spec)="Please specify:"
    label(data$p_school_type)="What is your grade & school envrionment?"
    label(data$p_school_concerns)="Are there any concerns about academic performance in school?"
    label(data$p_iep_504)="Do you have an IEP (Individualized Educational Plan) or 504 plan? "
    label(data$p_any_oth_info)="Is there anything else we should know?"
    label(data$p_prob_with_form)="Did you have any problems completing this form?"
    label(data$patient_ha_complete)="Complete?"
    label(data$c_reason_for_visit)="What is the reason for your visit today?"
    label(data$c_reason_oth)="Please specify the reason for your visit.    For the rest of the form, please answer the questions with your biggest symptom in mind wherever we ask about headaches."
    label(data$c_visit_type)="Visit Type"
    label(data$c_prov_seen___none)="Have you seen other health care providers for headaches and related conditions? (choice=None)"
    label(data$c_prov_seen___pcp)="Have you seen other health care providers for headaches and related conditions? (choice=Primary Care Clinician)"
    label(data$c_prov_seen___neuro)="Have you seen other health care providers for headaches and related conditions? (choice=Neurologist)"
    label(data$c_prov_seen___eye)="Have you seen other health care providers for headaches and related conditions? (choice=Eye doctor)"
    label(data$c_prov_seen___ent)="Have you seen other health care providers for headaches and related conditions? (choice=Ear, Nose, Throat (ENT))"
    label(data$c_prov_seen___allergy)="Have you seen other health care providers for headaches and related conditions? (choice=Allergist)"
    label(data$c_prov_seen___conc)="Have you seen other health care providers for headaches and related conditions? (choice=concion or Sports Medicine)"
    label(data$c_prov_seen___nsg)="Have you seen other health care providers for headaches and related conditions? (choice=Neurosurgeon)"
    label(data$c_prov_seen___gi)="Have you seen other health care providers for headaches and related conditions? (choice=Gastroenterologist)"
    label(data$c_prov_seen___osteo)="Have you seen other health care providers for headaches and related conditions? (choice=Osteopathic/Integrative Doctor)"
    label(data$c_prov_seen___onco)="Have you seen other health care providers for headaches and related conditions? (choice=Oncologist)"
    label(data$c_prov_seen___cardio)="Have you seen other health care providers for headaches and related conditions? (choice=Cardiologist)"
    label(data$c_prov_seen___psych)="Have you seen other health care providers for headaches and related conditions? (choice=Psychiatrist)"
    label(data$c_prov_seen___psychol)="Have you seen other health care providers for headaches and related conditions? (choice=psychologist)"
    label(data$c_prov_seen___couns)="Have you seen other health care providers for headaches and related conditions? (choice=Counselor)"
    label(data$c_prov_seen___ed)="Have you seen other health care providers for headaches and related conditions? (choice=Emergency Department)"
    label(data$c_prov_seen___oth)="Have you seen other health care providers for headaches and related conditions? (choice=Other)"
    label(data$c_prov_seen_oth)="Please specify:"
    label(data$c_stud_eval___none)="Have any tests been performed?   (choice=None)"
    label(data$c_stud_eval___brain)="Have any tests been performed?   (choice=MRI of Brain)"
    label(data$c_stud_eval___spine)="Have any tests been performed?   (choice=MRI of Spine)"
    label(data$c_stud_eval___ct)="Have any tests been performed?   (choice=CT of Brain)"
    label(data$c_stud_eval___eeg)="Have any tests been performed?   (choice=EEG (brain wave test))"
    label(data$c_stud_eval___emg)="Have any tests been performed?   (choice=EMG (muscle/nerve test))"
    label(data$c_stud_eval___genetic)="Have any tests been performed?   (choice=Genetic Testing)"
    label(data$c_stud_eval___lp)="Have any tests been performed?   (choice=Lumbar Puncture/Spinal tap)"
    label(data$c_stud_eval___npsych)="Have any tests been performed?   (choice=Neuropsych Testing)"
    label(data$c_stud_eval___metabolic)="Have any tests been performed?   (choice=Metabolic Disorders testing)"
    label(data$c_stud_eval___blood)="Have any tests been performed?   (choice=Blood Work)"
    label(data$c_stud_eval___notsure)="Have any tests been performed?   (choice=Not sure)"
    label(data$c_stud_eval___oth)="Have any tests been performed?   (choice=Other)"
    label(data$c_age_first_ha)="How old were you when you had your first headache?   We are asking about any headaches, not just the bad or recent ones."
    label(data$c_ha_in_lifetime)="How many headaches have you had in your lifetime?"
    label(data$c_current_ha_pattern)="What is the current pattern of your headaches?"
    label(data$c_epi_prec___none)="The arrow in the image above shows the time that your headaches started. Did anything happen around the time your headaches started? (choice=None)"
    label(data$c_epi_prec___conc)="The arrow in the image above shows the time that your headaches started. Did anything happen around the time your headaches started? (choice=Head trauma or concussion)"
    label(data$c_epi_prec___oth_inj)="The arrow in the image above shows the time that your headaches started. Did anything happen around the time your headaches started? (choice=Other injury)"
    label(data$c_epi_prec___sxg)="The arrow in the image above shows the time that your headaches started. Did anything happen around the time your headaches started? (choice=Surgery)"
    label(data$c_epi_prec___infect)="The arrow in the image above shows the time that your headaches started. Did anything happen around the time your headaches started? (choice=Infection)"
    label(data$c_epi_prec___oth_ill)="The arrow in the image above shows the time that your headaches started. Did anything happen around the time your headaches started? (choice=Other illness)"
    label(data$c_epi_prec___mens)="The arrow in the image above shows the time that your headaches started. Did anything happen around the time your headaches started? (choice=Menstrual periods started)"
    label(data$c_epi_prec___stress)="The arrow in the image above shows the time that your headaches started. Did anything happen around the time your headaches started? (choice=Stressful life event)"
    label(data$c_epi_prec___oth)="The arrow in the image above shows the time that your headaches started. Did anything happen around the time your headaches started? (choice=Other)"
    label(data$c_epi_prec_oth)="Please specify: "
    label(data$c_epi_conc_date)="On what date(s) did your concussion/trauma occur?"
    label(data$c_epi_conc_moi)="Mechanism of Injury"
    label(data$c_epi_conc_sport)="Sport"
    label(data$c_epi_pattern_change___often)="Have any of the following happened recently? (choice=Headaches come more often than they used to)"
    label(data$c_epi_pattern_change___longer)="Have any of the following happened recently? (choice=Headaches last longer than they used to)"
    label(data$c_epi_pattern_change___none)="Have any of the following happened recently? (choice=No recent change in headache pattern.)"
    label(data$c_epi_inc_fre_prec___none)="Did anything happen around the time your headaches became more freuent? (choice=None)"
    label(data$c_epi_inc_fre_prec___conc)="Did anything happen around the time your headaches became more freuent? (choice=Head trauma or concussion)"
    label(data$c_epi_inc_fre_prec___oth_inj)="Did anything happen around the time your headaches became more freuent? (choice=Other injury)"
    label(data$c_epi_inc_fre_prec___sxg)="Did anything happen around the time your headaches became more freuent? (choice=Surgery)"
    label(data$c_epi_inc_fre_prec___infect)="Did anything happen around the time your headaches became more freuent? (choice=Infection)"
    label(data$c_epi_inc_fre_prec___oth_ill)="Did anything happen around the time your headaches became more freuent? (choice=Other illness)"
    label(data$c_epi_inc_fre_prec___mens)="Did anything happen around the time your headaches became more freuent? (choice=Menstrual periods started)"
    label(data$c_epi_inc_fre_prec___stress)="Did anything happen around the time your headaches became more freuent? (choice=Stressful life event)"
    label(data$c_epi_inc_fre_prec___oth)="Did anything happen around the time your headaches became more freuent? (choice=Other)"
    label(data$c_epi_inc_fre_prec_oth)="Please specify: "
    label(data$c_epi_inc_fre_conc_date)="On what date(s) did your concussion/trauma occur?"
    label(data$c_epi_inc_fre_conc_moi)="Mechanism of Injury"
    label(data$c_epi_inc_fre_conc_sport)="Sport"
    label(data$c_epi_inc_fre_time)="Over how much time did the headaches become more frequent?"
    label(data$c_epi_fre)="How often are the headaches now?"
    label(data$c_epi_fre_oth)="Please specify:"
    label(data$c_epi_fre_dur)="For how long have the headaches been more than 3 days per week?"
    label(data$c_pattern_to_con)="How did the pain get to this pattern where there is at least some headache all the time?"
    label(data$c_con_st_epi_prec_ep___none)="The arrow in the image above shows the time that your headaches started. Did anything happen around the time your headaches started? (choice=None)"
    label(data$c_con_st_epi_prec_ep___conc)="The arrow in the image above shows the time that your headaches started. Did anything happen around the time your headaches started? (choice=Head trauma or concussion)"
    label(data$c_con_st_epi_prec_ep___oth_inj)="The arrow in the image above shows the time that your headaches started. Did anything happen around the time your headaches started? (choice=Other injury)"
    label(data$c_con_st_epi_prec_ep___sxg)="The arrow in the image above shows the time that your headaches started. Did anything happen around the time your headaches started? (choice=Surgery)"
    label(data$c_con_st_epi_prec_ep___infect)="The arrow in the image above shows the time that your headaches started. Did anything happen around the time your headaches started? (choice=Infection)"
    label(data$c_con_st_epi_prec_ep___oth_ill)="The arrow in the image above shows the time that your headaches started. Did anything happen around the time your headaches started? (choice=Other illness)"
    label(data$c_con_st_epi_prec_ep___mens)="The arrow in the image above shows the time that your headaches started. Did anything happen around the time your headaches started? (choice=Menstrual periods started)"
    label(data$c_con_st_epi_prec_ep___stress)="The arrow in the image above shows the time that your headaches started. Did anything happen around the time your headaches started? (choice=Stressful life event)"
    label(data$c_con_st_epi_prec_ep___oth)="The arrow in the image above shows the time that your headaches started. Did anything happen around the time your headaches started? (choice=Other)"
    label(data$c_con_st_epi_prec_ep_oth)="Please specify: "
    label(data$c_con_st_epi_conc_date)="On what date(s) did your concussion/trauma occur?"
    label(data$c_con_st_epi_conc_moi)="Mechanism of Injury"
    label(data$c_con_st_epi_conc_sport)="Sport"
    label(data$c_con_prec___none)="The arrow in the image above shows the time that your constant pain started. Did anything of the following happen at that time? (choice=None)"
    label(data$c_con_prec___conc)="The arrow in the image above shows the time that your constant pain started. Did anything of the following happen at that time? (choice=Head trauma or concussion)"
    label(data$c_con_prec___oth_inj)="The arrow in the image above shows the time that your constant pain started. Did anything of the following happen at that time? (choice=Other injury)"
    label(data$c_con_prec___sxg)="The arrow in the image above shows the time that your constant pain started. Did anything of the following happen at that time? (choice=Surgery)"
    label(data$c_con_prec___infect)="The arrow in the image above shows the time that your constant pain started. Did anything of the following happen at that time? (choice=Infection)"
    label(data$c_con_prec___oth_ill)="The arrow in the image above shows the time that your constant pain started. Did anything of the following happen at that time? (choice=Other illness)"
    label(data$c_con_prec___mens)="The arrow in the image above shows the time that your constant pain started. Did anything of the following happen at that time? (choice=Menstrual periods started)"
    label(data$c_con_prec___stress)="The arrow in the image above shows the time that your constant pain started. Did anything of the following happen at that time? (choice=Stressful life event)"
    label(data$c_con_prec___oth)="The arrow in the image above shows the time that your constant pain started. Did anything of the following happen at that time? (choice=Other)"
    label(data$c_con_prec_oth)="Please specify:"
    label(data$c_con_conc_date)="On what date(s) did your concussion/trauma occur?"
    label(data$c_con_conc_moi)="Mechanism of Injury"
    label(data$c_con_conc_sport)="Sport"
    label(data$c_con_start_epi_time)="How long did it take to go from infreuent headaches (1 time per week or less) to constant headache?    In other words, how much time passed between the 2 arrows?"
    label(data$c_con_pattern_duration)="For approximately how long have you had a constant headache?"
    label(data$c_con_start_date)="When?"
    label(data$c_con_start_age)="If you do not know exactly when your constant headache started, about how old were you when the constant headache began? "
    label(data$c_any_ha_days)="Days per month with ANY headaches"
    label(data$c_severe_ha_days)="Days per month with SEVERE headache"
    label(data$c_fre_bad)="How often do the headaches get in the way of what you want to do?"
    label(data$c_fre_bad_oth)="Please specify:"
    label(data$c_timing___none)="Do bad headaches occur at a particular time (time of day, season, or day of the week)? (choice=No)"
    label(data$c_timing___wake)="Do bad headaches occur at a particular time (time of day, season, or day of the week)? (choice=waking up)"
    label(data$c_timing___morning)="Do bad headaches occur at a particular time (time of day, season, or day of the week)? (choice=morning)"
    label(data$c_timing___noon)="Do bad headaches occur at a particular time (time of day, season, or day of the week)? (choice=afternoon)"
    label(data$c_timing___evening)="Do bad headaches occur at a particular time (time of day, season, or day of the week)? (choice=evening)"
    label(data$c_timing___night)="Do bad headaches occur at a particular time (time of day, season, or day of the week)? (choice=night)"
    label(data$c_timing___sleep)="Do bad headaches occur at a particular time (time of day, season, or day of the week)? (choice=while asleep)"
    label(data$c_timing___spring)="Do bad headaches occur at a particular time (time of day, season, or day of the week)? (choice=spring)"
    label(data$c_timing___summer)="Do bad headaches occur at a particular time (time of day, season, or day of the week)? (choice=summer)"
    label(data$c_timing___fall)="Do bad headaches occur at a particular time (time of day, season, or day of the week)? (choice=fall)"
    label(data$c_timing___winter)="Do bad headaches occur at a particular time (time of day, season, or day of the week)? (choice=winter)"
    label(data$c_timing___mon)="Do bad headaches occur at a particular time (time of day, season, or day of the week)? (choice=Monday)"
    label(data$c_timing___tue)="Do bad headaches occur at a particular time (time of day, season, or day of the week)? (choice=Tuesday)"
    label(data$c_timing___wed)="Do bad headaches occur at a particular time (time of day, season, or day of the week)? (choice=Wednesday)"
    label(data$c_timing___thur)="Do bad headaches occur at a particular time (time of day, season, or day of the week)? (choice=Thursday)"
    label(data$c_timing___fri)="Do bad headaches occur at a particular time (time of day, season, or day of the week)? (choice=Friday)"
    label(data$c_timing___sat)="Do bad headaches occur at a particular time (time of day, season, or day of the week)? (choice=Saturday)"
    label(data$c_timing___sun)="Do bad headaches occur at a particular time (time of day, season, or day of the week)? (choice=Sunday)"
    label(data$c_timing_wake_up)="Do headaches wake you from sleep?"
    label(data$c_ha_quality___throb)="Which of the following best describes your headache when it is very bad? (choice=Throbbing)"
    label(data$c_ha_quality___pound)="Which of the following best describes your headache when it is very bad? (choice=Pounding)"
    label(data$c_ha_quality___stab)="Which of the following best describes your headache when it is very bad? (choice=Stabbing)"
    label(data$c_ha_quality___pushin)="Which of the following best describes your headache when it is very bad? (choice=Pressure pushing in (squeezing))"
    label(data$c_ha_quality___pushout)="Which of the following best describes your headache when it is very bad? (choice=Pressure pushing out)"
    label(data$c_ha_quality___dull)="Which of the following best describes your headache when it is very bad? (choice=Dull)"
    label(data$c_ha_quality___burn)="Which of the following best describes your headache when it is very bad? (choice=Burning)"
    label(data$c_ha_quality___sharp)="Which of the following best describes your headache when it is very bad? (choice=Sharp)"
    label(data$c_ha_quality___tight)="Which of the following best describes your headache when it is very bad? (choice=Tightness)"
    label(data$c_ha_quality___pinch)="Which of the following best describes your headache when it is very bad? (choice=Pinching)"
    label(data$c_ha_quality___pulse)="Which of the following best describes your headache when it is very bad? (choice=Pulsating)"
    label(data$c_ha_quality___cant_desc)="Which of the following best describes your headache when it is very bad? (choice=Unable to describe)"
    label(data$c_ha_quality___oth)="Which of the following best describes your headache when it is very bad? (choice=Other)"
    label(data$c_ha_quality_oth)="Please specify: "
    label(data$c_location_side___right)="On which side do you feel headache pain? (choice=Right side only)"
    label(data$c_location_side___left)="On which side do you feel headache pain? (choice=Left side only)"
    label(data$c_location_side___both)="On which side do you feel headache pain? (choice=Both sides at the same time)"
    label(data$c_location_side___cant_desc)="On which side do you feel headache pain? (choice=Unable to describe)"
    label(data$c_location_area___sides)="Where on your head do you feel pain? (choice=Temples/sides)"
    label(data$c_location_area___front)="Where on your head do you feel pain? (choice=Front/Forehead)"
    label(data$c_location_area___top)="Where on your head do you feel pain? (choice=Top)"
    label(data$c_location_area___back)="Where on your head do you feel pain? (choice=Back of head)"
    label(data$c_location_area___neck)="Where on your head do you feel pain? (choice=Neck)"
    label(data$c_location_area___around)="Where on your head do you feel pain? (choice=Around eyes)"
    label(data$c_location_area___behind)="Where on your head do you feel pain? (choice=Behind the eyes)"
    label(data$c_location_area___allover)="Where on your head do you feel pain? (choice=All over)"
    label(data$c_location_area___oth)="Where on your head do you feel pain? (choice=Other)"
    label(data$c_location_area___cant_desc)="Where on your head do you feel pain? (choice=Unable to describe)"
    label(data$c_location_area_oth)="Please specify:"
    label(data$c_sev_overall)="Overall, how bad are the headaches?"
    label(data$c_sev_usual)="Your usual headache level:"
    label(data$c_sev_morning)="Your headache when you first wake up, before you get out of bed:"
    label(data$c_sev_hr_after_bed)="Your headache an hour after getting out of bed:"
    label(data$c_sev_rate_rise)="When the pain goes up, how long does it take for the pain to get bad?"
    label(data$c_sev_dur)="How long do bad headaches usually last?"
    label(data$c_sev_dur_spec)="Please specify:"
    label(data$c_relief_sleep)="Do you want to sleep when you get a headache?"
    label(data$c_relief___no)="Do any of the following make your headaches better? (choice=None)"
    label(data$c_relief___ice)="Do any of the following make your headaches better? (choice=Ice)"
    label(data$c_relief___heat)="Do any of the following make your headaches better? (choice=Heat)"
    label(data$c_relief___sunglasses)="Do any of the following make your headaches better? (choice=Sunglasses)"
    label(data$c_relief___caffeine)="Do any of the following make your headaches better? (choice=Caffeine)"
    label(data$c_relief___quiet)="Do any of the following make your headaches better? (choice=Quiet)"
    label(data$c_relief___lying_down)="Do any of the following make your headaches better? (choice=Lying down)"
    label(data$c_relief___active)="Do any of the following make your headaches better? (choice=Staying active)"
    label(data$c_relief___oth)="Do any of the following make your headaches better? (choice=Other)"
    label(data$c_relief_oth)="Please specify:"
    label(data$c_trigger___none)="Are there triggers that bring on headaches or make them worse? (choice=none)"
    label(data$c_trigger___period)="Are there triggers that bring on headaches or make them worse? (choice=menstrual cycle)"
    label(data$c_trigger___much_sleep)="Are there triggers that bring on headaches or make them worse? (choice=too much sleep)"
    label(data$c_trigger___little_sleep)="Are there triggers that bring on headaches or make them worse? (choice=too little sleep)"
    label(data$c_trigger___fatigue)="Are there triggers that bring on headaches or make them worse? (choice=fatigue)"
    label(data$c_trigger___exercise)="Are there triggers that bring on headaches or make them worse? (choice=exercising)"
    label(data$c_trigger___overheat)="Are there triggers that bring on headaches or make them worse? (choice=becoming overheated)"
    label(data$c_trigger___dehyd)="Are there triggers that bring on headaches or make them worse? (choice=dehydration)"
    label(data$c_trigger___skip_meals)="Are there triggers that bring on headaches or make them worse? (choice=skipping meals)"
    label(data$c_trigger___food)="Are there triggers that bring on headaches or make them worse? (choice=specific foods)"
    label(data$c_trigger___meds)="Are there triggers that bring on headaches or make them worse? (choice=medications)"
    label(data$c_trigger___chew)="Are there triggers that bring on headaches or make them worse? (choice=chewing)"
    label(data$c_trigger___stress)="Are there triggers that bring on headaches or make them worse? (choice=stress)"
    label(data$c_trigger___let_down)="Are there triggers that bring on headaches or make them worse? (choice=stress let-down)"
    label(data$c_trigger___screen)="Are there triggers that bring on headaches or make them worse? (choice=screen time)"
    label(data$c_trigger___concentrate)="Are there triggers that bring on headaches or make them worse? (choice=concentration)"
    label(data$c_trigger___read)="Are there triggers that bring on headaches or make them worse? (choice=reading)"
    label(data$c_trigger___light)="Are there triggers that bring on headaches or make them worse? (choice=light)"
    label(data$c_trigger___noises)="Are there triggers that bring on headaches or make them worse? (choice=noises)"
    label(data$c_trigger___smells)="Are there triggers that bring on headaches or make them worse? (choice=smells)"
    label(data$c_trigger___smoke)="Are there triggers that bring on headaches or make them worse? (choice=smoke)"
    label(data$c_trigger___weather)="Are there triggers that bring on headaches or make them worse? (choice=weather)"
    label(data$c_trigger___high_alt)="Are there triggers that bring on headaches or make them worse? (choice=higher altitude)"
    label(data$c_trigger___oth)="Are there triggers that bring on headaches or make them worse? (choice=other)"
    label(data$c_trigger_spec)="Please specify:"
    label(data$c_allodynia_hurt___none)="Do any of the following hurt? (choice=none)"
    label(data$c_allodynia_hurt___ponytail)="Do any of the following hurt? (choice=wearing your hair in a ponytail)"
    label(data$c_allodynia_hurt___comb)="Do any of the following hurt? (choice=combing or brushing your hair)"
    label(data$c_allodynia_hurt___hat)="Do any of the following hurt? (choice=wearing a hat)"
    label(data$c_allodynia_hurt___headphones)="Do any of the following hurt? (choice=wearing headphones)"
    label(data$c_valsalva_position___none)="Do any of these make headaches much worse?  (choice=none)"
    label(data$c_valsalva_position___sneeze)="Do any of these make headaches much worse?  (choice=sneezing)"
    label(data$c_valsalva_position___cough)="Do any of these make headaches much worse?  (choice=coughing)"
    label(data$c_valsalva_position___laugh)="Do any of these make headaches much worse?  (choice=laughing)"
    label(data$c_valsalva_position___stand)="Do any of these make headaches much worse?  (choice=standing up)"
    label(data$c_valsalva_position___lie)="Do any of these make headaches much worse?  (choice=lying down)"
    label(data$c_valsalva_dur)="How long does the increased pain last?"
    label(data$c_activity)="Does activity or playing impact headaches?"
    label(data$c_assoc_sx_vis___none)="Changes in vision: (choice=None)"
    label(data$c_assoc_sx_vis___spot)="Changes in vision: (choice=Spots)"
    label(data$c_assoc_sx_vis___star)="Changes in vision: (choice=Stars)"
    label(data$c_assoc_sx_vis___light)="Changes in vision: (choice=Lights)"
    label(data$c_assoc_sx_vis___zigzag)="Changes in vision: (choice=Zigzag lines)"
    label(data$c_assoc_sx_vis___blur)="Changes in vision: (choice=blurred vision)"
    label(data$c_assoc_sx_vis___double_vis)="Changes in vision: (choice=Double vision)"
    label(data$c_assoc_sx_vis___heat)="Changes in vision: (choice=Heat waves)"
    label(data$c_assoc_sx_vis___loss_vis)="Changes in vision: (choice=Loss of vision)"
    label(data$c_assoc_sx_vis___oth)="Changes in vision: (choice=Other)"
    label(data$c_assoc_sx_vis___cant_desc)="Changes in vision: (choice=Unable to describe)"
    label(data$c_assoc_sx_vis_spec)="Please specify:"
    label(data$c_assoc_sx_neur_bil___none)="Do you have any of these symptoms on BOTH SIDES of your body? (choice=None)"
    label(data$c_assoc_sx_neur_bil___weak)="Do you have any of these symptoms on BOTH SIDES of your body? (choice=Weakness)"
    label(data$c_assoc_sx_neur_bil___numb)="Do you have any of these symptoms on BOTH SIDES of your body? (choice=Numbness)"
    label(data$c_assoc_sx_neur_bil___tingle)="Do you have any of these symptoms on BOTH SIDES of your body? (choice=Tingling)"
    label(data$c_assoc_sx_neur_bil___run_nose)="Do you have any of these symptoms on BOTH SIDES of your body? (choice=Runny nose)"
    label(data$c_assoc_sx_neur_bil___tear)="Do you have any of these symptoms on BOTH SIDES of your body? (choice=Eye tearing)"
    label(data$c_assoc_sx_neur_bil___ptosis)="Do you have any of these symptoms on BOTH SIDES of your body? (choice=Droopy eyelid)"
    label(data$c_assoc_sx_neur_bil___red_eye)="Do you have any of these symptoms on BOTH SIDES of your body? (choice=Red eye)"
    label(data$c_assoc_sx_neur_bil___puff_eye)="Do you have any of these symptoms on BOTH SIDES of your body? (choice=Puffy eyelid)"
    label(data$c_assoc_sx_neur_bil___flush)="Do you have any of these symptoms on BOTH SIDES of your body? (choice=Forehead and facial flushing)"
    label(data$c_assoc_sx_neur_bil___sweat)="Do you have any of these symptoms on BOTH SIDES of your body? (choice=Forehead and facial sweating)"
    label(data$c_assoc_sx_neur_bil___full_ear)="Do you have any of these symptoms on BOTH SIDES of your body? (choice=Sensation of fullness in the ear)"
    label(data$c_assoc_sx_neur_bil___oth)="Do you have any of these symptoms on BOTH SIDES of your body? (choice=Other)"
    label(data$c_assoc_sx_neur_bil___)="Do you have any of these symptoms on BOTH SIDES of your body? (choice=)"
    label(data$c_assoc_sx_neur_bil_spec)="Please specify:"
    label(data$c_assoc_sx_neur_uni___none)="Do you experience any of these symptoms on ONE SIDE of your body? (choice=None)"
    label(data$c_assoc_sx_neur_uni___weak)="Do you experience any of these symptoms on ONE SIDE of your body? (choice=Weakness)"
    label(data$c_assoc_sx_neur_uni___numb)="Do you experience any of these symptoms on ONE SIDE of your body? (choice=Numbness)"
    label(data$c_assoc_sx_neur_uni___tingle)="Do you experience any of these symptoms on ONE SIDE of your body? (choice=Tingling)"
    label(data$c_assoc_sx_neur_uni___run_nose)="Do you experience any of these symptoms on ONE SIDE of your body? (choice=Runny nose)"
    label(data$c_assoc_sx_neur_uni___tear)="Do you experience any of these symptoms on ONE SIDE of your body? (choice=Eye tearing)"
    label(data$c_assoc_sx_neur_uni___ptosis)="Do you experience any of these symptoms on ONE SIDE of your body? (choice=Droopy eyelid)"
    label(data$c_assoc_sx_neur_uni___red_eye)="Do you experience any of these symptoms on ONE SIDE of your body? (choice=Red eye)"
    label(data$c_assoc_sx_neur_uni___puff_eye)="Do you experience any of these symptoms on ONE SIDE of your body? (choice=Puffy eyelid)"
    label(data$c_assoc_sx_neur_uni___pupilbig)="Do you experience any of these symptoms on ONE SIDE of your body? (choice=One pupilbig bigger than the other)"
    label(data$c_assoc_sx_neur_uni___flush)="Do you experience any of these symptoms on ONE SIDE of your body? (choice=Forehead and facial flushing)"
    label(data$c_assoc_sx_neur_uni___sweat)="Do you experience any of these symptoms on ONE SIDE of your body? (choice=Forehead and facial sweathing)"
    label(data$c_assoc_sx_neur_uni___full_ear)="Do you experience any of these symptoms on ONE SIDE of your body? (choice=Sensation of fullness in the ear)"
    label(data$c_assoc_sx_neur_uni___oth)="Do you experience any of these symptoms on ONE SIDE of your body? (choice=Other)"
    label(data$c_assoc_sx_neur_uni_spec)="Please specify:"
    label(data$c_assoc_sx_gi___none)="Stomach changes: (choice=none)"
    label(data$c_assoc_sx_gi___decreased_app)="Stomach changes: (choice=decreased appetite)"
    label(data$c_assoc_sx_gi___diarr)="Stomach changes: (choice=diarrhea)"
    label(data$c_assoc_sx_gi___naus)="Stomach changes: (choice=nausea)"
    label(data$c_assoc_sx_gi___stom_pain)="Stomach changes: (choice=stomach pain)"
    label(data$c_assoc_sx_gi___vomiting)="Stomach changes: (choice=vomiting)"
    label(data$c_assoc_sx_gi___oth)="Stomach changes: (choice=other)"
    label(data$c_assoc_sx_gi_spec)="Please specify:"
    label(data$c_assoc_sx_oth_sx___none)="Other symptoms: (choice=None)"
    label(data$c_assoc_sx_oth_sx___light)="Other symptoms: (choice=Sensitivity to light)"
    label(data$c_assoc_sx_oth_sx___smell)="Other symptoms: (choice=Sensitivity to smells)"
    label(data$c_assoc_sx_oth_sx___sound)="Other symptoms: (choice=Sensitivity to sounds)"
    label(data$c_assoc_sx_oth_sx___lighthead)="Other symptoms: (choice=lightheadness)"
    label(data$c_assoc_sx_oth_sx___spinning)="Other symptoms: (choice=Spinning sensation)"
    label(data$c_assoc_sx_oth_sx___balance)="Other symptoms: (choice=Balance problems)"
    label(data$c_assoc_sx_oth_sx___hear)="Other symptoms: (choice=Trouble hearing)"
    label(data$c_assoc_sx_oth_sx___ringing)="Other symptoms: (choice=Ringing in ear)"
    label(data$c_assoc_sx_oth_sx___unrespons)="Other symptoms: (choice=Unresponsive)"
    label(data$c_assoc_sx_oth_sx___neck_pain)="Other symptoms: (choice=Neck pain or stiffness)"
    label(data$c_assoc_sx_oth_sx___think)="Other symptoms: (choice=Trouble thinking)"
    label(data$c_assoc_sx_oth_sx___talk)="Other symptoms: (choice=Trouble talking)"
    label(data$c_assoc_sx_oth_sx___oth)="Other symptoms: (choice=Other)"
    label(data$c_assoc_sx_oth_sx_spec)="Please specify:"
    label(data$c_assoc_sx_pul_ear___none)="Do you ever hear your pulse in your ears (sounds like whoosh-whoosh-whoosh)?  (choice=None)"
    label(data$c_assoc_sx_pul_ear___standing)="Do you ever hear your pulse in your ears (sounds like whoosh-whoosh-whoosh)?  (choice=When standing up)"
    label(data$c_assoc_sx_pul_ear___lying)="Do you ever hear your pulse in your ears (sounds like whoosh-whoosh-whoosh)?  (choice=When lying down or at night)"
    label(data$c_assoc_sx_pul_ear___ha_bad)="Do you ever hear your pulse in your ears (sounds like whoosh-whoosh-whoosh)?  (choice=When the headache is very bad)"
    label(data$c_assoc_sx_pul_ear___oth)="Do you ever hear your pulse in your ears (sounds like whoosh-whoosh-whoosh)?  (choice=Other times)"
    label(data$c_assoc_sx_pul_ear_spec)="Please specify:"
    label(data$c_midas_1)="On how many days in the last 3 months did you miss work or school because of your headaches?"
    label(data$c_midas_2)="How many days in the last 3 months was your productivity at work or school reduced by half or more because of your headaches? (Do not include days you counted in question 1 where you missed work or school.)"
    label(data$c_midas_3)="On how many days in the last 3 months did you not do household work (such as housework,  home repairs and maintenance, caring for children and relatives) because of your headaches? "
    label(data$c_midas_4)="How many days in the last 3 months was your productivity in household work reduced by half or more because of your headaches? (Do not include days you counted in question 3 where you did not do household work.)"
    label(data$c_midas_5)="On how many days in the last 3 months did you miss family, social, or leisure activities because of your headaches?"
    label(data$c_midas_score)="Total MIDAS Score"
    label(data$c_pedmidas_1)="How many full school days of school were missed in the last 3 months due to headaches?"
    label(data$c_pedmidas_2)="How many partial days of school were missed in the last 3 months due to headaches (do not include full days counted in the first question)?"
    label(data$c_pedmidas_3)="How many days in the last 3 months did you function at less than half your ability in school because of a headache (do not include days counted in the first two questions)?"
    label(data$c_pedmidas_4)="How many days were you not able to do things at home (i.e., chores, homework, etc.) due to a headache?"
    label(data$c_pedmidas_5)="How many days did you not participate in other activities due to headaches (i.e., play, go out, sports, etc.)?"
    label(data$c_pedmidas_6)="How many days did you participate in these activities, but functioned at less than half your ability (do not include days counted in the 5th question above)?"
    label(data$c_pedmidas_score)="Total PedMIDAS Score"
    label(data$c_med_stop_ha___none)="Medications to STOP headaches (choice=None)"
    label(data$c_med_stop_ha___apap)="Medications to STOP headaches (choice=Acetaminophen (Tylenol))"
    label(data$c_med_stop_ha___ibupro)="Medications to STOP headaches (choice=Ibuprofen (Motrin/Advil))"
    label(data$c_med_stop_ha___naprox)="Medications to STOP headaches (choice=Naproxen (Aleve/Naprosyn))"
    label(data$c_med_stop_ha___asp)="Medications to STOP headaches (choice=Aspirin)"
    label(data$c_med_stop_ha___ketorolac)="Medications to STOP headaches (choice=Ketorolac (Toradol/Sprix))"
    label(data$c_med_stop_ha___ketoprof)="Medications to STOP headaches (choice=Ketoprofen (Relafen))"
    label(data$c_med_stop_ha___diclof)="Medications to STOP headaches (choice=Diclofenac (Voltaren))"
    label(data$c_med_stop_ha___celec)="Medications to STOP headaches (choice=Celecoxib (Celebrex))"
    label(data$c_med_stop_ha___exced)="Medications to STOP headaches (choice=Excedrin (Excedrin Migraine/Excedrin Tension))"
    label(data$c_med_stop_ha___butal)="Medications to STOP headaches (choice=Butalbital (Fioricet/Fiorinal))"
    label(data$c_med_stop_ha___midrin)="Medications to STOP headaches (choice=Midrin)"
    label(data$c_med_stop_ha___methylpred)="Medications to STOP headaches (choice=Methylprednisolone (Medrol Pack))"
    label(data$c_med_stop_ha___pred)="Medications to STOP headaches (choice=Prednisone/Prednisolone)"
    label(data$c_med_stop_ha___suma)="Medications to STOP headaches (choice=Sumatriptan (Imitrex/Treximet))"
    label(data$c_med_stop_ha___riza)="Medications to STOP headaches (choice=Rizatriptan (Maxalt))"
    label(data$c_med_stop_ha___nara)="Medications to STOP headaches (choice=Naratriptan (Amerge))"
    label(data$c_med_stop_ha___almo)="Medications to STOP headaches (choice=Almotriptan (Axert))"
    label(data$c_med_stop_ha___frova)="Medications to STOP headaches (choice=Frovatriptan (Frova))"
    label(data$c_med_stop_ha___eletrip)="Medications to STOP headaches (choice=Eletriptan (Relpax))"
    label(data$c_med_stop_ha___zolmit)="Medications to STOP headaches (choice=Zolmitriptan (Zomig))"
    label(data$c_med_stop_ha___metoclop)="Medications to STOP headaches (choice=Metoclopramide (Reglan))"
    label(data$c_med_stop_ha___proch)="Medications to STOP headaches (choice=Prochlorperazine (Compazine))"
    label(data$c_med_stop_ha___prometh)="Medications to STOP headaches (choice=Promethazine (Phenergan))"
    label(data$c_med_stop_ha___ond)="Medications to STOP headaches (choice=Ondansetron (Zofran))"
    label(data$c_med_stop_ha___diphen)="Medications to STOP headaches (choice=Diphenhydramine (Benadryl))"
    label(data$c_med_stop_ha___dhe)="Medications to STOP headaches (choice=DHE (Migranal))"
    label(data$c_med_stop_ha___tram)="Medications to STOP headaches (choice=Tramadol (Ultram/Ultracet))"
    label(data$c_med_stop_ha___t3)="Medications to STOP headaches (choice=Tylenol #3/Tylenol with Codeine)"
    label(data$c_med_stop_ha___morph)="Medications to STOP headaches (choice=Morphine)"
    label(data$c_med_stop_ha___hydromor)="Medications to STOP headaches (choice=Hydromorphone (Dilaudid))"
    label(data$c_med_stop_ha___nb)="Medications to STOP headaches (choice=Nerve block or Trigger Point Injection)"
    label(data$c_med_stop_ha___oth)="Medications to STOP headaches (choice=Other)"
    label(data$c_med_stop_ha_oth_spec)="Please specify: "
    label(data$c_when_take_med)="When do you usually take the medication to stop a headache?"
    label(data$c_how_oft_med)="How often do you take a medication to stop a headache?"
    label(data$c_duration_overuse)="For how long have you been taking an acute medicine more than 3 days per week?"
    label(data$c_med_prev_ha___none)="Prescribed treatments to PREVENT headaches or make the freuency or severity better (choice=None)"
    label(data$c_med_prev_ha___acetaz)="Prescribed treatments to PREVENT headaches or make the freuency or severity better (choice=Acetazolamide (Diamox))"
    label(data$c_med_prev_ha___amitrip)="Prescribed treatments to PREVENT headaches or make the freuency or severity better (choice=Amitriptyline (Elavil))"
    label(data$c_med_prev_ha___ateno)="Prescribed treatments to PREVENT headaches or make the freuency or severity better (choice=Atenolol (Tenormin))"
    label(data$c_med_prev_ha___botox)="Prescribed treatments to PREVENT headaches or make the freuency or severity better (choice=Botox injections)"
    label(data$c_med_prev_ha___cefaly)="Prescribed treatments to PREVENT headaches or make the freuency or severity better (choice=Cefaly device)"
    label(data$c_med_prev_ha___cypro)="Prescribed treatments to PREVENT headaches or make the freuency or severity better (choice=Cyproheptadine (Periactin))"
    label(data$c_med_prev_ha___doxy)="Prescribed treatments to PREVENT headaches or make the freuency or severity better (choice=Doxycycline)"
    label(data$c_med_prev_ha___dulox)="Prescribed treatments to PREVENT headaches or make the freuency or severity better (choice=Duloxetine (Cymbalta))"
    label(data$c_med_prev_ha___fluox)="Prescribed treatments to PREVENT headaches or make the freuency or severity better (choice=Fluoxetine (Prozac))"
    label(data$c_med_prev_ha___gaba)="Prescribed treatments to PREVENT headaches or make the freuency or severity better (choice=Gabapentin (Neurontin))"
    label(data$c_med_prev_ha___lamotrig)="Prescribed treatments to PREVENT headaches or make the freuency or severity better (choice=Lamotrigine (Lamictal))"
    label(data$c_med_prev_ha___lisin)="Prescribed treatments to PREVENT headaches or make the freuency or severity better (choice=Lisinopril (Zestril))"
    label(data$c_med_prev_ha___lvt)="Prescribed treatments to PREVENT headaches or make the freuency or severity better (choice=Levetiracetam (Keppra))"
    label(data$c_med_prev_ha___metopro)="Prescribed treatments to PREVENT headaches or make the freuency or severity better (choice=Metoprolol (Toprol))"
    label(data$c_med_prev_ha___minocy)="Prescribed treatments to PREVENT headaches or make the freuency or severity better (choice=Minocycline)"
    label(data$c_med_prev_ha___nb)="Prescribed treatments to PREVENT headaches or make the freuency or severity better (choice=Nerve block or Trigger point injections)"
    label(data$c_med_prev_ha___nebivo)="Prescribed treatments to PREVENT headaches or make the freuency or severity better (choice=Nebivolol (Bystolic))"
    label(data$c_med_prev_ha___nortrip)="Prescribed treatments to PREVENT headaches or make the freuency or severity better (choice=Nortriptyline (Pamelor))"
    label(data$c_med_prev_ha___pregab)="Prescribed treatments to PREVENT headaches or make the freuency or severity better (choice=Pregabalin (Lyrica))"
    label(data$c_med_prev_ha___propano)="Prescribed treatments to PREVENT headaches or make the freuency or severity better (choice=Propanolol (Inderal))"
    label(data$c_med_prev_ha___sertra)="Prescribed treatments to PREVENT headaches or make the freuency or severity better (choice=Sertraline (Zoloft))"
    label(data$c_med_prev_ha___topa)="Prescribed treatments to PREVENT headaches or make the freuency or severity better (choice=Topiramate (Topamax))"
    label(data$c_med_prev_ha___vpa)="Prescribed treatments to PREVENT headaches or make the freuency or severity better (choice=Valproic Acid (Depakote))"
    label(data$c_med_prev_ha___venla)="Prescribed treatments to PREVENT headaches or make the freuency or severity better (choice=Venlafaxine (Effexor))"
    label(data$c_med_prev_ha___verap)="Prescribed treatments to PREVENT headaches or make the freuency or severity better (choice=Verapamil (Calan))"
    label(data$c_med_prev_ha___zonis)="Prescribed treatments to PREVENT headaches or make the freuency or severity better (choice=Zonisamide (Zonegran))"
    label(data$c_med_prev_ha___oth)="Prescribed treatments to PREVENT headaches or make the freuency or severity better (choice=Other)"
    label(data$c_med_prev_ha_oth_spec)="Please specify:"
    label(data$c_vit_sup_ha___none)="Vitamins and Supplements (choice=None)"
    label(data$c_vit_sup_ha___vitb2)="Vitamins and Supplements (choice=Vitamin B2 (Riboflavin))"
    label(data$c_vit_sup_ha___vitd)="Vitamins and Supplements (choice=Vitamin D)"
    label(data$c_vit_sup_ha___mag)="Vitamins and Supplements (choice=Magnesium)"
    label(data$c_vit_sup_ha___fishoil)="Vitamins and Supplements (choice=Fish Oil)"
    label(data$c_vit_sup_ha___coenzq10)="Vitamins and Supplements (choice=CoEnzyme Q10)"
    label(data$c_vit_sup_ha___feverfew)="Vitamins and Supplements (choice=Feverfew)"
    label(data$c_vit_sup_ha___melatonin)="Vitamins and Supplements (choice=Melatonin)"
    label(data$c_vit_sup_ha___butterbur)="Vitamins and Supplements (choice=Butterbur (Petadolex))"
    label(data$c_vit_sup_ha___oth)="Vitamins and Supplements (choice=Other)"
    label(data$c_vit_sup_ha_oth)="Please specify:"
    label(data$c_non_med_trea_ha___none)="Non-Medication Treatments (choice=none)"
    label(data$c_non_med_trea_ha___acupunc)="Non-Medication Treatments (choice=acupuncture)"
    label(data$c_non_med_trea_ha___biofeed)="Non-Medication Treatments (choice=biofeedback)"
    label(data$c_non_med_trea_ha___chirop)="Non-Medication Treatments (choice=chiropractic manipulation)"
    label(data$c_non_med_trea_ha___counsel)="Non-Medication Treatments (choice=counseling or psychotherapy)"
    label(data$c_non_med_trea_ha___exercise)="Non-Medication Treatments (choice=intensive exercise)"
    label(data$c_non_med_trea_ha___massage)="Non-Medication Treatments (choice=massage therapy)"
    label(data$c_non_med_trea_ha___ot)="Non-Medication Treatments (choice=occupational therapy)"
    label(data$c_non_med_trea_ha___osteo)="Non-Medication Treatments (choice=osteopathic manipulation)"
    label(data$c_non_med_trea_ha___pt)="Non-Medication Treatments (choice=physical therapy)"
    label(data$c_non_med_trea_ha___vision)="Non-Medication Treatments (choice=vision therapy)"
    label(data$c_non_med_trea_ha___oth)="Non-Medication Treatments (choice=other)"
    label(data$c_non_med_trea_oth)="Please specify: "
    label(data$c_iv_med_ha___none)="Intravenous (IV) or Intramuscular (IM) Medications: (choice=None)"
    label(data$c_iv_med_ha___ketorolac)="Intravenous (IV) or Intramuscular (IM) Medications: (choice=Ketorolac (Toradol))"
    label(data$c_iv_med_ha___metoclop)="Intravenous (IV) or Intramuscular (IM) Medications: (choice=Metoclopramide (Reglan))"
    label(data$c_iv_med_ha___prochlor)="Intravenous (IV) or Intramuscular (IM) Medications: (choice=Prochlorperazine (Compazine))"
    label(data$c_iv_med_ha___methylpred)="Intravenous (IV) or Intramuscular (IM) Medications: (choice=Methylprednisolone)"
    label(data$c_iv_med_ha___dexameth)="Intravenous (IV) or Intramuscular (IM) Medications: (choice=Dexamethasone)"
    label(data$c_iv_med_ha___mag)="Intravenous (IV) or Intramuscular (IM) Medications: (choice=Magnesium)"
    label(data$c_iv_med_ha___vpa)="Intravenous (IV) or Intramuscular (IM) Medications: (choice=Valproic Acid (Depakote))"
    label(data$c_iv_med_ha___diphen)="Intravenous (IV) or Intramuscular (IM) Medications: (choice=Diphenhydramine (Benadryl))"
    label(data$c_iv_med_ha___opio)="Intravenous (IV) or Intramuscular (IM) Medications: (choice=Opioids (Morphine/Dilaudid))"
    label(data$c_iv_med_ha___lvt)="Intravenous (IV) or Intramuscular (IM) Medications: (choice=Levetiracetam (Keppra))"
    label(data$c_iv_med_ha___dhe)="Intravenous (IV) or Intramuscular (IM) Medications: (choice=DHE (Dihydroergotamine))"
    label(data$c_iv_med_ha___ond)="Intravenous (IV) or Intramuscular (IM) Medications: (choice=Ondansetron (Zofran))"
    label(data$c_iv_med_ha___oth)="Intravenous (IV) or Intramuscular (IM) Medications: (choice=Other)"
    label(data$c_iv_med_spec)="Please specify:"
    label(data$clinician_ha_complete)="Complete?"
    #Setting Units
    
    
    #Setting Factors(will create new variable for factors)
    data$redcap_repeat_instrument.factor = factor(data$redcap_repeat_instrument,levels=c("visit_diagnoses","lab","prior_labs","all_problems","imaging"))
    data$relation___mom.factor = factor(data$relation___mom,levels=c("0","1"))
    data$relation___dad.factor = factor(data$relation___dad,levels=c("0","1"))
    data$relation___self.factor = factor(data$relation___self,levels=c("0","1"))
    data$relation___interpret.factor = factor(data$relation___interpret,levels=c("0","1"))
    data$relation___m_grandma.factor = factor(data$relation___m_grandma,levels=c("0","1"))
    data$relation___m_grandpa.factor = factor(data$relation___m_grandpa,levels=c("0","1"))
    data$relation___p_grandma.factor = factor(data$relation___p_grandma,levels=c("0","1"))
    data$relation___p_grandpa.factor = factor(data$relation___p_grandpa,levels=c("0","1"))
    data$relation___aunt_unc.factor = factor(data$relation___aunt_unc,levels=c("0","1"))
    data$relation___stepma.factor = factor(data$relation___stepma,levels=c("0","1"))
    data$relation___steppa.factor = factor(data$relation___steppa,levels=c("0","1"))
    data$relation___guard.factor = factor(data$relation___guard,levels=c("0","1"))
    data$relation___fosterma.factor = factor(data$relation___fosterma,levels=c("0","1"))
    data$relation___fosterpa.factor = factor(data$relation___fosterpa,levels=c("0","1"))
    data$relation___provider.factor = factor(data$relation___provider,levels=c("0","1"))
    data$relation___facility.factor = factor(data$relation___facility,levels=c("0","1"))
    data$relation___oth.factor = factor(data$relation___oth,levels=c("0","1"))
    data$p_prov_seen___none.factor = factor(data$p_prov_seen___none,levels=c("0","1"))
    data$p_prov_seen___pcp.factor = factor(data$p_prov_seen___pcp,levels=c("0","1"))
    data$p_prov_seen___neuro.factor = factor(data$p_prov_seen___neuro,levels=c("0","1"))
    data$p_prov_seen___eye.factor = factor(data$p_prov_seen___eye,levels=c("0","1"))
    data$p_prov_seen___ent.factor = factor(data$p_prov_seen___ent,levels=c("0","1"))
    data$p_prov_seen___allergy.factor = factor(data$p_prov_seen___allergy,levels=c("0","1"))
    data$p_prov_seen___conc.factor = factor(data$p_prov_seen___conc,levels=c("0","1"))
    data$p_prov_seen___nsg.factor = factor(data$p_prov_seen___nsg,levels=c("0","1"))
    data$p_prov_seen___gi.factor = factor(data$p_prov_seen___gi,levels=c("0","1"))
    data$p_prov_seen___osteo.factor = factor(data$p_prov_seen___osteo,levels=c("0","1"))
    data$p_prov_seen___onco.factor = factor(data$p_prov_seen___onco,levels=c("0","1"))
    data$p_prov_seen___cardio.factor = factor(data$p_prov_seen___cardio,levels=c("0","1"))
    data$p_prov_seen___psych.factor = factor(data$p_prov_seen___psych,levels=c("0","1"))
    data$p_prov_seen___psychol.factor = factor(data$p_prov_seen___psychol,levels=c("0","1"))
    data$p_prov_seen___couns.factor = factor(data$p_prov_seen___couns,levels=c("0","1"))
    data$p_prov_seen___ed.factor = factor(data$p_prov_seen___ed,levels=c("0","1"))
    data$p_prov_seen___oth.factor = factor(data$p_prov_seen___oth,levels=c("0","1"))
    data$p_stud_eval___none.factor = factor(data$p_stud_eval___none,levels=c("0","1"))
    data$p_stud_eval___brain.factor = factor(data$p_stud_eval___brain,levels=c("0","1"))
    data$p_stud_eval___spine.factor = factor(data$p_stud_eval___spine,levels=c("0","1"))
    data$p_stud_eval___ct.factor = factor(data$p_stud_eval___ct,levels=c("0","1"))
    data$p_stud_eval___eeg.factor = factor(data$p_stud_eval___eeg,levels=c("0","1"))
    data$p_stud_eval___emg.factor = factor(data$p_stud_eval___emg,levels=c("0","1"))
    data$p_stud_eval___genetic.factor = factor(data$p_stud_eval___genetic,levels=c("0","1"))
    data$p_stud_eval___lp.factor = factor(data$p_stud_eval___lp,levels=c("0","1"))
    data$p_stud_eval___npsych.factor = factor(data$p_stud_eval___npsych,levels=c("0","1"))
    data$p_stud_eval___metabolic.factor = factor(data$p_stud_eval___metabolic,levels=c("0","1"))
    data$p_stud_eval___blood.factor = factor(data$p_stud_eval___blood,levels=c("0","1"))
    data$p_stud_eval___notsure.factor = factor(data$p_stud_eval___notsure,levels=c("0","1"))
    data$p_stud_eval___oth.factor = factor(data$p_stud_eval___oth,levels=c("0","1"))
    data$p_ha_in_lifetime.factor = factor(data$p_ha_in_lifetime,levels=c("one","few","many"))
    data$p_current_ha_pattern.factor = factor(data$p_current_ha_pattern,levels=c("episodic","cons_same","cons_flare"))
    data$p_epi_prec___none.factor = factor(data$p_epi_prec___none,levels=c("0","1"))
    data$p_epi_prec___conc.factor = factor(data$p_epi_prec___conc,levels=c("0","1"))
    data$p_epi_prec___oth_inj.factor = factor(data$p_epi_prec___oth_inj,levels=c("0","1"))
    data$p_epi_prec___sxg.factor = factor(data$p_epi_prec___sxg,levels=c("0","1"))
    data$p_epi_prec___infect.factor = factor(data$p_epi_prec___infect,levels=c("0","1"))
    data$p_epi_prec___oth_ill.factor = factor(data$p_epi_prec___oth_ill,levels=c("0","1"))
    data$p_epi_prec___mens.factor = factor(data$p_epi_prec___mens,levels=c("0","1"))
    data$p_epi_prec___stress.factor = factor(data$p_epi_prec___stress,levels=c("0","1"))
    data$p_epi_prec___oth.factor = factor(data$p_epi_prec___oth,levels=c("0","1"))
    data$p_epi_pattern_change___often.factor = factor(data$p_epi_pattern_change___often,levels=c("0","1"))
    data$p_epi_pattern_change___longer.factor = factor(data$p_epi_pattern_change___longer,levels=c("0","1"))
    data$p_epi_pattern_change___none.factor = factor(data$p_epi_pattern_change___none,levels=c("0","1"))
    data$p_epi_inc_fre_prec___none.factor = factor(data$p_epi_inc_fre_prec___none,levels=c("0","1"))
    data$p_epi_inc_fre_prec___conc.factor = factor(data$p_epi_inc_fre_prec___conc,levels=c("0","1"))
    data$p_epi_inc_fre_prec___oth_inj.factor = factor(data$p_epi_inc_fre_prec___oth_inj,levels=c("0","1"))
    data$p_epi_inc_fre_prec___sxg.factor = factor(data$p_epi_inc_fre_prec___sxg,levels=c("0","1"))
    data$p_epi_inc_fre_prec___infect.factor = factor(data$p_epi_inc_fre_prec___infect,levels=c("0","1"))
    data$p_epi_inc_fre_prec___oth_ill.factor = factor(data$p_epi_inc_fre_prec___oth_ill,levels=c("0","1"))
    data$p_epi_inc_fre_prec___mens.factor = factor(data$p_epi_inc_fre_prec___mens,levels=c("0","1"))
    data$p_epi_inc_fre_prec___stress.factor = factor(data$p_epi_inc_fre_prec___stress,levels=c("0","1"))
    data$p_epi_inc_fre_prec___oth.factor = factor(data$p_epi_inc_fre_prec___oth,levels=c("0","1"))
    data$p_epi_inc_fre_time.factor = factor(data$p_epi_inc_fre_time,levels=c("2wks","2to4wk","4to8wk","8to12wk","3to6mo","6to12mo","1to2y","2to3y","3yrs"))
    data$p_epi_fre.factor = factor(data$p_epi_fre,levels=c("1mo","1to3mo","1wk","2to3wk","3wk","daily","never","oth"))
    data$p_epi_fre_dur.factor = factor(data$p_epi_fre_dur,levels=c("1mo","1to3mo","3mo"))
    data$p_pattern_to_con.factor = factor(data$p_pattern_to_con,levels=c("epi","rare","none"))
    data$p_con_st_epi_prec_ep___none.factor = factor(data$p_con_st_epi_prec_ep___none,levels=c("0","1"))
    data$p_con_st_epi_prec_ep___conc.factor = factor(data$p_con_st_epi_prec_ep___conc,levels=c("0","1"))
    data$p_con_st_epi_prec_ep___oth_inj.factor = factor(data$p_con_st_epi_prec_ep___oth_inj,levels=c("0","1"))
    data$p_con_st_epi_prec_ep___sxg.factor = factor(data$p_con_st_epi_prec_ep___sxg,levels=c("0","1"))
    data$p_con_st_epi_prec_ep___infect.factor = factor(data$p_con_st_epi_prec_ep___infect,levels=c("0","1"))
    data$p_con_st_epi_prec_ep___oth_ill.factor = factor(data$p_con_st_epi_prec_ep___oth_ill,levels=c("0","1"))
    data$p_con_st_epi_prec_ep___mens.factor = factor(data$p_con_st_epi_prec_ep___mens,levels=c("0","1"))
    data$p_con_st_epi_prec_ep___stress.factor = factor(data$p_con_st_epi_prec_ep___stress,levels=c("0","1"))
    data$p_con_st_epi_prec_ep___oth.factor = factor(data$p_con_st_epi_prec_ep___oth,levels=c("0","1"))
    data$p_con_prec___none.factor = factor(data$p_con_prec___none,levels=c("0","1"))
    data$p_con_prec___conc.factor = factor(data$p_con_prec___conc,levels=c("0","1"))
    data$p_con_prec___oth_inj.factor = factor(data$p_con_prec___oth_inj,levels=c("0","1"))
    data$p_con_prec___sxg.factor = factor(data$p_con_prec___sxg,levels=c("0","1"))
    data$p_con_prec___infect.factor = factor(data$p_con_prec___infect,levels=c("0","1"))
    data$p_con_prec___oth_ill.factor = factor(data$p_con_prec___oth_ill,levels=c("0","1"))
    data$p_con_prec___mens.factor = factor(data$p_con_prec___mens,levels=c("0","1"))
    data$p_con_prec___stress.factor = factor(data$p_con_prec___stress,levels=c("0","1"))
    data$p_con_prec___oth.factor = factor(data$p_con_prec___oth,levels=c("0","1"))
    data$p_con_start_epi_time.factor = factor(data$p_con_start_epi_time,levels=c("2wks","2to4wk","4to8wk","8to12wk","3to6mo","6to12mo","1to2y","2to3y","3yrs"))
    data$p_con_pattern_duration.factor = factor(data$p_con_pattern_duration,levels=c("2wks","2to4wk","4to8wk","8to12wk","3to6mo","6to12mo","1to2y","2to3y","3yrs"))
    data$p_fre_bad.factor = factor(data$p_fre_bad,levels=c("never","1mo","1to3mo","1wk","2to3wk","3wk","daily","always","oth"))
    data$p_timing___none.factor = factor(data$p_timing___none,levels=c("0","1"))
    data$p_timing___wake.factor = factor(data$p_timing___wake,levels=c("0","1"))
    data$p_timing___morning.factor = factor(data$p_timing___morning,levels=c("0","1"))
    data$p_timing___noon.factor = factor(data$p_timing___noon,levels=c("0","1"))
    data$p_timing___evening.factor = factor(data$p_timing___evening,levels=c("0","1"))
    data$p_timing___night.factor = factor(data$p_timing___night,levels=c("0","1"))
    data$p_timing___sleep.factor = factor(data$p_timing___sleep,levels=c("0","1"))
    data$p_timing___spring.factor = factor(data$p_timing___spring,levels=c("0","1"))
    data$p_timing___summer.factor = factor(data$p_timing___summer,levels=c("0","1"))
    data$p_timing___fall.factor = factor(data$p_timing___fall,levels=c("0","1"))
    data$p_timing___winter.factor = factor(data$p_timing___winter,levels=c("0","1"))
    data$p_timing___mon.factor = factor(data$p_timing___mon,levels=c("0","1"))
    data$p_timing___tue.factor = factor(data$p_timing___tue,levels=c("0","1"))
    data$p_timing___wed.factor = factor(data$p_timing___wed,levels=c("0","1"))
    data$p_timing___thur.factor = factor(data$p_timing___thur,levels=c("0","1"))
    data$p_timing___fri.factor = factor(data$p_timing___fri,levels=c("0","1"))
    data$p_timing___sat.factor = factor(data$p_timing___sat,levels=c("0","1"))
    data$p_timing___sun.factor = factor(data$p_timing___sun,levels=c("0","1"))
    data$p_timing_wake_up.factor = factor(data$p_timing_wake_up,levels=c("1","0"))
    data$p_ha_quality___throb.factor = factor(data$p_ha_quality___throb,levels=c("0","1"))
    data$p_ha_quality___pound.factor = factor(data$p_ha_quality___pound,levels=c("0","1"))
    data$p_ha_quality___stab.factor = factor(data$p_ha_quality___stab,levels=c("0","1"))
    data$p_ha_quality___pushin.factor = factor(data$p_ha_quality___pushin,levels=c("0","1"))
    data$p_ha_quality___pushout.factor = factor(data$p_ha_quality___pushout,levels=c("0","1"))
    data$p_ha_quality___dull.factor = factor(data$p_ha_quality___dull,levels=c("0","1"))
    data$p_ha_quality___burn.factor = factor(data$p_ha_quality___burn,levels=c("0","1"))
    data$p_ha_quality___sharp.factor = factor(data$p_ha_quality___sharp,levels=c("0","1"))
    data$p_ha_quality___tight.factor = factor(data$p_ha_quality___tight,levels=c("0","1"))
    data$p_ha_quality___pinch.factor = factor(data$p_ha_quality___pinch,levels=c("0","1"))
    data$p_ha_quality___pulse.factor = factor(data$p_ha_quality___pulse,levels=c("0","1"))
    data$p_ha_quality___cant_desc.factor = factor(data$p_ha_quality___cant_desc,levels=c("0","1"))
    data$p_ha_quality___oth.factor = factor(data$p_ha_quality___oth,levels=c("0","1"))
    data$p_location_side___right.factor = factor(data$p_location_side___right,levels=c("0","1"))
    data$p_location_side___left.factor = factor(data$p_location_side___left,levels=c("0","1"))
    data$p_location_side___both.factor = factor(data$p_location_side___both,levels=c("0","1"))
    data$p_location_side___cant_desc.factor = factor(data$p_location_side___cant_desc,levels=c("0","1"))
    data$p_location_area___sides.factor = factor(data$p_location_area___sides,levels=c("0","1"))
    data$p_location_area___front.factor = factor(data$p_location_area___front,levels=c("0","1"))
    data$p_location_area___top.factor = factor(data$p_location_area___top,levels=c("0","1"))
    data$p_location_area___back.factor = factor(data$p_location_area___back,levels=c("0","1"))
    data$p_location_area___neck.factor = factor(data$p_location_area___neck,levels=c("0","1"))
    data$p_location_area___around.factor = factor(data$p_location_area___around,levels=c("0","1"))
    data$p_location_area___behind.factor = factor(data$p_location_area___behind,levels=c("0","1"))
    data$p_location_area___allover.factor = factor(data$p_location_area___allover,levels=c("0","1"))
    data$p_location_area___oth.factor = factor(data$p_location_area___oth,levels=c("0","1"))
    data$p_location_area___cant_desc.factor = factor(data$p_location_area___cant_desc,levels=c("0","1"))
    data$p_sev_overall.factor = factor(data$p_sev_overall,levels=c("mild","mod","sev"))
    data$p_sev_usual.factor = factor(data$p_sev_usual,levels=c("0","1","2","3","4","5","6","7","8","9","10"))
    data$p_sev_morning.factor = factor(data$p_sev_morning,levels=c("0","1","2","3","4","5","6","7","8","9","10"))
    data$p_sev_hr_after_bed.factor = factor(data$p_sev_hr_after_bed,levels=c("0","1","2","3","4","5","6","7","8","9","10"))
    data$p_sev_rate_rise.factor = factor(data$p_sev_rate_rise,levels=c("wakeup","secs","mins","hrs","no_change"))
    data$p_sev_dur.factor = factor(data$p_sev_dur,levels=c("secs","mins","hrs","1to3d","3days"))
    data$p_relief_sleep.factor = factor(data$p_relief_sleep,levels=c("1","0"))
    data$p_relief___no.factor = factor(data$p_relief___no,levels=c("0","1"))
    data$p_relief___ice.factor = factor(data$p_relief___ice,levels=c("0","1"))
    data$p_relief___heat.factor = factor(data$p_relief___heat,levels=c("0","1"))
    data$p_relief___sunglasses.factor = factor(data$p_relief___sunglasses,levels=c("0","1"))
    data$p_relief___caffeine.factor = factor(data$p_relief___caffeine,levels=c("0","1"))
    data$p_relief___quiet.factor = factor(data$p_relief___quiet,levels=c("0","1"))
    data$p_relief___lying_down.factor = factor(data$p_relief___lying_down,levels=c("0","1"))
    data$p_relief___active.factor = factor(data$p_relief___active,levels=c("0","1"))
    data$p_relief___oth.factor = factor(data$p_relief___oth,levels=c("0","1"))
    data$p_trigger___none.factor = factor(data$p_trigger___none,levels=c("0","1"))
    data$p_trigger___period.factor = factor(data$p_trigger___period,levels=c("0","1"))
    data$p_trigger___much_sleep.factor = factor(data$p_trigger___much_sleep,levels=c("0","1"))
    data$p_trigger___little_sleep.factor = factor(data$p_trigger___little_sleep,levels=c("0","1"))
    data$p_trigger___fatigue.factor = factor(data$p_trigger___fatigue,levels=c("0","1"))
    data$p_trigger___exercise.factor = factor(data$p_trigger___exercise,levels=c("0","1"))
    data$p_trigger___overheat.factor = factor(data$p_trigger___overheat,levels=c("0","1"))
    data$p_trigger___dehyd.factor = factor(data$p_trigger___dehyd,levels=c("0","1"))
    data$p_trigger___skip_meals.factor = factor(data$p_trigger___skip_meals,levels=c("0","1"))
    data$p_trigger___food.factor = factor(data$p_trigger___food,levels=c("0","1"))
    data$p_trigger___meds.factor = factor(data$p_trigger___meds,levels=c("0","1"))
    data$p_trigger___chew.factor = factor(data$p_trigger___chew,levels=c("0","1"))
    data$p_trigger___stress.factor = factor(data$p_trigger___stress,levels=c("0","1"))
    data$p_trigger___let_down.factor = factor(data$p_trigger___let_down,levels=c("0","1"))
    data$p_trigger___screen.factor = factor(data$p_trigger___screen,levels=c("0","1"))
    data$p_trigger___concentrate.factor = factor(data$p_trigger___concentrate,levels=c("0","1"))
    data$p_trigger___read.factor = factor(data$p_trigger___read,levels=c("0","1"))
    data$p_trigger___light.factor = factor(data$p_trigger___light,levels=c("0","1"))
    data$p_trigger___noises.factor = factor(data$p_trigger___noises,levels=c("0","1"))
    data$p_trigger___smells.factor = factor(data$p_trigger___smells,levels=c("0","1"))
    data$p_trigger___smoke.factor = factor(data$p_trigger___smoke,levels=c("0","1"))
    data$p_trigger___weather.factor = factor(data$p_trigger___weather,levels=c("0","1"))
    data$p_trigger___high_alt.factor = factor(data$p_trigger___high_alt,levels=c("0","1"))
    data$p_trigger___oth.factor = factor(data$p_trigger___oth,levels=c("0","1"))
    data$p_allodynia_hurt___none.factor = factor(data$p_allodynia_hurt___none,levels=c("0","1"))
    data$p_allodynia_hurt___ponytail.factor = factor(data$p_allodynia_hurt___ponytail,levels=c("0","1"))
    data$p_allodynia_hurt___comb.factor = factor(data$p_allodynia_hurt___comb,levels=c("0","1"))
    data$p_allodynia_hurt___hat.factor = factor(data$p_allodynia_hurt___hat,levels=c("0","1"))
    data$p_allodynia_hurt___headphones.factor = factor(data$p_allodynia_hurt___headphones,levels=c("0","1"))
    data$p_valsalva_position___none.factor = factor(data$p_valsalva_position___none,levels=c("0","1"))
    data$p_valsalva_position___sneeze.factor = factor(data$p_valsalva_position___sneeze,levels=c("0","1"))
    data$p_valsalva_position___cough.factor = factor(data$p_valsalva_position___cough,levels=c("0","1"))
    data$p_valsalva_position___laugh.factor = factor(data$p_valsalva_position___laugh,levels=c("0","1"))
    data$p_valsalva_position___stand.factor = factor(data$p_valsalva_position___stand,levels=c("0","1"))
    data$p_valsalva_position___lie.factor = factor(data$p_valsalva_position___lie,levels=c("0","1"))
    data$p_valsalva_dur.factor = factor(data$p_valsalva_dur,levels=c("dur_sneeze","secs","mins","hrs"))
    data$p_activity.factor = factor(data$p_activity,levels=c("no_change","feel_better","feel_worse","move"))
    data$p_assoc_sx_vis___none.factor = factor(data$p_assoc_sx_vis___none,levels=c("0","1"))
    data$p_assoc_sx_vis___spot.factor = factor(data$p_assoc_sx_vis___spot,levels=c("0","1"))
    data$p_assoc_sx_vis___star.factor = factor(data$p_assoc_sx_vis___star,levels=c("0","1"))
    data$p_assoc_sx_vis___light.factor = factor(data$p_assoc_sx_vis___light,levels=c("0","1"))
    data$p_assoc_sx_vis___zigzag.factor = factor(data$p_assoc_sx_vis___zigzag,levels=c("0","1"))
    data$p_assoc_sx_vis___blur.factor = factor(data$p_assoc_sx_vis___blur,levels=c("0","1"))
    data$p_assoc_sx_vis___double_vis.factor = factor(data$p_assoc_sx_vis___double_vis,levels=c("0","1"))
    data$p_assoc_sx_vis___heat.factor = factor(data$p_assoc_sx_vis___heat,levels=c("0","1"))
    data$p_assoc_sx_vis___loss_vis.factor = factor(data$p_assoc_sx_vis___loss_vis,levels=c("0","1"))
    data$p_assoc_sx_vis___oth.factor = factor(data$p_assoc_sx_vis___oth,levels=c("0","1"))
    data$p_assoc_sx_vis___cant_desc.factor = factor(data$p_assoc_sx_vis___cant_desc,levels=c("0","1"))
    data$p_assoc_sx_neur_bil___none.factor = factor(data$p_assoc_sx_neur_bil___none,levels=c("0","1"))
    data$p_assoc_sx_neur_bil___weak.factor = factor(data$p_assoc_sx_neur_bil___weak,levels=c("0","1"))
    data$p_assoc_sx_neur_bil___numb.factor = factor(data$p_assoc_sx_neur_bil___numb,levels=c("0","1"))
    data$p_assoc_sx_neur_bil___tingle.factor = factor(data$p_assoc_sx_neur_bil___tingle,levels=c("0","1"))
    data$p_assoc_sx_neur_bil___run_nose.factor = factor(data$p_assoc_sx_neur_bil___run_nose,levels=c("0","1"))
    data$p_assoc_sx_neur_bil___tear.factor = factor(data$p_assoc_sx_neur_bil___tear,levels=c("0","1"))
    data$p_assoc_sx_neur_bil___ptosis.factor = factor(data$p_assoc_sx_neur_bil___ptosis,levels=c("0","1"))
    data$p_assoc_sx_neur_bil___red_eye.factor = factor(data$p_assoc_sx_neur_bil___red_eye,levels=c("0","1"))
    data$p_assoc_sx_neur_bil___puff_eye.factor = factor(data$p_assoc_sx_neur_bil___puff_eye,levels=c("0","1"))
    data$p_assoc_sx_neur_bil___flush.factor = factor(data$p_assoc_sx_neur_bil___flush,levels=c("0","1"))
    data$p_assoc_sx_neur_bil___sweat.factor = factor(data$p_assoc_sx_neur_bil___sweat,levels=c("0","1"))
    data$p_assoc_sx_neur_bil___full_ear.factor = factor(data$p_assoc_sx_neur_bil___full_ear,levels=c("0","1"))
    data$p_assoc_sx_neur_bil___oth.factor = factor(data$p_assoc_sx_neur_bil___oth,levels=c("0","1"))
    data$p_assoc_sx_neur_bil___.factor = factor(data$p_assoc_sx_neur_bil___,levels=c("0","1"))
    data$p_assoc_sx_neur_uni___none.factor = factor(data$p_assoc_sx_neur_uni___none,levels=c("0","1"))
    data$p_assoc_sx_neur_uni___weak.factor = factor(data$p_assoc_sx_neur_uni___weak,levels=c("0","1"))
    data$p_assoc_sx_neur_uni___numb.factor = factor(data$p_assoc_sx_neur_uni___numb,levels=c("0","1"))
    data$p_assoc_sx_neur_uni___tingle.factor = factor(data$p_assoc_sx_neur_uni___tingle,levels=c("0","1"))
    data$p_assoc_sx_neur_uni___run_nose.factor = factor(data$p_assoc_sx_neur_uni___run_nose,levels=c("0","1"))
    data$p_assoc_sx_neur_uni___tear.factor = factor(data$p_assoc_sx_neur_uni___tear,levels=c("0","1"))
    data$p_assoc_sx_neur_uni___ptosis.factor = factor(data$p_assoc_sx_neur_uni___ptosis,levels=c("0","1"))
    data$p_assoc_sx_neur_uni___red_eye.factor = factor(data$p_assoc_sx_neur_uni___red_eye,levels=c("0","1"))
    data$p_assoc_sx_neur_uni___puff_eye.factor = factor(data$p_assoc_sx_neur_uni___puff_eye,levels=c("0","1"))
    data$p_assoc_sx_neur_uni___pupilbig.factor = factor(data$p_assoc_sx_neur_uni___pupilbig,levels=c("0","1"))
    data$p_assoc_sx_neur_uni___flush.factor = factor(data$p_assoc_sx_neur_uni___flush,levels=c("0","1"))
    data$p_assoc_sx_neur_uni___sweat.factor = factor(data$p_assoc_sx_neur_uni___sweat,levels=c("0","1"))
    data$p_assoc_sx_neur_uni___full_ear.factor = factor(data$p_assoc_sx_neur_uni___full_ear,levels=c("0","1"))
    data$p_assoc_sx_neur_uni___oth.factor = factor(data$p_assoc_sx_neur_uni___oth,levels=c("0","1"))
    data$p_assoc_sx_gi___none.factor = factor(data$p_assoc_sx_gi___none,levels=c("0","1"))
    data$p_assoc_sx_gi___decreased_app.factor = factor(data$p_assoc_sx_gi___decreased_app,levels=c("0","1"))
    data$p_assoc_sx_gi___diarr.factor = factor(data$p_assoc_sx_gi___diarr,levels=c("0","1"))
    data$p_assoc_sx_gi___naus.factor = factor(data$p_assoc_sx_gi___naus,levels=c("0","1"))
    data$p_assoc_sx_gi___stom_pain.factor = factor(data$p_assoc_sx_gi___stom_pain,levels=c("0","1"))
    data$p_assoc_sx_gi___vomiting.factor = factor(data$p_assoc_sx_gi___vomiting,levels=c("0","1"))
    data$p_assoc_sx_gi___oth.factor = factor(data$p_assoc_sx_gi___oth,levels=c("0","1"))
    data$p_assoc_sx_oth_sx___none.factor = factor(data$p_assoc_sx_oth_sx___none,levels=c("0","1"))
    data$p_assoc_sx_oth_sx___light.factor = factor(data$p_assoc_sx_oth_sx___light,levels=c("0","1"))
    data$p_assoc_sx_oth_sx___smell.factor = factor(data$p_assoc_sx_oth_sx___smell,levels=c("0","1"))
    data$p_assoc_sx_oth_sx___sound.factor = factor(data$p_assoc_sx_oth_sx___sound,levels=c("0","1"))
    data$p_assoc_sx_oth_sx___lighthead.factor = factor(data$p_assoc_sx_oth_sx___lighthead,levels=c("0","1"))
    data$p_assoc_sx_oth_sx___spinning.factor = factor(data$p_assoc_sx_oth_sx___spinning,levels=c("0","1"))
    data$p_assoc_sx_oth_sx___balance.factor = factor(data$p_assoc_sx_oth_sx___balance,levels=c("0","1"))
    data$p_assoc_sx_oth_sx___hear.factor = factor(data$p_assoc_sx_oth_sx___hear,levels=c("0","1"))
    data$p_assoc_sx_oth_sx___ringing.factor = factor(data$p_assoc_sx_oth_sx___ringing,levels=c("0","1"))
    data$p_assoc_sx_oth_sx___unrespons.factor = factor(data$p_assoc_sx_oth_sx___unrespons,levels=c("0","1"))
    data$p_assoc_sx_oth_sx___neck_pain.factor = factor(data$p_assoc_sx_oth_sx___neck_pain,levels=c("0","1"))
    data$p_assoc_sx_oth_sx___think.factor = factor(data$p_assoc_sx_oth_sx___think,levels=c("0","1"))
    data$p_assoc_sx_oth_sx___talk.factor = factor(data$p_assoc_sx_oth_sx___talk,levels=c("0","1"))
    data$p_assoc_sx_oth_sx___oth.factor = factor(data$p_assoc_sx_oth_sx___oth,levels=c("0","1"))
    data$p_assoc_sx_pul_ear___none.factor = factor(data$p_assoc_sx_pul_ear___none,levels=c("0","1"))
    data$p_assoc_sx_pul_ear___standing.factor = factor(data$p_assoc_sx_pul_ear___standing,levels=c("0","1"))
    data$p_assoc_sx_pul_ear___lying.factor = factor(data$p_assoc_sx_pul_ear___lying,levels=c("0","1"))
    data$p_assoc_sx_pul_ear___ha_bad.factor = factor(data$p_assoc_sx_pul_ear___ha_bad,levels=c("0","1"))
    data$p_assoc_sx_pul_ear___oth.factor = factor(data$p_assoc_sx_pul_ear___oth,levels=c("0","1"))
    data$p_med_stop_ha___none.factor = factor(data$p_med_stop_ha___none,levels=c("0","1"))
    data$p_med_stop_ha___apap.factor = factor(data$p_med_stop_ha___apap,levels=c("0","1"))
    data$p_med_stop_ha___ibupro.factor = factor(data$p_med_stop_ha___ibupro,levels=c("0","1"))
    data$p_med_stop_ha___naprox.factor = factor(data$p_med_stop_ha___naprox,levels=c("0","1"))
    data$p_med_stop_ha___asp.factor = factor(data$p_med_stop_ha___asp,levels=c("0","1"))
    data$p_med_stop_ha___ketorolac.factor = factor(data$p_med_stop_ha___ketorolac,levels=c("0","1"))
    data$p_med_stop_ha___ketoprof.factor = factor(data$p_med_stop_ha___ketoprof,levels=c("0","1"))
    data$p_med_stop_ha___diclof.factor = factor(data$p_med_stop_ha___diclof,levels=c("0","1"))
    data$p_med_stop_ha___celec.factor = factor(data$p_med_stop_ha___celec,levels=c("0","1"))
    data$p_med_stop_ha___exced.factor = factor(data$p_med_stop_ha___exced,levels=c("0","1"))
    data$p_med_stop_ha___butal.factor = factor(data$p_med_stop_ha___butal,levels=c("0","1"))
    data$p_med_stop_ha___midrin.factor = factor(data$p_med_stop_ha___midrin,levels=c("0","1"))
    data$p_med_stop_ha___methylpred.factor = factor(data$p_med_stop_ha___methylpred,levels=c("0","1"))
    data$p_med_stop_ha___pred.factor = factor(data$p_med_stop_ha___pred,levels=c("0","1"))
    data$p_med_stop_ha___suma.factor = factor(data$p_med_stop_ha___suma,levels=c("0","1"))
    data$p_med_stop_ha___riza.factor = factor(data$p_med_stop_ha___riza,levels=c("0","1"))
    data$p_med_stop_ha___nara.factor = factor(data$p_med_stop_ha___nara,levels=c("0","1"))
    data$p_med_stop_ha___almo.factor = factor(data$p_med_stop_ha___almo,levels=c("0","1"))
    data$p_med_stop_ha___frova.factor = factor(data$p_med_stop_ha___frova,levels=c("0","1"))
    data$p_med_stop_ha___eletrip.factor = factor(data$p_med_stop_ha___eletrip,levels=c("0","1"))
    data$p_med_stop_ha___zolmit.factor = factor(data$p_med_stop_ha___zolmit,levels=c("0","1"))
    data$p_med_stop_ha___metoclop.factor = factor(data$p_med_stop_ha___metoclop,levels=c("0","1"))
    data$p_med_stop_ha___proch.factor = factor(data$p_med_stop_ha___proch,levels=c("0","1"))
    data$p_med_stop_ha___prometh.factor = factor(data$p_med_stop_ha___prometh,levels=c("0","1"))
    data$p_med_stop_ha___ond.factor = factor(data$p_med_stop_ha___ond,levels=c("0","1"))
    data$p_med_stop_ha___diphen.factor = factor(data$p_med_stop_ha___diphen,levels=c("0","1"))
    data$p_med_stop_ha___dhe.factor = factor(data$p_med_stop_ha___dhe,levels=c("0","1"))
    data$p_med_stop_ha___tram.factor = factor(data$p_med_stop_ha___tram,levels=c("0","1"))
    data$p_med_stop_ha___t3.factor = factor(data$p_med_stop_ha___t3,levels=c("0","1"))
    data$p_med_stop_ha___morph.factor = factor(data$p_med_stop_ha___morph,levels=c("0","1"))
    data$p_med_stop_ha___hydromor.factor = factor(data$p_med_stop_ha___hydromor,levels=c("0","1"))
    data$p_med_stop_ha___nb.factor = factor(data$p_med_stop_ha___nb,levels=c("0","1"))
    data$p_med_stop_ha___oth.factor = factor(data$p_med_stop_ha___oth,levels=c("0","1"))
    data$p_when_take_med.factor = factor(data$p_when_take_med,levels=c("beforepain","painstart","painmild","painmoderate","painbad","painworse"))
    data$p_how_oft_med.factor = factor(data$p_how_oft_med,levels=c("less_1wk","1to3wk","4wks_greater","qd"))
    data$p_duration_overuse.factor = factor(data$p_duration_overuse,levels=c("less_1mo","1to3mo","3mo_greater"))
    data$p_med_prev_ha___none.factor = factor(data$p_med_prev_ha___none,levels=c("0","1"))
    data$p_med_prev_ha___acetaz.factor = factor(data$p_med_prev_ha___acetaz,levels=c("0","1"))
    data$p_med_prev_ha___amitrip.factor = factor(data$p_med_prev_ha___amitrip,levels=c("0","1"))
    data$p_med_prev_ha___ateno.factor = factor(data$p_med_prev_ha___ateno,levels=c("0","1"))
    data$p_med_prev_ha___botox.factor = factor(data$p_med_prev_ha___botox,levels=c("0","1"))
    data$p_med_prev_ha___cefaly.factor = factor(data$p_med_prev_ha___cefaly,levels=c("0","1"))
    data$p_med_prev_ha___cypro.factor = factor(data$p_med_prev_ha___cypro,levels=c("0","1"))
    data$p_med_prev_ha___doxy.factor = factor(data$p_med_prev_ha___doxy,levels=c("0","1"))
    data$p_med_prev_ha___dulox.factor = factor(data$p_med_prev_ha___dulox,levels=c("0","1"))
    data$p_med_prev_ha___fluox.factor = factor(data$p_med_prev_ha___fluox,levels=c("0","1"))
    data$p_med_prev_ha___gaba.factor = factor(data$p_med_prev_ha___gaba,levels=c("0","1"))
    data$p_med_prev_ha___lamotrig.factor = factor(data$p_med_prev_ha___lamotrig,levels=c("0","1"))
    data$p_med_prev_ha___lisin.factor = factor(data$p_med_prev_ha___lisin,levels=c("0","1"))
    data$p_med_prev_ha___lvt.factor = factor(data$p_med_prev_ha___lvt,levels=c("0","1"))
    data$p_med_prev_ha___metopro.factor = factor(data$p_med_prev_ha___metopro,levels=c("0","1"))
    data$p_med_prev_ha___minocy.factor = factor(data$p_med_prev_ha___minocy,levels=c("0","1"))
    data$p_med_prev_ha___nb.factor = factor(data$p_med_prev_ha___nb,levels=c("0","1"))
    data$p_med_prev_ha___nebivo.factor = factor(data$p_med_prev_ha___nebivo,levels=c("0","1"))
    data$p_med_prev_ha___nortrip.factor = factor(data$p_med_prev_ha___nortrip,levels=c("0","1"))
    data$p_med_prev_ha___pregab.factor = factor(data$p_med_prev_ha___pregab,levels=c("0","1"))
    data$p_med_prev_ha___propano.factor = factor(data$p_med_prev_ha___propano,levels=c("0","1"))
    data$p_med_prev_ha___sertra.factor = factor(data$p_med_prev_ha___sertra,levels=c("0","1"))
    data$p_med_prev_ha___topa.factor = factor(data$p_med_prev_ha___topa,levels=c("0","1"))
    data$p_med_prev_ha___vpa.factor = factor(data$p_med_prev_ha___vpa,levels=c("0","1"))
    data$p_med_prev_ha___venla.factor = factor(data$p_med_prev_ha___venla,levels=c("0","1"))
    data$p_med_prev_ha___verap.factor = factor(data$p_med_prev_ha___verap,levels=c("0","1"))
    data$p_med_prev_ha___zonis.factor = factor(data$p_med_prev_ha___zonis,levels=c("0","1"))
    data$p_med_prev_ha___oth.factor = factor(data$p_med_prev_ha___oth,levels=c("0","1"))
    data$p_vit_sup_ha___none.factor = factor(data$p_vit_sup_ha___none,levels=c("0","1"))
    data$p_vit_sup_ha___vitb2.factor = factor(data$p_vit_sup_ha___vitb2,levels=c("0","1"))
    data$p_vit_sup_ha___vitd.factor = factor(data$p_vit_sup_ha___vitd,levels=c("0","1"))
    data$p_vit_sup_ha___mag.factor = factor(data$p_vit_sup_ha___mag,levels=c("0","1"))
    data$p_vit_sup_ha___fishoil.factor = factor(data$p_vit_sup_ha___fishoil,levels=c("0","1"))
    data$p_vit_sup_ha___coenzq10.factor = factor(data$p_vit_sup_ha___coenzq10,levels=c("0","1"))
    data$p_vit_sup_ha___feverfew.factor = factor(data$p_vit_sup_ha___feverfew,levels=c("0","1"))
    data$p_vit_sup_ha___melatonin.factor = factor(data$p_vit_sup_ha___melatonin,levels=c("0","1"))
    data$p_vit_sup_ha___butterbur.factor = factor(data$p_vit_sup_ha___butterbur,levels=c("0","1"))
    data$p_vit_sup_ha___oth.factor = factor(data$p_vit_sup_ha___oth,levels=c("0","1"))
    data$p_non_med_trea_ha___none.factor = factor(data$p_non_med_trea_ha___none,levels=c("0","1"))
    data$p_non_med_trea_ha___acupunc.factor = factor(data$p_non_med_trea_ha___acupunc,levels=c("0","1"))
    data$p_non_med_trea_ha___biofeed.factor = factor(data$p_non_med_trea_ha___biofeed,levels=c("0","1"))
    data$p_non_med_trea_ha___chirop.factor = factor(data$p_non_med_trea_ha___chirop,levels=c("0","1"))
    data$p_non_med_trea_ha___counsel.factor = factor(data$p_non_med_trea_ha___counsel,levels=c("0","1"))
    data$p_non_med_trea_ha___exercise.factor = factor(data$p_non_med_trea_ha___exercise,levels=c("0","1"))
    data$p_non_med_trea_ha___massage.factor = factor(data$p_non_med_trea_ha___massage,levels=c("0","1"))
    data$p_non_med_trea_ha___ot.factor = factor(data$p_non_med_trea_ha___ot,levels=c("0","1"))
    data$p_non_med_trea_ha___osteo.factor = factor(data$p_non_med_trea_ha___osteo,levels=c("0","1"))
    data$p_non_med_trea_ha___pt.factor = factor(data$p_non_med_trea_ha___pt,levels=c("0","1"))
    data$p_non_med_trea_ha___vision.factor = factor(data$p_non_med_trea_ha___vision,levels=c("0","1"))
    data$p_non_med_trea_ha___oth.factor = factor(data$p_non_med_trea_ha___oth,levels=c("0","1"))
    data$p_iv_med_ha___none.factor = factor(data$p_iv_med_ha___none,levels=c("0","1"))
    data$p_iv_med_ha___ketorolac.factor = factor(data$p_iv_med_ha___ketorolac,levels=c("0","1"))
    data$p_iv_med_ha___metoclop.factor = factor(data$p_iv_med_ha___metoclop,levels=c("0","1"))
    data$p_iv_med_ha___prochlor.factor = factor(data$p_iv_med_ha___prochlor,levels=c("0","1"))
    data$p_iv_med_ha___methylpred.factor = factor(data$p_iv_med_ha___methylpred,levels=c("0","1"))
    data$p_iv_med_ha___dexameth.factor = factor(data$p_iv_med_ha___dexameth,levels=c("0","1"))
    data$p_iv_med_ha___mag.factor = factor(data$p_iv_med_ha___mag,levels=c("0","1"))
    data$p_iv_med_ha___vpa.factor = factor(data$p_iv_med_ha___vpa,levels=c("0","1"))
    data$p_iv_med_ha___diphen.factor = factor(data$p_iv_med_ha___diphen,levels=c("0","1"))
    data$p_iv_med_ha___opio.factor = factor(data$p_iv_med_ha___opio,levels=c("0","1"))
    data$p_iv_med_ha___lvt.factor = factor(data$p_iv_med_ha___lvt,levels=c("0","1"))
    data$p_iv_med_ha___dhe.factor = factor(data$p_iv_med_ha___dhe,levels=c("0","1"))
    data$p_iv_med_ha___ond.factor = factor(data$p_iv_med_ha___ond,levels=c("0","1"))
    data$p_iv_med_ha___oth.factor = factor(data$p_iv_med_ha___oth,levels=c("0","1"))
    data$p_prob_preg_birth.factor = factor(data$p_prob_preg_birth,levels=c("1","0"))
    data$p_preg_full_term.factor = factor(data$p_preg_full_term,levels=c("full","premature","unk"))
    data$p_birth_lbs.factor = factor(data$p_birth_lbs,levels=c("1","2","3","4","5","6","7","8","9","10","11","12","unk"))
    data$p_birth_oz.factor = factor(data$p_birth_oz,levels=c("0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","unk"))
    data$p_early_dev_concerns.factor = factor(data$p_early_dev_concerns,levels=c("1","0"))
    data$p_lost_dev_skill.factor = factor(data$p_lost_dev_skill,levels=c("1","0"))
    data$p_behav_diff.factor = factor(data$p_behav_diff,levels=c("1","0"))
    data$p_dom_hand.factor = factor(data$p_dom_hand,levels=c("right","left","both","not_sure"))
    data$p_dom_hand_age.factor = factor(data$p_dom_hand_age,levels=c("less12mo","13_17mo","more18mo","oth"))
    data$p_hosp_overnt.factor = factor(data$p_hosp_overnt,levels=c("1","0"))
    data$p_surgery.factor = factor(data$p_surgery,levels=c("1","0"))
    data$p_immun_up_date.factor = factor(data$p_immun_up_date,levels=c("1","0"))
    data$p_overall_prob___none.factor = factor(data$p_overall_prob___none,levels=c("0","1"))
    data$p_overall_prob___wt_loss.factor = factor(data$p_overall_prob___wt_loss,levels=c("0","1"))
    data$p_overall_prob___wt_gain.factor = factor(data$p_overall_prob___wt_gain,levels=c("0","1"))
    data$p_overall_prob___fever.factor = factor(data$p_overall_prob___fever,levels=c("0","1"))
    data$p_overall_prob___fatigue.factor = factor(data$p_overall_prob___fatigue,levels=c("0","1"))
    data$p_overall_prob___ftt.factor = factor(data$p_overall_prob___ftt,levels=c("0","1"))
    data$p_overall_prob___oth.factor = factor(data$p_overall_prob___oth,levels=c("0","1"))
    data$p_eye_prob___none.factor = factor(data$p_eye_prob___none,levels=c("0","1"))
    data$p_eye_prob___glasses.factor = factor(data$p_eye_prob___glasses,levels=c("0","1"))
    data$p_eye_prob___outward_eyes.factor = factor(data$p_eye_prob___outward_eyes,levels=c("0","1"))
    data$p_eye_prob___inward_eyes.factor = factor(data$p_eye_prob___inward_eyes,levels=c("0","1"))
    data$p_eye_prob___eye_movt.factor = factor(data$p_eye_prob___eye_movt,levels=c("0","1"))
    data$p_eye_prob___prob_seeing.factor = factor(data$p_eye_prob___prob_seeing,levels=c("0","1"))
    data$p_eye_prob___blind.factor = factor(data$p_eye_prob___blind,levels=c("0","1"))
    data$p_eye_prob___oth.factor = factor(data$p_eye_prob___oth,levels=c("0","1"))
    data$p_ent_prob___none.factor = factor(data$p_ent_prob___none,levels=c("0","1"))
    data$p_ent_prob___hearing.factor = factor(data$p_ent_prob___hearing,levels=c("0","1"))
    data$p_ent_prob___deafness.factor = factor(data$p_ent_prob___deafness,levels=c("0","1"))
    data$p_ent_prob___ear_infec.factor = factor(data$p_ent_prob___ear_infec,levels=c("0","1"))
    data$p_ent_prob___sinus_infec.factor = factor(data$p_ent_prob___sinus_infec,levels=c("0","1"))
    data$p_ent_prob___ringing.factor = factor(data$p_ent_prob___ringing,levels=c("0","1"))
    data$p_ent_prob___dizzy.factor = factor(data$p_ent_prob___dizzy,levels=c("0","1"))
    data$p_ent_prob___tracheo.factor = factor(data$p_ent_prob___tracheo,levels=c("0","1"))
    data$p_ent_prob___nose_bleed.factor = factor(data$p_ent_prob___nose_bleed,levels=c("0","1"))
    data$p_ent_prob___mouth_sore.factor = factor(data$p_ent_prob___mouth_sore,levels=c("0","1"))
    data$p_ent_prob___oth.factor = factor(data$p_ent_prob___oth,levels=c("0","1"))
    data$p_heart_prob___none.factor = factor(data$p_heart_prob___none,levels=c("0","1"))
    data$p_heart_prob___murmur.factor = factor(data$p_heart_prob___murmur,levels=c("0","1"))
    data$p_heart_prob___chd.factor = factor(data$p_heart_prob___chd,levels=c("0","1"))
    data$p_heart_prob___high_blood.factor = factor(data$p_heart_prob___high_blood,levels=c("0","1"))
    data$p_heart_prob___faint.factor = factor(data$p_heart_prob___faint,levels=c("0","1"))
    data$p_heart_prob___irreg_beat.factor = factor(data$p_heart_prob___irreg_beat,levels=c("0","1"))
    data$p_heart_prob___easy_tired.factor = factor(data$p_heart_prob___easy_tired,levels=c("0","1"))
    data$p_heart_prob___pots.factor = factor(data$p_heart_prob___pots,levels=c("0","1"))
    data$p_heart_prob___chest_pain.factor = factor(data$p_heart_prob___chest_pain,levels=c("0","1"))
    data$p_heart_prob___oth.factor = factor(data$p_heart_prob___oth,levels=c("0","1"))
    data$p_lung_prob___none.factor = factor(data$p_lung_prob___none,levels=c("0","1"))
    data$p_lung_prob___asthma.factor = factor(data$p_lung_prob___asthma,levels=c("0","1"))
    data$p_lung_prob___apnea.factor = factor(data$p_lung_prob___apnea,levels=c("0","1"))
    data$p_lung_prob___pneum.factor = factor(data$p_lung_prob___pneum,levels=c("0","1"))
    data$p_lung_prob___cough.factor = factor(data$p_lung_prob___cough,levels=c("0","1"))
    data$p_lung_prob___sob.factor = factor(data$p_lung_prob___sob,levels=c("0","1"))
    data$p_lung_prob___cpap.factor = factor(data$p_lung_prob___cpap,levels=c("0","1"))
    data$p_lung_prob___oth.factor = factor(data$p_lung_prob___oth,levels=c("0","1"))
    data$p_sleep_prob___none.factor = factor(data$p_sleep_prob___none,levels=c("0","1"))
    data$p_sleep_prob___apnea.factor = factor(data$p_sleep_prob___apnea,levels=c("0","1"))
    data$p_sleep_prob___snore.factor = factor(data$p_sleep_prob___snore,levels=c("0","1"))
    data$p_sleep_prob___fall_asleep.factor = factor(data$p_sleep_prob___fall_asleep,levels=c("0","1"))
    data$p_sleep_prob___stay_asleep.factor = factor(data$p_sleep_prob___stay_asleep,levels=c("0","1"))
    data$p_sleep_prob___pm_terror.factor = factor(data$p_sleep_prob___pm_terror,levels=c("0","1"))
    data$p_sleep_prob___day_drowsy.factor = factor(data$p_sleep_prob___day_drowsy,levels=c("0","1"))
    data$p_sleep_prob___oth.factor = factor(data$p_sleep_prob___oth,levels=c("0","1"))
    data$p_gi_prob___none.factor = factor(data$p_gi_prob___none,levels=c("0","1"))
    data$p_gi_prob___reflux.factor = factor(data$p_gi_prob___reflux,levels=c("0","1"))
    data$p_gi_prob___nausea.factor = factor(data$p_gi_prob___nausea,levels=c("0","1"))
    data$p_gi_prob___constipa.factor = factor(data$p_gi_prob___constipa,levels=c("0","1"))
    data$p_gi_prob___diarrhea.factor = factor(data$p_gi_prob___diarrhea,levels=c("0","1"))
    data$p_gi_prob___abd_pain.factor = factor(data$p_gi_prob___abd_pain,levels=c("0","1"))
    data$p_gi_prob___tube.factor = factor(data$p_gi_prob___tube,levels=c("0","1"))
    data$p_gi_prob___oth.factor = factor(data$p_gi_prob___oth,levels=c("0","1"))
    data$p_gu_prob___none.factor = factor(data$p_gu_prob___none,levels=c("0","1"))
    data$p_gu_prob___kidney.factor = factor(data$p_gu_prob___kidney,levels=c("0","1"))
    data$p_gu_prob___fre_uti.factor = factor(data$p_gu_prob___fre_uti,levels=c("0","1"))
    data$p_gu_prob___urine_prob.factor = factor(data$p_gu_prob___urine_prob,levels=c("0","1"))
    data$p_gu_prob___menstrual.factor = factor(data$p_gu_prob___menstrual,levels=c("0","1"))
    data$p_gu_prob___enuresis.factor = factor(data$p_gu_prob___enuresis,levels=c("0","1"))
    data$p_gu_prob___incont.factor = factor(data$p_gu_prob___incont,levels=c("0","1"))
    data$p_gu_prob___oth.factor = factor(data$p_gu_prob___oth,levels=c("0","1"))
    data$p_musc_prob___none.factor = factor(data$p_musc_prob___none,levels=c("0","1"))
    data$p_musc_prob___joint_pain.factor = factor(data$p_musc_prob___joint_pain,levels=c("0","1"))
    data$p_musc_prob___neck_pain.factor = factor(data$p_musc_prob___neck_pain,levels=c("0","1"))
    data$p_musc_prob___back_pain.factor = factor(data$p_musc_prob___back_pain,levels=c("0","1"))
    data$p_musc_prob___scolio.factor = factor(data$p_musc_prob___scolio,levels=c("0","1"))
    data$p_musc_prob___muscle_weak.factor = factor(data$p_musc_prob___muscle_weak,levels=c("0","1"))
    data$p_musc_prob___osteopenia.factor = factor(data$p_musc_prob___osteopenia,levels=c("0","1"))
    data$p_musc_prob___oth.factor = factor(data$p_musc_prob___oth,levels=c("0","1"))
    data$p_skin_prob___none.factor = factor(data$p_skin_prob___none,levels=c("0","1"))
    data$p_skin_prob___eczema.factor = factor(data$p_skin_prob___eczema,levels=c("0","1"))
    data$p_skin_prob___birthmark.factor = factor(data$p_skin_prob___birthmark,levels=c("0","1"))
    data$p_skin_prob___rash.factor = factor(data$p_skin_prob___rash,levels=c("0","1"))
    data$p_skin_prob___acne.factor = factor(data$p_skin_prob___acne,levels=c("0","1"))
    data$p_skin_prob___oth.factor = factor(data$p_skin_prob___oth,levels=c("0","1"))
    data$p_endo_prob___none.factor = factor(data$p_endo_prob___none,levels=c("0","1"))
    data$p_endo_prob___thyroid.factor = factor(data$p_endo_prob___thyroid,levels=c("0","1"))
    data$p_endo_prob___diab.factor = factor(data$p_endo_prob___diab,levels=c("0","1"))
    data$p_endo_prob___grow_prob.factor = factor(data$p_endo_prob___grow_prob,levels=c("0","1"))
    data$p_endo_prob___puberty.factor = factor(data$p_endo_prob___puberty,levels=c("0","1"))
    data$p_endo_prob___oth.factor = factor(data$p_endo_prob___oth,levels=c("0","1"))
    data$p_hema_prob___none.factor = factor(data$p_hema_prob___none,levels=c("0","1"))
    data$p_hema_prob___sickle.factor = factor(data$p_hema_prob___sickle,levels=c("0","1"))
    data$p_hema_prob___anemia.factor = factor(data$p_hema_prob___anemia,levels=c("0","1"))
    data$p_hema_prob___abnl_bleed.factor = factor(data$p_hema_prob___abnl_bleed,levels=c("0","1"))
    data$p_hema_prob___bruise.factor = factor(data$p_hema_prob___bruise,levels=c("0","1"))
    data$p_hema_prob___bleed.factor = factor(data$p_hema_prob___bleed,levels=c("0","1"))
    data$p_hema_prob___cancer.factor = factor(data$p_hema_prob___cancer,levels=c("0","1"))
    data$p_hema_prob___oth.factor = factor(data$p_hema_prob___oth,levels=c("0","1"))
    data$p_hema_prob___.factor = factor(data$p_hema_prob___,levels=c("0","1"))
    data$p_immu_prob___none.factor = factor(data$p_immu_prob___none,levels=c("0","1"))
    data$p_immu_prob___allergies.factor = factor(data$p_immu_prob___allergies,levels=c("0","1"))
    data$p_immu_prob___lupus.factor = factor(data$p_immu_prob___lupus,levels=c("0","1"))
    data$p_immu_prob___arth.factor = factor(data$p_immu_prob___arth,levels=c("0","1"))
    data$p_immu_prob___imm_def.factor = factor(data$p_immu_prob___imm_def,levels=c("0","1"))
    data$p_immu_prob___fre_ill.factor = factor(data$p_immu_prob___fre_ill,levels=c("0","1"))
    data$p_immu_prob___autoimmune.factor = factor(data$p_immu_prob___autoimmune,levels=c("0","1"))
    data$p_immu_prob___oth.factor = factor(data$p_immu_prob___oth,levels=c("0","1"))
    data$p_psych_prob___none.factor = factor(data$p_psych_prob___none,levels=c("0","1"))
    data$p_psych_prob___adhd.factor = factor(data$p_psych_prob___adhd,levels=c("0","1"))
    data$p_psych_prob___anxiety.factor = factor(data$p_psych_prob___anxiety,levels=c("0","1"))
    data$p_psych_prob___depress.factor = factor(data$p_psych_prob___depress,levels=c("0","1"))
    data$p_psych_prob___behavior.factor = factor(data$p_psych_prob___behavior,levels=c("0","1"))
    data$p_psych_prob___odd.factor = factor(data$p_psych_prob___odd,levels=c("0","1"))
    data$p_psych_prob___ocd.factor = factor(data$p_psych_prob___ocd,levels=c("0","1"))
    data$p_psych_prob___pdd.factor = factor(data$p_psych_prob___pdd,levels=c("0","1"))
    data$p_psych_prob___sw.factor = factor(data$p_psych_prob___sw,levels=c("0","1"))
    data$p_psych_prob___psychol.factor = factor(data$p_psych_prob___psychol,levels=c("0","1"))
    data$p_psych_prob___psychi.factor = factor(data$p_psych_prob___psychi,levels=c("0","1"))
    data$p_psych_prob___oth.factor = factor(data$p_psych_prob___oth,levels=c("0","1"))
    data$p_psych_prob___.factor = factor(data$p_psych_prob___,levels=c("0","1"))
    data$p_neur_prob___none.factor = factor(data$p_neur_prob___none,levels=c("0","1"))
    data$p_neur_prob___seiz_epil.factor = factor(data$p_neur_prob___seiz_epil,levels=c("0","1"))
    data$p_neur_prob___ha.factor = factor(data$p_neur_prob___ha,levels=c("0","1"))
    data$p_neur_prob___tics.factor = factor(data$p_neur_prob___tics,levels=c("0","1"))
    data$p_neur_prob___stroke.factor = factor(data$p_neur_prob___stroke,levels=c("0","1"))
    data$p_neur_prob___learn.factor = factor(data$p_neur_prob___learn,levels=c("0","1"))
    data$p_neur_prob___neuromus.factor = factor(data$p_neur_prob___neuromus,levels=c("0","1"))
    data$p_neur_prob___devt_prob.factor = factor(data$p_neur_prob___devt_prob,levels=c("0","1"))
    data$p_neur_prob___concentrate.factor = factor(data$p_neur_prob___concentrate,levels=c("0","1"))
    data$p_neur_prob___balance.factor = factor(data$p_neur_prob___balance,levels=c("0","1"))
    data$p_neur_prob___mening.factor = factor(data$p_neur_prob___mening,levels=c("0","1"))
    data$p_neur_prob___conc.factor = factor(data$p_neur_prob___conc,levels=c("0","1"))
    data$p_neur_prob___enceph.factor = factor(data$p_neur_prob___enceph,levels=c("0","1"))
    data$p_neur_prob___numb.factor = factor(data$p_neur_prob___numb,levels=c("0","1"))
    data$p_neur_prob___motion_sick.factor = factor(data$p_neur_prob___motion_sick,levels=c("0","1"))
    data$p_neur_prob___oth.factor = factor(data$p_neur_prob___oth,levels=c("0","1"))
    data$p_curr_interven___none.factor = factor(data$p_curr_interven___none,levels=c("0","1"))
    data$p_curr_interven___pt.factor = factor(data$p_curr_interven___pt,levels=c("0","1"))
    data$p_curr_interven___ot.factor = factor(data$p_curr_interven___ot,levels=c("0","1"))
    data$p_curr_interven___speech.factor = factor(data$p_curr_interven___speech,levels=c("0","1"))
    data$p_curr_interven___behavior.factor = factor(data$p_curr_interven___behavior,levels=c("0","1"))
    data$p_curr_interven___vision.factor = factor(data$p_curr_interven___vision,levels=c("0","1"))
    data$p_curr_interven___feeding.factor = factor(data$p_curr_interven___feeding,levels=c("0","1"))
    data$p_curr_interven___develop.factor = factor(data$p_curr_interven___develop,levels=c("0","1"))
    data$p_past_interven___none.factor = factor(data$p_past_interven___none,levels=c("0","1"))
    data$p_past_interven___pt.factor = factor(data$p_past_interven___pt,levels=c("0","1"))
    data$p_past_interven___ot.factor = factor(data$p_past_interven___ot,levels=c("0","1"))
    data$p_past_interven___speech.factor = factor(data$p_past_interven___speech,levels=c("0","1"))
    data$p_past_interven___behavior.factor = factor(data$p_past_interven___behavior,levels=c("0","1"))
    data$p_past_interven___vision.factor = factor(data$p_past_interven___vision,levels=c("0","1"))
    data$p_past_interven___feeding.factor = factor(data$p_past_interven___feeding,levels=c("0","1"))
    data$p_past_interven___develop.factor = factor(data$p_past_interven___develop,levels=c("0","1"))
    data$p_ha_psych_ques.factor = factor(data$p_ha_psych_ques,levels=c("1","0"))
    data$p_fam_hist_dev___none.factor = factor(data$p_fam_hist_dev___none,levels=c("0","1"))
    data$p_fam_hist_dev___devt_delay.factor = factor(data$p_fam_hist_dev___devt_delay,levels=c("0","1"))
    data$p_fam_hist_dev___learn.factor = factor(data$p_fam_hist_dev___learn,levels=c("0","1"))
    data$p_fam_hist_dev___mental.factor = factor(data$p_fam_hist_dev___mental,levels=c("0","1"))
    data$p_fam_hist_dev___autistic.factor = factor(data$p_fam_hist_dev___autistic,levels=c("0","1"))
    data$p_fam_hist_dev___oth.factor = factor(data$p_fam_hist_dev___oth,levels=c("0","1"))
    data$p_fam_hist_behav___none.factor = factor(data$p_fam_hist_behav___none,levels=c("0","1"))
    data$p_fam_hist_behav___add.factor = factor(data$p_fam_hist_behav___add,levels=c("0","1"))
    data$p_fam_hist_behav___depress.factor = factor(data$p_fam_hist_behav___depress,levels=c("0","1"))
    data$p_fam_hist_behav___anx.factor = factor(data$p_fam_hist_behav___anx,levels=c("0","1"))
    data$p_fam_hist_behav___sub_abuse.factor = factor(data$p_fam_hist_behav___sub_abuse,levels=c("0","1"))
    data$p_fam_hist_behav___bipolar.factor = factor(data$p_fam_hist_behav___bipolar,levels=c("0","1"))
    data$p_fam_hist_behav___oth.factor = factor(data$p_fam_hist_behav___oth,levels=c("0","1"))
    data$p_fam_hist_neuro___none.factor = factor(data$p_fam_hist_neuro___none,levels=c("0","1"))
    data$p_fam_hist_neuro___ha.factor = factor(data$p_fam_hist_neuro___ha,levels=c("0","1"))
    data$p_fam_hist_neuro___mig.factor = factor(data$p_fam_hist_neuro___mig,levels=c("0","1"))
    data$p_fam_hist_neuro___seiz.factor = factor(data$p_fam_hist_neuro___seiz,levels=c("0","1"))
    data$p_fam_hist_neuro___epi.factor = factor(data$p_fam_hist_neuro___epi,levels=c("0","1"))
    data$p_fam_hist_neuro___tics.factor = factor(data$p_fam_hist_neuro___tics,levels=c("0","1"))
    data$p_fam_hist_neuro___tourette.factor = factor(data$p_fam_hist_neuro___tourette,levels=c("0","1"))
    data$p_fam_hist_neuro___ms.factor = factor(data$p_fam_hist_neuro___ms,levels=c("0","1"))
    data$p_fam_hist_neuro___neuromus.factor = factor(data$p_fam_hist_neuro___neuromus,levels=c("0","1"))
    data$p_fam_hist_neuro___aneurysm.factor = factor(data$p_fam_hist_neuro___aneurysm,levels=c("0","1"))
    data$p_fam_hist_neuro___vascular.factor = factor(data$p_fam_hist_neuro___vascular,levels=c("0","1"))
    data$p_fam_hist_neuro___stroke.factor = factor(data$p_fam_hist_neuro___stroke,levels=c("0","1"))
    data$p_fam_hist_neuro___tumor.factor = factor(data$p_fam_hist_neuro___tumor,levels=c("0","1"))
    data$p_fam_hist_neuro___oth.factor = factor(data$p_fam_hist_neuro___oth,levels=c("0","1"))
    data$p_fam_hist_med___none.factor = factor(data$p_fam_hist_med___none,levels=c("0","1"))
    data$p_fam_hist_med___bleed.factor = factor(data$p_fam_hist_med___bleed,levels=c("0","1"))
    data$p_fam_hist_med___venous_throm.factor = factor(data$p_fam_hist_med___venous_throm,levels=c("0","1"))
    data$p_fam_hist_med___pulm_emb.factor = factor(data$p_fam_hist_med___pulm_emb,levels=c("0","1"))
    data$p_fam_hist_med___miscarriage.factor = factor(data$p_fam_hist_med___miscarriage,levels=c("0","1"))
    data$p_fam_hist_med___autoimmune.factor = factor(data$p_fam_hist_med___autoimmune,levels=c("0","1"))
    data$p_fam_hist_med___gene.factor = factor(data$p_fam_hist_med___gene,levels=c("0","1"))
    data$p_fam_hist_med___early_deaths.factor = factor(data$p_fam_hist_med___early_deaths,levels=c("0","1"))
    data$p_fam_hist_med___hear_loss.factor = factor(data$p_fam_hist_med___hear_loss,levels=c("0","1"))
    data$p_fam_hist_med___vision_loss.factor = factor(data$p_fam_hist_med___vision_loss,levels=c("0","1"))
    data$p_fam_hist_med___heart_disease.factor = factor(data$p_fam_hist_med___heart_disease,levels=c("0","1"))
    data$p_fam_hist_med___pots.factor = factor(data$p_fam_hist_med___pots,levels=c("0","1"))
    data$p_fam_hist_med___high_blood.factor = factor(data$p_fam_hist_med___high_blood,levels=c("0","1"))
    data$p_fam_hist_med___high_choles.factor = factor(data$p_fam_hist_med___high_choles,levels=c("0","1"))
    data$p_fam_hist_med___obese.factor = factor(data$p_fam_hist_med___obese,levels=c("0","1"))
    data$p_fam_hist_med___cancer.factor = factor(data$p_fam_hist_med___cancer,levels=c("0","1"))
    data$p_fam_hist_med___thyroid.factor = factor(data$p_fam_hist_med___thyroid,levels=c("0","1"))
    data$p_fam_hist_med___oth.factor = factor(data$p_fam_hist_med___oth,levels=c("0","1"))
    data$p_lives_w_child___mom.factor = factor(data$p_lives_w_child___mom,levels=c("0","1"))
    data$p_lives_w_child___dad.factor = factor(data$p_lives_w_child___dad,levels=c("0","1"))
    data$p_lives_w_child___sibling.factor = factor(data$p_lives_w_child___sibling,levels=c("0","1"))
    data$p_lives_w_child___grand_par.factor = factor(data$p_lives_w_child___grand_par,levels=c("0","1"))
    data$p_lives_w_child___aunt_unc.factor = factor(data$p_lives_w_child___aunt_unc,levels=c("0","1"))
    data$p_lives_w_child___step_par.factor = factor(data$p_lives_w_child___step_par,levels=c("0","1"))
    data$p_lives_w_child___foster_par.factor = factor(data$p_lives_w_child___foster_par,levels=c("0","1"))
    data$p_lives_w_child___facility.factor = factor(data$p_lives_w_child___facility,levels=c("0","1"))
    data$p_lives_w_child___oth.factor = factor(data$p_lives_w_child___oth,levels=c("0","1"))
    data$p_legal_decision___parent.factor = factor(data$p_legal_decision___parent,levels=c("0","1"))
    data$p_legal_decision___mom.factor = factor(data$p_legal_decision___mom,levels=c("0","1"))
    data$p_legal_decision___dad.factor = factor(data$p_legal_decision___dad,levels=c("0","1"))
    data$p_legal_decision___grandma.factor = factor(data$p_legal_decision___grandma,levels=c("0","1"))
    data$p_legal_decision___grandpa.factor = factor(data$p_legal_decision___grandpa,levels=c("0","1"))
    data$p_legal_decision___grandprnt.factor = factor(data$p_legal_decision___grandprnt,levels=c("0","1"))
    data$p_legal_decision___fosterpar.factor = factor(data$p_legal_decision___fosterpar,levels=c("0","1"))
    data$p_legal_decision___dhs_dyfs.factor = factor(data$p_legal_decision___dhs_dyfs,levels=c("0","1"))
    data$p_legal_decision___oth.factor = factor(data$p_legal_decision___oth,levels=c("0","1"))
    data$p_recent_change.factor = factor(data$p_recent_change,levels=c("1","0"))
    data$p_school_type.factor = factor(data$p_school_type,levels=c("daycare","preschool","sitter","kinder","first","second","third","fourth","fifth","sixth","seventh","eighth","ninth","tenth","eleventh","twelveth","fresh","soph","jr","sen","spec_ed","home_school","homebound","cyber","voc","oth"))
    data$p_school_concerns.factor = factor(data$p_school_concerns,levels=c("1","0"))
    data$p_iep_504.factor = factor(data$p_iep_504,levels=c("iep","504","neither","unsure"))
    data$patient_ha_complete.factor = factor(data$patient_ha_complete,levels=c("0","1","2"))
    data$c_reason_for_visit.factor = factor(data$c_reason_for_visit,levels=c("ha","oth"))
    data$c_visit_type.factor = factor(data$c_visit_type,levels=c("new","consult","second_opin","fu","hosp_fu"))
    data$c_prov_seen___none.factor = factor(data$c_prov_seen___none,levels=c("0","1"))
    data$c_prov_seen___pcp.factor = factor(data$c_prov_seen___pcp,levels=c("0","1"))
    data$c_prov_seen___neuro.factor = factor(data$c_prov_seen___neuro,levels=c("0","1"))
    data$c_prov_seen___eye.factor = factor(data$c_prov_seen___eye,levels=c("0","1"))
    data$c_prov_seen___ent.factor = factor(data$c_prov_seen___ent,levels=c("0","1"))
    data$c_prov_seen___allergy.factor = factor(data$c_prov_seen___allergy,levels=c("0","1"))
    data$c_prov_seen___conc.factor = factor(data$c_prov_seen___conc,levels=c("0","1"))
    data$c_prov_seen___nsg.factor = factor(data$c_prov_seen___nsg,levels=c("0","1"))
    data$c_prov_seen___gi.factor = factor(data$c_prov_seen___gi,levels=c("0","1"))
    data$c_prov_seen___osteo.factor = factor(data$c_prov_seen___osteo,levels=c("0","1"))
    data$c_prov_seen___onco.factor = factor(data$c_prov_seen___onco,levels=c("0","1"))
    data$c_prov_seen___cardio.factor = factor(data$c_prov_seen___cardio,levels=c("0","1"))
    data$c_prov_seen___psych.factor = factor(data$c_prov_seen___psych,levels=c("0","1"))
    data$c_prov_seen___psychol.factor = factor(data$c_prov_seen___psychol,levels=c("0","1"))
    data$c_prov_seen___couns.factor = factor(data$c_prov_seen___couns,levels=c("0","1"))
    data$c_prov_seen___ed.factor = factor(data$c_prov_seen___ed,levels=c("0","1"))
    data$c_prov_seen___oth.factor = factor(data$c_prov_seen___oth,levels=c("0","1"))
    data$c_stud_eval___none.factor = factor(data$c_stud_eval___none,levels=c("0","1"))
    data$c_stud_eval___brain.factor = factor(data$c_stud_eval___brain,levels=c("0","1"))
    data$c_stud_eval___spine.factor = factor(data$c_stud_eval___spine,levels=c("0","1"))
    data$c_stud_eval___ct.factor = factor(data$c_stud_eval___ct,levels=c("0","1"))
    data$c_stud_eval___eeg.factor = factor(data$c_stud_eval___eeg,levels=c("0","1"))
    data$c_stud_eval___emg.factor = factor(data$c_stud_eval___emg,levels=c("0","1"))
    data$c_stud_eval___genetic.factor = factor(data$c_stud_eval___genetic,levels=c("0","1"))
    data$c_stud_eval___lp.factor = factor(data$c_stud_eval___lp,levels=c("0","1"))
    data$c_stud_eval___npsych.factor = factor(data$c_stud_eval___npsych,levels=c("0","1"))
    data$c_stud_eval___metabolic.factor = factor(data$c_stud_eval___metabolic,levels=c("0","1"))
    data$c_stud_eval___blood.factor = factor(data$c_stud_eval___blood,levels=c("0","1"))
    data$c_stud_eval___notsure.factor = factor(data$c_stud_eval___notsure,levels=c("0","1"))
    data$c_stud_eval___oth.factor = factor(data$c_stud_eval___oth,levels=c("0","1"))
    data$c_ha_in_lifetime.factor = factor(data$c_ha_in_lifetime,levels=c("one","few","many"))
    data$c_current_ha_pattern.factor = factor(data$c_current_ha_pattern,levels=c("episodic","cons_same","cons_flare"))
    data$c_epi_prec___none.factor = factor(data$c_epi_prec___none,levels=c("0","1"))
    data$c_epi_prec___conc.factor = factor(data$c_epi_prec___conc,levels=c("0","1"))
    data$c_epi_prec___oth_inj.factor = factor(data$c_epi_prec___oth_inj,levels=c("0","1"))
    data$c_epi_prec___sxg.factor = factor(data$c_epi_prec___sxg,levels=c("0","1"))
    data$c_epi_prec___infect.factor = factor(data$c_epi_prec___infect,levels=c("0","1"))
    data$c_epi_prec___oth_ill.factor = factor(data$c_epi_prec___oth_ill,levels=c("0","1"))
    data$c_epi_prec___mens.factor = factor(data$c_epi_prec___mens,levels=c("0","1"))
    data$c_epi_prec___stress.factor = factor(data$c_epi_prec___stress,levels=c("0","1"))
    data$c_epi_prec___oth.factor = factor(data$c_epi_prec___oth,levels=c("0","1"))
    data$c_epi_conc_moi.factor = factor(data$c_epi_conc_moi,levels=c("fell","struck","sport","mva","bike","ped","oth"))
    data$c_epi_conc_sport.factor = factor(data$c_epi_conc_sport,levels=c("football","hockey","soccer","lacrosse","baseball","softball","volleyball","basketball","field","wrestling","skiing","cheer","martial","oth"))
    data$c_epi_pattern_change___often.factor = factor(data$c_epi_pattern_change___often,levels=c("0","1"))
    data$c_epi_pattern_change___longer.factor = factor(data$c_epi_pattern_change___longer,levels=c("0","1"))
    data$c_epi_pattern_change___none.factor = factor(data$c_epi_pattern_change___none,levels=c("0","1"))
    data$c_epi_inc_fre_prec___none.factor = factor(data$c_epi_inc_fre_prec___none,levels=c("0","1"))
    data$c_epi_inc_fre_prec___conc.factor = factor(data$c_epi_inc_fre_prec___conc,levels=c("0","1"))
    data$c_epi_inc_fre_prec___oth_inj.factor = factor(data$c_epi_inc_fre_prec___oth_inj,levels=c("0","1"))
    data$c_epi_inc_fre_prec___sxg.factor = factor(data$c_epi_inc_fre_prec___sxg,levels=c("0","1"))
    data$c_epi_inc_fre_prec___infect.factor = factor(data$c_epi_inc_fre_prec___infect,levels=c("0","1"))
    data$c_epi_inc_fre_prec___oth_ill.factor = factor(data$c_epi_inc_fre_prec___oth_ill,levels=c("0","1"))
    data$c_epi_inc_fre_prec___mens.factor = factor(data$c_epi_inc_fre_prec___mens,levels=c("0","1"))
    data$c_epi_inc_fre_prec___stress.factor = factor(data$c_epi_inc_fre_prec___stress,levels=c("0","1"))
    data$c_epi_inc_fre_prec___oth.factor = factor(data$c_epi_inc_fre_prec___oth,levels=c("0","1"))
    data$c_epi_inc_fre_conc_moi.factor = factor(data$c_epi_inc_fre_conc_moi,levels=c("fell","struck","sport","mva","bike","ped","oth"))
    data$c_epi_inc_fre_conc_sport.factor = factor(data$c_epi_inc_fre_conc_sport,levels=c("football","hockey","soccer","lacrosse","baseball","softball","volleyball","basketball","field","wrestling","skiing","cheer","martial","oth"))
    data$c_epi_inc_fre_time.factor = factor(data$c_epi_inc_fre_time,levels=c("2wks","2to4wk","4to8wk","8to12wk","3to6mo","6to12mo","1to2y","2to3y","3yrs"))
    data$c_epi_fre.factor = factor(data$c_epi_fre,levels=c("1mo","1to3mo","1wk","2to3wk","3wk","daily","never","oth"))
    data$c_epi_fre_dur.factor = factor(data$c_epi_fre_dur,levels=c("1mo","1to3mo","3mo"))
    data$c_pattern_to_con.factor = factor(data$c_pattern_to_con,levels=c("epi","rare","none"))
    data$c_con_st_epi_prec_ep___none.factor = factor(data$c_con_st_epi_prec_ep___none,levels=c("0","1"))
    data$c_con_st_epi_prec_ep___conc.factor = factor(data$c_con_st_epi_prec_ep___conc,levels=c("0","1"))
    data$c_con_st_epi_prec_ep___oth_inj.factor = factor(data$c_con_st_epi_prec_ep___oth_inj,levels=c("0","1"))
    data$c_con_st_epi_prec_ep___sxg.factor = factor(data$c_con_st_epi_prec_ep___sxg,levels=c("0","1"))
    data$c_con_st_epi_prec_ep___infect.factor = factor(data$c_con_st_epi_prec_ep___infect,levels=c("0","1"))
    data$c_con_st_epi_prec_ep___oth_ill.factor = factor(data$c_con_st_epi_prec_ep___oth_ill,levels=c("0","1"))
    data$c_con_st_epi_prec_ep___mens.factor = factor(data$c_con_st_epi_prec_ep___mens,levels=c("0","1"))
    data$c_con_st_epi_prec_ep___stress.factor = factor(data$c_con_st_epi_prec_ep___stress,levels=c("0","1"))
    data$c_con_st_epi_prec_ep___oth.factor = factor(data$c_con_st_epi_prec_ep___oth,levels=c("0","1"))
    data$c_con_st_epi_conc_moi.factor = factor(data$c_con_st_epi_conc_moi,levels=c("fell","struck","sport","mva","bike","ped","oth"))
    data$c_con_st_epi_conc_sport.factor = factor(data$c_con_st_epi_conc_sport,levels=c("football","hockey","soccer","lacrosse","baseball","softball","volleyball","basketball","field","wrestling","skiing","cheer","martial","oth"))
    data$c_con_prec___none.factor = factor(data$c_con_prec___none,levels=c("0","1"))
    data$c_con_prec___conc.factor = factor(data$c_con_prec___conc,levels=c("0","1"))
    data$c_con_prec___oth_inj.factor = factor(data$c_con_prec___oth_inj,levels=c("0","1"))
    data$c_con_prec___sxg.factor = factor(data$c_con_prec___sxg,levels=c("0","1"))
    data$c_con_prec___infect.factor = factor(data$c_con_prec___infect,levels=c("0","1"))
    data$c_con_prec___oth_ill.factor = factor(data$c_con_prec___oth_ill,levels=c("0","1"))
    data$c_con_prec___mens.factor = factor(data$c_con_prec___mens,levels=c("0","1"))
    data$c_con_prec___stress.factor = factor(data$c_con_prec___stress,levels=c("0","1"))
    data$c_con_prec___oth.factor = factor(data$c_con_prec___oth,levels=c("0","1"))
    data$c_con_conc_moi.factor = factor(data$c_con_conc_moi,levels=c("fell","struck","sport","mva","bike","ped","oth"))
    data$c_con_conc_sport.factor = factor(data$c_con_conc_sport,levels=c("football","hockey","soccer","lacrosse","baseball","softball","volleyball","basketball","field","wrestling","skiing","cheer","martial","oth"))
    data$c_con_start_epi_time.factor = factor(data$c_con_start_epi_time,levels=c("2wks","2to4wk","4to8wk","8to12wk","3to6mo","6to12mo","1to2y","2to3y","3yrs"))
    data$c_con_pattern_duration.factor = factor(data$c_con_pattern_duration,levels=c("2wks","2to4wk","4to8wk","8to12wk","3to6mo","6to12mo","1to2y","2to3y","3yrs"))
    data$c_fre_bad.factor = factor(data$c_fre_bad,levels=c("never","1mo","1to3mo","1wk","2to3wk","3wk","daily","always","oth"))
    data$c_timing___none.factor = factor(data$c_timing___none,levels=c("0","1"))
    data$c_timing___wake.factor = factor(data$c_timing___wake,levels=c("0","1"))
    data$c_timing___morning.factor = factor(data$c_timing___morning,levels=c("0","1"))
    data$c_timing___noon.factor = factor(data$c_timing___noon,levels=c("0","1"))
    data$c_timing___evening.factor = factor(data$c_timing___evening,levels=c("0","1"))
    data$c_timing___night.factor = factor(data$c_timing___night,levels=c("0","1"))
    data$c_timing___sleep.factor = factor(data$c_timing___sleep,levels=c("0","1"))
    data$c_timing___spring.factor = factor(data$c_timing___spring,levels=c("0","1"))
    data$c_timing___summer.factor = factor(data$c_timing___summer,levels=c("0","1"))
    data$c_timing___fall.factor = factor(data$c_timing___fall,levels=c("0","1"))
    data$c_timing___winter.factor = factor(data$c_timing___winter,levels=c("0","1"))
    data$c_timing___mon.factor = factor(data$c_timing___mon,levels=c("0","1"))
    data$c_timing___tue.factor = factor(data$c_timing___tue,levels=c("0","1"))
    data$c_timing___wed.factor = factor(data$c_timing___wed,levels=c("0","1"))
    data$c_timing___thur.factor = factor(data$c_timing___thur,levels=c("0","1"))
    data$c_timing___fri.factor = factor(data$c_timing___fri,levels=c("0","1"))
    data$c_timing___sat.factor = factor(data$c_timing___sat,levels=c("0","1"))
    data$c_timing___sun.factor = factor(data$c_timing___sun,levels=c("0","1"))
    data$c_timing_wake_up.factor = factor(data$c_timing_wake_up,levels=c("1","0"))
    data$c_ha_quality___throb.factor = factor(data$c_ha_quality___throb,levels=c("0","1"))
    data$c_ha_quality___pound.factor = factor(data$c_ha_quality___pound,levels=c("0","1"))
    data$c_ha_quality___stab.factor = factor(data$c_ha_quality___stab,levels=c("0","1"))
    data$c_ha_quality___pushin.factor = factor(data$c_ha_quality___pushin,levels=c("0","1"))
    data$c_ha_quality___pushout.factor = factor(data$c_ha_quality___pushout,levels=c("0","1"))
    data$c_ha_quality___dull.factor = factor(data$c_ha_quality___dull,levels=c("0","1"))
    data$c_ha_quality___burn.factor = factor(data$c_ha_quality___burn,levels=c("0","1"))
    data$c_ha_quality___sharp.factor = factor(data$c_ha_quality___sharp,levels=c("0","1"))
    data$c_ha_quality___tight.factor = factor(data$c_ha_quality___tight,levels=c("0","1"))
    data$c_ha_quality___pinch.factor = factor(data$c_ha_quality___pinch,levels=c("0","1"))
    data$c_ha_quality___pulse.factor = factor(data$c_ha_quality___pulse,levels=c("0","1"))
    data$c_ha_quality___cant_desc.factor = factor(data$c_ha_quality___cant_desc,levels=c("0","1"))
    data$c_ha_quality___oth.factor = factor(data$c_ha_quality___oth,levels=c("0","1"))
    data$c_location_side___right.factor = factor(data$c_location_side___right,levels=c("0","1"))
    data$c_location_side___left.factor = factor(data$c_location_side___left,levels=c("0","1"))
    data$c_location_side___both.factor = factor(data$c_location_side___both,levels=c("0","1"))
    data$c_location_side___cant_desc.factor = factor(data$c_location_side___cant_desc,levels=c("0","1"))
    data$c_location_area___sides.factor = factor(data$c_location_area___sides,levels=c("0","1"))
    data$c_location_area___front.factor = factor(data$c_location_area___front,levels=c("0","1"))
    data$c_location_area___top.factor = factor(data$c_location_area___top,levels=c("0","1"))
    data$c_location_area___back.factor = factor(data$c_location_area___back,levels=c("0","1"))
    data$c_location_area___neck.factor = factor(data$c_location_area___neck,levels=c("0","1"))
    data$c_location_area___around.factor = factor(data$c_location_area___around,levels=c("0","1"))
    data$c_location_area___behind.factor = factor(data$c_location_area___behind,levels=c("0","1"))
    data$c_location_area___allover.factor = factor(data$c_location_area___allover,levels=c("0","1"))
    data$c_location_area___oth.factor = factor(data$c_location_area___oth,levels=c("0","1"))
    data$c_location_area___cant_desc.factor = factor(data$c_location_area___cant_desc,levels=c("0","1"))
    data$c_sev_overall.factor = factor(data$c_sev_overall,levels=c("mild","mod","sev"))
    data$c_sev_usual.factor = factor(data$c_sev_usual,levels=c("0","1","2","3","4","5","6","7","8","9","10"))
    data$c_sev_morning.factor = factor(data$c_sev_morning,levels=c("0","1","2","3","4","5","6","7","8","9","10"))
    data$c_sev_hr_after_bed.factor = factor(data$c_sev_hr_after_bed,levels=c("0","1","2","3","4","5","6","7","8","9","10"))
    data$c_sev_rate_rise.factor = factor(data$c_sev_rate_rise,levels=c("wakeup","secs","mins","hrs","no_change"))
    data$c_sev_dur.factor = factor(data$c_sev_dur,levels=c("secs","mins","hrs","1to3d","3days"))
    data$c_relief_sleep.factor = factor(data$c_relief_sleep,levels=c("1","0"))
    data$c_relief___no.factor = factor(data$c_relief___no,levels=c("0","1"))
    data$c_relief___ice.factor = factor(data$c_relief___ice,levels=c("0","1"))
    data$c_relief___heat.factor = factor(data$c_relief___heat,levels=c("0","1"))
    data$c_relief___sunglasses.factor = factor(data$c_relief___sunglasses,levels=c("0","1"))
    data$c_relief___caffeine.factor = factor(data$c_relief___caffeine,levels=c("0","1"))
    data$c_relief___quiet.factor = factor(data$c_relief___quiet,levels=c("0","1"))
    data$c_relief___lying_down.factor = factor(data$c_relief___lying_down,levels=c("0","1"))
    data$c_relief___active.factor = factor(data$c_relief___active,levels=c("0","1"))
    data$c_relief___oth.factor = factor(data$c_relief___oth,levels=c("0","1"))
    data$c_trigger___none.factor = factor(data$c_trigger___none,levels=c("0","1"))
    data$c_trigger___period.factor = factor(data$c_trigger___period,levels=c("0","1"))
    data$c_trigger___much_sleep.factor = factor(data$c_trigger___much_sleep,levels=c("0","1"))
    data$c_trigger___little_sleep.factor = factor(data$c_trigger___little_sleep,levels=c("0","1"))
    data$c_trigger___fatigue.factor = factor(data$c_trigger___fatigue,levels=c("0","1"))
    data$c_trigger___exercise.factor = factor(data$c_trigger___exercise,levels=c("0","1"))
    data$c_trigger___overheat.factor = factor(data$c_trigger___overheat,levels=c("0","1"))
    data$c_trigger___dehyd.factor = factor(data$c_trigger___dehyd,levels=c("0","1"))
    data$c_trigger___skip_meals.factor = factor(data$c_trigger___skip_meals,levels=c("0","1"))
    data$c_trigger___food.factor = factor(data$c_trigger___food,levels=c("0","1"))
    data$c_trigger___meds.factor = factor(data$c_trigger___meds,levels=c("0","1"))
    data$c_trigger___chew.factor = factor(data$c_trigger___chew,levels=c("0","1"))
    data$c_trigger___stress.factor = factor(data$c_trigger___stress,levels=c("0","1"))
    data$c_trigger___let_down.factor = factor(data$c_trigger___let_down,levels=c("0","1"))
    data$c_trigger___screen.factor = factor(data$c_trigger___screen,levels=c("0","1"))
    data$c_trigger___concentrate.factor = factor(data$c_trigger___concentrate,levels=c("0","1"))
    data$c_trigger___read.factor = factor(data$c_trigger___read,levels=c("0","1"))
    data$c_trigger___light.factor = factor(data$c_trigger___light,levels=c("0","1"))
    data$c_trigger___noises.factor = factor(data$c_trigger___noises,levels=c("0","1"))
    data$c_trigger___smells.factor = factor(data$c_trigger___smells,levels=c("0","1"))
    data$c_trigger___smoke.factor = factor(data$c_trigger___smoke,levels=c("0","1"))
    data$c_trigger___weather.factor = factor(data$c_trigger___weather,levels=c("0","1"))
    data$c_trigger___high_alt.factor = factor(data$c_trigger___high_alt,levels=c("0","1"))
    data$c_trigger___oth.factor = factor(data$c_trigger___oth,levels=c("0","1"))
    data$c_allodynia_hurt___none.factor = factor(data$c_allodynia_hurt___none,levels=c("0","1"))
    data$c_allodynia_hurt___ponytail.factor = factor(data$c_allodynia_hurt___ponytail,levels=c("0","1"))
    data$c_allodynia_hurt___comb.factor = factor(data$c_allodynia_hurt___comb,levels=c("0","1"))
    data$c_allodynia_hurt___hat.factor = factor(data$c_allodynia_hurt___hat,levels=c("0","1"))
    data$c_allodynia_hurt___headphones.factor = factor(data$c_allodynia_hurt___headphones,levels=c("0","1"))
    data$c_valsalva_position___none.factor = factor(data$c_valsalva_position___none,levels=c("0","1"))
    data$c_valsalva_position___sneeze.factor = factor(data$c_valsalva_position___sneeze,levels=c("0","1"))
    data$c_valsalva_position___cough.factor = factor(data$c_valsalva_position___cough,levels=c("0","1"))
    data$c_valsalva_position___laugh.factor = factor(data$c_valsalva_position___laugh,levels=c("0","1"))
    data$c_valsalva_position___stand.factor = factor(data$c_valsalva_position___stand,levels=c("0","1"))
    data$c_valsalva_position___lie.factor = factor(data$c_valsalva_position___lie,levels=c("0","1"))
    data$c_valsalva_dur.factor = factor(data$c_valsalva_dur,levels=c("dur_sneeze","secs","mins","hrs"))
    data$c_activity.factor = factor(data$c_activity,levels=c("no_change","feel_better","feel_worse","move"))
    data$c_assoc_sx_vis___none.factor = factor(data$c_assoc_sx_vis___none,levels=c("0","1"))
    data$c_assoc_sx_vis___spot.factor = factor(data$c_assoc_sx_vis___spot,levels=c("0","1"))
    data$c_assoc_sx_vis___star.factor = factor(data$c_assoc_sx_vis___star,levels=c("0","1"))
    data$c_assoc_sx_vis___light.factor = factor(data$c_assoc_sx_vis___light,levels=c("0","1"))
    data$c_assoc_sx_vis___zigzag.factor = factor(data$c_assoc_sx_vis___zigzag,levels=c("0","1"))
    data$c_assoc_sx_vis___blur.factor = factor(data$c_assoc_sx_vis___blur,levels=c("0","1"))
    data$c_assoc_sx_vis___double_vis.factor = factor(data$c_assoc_sx_vis___double_vis,levels=c("0","1"))
    data$c_assoc_sx_vis___heat.factor = factor(data$c_assoc_sx_vis___heat,levels=c("0","1"))
    data$c_assoc_sx_vis___loss_vis.factor = factor(data$c_assoc_sx_vis___loss_vis,levels=c("0","1"))
    data$c_assoc_sx_vis___oth.factor = factor(data$c_assoc_sx_vis___oth,levels=c("0","1"))
    data$c_assoc_sx_vis___cant_desc.factor = factor(data$c_assoc_sx_vis___cant_desc,levels=c("0","1"))
    data$c_assoc_sx_neur_bil___none.factor = factor(data$c_assoc_sx_neur_bil___none,levels=c("0","1"))
    data$c_assoc_sx_neur_bil___weak.factor = factor(data$c_assoc_sx_neur_bil___weak,levels=c("0","1"))
    data$c_assoc_sx_neur_bil___numb.factor = factor(data$c_assoc_sx_neur_bil___numb,levels=c("0","1"))
    data$c_assoc_sx_neur_bil___tingle.factor = factor(data$c_assoc_sx_neur_bil___tingle,levels=c("0","1"))
    data$c_assoc_sx_neur_bil___run_nose.factor = factor(data$c_assoc_sx_neur_bil___run_nose,levels=c("0","1"))
    data$c_assoc_sx_neur_bil___tear.factor = factor(data$c_assoc_sx_neur_bil___tear,levels=c("0","1"))
    data$c_assoc_sx_neur_bil___ptosis.factor = factor(data$c_assoc_sx_neur_bil___ptosis,levels=c("0","1"))
    data$c_assoc_sx_neur_bil___red_eye.factor = factor(data$c_assoc_sx_neur_bil___red_eye,levels=c("0","1"))
    data$c_assoc_sx_neur_bil___puff_eye.factor = factor(data$c_assoc_sx_neur_bil___puff_eye,levels=c("0","1"))
    data$c_assoc_sx_neur_bil___flush.factor = factor(data$c_assoc_sx_neur_bil___flush,levels=c("0","1"))
    data$c_assoc_sx_neur_bil___sweat.factor = factor(data$c_assoc_sx_neur_bil___sweat,levels=c("0","1"))
    data$c_assoc_sx_neur_bil___full_ear.factor = factor(data$c_assoc_sx_neur_bil___full_ear,levels=c("0","1"))
    data$c_assoc_sx_neur_bil___oth.factor = factor(data$c_assoc_sx_neur_bil___oth,levels=c("0","1"))
    data$c_assoc_sx_neur_bil___.factor = factor(data$c_assoc_sx_neur_bil___,levels=c("0","1"))
    data$c_assoc_sx_neur_uni___none.factor = factor(data$c_assoc_sx_neur_uni___none,levels=c("0","1"))
    data$c_assoc_sx_neur_uni___weak.factor = factor(data$c_assoc_sx_neur_uni___weak,levels=c("0","1"))
    data$c_assoc_sx_neur_uni___numb.factor = factor(data$c_assoc_sx_neur_uni___numb,levels=c("0","1"))
    data$c_assoc_sx_neur_uni___tingle.factor = factor(data$c_assoc_sx_neur_uni___tingle,levels=c("0","1"))
    data$c_assoc_sx_neur_uni___run_nose.factor = factor(data$c_assoc_sx_neur_uni___run_nose,levels=c("0","1"))
    data$c_assoc_sx_neur_uni___tear.factor = factor(data$c_assoc_sx_neur_uni___tear,levels=c("0","1"))
    data$c_assoc_sx_neur_uni___ptosis.factor = factor(data$c_assoc_sx_neur_uni___ptosis,levels=c("0","1"))
    data$c_assoc_sx_neur_uni___red_eye.factor = factor(data$c_assoc_sx_neur_uni___red_eye,levels=c("0","1"))
    data$c_assoc_sx_neur_uni___puff_eye.factor = factor(data$c_assoc_sx_neur_uni___puff_eye,levels=c("0","1"))
    data$c_assoc_sx_neur_uni___pupilbig.factor = factor(data$c_assoc_sx_neur_uni___pupilbig,levels=c("0","1"))
    data$c_assoc_sx_neur_uni___flush.factor = factor(data$c_assoc_sx_neur_uni___flush,levels=c("0","1"))
    data$c_assoc_sx_neur_uni___sweat.factor = factor(data$c_assoc_sx_neur_uni___sweat,levels=c("0","1"))
    data$c_assoc_sx_neur_uni___full_ear.factor = factor(data$c_assoc_sx_neur_uni___full_ear,levels=c("0","1"))
    data$c_assoc_sx_neur_uni___oth.factor = factor(data$c_assoc_sx_neur_uni___oth,levels=c("0","1"))
    data$c_assoc_sx_gi___none.factor = factor(data$c_assoc_sx_gi___none,levels=c("0","1"))
    data$c_assoc_sx_gi___decreased_app.factor = factor(data$c_assoc_sx_gi___decreased_app,levels=c("0","1"))
    data$c_assoc_sx_gi___diarr.factor = factor(data$c_assoc_sx_gi___diarr,levels=c("0","1"))
    data$c_assoc_sx_gi___naus.factor = factor(data$c_assoc_sx_gi___naus,levels=c("0","1"))
    data$c_assoc_sx_gi___stom_pain.factor = factor(data$c_assoc_sx_gi___stom_pain,levels=c("0","1"))
    data$c_assoc_sx_gi___vomiting.factor = factor(data$c_assoc_sx_gi___vomiting,levels=c("0","1"))
    data$c_assoc_sx_gi___oth.factor = factor(data$c_assoc_sx_gi___oth,levels=c("0","1"))
    data$c_assoc_sx_oth_sx___none.factor = factor(data$c_assoc_sx_oth_sx___none,levels=c("0","1"))
    data$c_assoc_sx_oth_sx___light.factor = factor(data$c_assoc_sx_oth_sx___light,levels=c("0","1"))
    data$c_assoc_sx_oth_sx___smell.factor = factor(data$c_assoc_sx_oth_sx___smell,levels=c("0","1"))
    data$c_assoc_sx_oth_sx___sound.factor = factor(data$c_assoc_sx_oth_sx___sound,levels=c("0","1"))
    data$c_assoc_sx_oth_sx___lighthead.factor = factor(data$c_assoc_sx_oth_sx___lighthead,levels=c("0","1"))
    data$c_assoc_sx_oth_sx___spinning.factor = factor(data$c_assoc_sx_oth_sx___spinning,levels=c("0","1"))
    data$c_assoc_sx_oth_sx___balance.factor = factor(data$c_assoc_sx_oth_sx___balance,levels=c("0","1"))
    data$c_assoc_sx_oth_sx___hear.factor = factor(data$c_assoc_sx_oth_sx___hear,levels=c("0","1"))
    data$c_assoc_sx_oth_sx___ringing.factor = factor(data$c_assoc_sx_oth_sx___ringing,levels=c("0","1"))
    data$c_assoc_sx_oth_sx___unrespons.factor = factor(data$c_assoc_sx_oth_sx___unrespons,levels=c("0","1"))
    data$c_assoc_sx_oth_sx___neck_pain.factor = factor(data$c_assoc_sx_oth_sx___neck_pain,levels=c("0","1"))
    data$c_assoc_sx_oth_sx___think.factor = factor(data$c_assoc_sx_oth_sx___think,levels=c("0","1"))
    data$c_assoc_sx_oth_sx___talk.factor = factor(data$c_assoc_sx_oth_sx___talk,levels=c("0","1"))
    data$c_assoc_sx_oth_sx___oth.factor = factor(data$c_assoc_sx_oth_sx___oth,levels=c("0","1"))
    data$c_assoc_sx_pul_ear___none.factor = factor(data$c_assoc_sx_pul_ear___none,levels=c("0","1"))
    data$c_assoc_sx_pul_ear___standing.factor = factor(data$c_assoc_sx_pul_ear___standing,levels=c("0","1"))
    data$c_assoc_sx_pul_ear___lying.factor = factor(data$c_assoc_sx_pul_ear___lying,levels=c("0","1"))
    data$c_assoc_sx_pul_ear___ha_bad.factor = factor(data$c_assoc_sx_pul_ear___ha_bad,levels=c("0","1"))
    data$c_assoc_sx_pul_ear___oth.factor = factor(data$c_assoc_sx_pul_ear___oth,levels=c("0","1"))
    data$c_med_stop_ha___none.factor = factor(data$c_med_stop_ha___none,levels=c("0","1"))
    data$c_med_stop_ha___apap.factor = factor(data$c_med_stop_ha___apap,levels=c("0","1"))
    data$c_med_stop_ha___ibupro.factor = factor(data$c_med_stop_ha___ibupro,levels=c("0","1"))
    data$c_med_stop_ha___naprox.factor = factor(data$c_med_stop_ha___naprox,levels=c("0","1"))
    data$c_med_stop_ha___asp.factor = factor(data$c_med_stop_ha___asp,levels=c("0","1"))
    data$c_med_stop_ha___ketorolac.factor = factor(data$c_med_stop_ha___ketorolac,levels=c("0","1"))
    data$c_med_stop_ha___ketoprof.factor = factor(data$c_med_stop_ha___ketoprof,levels=c("0","1"))
    data$c_med_stop_ha___diclof.factor = factor(data$c_med_stop_ha___diclof,levels=c("0","1"))
    data$c_med_stop_ha___celec.factor = factor(data$c_med_stop_ha___celec,levels=c("0","1"))
    data$c_med_stop_ha___exced.factor = factor(data$c_med_stop_ha___exced,levels=c("0","1"))
    data$c_med_stop_ha___butal.factor = factor(data$c_med_stop_ha___butal,levels=c("0","1"))
    data$c_med_stop_ha___midrin.factor = factor(data$c_med_stop_ha___midrin,levels=c("0","1"))
    data$c_med_stop_ha___methylpred.factor = factor(data$c_med_stop_ha___methylpred,levels=c("0","1"))
    data$c_med_stop_ha___pred.factor = factor(data$c_med_stop_ha___pred,levels=c("0","1"))
    data$c_med_stop_ha___suma.factor = factor(data$c_med_stop_ha___suma,levels=c("0","1"))
    data$c_med_stop_ha___riza.factor = factor(data$c_med_stop_ha___riza,levels=c("0","1"))
    data$c_med_stop_ha___nara.factor = factor(data$c_med_stop_ha___nara,levels=c("0","1"))
    data$c_med_stop_ha___almo.factor = factor(data$c_med_stop_ha___almo,levels=c("0","1"))
    data$c_med_stop_ha___frova.factor = factor(data$c_med_stop_ha___frova,levels=c("0","1"))
    data$c_med_stop_ha___eletrip.factor = factor(data$c_med_stop_ha___eletrip,levels=c("0","1"))
    data$c_med_stop_ha___zolmit.factor = factor(data$c_med_stop_ha___zolmit,levels=c("0","1"))
    data$c_med_stop_ha___metoclop.factor = factor(data$c_med_stop_ha___metoclop,levels=c("0","1"))
    data$c_med_stop_ha___proch.factor = factor(data$c_med_stop_ha___proch,levels=c("0","1"))
    data$c_med_stop_ha___prometh.factor = factor(data$c_med_stop_ha___prometh,levels=c("0","1"))
    data$c_med_stop_ha___ond.factor = factor(data$c_med_stop_ha___ond,levels=c("0","1"))
    data$c_med_stop_ha___diphen.factor = factor(data$c_med_stop_ha___diphen,levels=c("0","1"))
    data$c_med_stop_ha___dhe.factor = factor(data$c_med_stop_ha___dhe,levels=c("0","1"))
    data$c_med_stop_ha___tram.factor = factor(data$c_med_stop_ha___tram,levels=c("0","1"))
    data$c_med_stop_ha___t3.factor = factor(data$c_med_stop_ha___t3,levels=c("0","1"))
    data$c_med_stop_ha___morph.factor = factor(data$c_med_stop_ha___morph,levels=c("0","1"))
    data$c_med_stop_ha___hydromor.factor = factor(data$c_med_stop_ha___hydromor,levels=c("0","1"))
    data$c_med_stop_ha___nb.factor = factor(data$c_med_stop_ha___nb,levels=c("0","1"))
    data$c_med_stop_ha___oth.factor = factor(data$c_med_stop_ha___oth,levels=c("0","1"))
    data$c_when_take_med.factor = factor(data$c_when_take_med,levels=c("beforepain","painstart","painmild","painmoderate","painbad","painworse"))
    data$c_how_oft_med.factor = factor(data$c_how_oft_med,levels=c("less_1wk","1to3wk","4wks_greater","qd"))
    data$c_duration_overuse.factor = factor(data$c_duration_overuse,levels=c("less_1mo","1to3mo","3mo_greater"))
    data$c_med_prev_ha___none.factor = factor(data$c_med_prev_ha___none,levels=c("0","1"))
    data$c_med_prev_ha___acetaz.factor = factor(data$c_med_prev_ha___acetaz,levels=c("0","1"))
    data$c_med_prev_ha___amitrip.factor = factor(data$c_med_prev_ha___amitrip,levels=c("0","1"))
    data$c_med_prev_ha___ateno.factor = factor(data$c_med_prev_ha___ateno,levels=c("0","1"))
    data$c_med_prev_ha___botox.factor = factor(data$c_med_prev_ha___botox,levels=c("0","1"))
    data$c_med_prev_ha___cefaly.factor = factor(data$c_med_prev_ha___cefaly,levels=c("0","1"))
    data$c_med_prev_ha___cypro.factor = factor(data$c_med_prev_ha___cypro,levels=c("0","1"))
    data$c_med_prev_ha___doxy.factor = factor(data$c_med_prev_ha___doxy,levels=c("0","1"))
    data$c_med_prev_ha___dulox.factor = factor(data$c_med_prev_ha___dulox,levels=c("0","1"))
    data$c_med_prev_ha___fluox.factor = factor(data$c_med_prev_ha___fluox,levels=c("0","1"))
    data$c_med_prev_ha___gaba.factor = factor(data$c_med_prev_ha___gaba,levels=c("0","1"))
    data$c_med_prev_ha___lamotrig.factor = factor(data$c_med_prev_ha___lamotrig,levels=c("0","1"))
    data$c_med_prev_ha___lisin.factor = factor(data$c_med_prev_ha___lisin,levels=c("0","1"))
    data$c_med_prev_ha___lvt.factor = factor(data$c_med_prev_ha___lvt,levels=c("0","1"))
    data$c_med_prev_ha___metopro.factor = factor(data$c_med_prev_ha___metopro,levels=c("0","1"))
    data$c_med_prev_ha___minocy.factor = factor(data$c_med_prev_ha___minocy,levels=c("0","1"))
    data$c_med_prev_ha___nb.factor = factor(data$c_med_prev_ha___nb,levels=c("0","1"))
    data$c_med_prev_ha___nebivo.factor = factor(data$c_med_prev_ha___nebivo,levels=c("0","1"))
    data$c_med_prev_ha___nortrip.factor = factor(data$c_med_prev_ha___nortrip,levels=c("0","1"))
    data$c_med_prev_ha___pregab.factor = factor(data$c_med_prev_ha___pregab,levels=c("0","1"))
    data$c_med_prev_ha___propano.factor = factor(data$c_med_prev_ha___propano,levels=c("0","1"))
    data$c_med_prev_ha___sertra.factor = factor(data$c_med_prev_ha___sertra,levels=c("0","1"))
    data$c_med_prev_ha___topa.factor = factor(data$c_med_prev_ha___topa,levels=c("0","1"))
    data$c_med_prev_ha___vpa.factor = factor(data$c_med_prev_ha___vpa,levels=c("0","1"))
    data$c_med_prev_ha___venla.factor = factor(data$c_med_prev_ha___venla,levels=c("0","1"))
    data$c_med_prev_ha___verap.factor = factor(data$c_med_prev_ha___verap,levels=c("0","1"))
    data$c_med_prev_ha___zonis.factor = factor(data$c_med_prev_ha___zonis,levels=c("0","1"))
    data$c_med_prev_ha___oth.factor = factor(data$c_med_prev_ha___oth,levels=c("0","1"))
    data$c_vit_sup_ha___none.factor = factor(data$c_vit_sup_ha___none,levels=c("0","1"))
    data$c_vit_sup_ha___vitb2.factor = factor(data$c_vit_sup_ha___vitb2,levels=c("0","1"))
    data$c_vit_sup_ha___vitd.factor = factor(data$c_vit_sup_ha___vitd,levels=c("0","1"))
    data$c_vit_sup_ha___mag.factor = factor(data$c_vit_sup_ha___mag,levels=c("0","1"))
    data$c_vit_sup_ha___fishoil.factor = factor(data$c_vit_sup_ha___fishoil,levels=c("0","1"))
    data$c_vit_sup_ha___coenzq10.factor = factor(data$c_vit_sup_ha___coenzq10,levels=c("0","1"))
    data$c_vit_sup_ha___feverfew.factor = factor(data$c_vit_sup_ha___feverfew,levels=c("0","1"))
    data$c_vit_sup_ha___melatonin.factor = factor(data$c_vit_sup_ha___melatonin,levels=c("0","1"))
    data$c_vit_sup_ha___butterbur.factor = factor(data$c_vit_sup_ha___butterbur,levels=c("0","1"))
    data$c_vit_sup_ha___oth.factor = factor(data$c_vit_sup_ha___oth,levels=c("0","1"))
    data$c_non_med_trea_ha___none.factor = factor(data$c_non_med_trea_ha___none,levels=c("0","1"))
    data$c_non_med_trea_ha___acupunc.factor = factor(data$c_non_med_trea_ha___acupunc,levels=c("0","1"))
    data$c_non_med_trea_ha___biofeed.factor = factor(data$c_non_med_trea_ha___biofeed,levels=c("0","1"))
    data$c_non_med_trea_ha___chirop.factor = factor(data$c_non_med_trea_ha___chirop,levels=c("0","1"))
    data$c_non_med_trea_ha___counsel.factor = factor(data$c_non_med_trea_ha___counsel,levels=c("0","1"))
    data$c_non_med_trea_ha___exercise.factor = factor(data$c_non_med_trea_ha___exercise,levels=c("0","1"))
    data$c_non_med_trea_ha___massage.factor = factor(data$c_non_med_trea_ha___massage,levels=c("0","1"))
    data$c_non_med_trea_ha___ot.factor = factor(data$c_non_med_trea_ha___ot,levels=c("0","1"))
    data$c_non_med_trea_ha___osteo.factor = factor(data$c_non_med_trea_ha___osteo,levels=c("0","1"))
    data$c_non_med_trea_ha___pt.factor = factor(data$c_non_med_trea_ha___pt,levels=c("0","1"))
    data$c_non_med_trea_ha___vision.factor = factor(data$c_non_med_trea_ha___vision,levels=c("0","1"))
    data$c_non_med_trea_ha___oth.factor = factor(data$c_non_med_trea_ha___oth,levels=c("0","1"))
    data$c_iv_med_ha___none.factor = factor(data$c_iv_med_ha___none,levels=c("0","1"))
    data$c_iv_med_ha___ketorolac.factor = factor(data$c_iv_med_ha___ketorolac,levels=c("0","1"))
    data$c_iv_med_ha___metoclop.factor = factor(data$c_iv_med_ha___metoclop,levels=c("0","1"))
    data$c_iv_med_ha___prochlor.factor = factor(data$c_iv_med_ha___prochlor,levels=c("0","1"))
    data$c_iv_med_ha___methylpred.factor = factor(data$c_iv_med_ha___methylpred,levels=c("0","1"))
    data$c_iv_med_ha___dexameth.factor = factor(data$c_iv_med_ha___dexameth,levels=c("0","1"))
    data$c_iv_med_ha___mag.factor = factor(data$c_iv_med_ha___mag,levels=c("0","1"))
    data$c_iv_med_ha___vpa.factor = factor(data$c_iv_med_ha___vpa,levels=c("0","1"))
    data$c_iv_med_ha___diphen.factor = factor(data$c_iv_med_ha___diphen,levels=c("0","1"))
    data$c_iv_med_ha___opio.factor = factor(data$c_iv_med_ha___opio,levels=c("0","1"))
    data$c_iv_med_ha___lvt.factor = factor(data$c_iv_med_ha___lvt,levels=c("0","1"))
    data$c_iv_med_ha___dhe.factor = factor(data$c_iv_med_ha___dhe,levels=c("0","1"))
    data$c_iv_med_ha___ond.factor = factor(data$c_iv_med_ha___ond,levels=c("0","1"))
    data$c_iv_med_ha___oth.factor = factor(data$c_iv_med_ha___oth,levels=c("0","1"))
    data$clinician_ha_complete.factor = factor(data$clinician_ha_complete,levels=c("0","1","2"))
    
    levels(data$redcap_repeat_instrument.factor)=c("Visit Diagnoses","Lab","Prior Labs","All Problems","Imaging")
    levels(data$relation___mom.factor)=c("Unchecked","Checked")
    levels(data$relation___dad.factor)=c("Unchecked","Checked")
    levels(data$relation___self.factor)=c("Unchecked","Checked")
    levels(data$relation___interpret.factor)=c("Unchecked","Checked")
    levels(data$relation___m_grandma.factor)=c("Unchecked","Checked")
    levels(data$relation___m_grandpa.factor)=c("Unchecked","Checked")
    levels(data$relation___p_grandma.factor)=c("Unchecked","Checked")
    levels(data$relation___p_grandpa.factor)=c("Unchecked","Checked")
    levels(data$relation___aunt_unc.factor)=c("Unchecked","Checked")
    levels(data$relation___stepma.factor)=c("Unchecked","Checked")
    levels(data$relation___steppa.factor)=c("Unchecked","Checked")
    levels(data$relation___guard.factor)=c("Unchecked","Checked")
    levels(data$relation___fosterma.factor)=c("Unchecked","Checked")
    levels(data$relation___fosterpa.factor)=c("Unchecked","Checked")
    levels(data$relation___provider.factor)=c("Unchecked","Checked")
    levels(data$relation___facility.factor)=c("Unchecked","Checked")
    levels(data$relation___oth.factor)=c("Unchecked","Checked")
    levels(data$p_prov_seen___none.factor)=c("Unchecked","Checked")
    levels(data$p_prov_seen___pcp.factor)=c("Unchecked","Checked")
    levels(data$p_prov_seen___neuro.factor)=c("Unchecked","Checked")
    levels(data$p_prov_seen___eye.factor)=c("Unchecked","Checked")
    levels(data$p_prov_seen___ent.factor)=c("Unchecked","Checked")
    levels(data$p_prov_seen___allergy.factor)=c("Unchecked","Checked")
    levels(data$p_prov_seen___conc.factor)=c("Unchecked","Checked")
    levels(data$p_prov_seen___nsg.factor)=c("Unchecked","Checked")
    levels(data$p_prov_seen___gi.factor)=c("Unchecked","Checked")
    levels(data$p_prov_seen___osteo.factor)=c("Unchecked","Checked")
    levels(data$p_prov_seen___onco.factor)=c("Unchecked","Checked")
    levels(data$p_prov_seen___cardio.factor)=c("Unchecked","Checked")
    levels(data$p_prov_seen___psych.factor)=c("Unchecked","Checked")
    levels(data$p_prov_seen___psychol.factor)=c("Unchecked","Checked")
    levels(data$p_prov_seen___couns.factor)=c("Unchecked","Checked")
    levels(data$p_prov_seen___ed.factor)=c("Unchecked","Checked")
    levels(data$p_prov_seen___oth.factor)=c("Unchecked","Checked")
    levels(data$p_stud_eval___none.factor)=c("Unchecked","Checked")
    levels(data$p_stud_eval___brain.factor)=c("Unchecked","Checked")
    levels(data$p_stud_eval___spine.factor)=c("Unchecked","Checked")
    levels(data$p_stud_eval___ct.factor)=c("Unchecked","Checked")
    levels(data$p_stud_eval___eeg.factor)=c("Unchecked","Checked")
    levels(data$p_stud_eval___emg.factor)=c("Unchecked","Checked")
    levels(data$p_stud_eval___genetic.factor)=c("Unchecked","Checked")
    levels(data$p_stud_eval___lp.factor)=c("Unchecked","Checked")
    levels(data$p_stud_eval___npsych.factor)=c("Unchecked","Checked")
    levels(data$p_stud_eval___metabolic.factor)=c("Unchecked","Checked")
    levels(data$p_stud_eval___blood.factor)=c("Unchecked","Checked")
    levels(data$p_stud_eval___notsure.factor)=c("Unchecked","Checked")
    levels(data$p_stud_eval___oth.factor)=c("Unchecked","Checked")
    levels(data$p_ha_in_lifetime.factor)=c("1","A few (2 to 4)","Many (5 or more)")
    levels(data$p_current_ha_pattern.factor)=c("Sometimes I have a headache, and sometimes I have no headache.  Also use for constant headache for less than 2 weeks.","Some headache is there all the time, and it doesnt change much.","Some headache is there all the time.  The pain is better sometimes, and worse sometimes.")
    levels(data$p_epi_prec___none.factor)=c("Unchecked","Checked")
    levels(data$p_epi_prec___conc.factor)=c("Unchecked","Checked")
    levels(data$p_epi_prec___oth_inj.factor)=c("Unchecked","Checked")
    levels(data$p_epi_prec___sxg.factor)=c("Unchecked","Checked")
    levels(data$p_epi_prec___infect.factor)=c("Unchecked","Checked")
    levels(data$p_epi_prec___oth_ill.factor)=c("Unchecked","Checked")
    levels(data$p_epi_prec___mens.factor)=c("Unchecked","Checked")
    levels(data$p_epi_prec___stress.factor)=c("Unchecked","Checked")
    levels(data$p_epi_prec___oth.factor)=c("Unchecked","Checked")
    levels(data$p_epi_pattern_change___often.factor)=c("Unchecked","Checked")
    levels(data$p_epi_pattern_change___longer.factor)=c("Unchecked","Checked")
    levels(data$p_epi_pattern_change___none.factor)=c("Unchecked","Checked")
    levels(data$p_epi_inc_fre_prec___none.factor)=c("Unchecked","Checked")
    levels(data$p_epi_inc_fre_prec___conc.factor)=c("Unchecked","Checked")
    levels(data$p_epi_inc_fre_prec___oth_inj.factor)=c("Unchecked","Checked")
    levels(data$p_epi_inc_fre_prec___sxg.factor)=c("Unchecked","Checked")
    levels(data$p_epi_inc_fre_prec___infect.factor)=c("Unchecked","Checked")
    levels(data$p_epi_inc_fre_prec___oth_ill.factor)=c("Unchecked","Checked")
    levels(data$p_epi_inc_fre_prec___mens.factor)=c("Unchecked","Checked")
    levels(data$p_epi_inc_fre_prec___stress.factor)=c("Unchecked","Checked")
    levels(data$p_epi_inc_fre_prec___oth.factor)=c("Unchecked","Checked")
    levels(data$p_epi_inc_fre_time.factor)=c("Less than 2 weeks","2 to 4 weeks","4 to 8 weeks","8 to 12 weeks","3 to 6 months","6 to 12 months","1 to 2 years","2 to 3 years",">3 years")
    levels(data$p_epi_fre.factor)=c("Less than 1 per month","1 to 3 per month","1 per week","2 to 3 per week","More than 3 per week","Daily","Never","Other")
    levels(data$p_epi_fre_dur.factor)=c("< 1 month","1-3 months",">3 months")
    levels(data$p_pattern_to_con.factor)=c("Headaches came more and more often, then constant pain started","Headaches came infreuently, then constant pain started","No headaches, then constant pain started")
    levels(data$p_con_st_epi_prec_ep___none.factor)=c("Unchecked","Checked")
    levels(data$p_con_st_epi_prec_ep___conc.factor)=c("Unchecked","Checked")
    levels(data$p_con_st_epi_prec_ep___oth_inj.factor)=c("Unchecked","Checked")
    levels(data$p_con_st_epi_prec_ep___sxg.factor)=c("Unchecked","Checked")
    levels(data$p_con_st_epi_prec_ep___infect.factor)=c("Unchecked","Checked")
    levels(data$p_con_st_epi_prec_ep___oth_ill.factor)=c("Unchecked","Checked")
    levels(data$p_con_st_epi_prec_ep___mens.factor)=c("Unchecked","Checked")
    levels(data$p_con_st_epi_prec_ep___stress.factor)=c("Unchecked","Checked")
    levels(data$p_con_st_epi_prec_ep___oth.factor)=c("Unchecked","Checked")
    levels(data$p_con_prec___none.factor)=c("Unchecked","Checked")
    levels(data$p_con_prec___conc.factor)=c("Unchecked","Checked")
    levels(data$p_con_prec___oth_inj.factor)=c("Unchecked","Checked")
    levels(data$p_con_prec___sxg.factor)=c("Unchecked","Checked")
    levels(data$p_con_prec___infect.factor)=c("Unchecked","Checked")
    levels(data$p_con_prec___oth_ill.factor)=c("Unchecked","Checked")
    levels(data$p_con_prec___mens.factor)=c("Unchecked","Checked")
    levels(data$p_con_prec___stress.factor)=c("Unchecked","Checked")
    levels(data$p_con_prec___oth.factor)=c("Unchecked","Checked")
    levels(data$p_con_start_epi_time.factor)=c("Less than 2 weeks","2 to 4 weeks","4 to 8 weeks","8 to 12 weeks","3 to 6 months","6 to 12 months","1 to 2 years","2 to 3 years",">3 years")
    levels(data$p_con_pattern_duration.factor)=c("Less than 2 weeks","2 to 4 weeks","4 to 8 weeks","8 to 12 weeks","3 to 6 months","6 to 12 months","1 to 2 years","2 to 3 years",">3 years")
    levels(data$p_fre_bad.factor)=c("Never","Less than 1 per month","1 to 3 per month","1 per week","2 to 3 per week","More than 3 per week","Daily","Always","Other")
    levels(data$p_timing___none.factor)=c("Unchecked","Checked")
    levels(data$p_timing___wake.factor)=c("Unchecked","Checked")
    levels(data$p_timing___morning.factor)=c("Unchecked","Checked")
    levels(data$p_timing___noon.factor)=c("Unchecked","Checked")
    levels(data$p_timing___evening.factor)=c("Unchecked","Checked")
    levels(data$p_timing___night.factor)=c("Unchecked","Checked")
    levels(data$p_timing___sleep.factor)=c("Unchecked","Checked")
    levels(data$p_timing___spring.factor)=c("Unchecked","Checked")
    levels(data$p_timing___summer.factor)=c("Unchecked","Checked")
    levels(data$p_timing___fall.factor)=c("Unchecked","Checked")
    levels(data$p_timing___winter.factor)=c("Unchecked","Checked")
    levels(data$p_timing___mon.factor)=c("Unchecked","Checked")
    levels(data$p_timing___tue.factor)=c("Unchecked","Checked")
    levels(data$p_timing___wed.factor)=c("Unchecked","Checked")
    levels(data$p_timing___thur.factor)=c("Unchecked","Checked")
    levels(data$p_timing___fri.factor)=c("Unchecked","Checked")
    levels(data$p_timing___sat.factor)=c("Unchecked","Checked")
    levels(data$p_timing___sun.factor)=c("Unchecked","Checked")
    levels(data$p_timing_wake_up.factor)=c("Yes","No")
    levels(data$p_ha_quality___throb.factor)=c("Unchecked","Checked")
    levels(data$p_ha_quality___pound.factor)=c("Unchecked","Checked")
    levels(data$p_ha_quality___stab.factor)=c("Unchecked","Checked")
    levels(data$p_ha_quality___pushin.factor)=c("Unchecked","Checked")
    levels(data$p_ha_quality___pushout.factor)=c("Unchecked","Checked")
    levels(data$p_ha_quality___dull.factor)=c("Unchecked","Checked")
    levels(data$p_ha_quality___burn.factor)=c("Unchecked","Checked")
    levels(data$p_ha_quality___sharp.factor)=c("Unchecked","Checked")
    levels(data$p_ha_quality___tight.factor)=c("Unchecked","Checked")
    levels(data$p_ha_quality___pinch.factor)=c("Unchecked","Checked")
    levels(data$p_ha_quality___pulse.factor)=c("Unchecked","Checked")
    levels(data$p_ha_quality___cant_desc.factor)=c("Unchecked","Checked")
    levels(data$p_ha_quality___oth.factor)=c("Unchecked","Checked")
    levels(data$p_location_side___right.factor)=c("Unchecked","Checked")
    levels(data$p_location_side___left.factor)=c("Unchecked","Checked")
    levels(data$p_location_side___both.factor)=c("Unchecked","Checked")
    levels(data$p_location_side___cant_desc.factor)=c("Unchecked","Checked")
    levels(data$p_location_area___sides.factor)=c("Unchecked","Checked")
    levels(data$p_location_area___front.factor)=c("Unchecked","Checked")
    levels(data$p_location_area___top.factor)=c("Unchecked","Checked")
    levels(data$p_location_area___back.factor)=c("Unchecked","Checked")
    levels(data$p_location_area___neck.factor)=c("Unchecked","Checked")
    levels(data$p_location_area___around.factor)=c("Unchecked","Checked")
    levels(data$p_location_area___behind.factor)=c("Unchecked","Checked")
    levels(data$p_location_area___allover.factor)=c("Unchecked","Checked")
    levels(data$p_location_area___oth.factor)=c("Unchecked","Checked")
    levels(data$p_location_area___cant_desc.factor)=c("Unchecked","Checked")
    levels(data$p_sev_overall.factor)=c("Mild","Moderate","Severe")
    levels(data$p_sev_usual.factor)=c("0","1","2","3","4","5","6","7","8","9","10")
    levels(data$p_sev_morning.factor)=c("0","1","2","3","4","5","6","7","8","9","10")
    levels(data$p_sev_hr_after_bed.factor)=c("0","1","2","3","4","5","6","7","8","9","10")
    levels(data$p_sev_rate_rise.factor)=c("I wake up with bad pain.","Seconds","Minutes","Hours","My pain level doesnt change")
    levels(data$p_sev_dur.factor)=c("Seconds","Minutes","Hours","1 to 3 days","More than 3 days")
    levels(data$p_relief_sleep.factor)=c("Yes","No")
    levels(data$p_relief___no.factor)=c("Unchecked","Checked")
    levels(data$p_relief___ice.factor)=c("Unchecked","Checked")
    levels(data$p_relief___heat.factor)=c("Unchecked","Checked")
    levels(data$p_relief___sunglasses.factor)=c("Unchecked","Checked")
    levels(data$p_relief___caffeine.factor)=c("Unchecked","Checked")
    levels(data$p_relief___quiet.factor)=c("Unchecked","Checked")
    levels(data$p_relief___lying_down.factor)=c("Unchecked","Checked")
    levels(data$p_relief___active.factor)=c("Unchecked","Checked")
    levels(data$p_relief___oth.factor)=c("Unchecked","Checked")
    levels(data$p_trigger___none.factor)=c("Unchecked","Checked")
    levels(data$p_trigger___period.factor)=c("Unchecked","Checked")
    levels(data$p_trigger___much_sleep.factor)=c("Unchecked","Checked")
    levels(data$p_trigger___little_sleep.factor)=c("Unchecked","Checked")
    levels(data$p_trigger___fatigue.factor)=c("Unchecked","Checked")
    levels(data$p_trigger___exercise.factor)=c("Unchecked","Checked")
    levels(data$p_trigger___overheat.factor)=c("Unchecked","Checked")
    levels(data$p_trigger___dehyd.factor)=c("Unchecked","Checked")
    levels(data$p_trigger___skip_meals.factor)=c("Unchecked","Checked")
    levels(data$p_trigger___food.factor)=c("Unchecked","Checked")
    levels(data$p_trigger___meds.factor)=c("Unchecked","Checked")
    levels(data$p_trigger___chew.factor)=c("Unchecked","Checked")
    levels(data$p_trigger___stress.factor)=c("Unchecked","Checked")
    levels(data$p_trigger___let_down.factor)=c("Unchecked","Checked")
    levels(data$p_trigger___screen.factor)=c("Unchecked","Checked")
    levels(data$p_trigger___concentrate.factor)=c("Unchecked","Checked")
    levels(data$p_trigger___read.factor)=c("Unchecked","Checked")
    levels(data$p_trigger___light.factor)=c("Unchecked","Checked")
    levels(data$p_trigger___noises.factor)=c("Unchecked","Checked")
    levels(data$p_trigger___smells.factor)=c("Unchecked","Checked")
    levels(data$p_trigger___smoke.factor)=c("Unchecked","Checked")
    levels(data$p_trigger___weather.factor)=c("Unchecked","Checked")
    levels(data$p_trigger___high_alt.factor)=c("Unchecked","Checked")
    levels(data$p_trigger___oth.factor)=c("Unchecked","Checked")
    levels(data$p_allodynia_hurt___none.factor)=c("Unchecked","Checked")
    levels(data$p_allodynia_hurt___ponytail.factor)=c("Unchecked","Checked")
    levels(data$p_allodynia_hurt___comb.factor)=c("Unchecked","Checked")
    levels(data$p_allodynia_hurt___hat.factor)=c("Unchecked","Checked")
    levels(data$p_allodynia_hurt___headphones.factor)=c("Unchecked","Checked")
    levels(data$p_valsalva_position___none.factor)=c("Unchecked","Checked")
    levels(data$p_valsalva_position___sneeze.factor)=c("Unchecked","Checked")
    levels(data$p_valsalva_position___cough.factor)=c("Unchecked","Checked")
    levels(data$p_valsalva_position___laugh.factor)=c("Unchecked","Checked")
    levels(data$p_valsalva_position___stand.factor)=c("Unchecked","Checked")
    levels(data$p_valsalva_position___lie.factor)=c("Unchecked","Checked")
    levels(data$p_valsalva_dur.factor)=c("Just while I sneeze/cough/laugh","A few seconds","Minutes","Hours")
    levels(data$p_activity.factor)=c("No change","Pain gets better","Pain gets worse","I feel like I need to move or pace when I have a headache")
    levels(data$p_assoc_sx_vis___none.factor)=c("Unchecked","Checked")
    levels(data$p_assoc_sx_vis___spot.factor)=c("Unchecked","Checked")
    levels(data$p_assoc_sx_vis___star.factor)=c("Unchecked","Checked")
    levels(data$p_assoc_sx_vis___light.factor)=c("Unchecked","Checked")
    levels(data$p_assoc_sx_vis___zigzag.factor)=c("Unchecked","Checked")
    levels(data$p_assoc_sx_vis___blur.factor)=c("Unchecked","Checked")
    levels(data$p_assoc_sx_vis___double_vis.factor)=c("Unchecked","Checked")
    levels(data$p_assoc_sx_vis___heat.factor)=c("Unchecked","Checked")
    levels(data$p_assoc_sx_vis___loss_vis.factor)=c("Unchecked","Checked")
    levels(data$p_assoc_sx_vis___oth.factor)=c("Unchecked","Checked")
    levels(data$p_assoc_sx_vis___cant_desc.factor)=c("Unchecked","Checked")
    levels(data$p_assoc_sx_neur_bil___none.factor)=c("Unchecked","Checked")
    levels(data$p_assoc_sx_neur_bil___weak.factor)=c("Unchecked","Checked")
    levels(data$p_assoc_sx_neur_bil___numb.factor)=c("Unchecked","Checked")
    levels(data$p_assoc_sx_neur_bil___tingle.factor)=c("Unchecked","Checked")
    levels(data$p_assoc_sx_neur_bil___run_nose.factor)=c("Unchecked","Checked")
    levels(data$p_assoc_sx_neur_bil___tear.factor)=c("Unchecked","Checked")
    levels(data$p_assoc_sx_neur_bil___ptosis.factor)=c("Unchecked","Checked")
    levels(data$p_assoc_sx_neur_bil___red_eye.factor)=c("Unchecked","Checked")
    levels(data$p_assoc_sx_neur_bil___puff_eye.factor)=c("Unchecked","Checked")
    levels(data$p_assoc_sx_neur_bil___flush.factor)=c("Unchecked","Checked")
    levels(data$p_assoc_sx_neur_bil___sweat.factor)=c("Unchecked","Checked")
    levels(data$p_assoc_sx_neur_bil___full_ear.factor)=c("Unchecked","Checked")
    levels(data$p_assoc_sx_neur_bil___oth.factor)=c("Unchecked","Checked")
    levels(data$p_assoc_sx_neur_bil___.factor)=c("Unchecked","Checked")
    levels(data$p_assoc_sx_neur_uni___none.factor)=c("Unchecked","Checked")
    levels(data$p_assoc_sx_neur_uni___weak.factor)=c("Unchecked","Checked")
    levels(data$p_assoc_sx_neur_uni___numb.factor)=c("Unchecked","Checked")
    levels(data$p_assoc_sx_neur_uni___tingle.factor)=c("Unchecked","Checked")
    levels(data$p_assoc_sx_neur_uni___run_nose.factor)=c("Unchecked","Checked")
    levels(data$p_assoc_sx_neur_uni___tear.factor)=c("Unchecked","Checked")
    levels(data$p_assoc_sx_neur_uni___ptosis.factor)=c("Unchecked","Checked")
    levels(data$p_assoc_sx_neur_uni___red_eye.factor)=c("Unchecked","Checked")
    levels(data$p_assoc_sx_neur_uni___puff_eye.factor)=c("Unchecked","Checked")
    levels(data$p_assoc_sx_neur_uni___pupilbig.factor)=c("Unchecked","Checked")
    levels(data$p_assoc_sx_neur_uni___flush.factor)=c("Unchecked","Checked")
    levels(data$p_assoc_sx_neur_uni___sweat.factor)=c("Unchecked","Checked")
    levels(data$p_assoc_sx_neur_uni___full_ear.factor)=c("Unchecked","Checked")
    levels(data$p_assoc_sx_neur_uni___oth.factor)=c("Unchecked","Checked")
    levels(data$p_assoc_sx_gi___none.factor)=c("Unchecked","Checked")
    levels(data$p_assoc_sx_gi___decreased_app.factor)=c("Unchecked","Checked")
    levels(data$p_assoc_sx_gi___diarr.factor)=c("Unchecked","Checked")
    levels(data$p_assoc_sx_gi___naus.factor)=c("Unchecked","Checked")
    levels(data$p_assoc_sx_gi___stom_pain.factor)=c("Unchecked","Checked")
    levels(data$p_assoc_sx_gi___vomiting.factor)=c("Unchecked","Checked")
    levels(data$p_assoc_sx_gi___oth.factor)=c("Unchecked","Checked")
    levels(data$p_assoc_sx_oth_sx___none.factor)=c("Unchecked","Checked")
    levels(data$p_assoc_sx_oth_sx___light.factor)=c("Unchecked","Checked")
    levels(data$p_assoc_sx_oth_sx___smell.factor)=c("Unchecked","Checked")
    levels(data$p_assoc_sx_oth_sx___sound.factor)=c("Unchecked","Checked")
    levels(data$p_assoc_sx_oth_sx___lighthead.factor)=c("Unchecked","Checked")
    levels(data$p_assoc_sx_oth_sx___spinning.factor)=c("Unchecked","Checked")
    levels(data$p_assoc_sx_oth_sx___balance.factor)=c("Unchecked","Checked")
    levels(data$p_assoc_sx_oth_sx___hear.factor)=c("Unchecked","Checked")
    levels(data$p_assoc_sx_oth_sx___ringing.factor)=c("Unchecked","Checked")
    levels(data$p_assoc_sx_oth_sx___unrespons.factor)=c("Unchecked","Checked")
    levels(data$p_assoc_sx_oth_sx___neck_pain.factor)=c("Unchecked","Checked")
    levels(data$p_assoc_sx_oth_sx___think.factor)=c("Unchecked","Checked")
    levels(data$p_assoc_sx_oth_sx___talk.factor)=c("Unchecked","Checked")
    levels(data$p_assoc_sx_oth_sx___oth.factor)=c("Unchecked","Checked")
    levels(data$p_assoc_sx_pul_ear___none.factor)=c("Unchecked","Checked")
    levels(data$p_assoc_sx_pul_ear___standing.factor)=c("Unchecked","Checked")
    levels(data$p_assoc_sx_pul_ear___lying.factor)=c("Unchecked","Checked")
    levels(data$p_assoc_sx_pul_ear___ha_bad.factor)=c("Unchecked","Checked")
    levels(data$p_assoc_sx_pul_ear___oth.factor)=c("Unchecked","Checked")
    levels(data$p_med_stop_ha___none.factor)=c("Unchecked","Checked")
    levels(data$p_med_stop_ha___apap.factor)=c("Unchecked","Checked")
    levels(data$p_med_stop_ha___ibupro.factor)=c("Unchecked","Checked")
    levels(data$p_med_stop_ha___naprox.factor)=c("Unchecked","Checked")
    levels(data$p_med_stop_ha___asp.factor)=c("Unchecked","Checked")
    levels(data$p_med_stop_ha___ketorolac.factor)=c("Unchecked","Checked")
    levels(data$p_med_stop_ha___ketoprof.factor)=c("Unchecked","Checked")
    levels(data$p_med_stop_ha___diclof.factor)=c("Unchecked","Checked")
    levels(data$p_med_stop_ha___celec.factor)=c("Unchecked","Checked")
    levels(data$p_med_stop_ha___exced.factor)=c("Unchecked","Checked")
    levels(data$p_med_stop_ha___butal.factor)=c("Unchecked","Checked")
    levels(data$p_med_stop_ha___midrin.factor)=c("Unchecked","Checked")
    levels(data$p_med_stop_ha___methylpred.factor)=c("Unchecked","Checked")
    levels(data$p_med_stop_ha___pred.factor)=c("Unchecked","Checked")
    levels(data$p_med_stop_ha___suma.factor)=c("Unchecked","Checked")
    levels(data$p_med_stop_ha___riza.factor)=c("Unchecked","Checked")
    levels(data$p_med_stop_ha___nara.factor)=c("Unchecked","Checked")
    levels(data$p_med_stop_ha___almo.factor)=c("Unchecked","Checked")
    levels(data$p_med_stop_ha___frova.factor)=c("Unchecked","Checked")
    levels(data$p_med_stop_ha___eletrip.factor)=c("Unchecked","Checked")
    levels(data$p_med_stop_ha___zolmit.factor)=c("Unchecked","Checked")
    levels(data$p_med_stop_ha___metoclop.factor)=c("Unchecked","Checked")
    levels(data$p_med_stop_ha___proch.factor)=c("Unchecked","Checked")
    levels(data$p_med_stop_ha___prometh.factor)=c("Unchecked","Checked")
    levels(data$p_med_stop_ha___ond.factor)=c("Unchecked","Checked")
    levels(data$p_med_stop_ha___diphen.factor)=c("Unchecked","Checked")
    levels(data$p_med_stop_ha___dhe.factor)=c("Unchecked","Checked")
    levels(data$p_med_stop_ha___tram.factor)=c("Unchecked","Checked")
    levels(data$p_med_stop_ha___t3.factor)=c("Unchecked","Checked")
    levels(data$p_med_stop_ha___morph.factor)=c("Unchecked","Checked")
    levels(data$p_med_stop_ha___hydromor.factor)=c("Unchecked","Checked")
    levels(data$p_med_stop_ha___nb.factor)=c("Unchecked","Checked")
    levels(data$p_med_stop_ha___oth.factor)=c("Unchecked","Checked")
    levels(data$p_when_take_med.factor)=c("before the pain starts, with a warning sign","as soon as the pain starts","when the pain is mild","when the pain is moderate/medium","when the pain is bad","when the pain is much worse than usual")
    levels(data$p_how_oft_med.factor)=c("less than one day a week","1-3 days per week","4 or more days a week","every day")
    levels(data$p_duration_overuse.factor)=c("Less than 1 month","1-3 months",">3 months")
    levels(data$p_med_prev_ha___none.factor)=c("Unchecked","Checked")
    levels(data$p_med_prev_ha___acetaz.factor)=c("Unchecked","Checked")
    levels(data$p_med_prev_ha___amitrip.factor)=c("Unchecked","Checked")
    levels(data$p_med_prev_ha___ateno.factor)=c("Unchecked","Checked")
    levels(data$p_med_prev_ha___botox.factor)=c("Unchecked","Checked")
    levels(data$p_med_prev_ha___cefaly.factor)=c("Unchecked","Checked")
    levels(data$p_med_prev_ha___cypro.factor)=c("Unchecked","Checked")
    levels(data$p_med_prev_ha___doxy.factor)=c("Unchecked","Checked")
    levels(data$p_med_prev_ha___dulox.factor)=c("Unchecked","Checked")
    levels(data$p_med_prev_ha___fluox.factor)=c("Unchecked","Checked")
    levels(data$p_med_prev_ha___gaba.factor)=c("Unchecked","Checked")
    levels(data$p_med_prev_ha___lamotrig.factor)=c("Unchecked","Checked")
    levels(data$p_med_prev_ha___lisin.factor)=c("Unchecked","Checked")
    levels(data$p_med_prev_ha___lvt.factor)=c("Unchecked","Checked")
    levels(data$p_med_prev_ha___metopro.factor)=c("Unchecked","Checked")
    levels(data$p_med_prev_ha___minocy.factor)=c("Unchecked","Checked")
    levels(data$p_med_prev_ha___nb.factor)=c("Unchecked","Checked")
    levels(data$p_med_prev_ha___nebivo.factor)=c("Unchecked","Checked")
    levels(data$p_med_prev_ha___nortrip.factor)=c("Unchecked","Checked")
    levels(data$p_med_prev_ha___pregab.factor)=c("Unchecked","Checked")
    levels(data$p_med_prev_ha___propano.factor)=c("Unchecked","Checked")
    levels(data$p_med_prev_ha___sertra.factor)=c("Unchecked","Checked")
    levels(data$p_med_prev_ha___topa.factor)=c("Unchecked","Checked")
    levels(data$p_med_prev_ha___vpa.factor)=c("Unchecked","Checked")
    levels(data$p_med_prev_ha___venla.factor)=c("Unchecked","Checked")
    levels(data$p_med_prev_ha___verap.factor)=c("Unchecked","Checked")
    levels(data$p_med_prev_ha___zonis.factor)=c("Unchecked","Checked")
    levels(data$p_med_prev_ha___oth.factor)=c("Unchecked","Checked")
    levels(data$p_vit_sup_ha___none.factor)=c("Unchecked","Checked")
    levels(data$p_vit_sup_ha___vitb2.factor)=c("Unchecked","Checked")
    levels(data$p_vit_sup_ha___vitd.factor)=c("Unchecked","Checked")
    levels(data$p_vit_sup_ha___mag.factor)=c("Unchecked","Checked")
    levels(data$p_vit_sup_ha___fishoil.factor)=c("Unchecked","Checked")
    levels(data$p_vit_sup_ha___coenzq10.factor)=c("Unchecked","Checked")
    levels(data$p_vit_sup_ha___feverfew.factor)=c("Unchecked","Checked")
    levels(data$p_vit_sup_ha___melatonin.factor)=c("Unchecked","Checked")
    levels(data$p_vit_sup_ha___butterbur.factor)=c("Unchecked","Checked")
    levels(data$p_vit_sup_ha___oth.factor)=c("Unchecked","Checked")
    levels(data$p_non_med_trea_ha___none.factor)=c("Unchecked","Checked")
    levels(data$p_non_med_trea_ha___acupunc.factor)=c("Unchecked","Checked")
    levels(data$p_non_med_trea_ha___biofeed.factor)=c("Unchecked","Checked")
    levels(data$p_non_med_trea_ha___chirop.factor)=c("Unchecked","Checked")
    levels(data$p_non_med_trea_ha___counsel.factor)=c("Unchecked","Checked")
    levels(data$p_non_med_trea_ha___exercise.factor)=c("Unchecked","Checked")
    levels(data$p_non_med_trea_ha___massage.factor)=c("Unchecked","Checked")
    levels(data$p_non_med_trea_ha___ot.factor)=c("Unchecked","Checked")
    levels(data$p_non_med_trea_ha___osteo.factor)=c("Unchecked","Checked")
    levels(data$p_non_med_trea_ha___pt.factor)=c("Unchecked","Checked")
    levels(data$p_non_med_trea_ha___vision.factor)=c("Unchecked","Checked")
    levels(data$p_non_med_trea_ha___oth.factor)=c("Unchecked","Checked")
    levels(data$p_iv_med_ha___none.factor)=c("Unchecked","Checked")
    levels(data$p_iv_med_ha___ketorolac.factor)=c("Unchecked","Checked")
    levels(data$p_iv_med_ha___metoclop.factor)=c("Unchecked","Checked")
    levels(data$p_iv_med_ha___prochlor.factor)=c("Unchecked","Checked")
    levels(data$p_iv_med_ha___methylpred.factor)=c("Unchecked","Checked")
    levels(data$p_iv_med_ha___dexameth.factor)=c("Unchecked","Checked")
    levels(data$p_iv_med_ha___mag.factor)=c("Unchecked","Checked")
    levels(data$p_iv_med_ha___vpa.factor)=c("Unchecked","Checked")
    levels(data$p_iv_med_ha___diphen.factor)=c("Unchecked","Checked")
    levels(data$p_iv_med_ha___opio.factor)=c("Unchecked","Checked")
    levels(data$p_iv_med_ha___lvt.factor)=c("Unchecked","Checked")
    levels(data$p_iv_med_ha___dhe.factor)=c("Unchecked","Checked")
    levels(data$p_iv_med_ha___ond.factor)=c("Unchecked","Checked")
    levels(data$p_iv_med_ha___oth.factor)=c("Unchecked","Checked")
    levels(data$p_prob_preg_birth.factor)=c("Yes","No")
    levels(data$p_preg_full_term.factor)=c("Full term (at least 37 weeks)","Premature (less than 37 weeks)","unknown")
    levels(data$p_birth_lbs.factor)=c("1 pound","2 pounds","3 pounds","4 pounds","5 pounds","6 pounds","7 pounds","8 pounds","9 pounds","10 pounds","11 pounds","12 pounds","Unknown")
    levels(data$p_birth_oz.factor)=c("0 ounces","1 ounce","2 ounce","3 ounce","4 ounce","5 ounce","6 ounce","7 ounce","8 ounce","9 ounce","10 ounce","11 ounce","12 ounce","13 ounce","14 ounce","15 ounce","Unknown")
    levels(data$p_early_dev_concerns.factor)=c("Yes","No")
    levels(data$p_lost_dev_skill.factor)=c("Yes","No")
    levels(data$p_behav_diff.factor)=c("Yes","No")
    levels(data$p_dom_hand.factor)=c("Right","Left","Both","Not sure")
    levels(data$p_dom_hand_age.factor)=c("< 12 months","13-17 mo","> 18 mo","Other")
    levels(data$p_hosp_overnt.factor)=c("Yes","No")
    levels(data$p_surgery.factor)=c("Yes","No")
    levels(data$p_immun_up_date.factor)=c("Yes","No")
    levels(data$p_overall_prob___none.factor)=c("Unchecked","Checked")
    levels(data$p_overall_prob___wt_loss.factor)=c("Unchecked","Checked")
    levels(data$p_overall_prob___wt_gain.factor)=c("Unchecked","Checked")
    levels(data$p_overall_prob___fever.factor)=c("Unchecked","Checked")
    levels(data$p_overall_prob___fatigue.factor)=c("Unchecked","Checked")
    levels(data$p_overall_prob___ftt.factor)=c("Unchecked","Checked")
    levels(data$p_overall_prob___oth.factor)=c("Unchecked","Checked")
    levels(data$p_eye_prob___none.factor)=c("Unchecked","Checked")
    levels(data$p_eye_prob___glasses.factor)=c("Unchecked","Checked")
    levels(data$p_eye_prob___outward_eyes.factor)=c("Unchecked","Checked")
    levels(data$p_eye_prob___inward_eyes.factor)=c("Unchecked","Checked")
    levels(data$p_eye_prob___eye_movt.factor)=c("Unchecked","Checked")
    levels(data$p_eye_prob___prob_seeing.factor)=c("Unchecked","Checked")
    levels(data$p_eye_prob___blind.factor)=c("Unchecked","Checked")
    levels(data$p_eye_prob___oth.factor)=c("Unchecked","Checked")
    levels(data$p_ent_prob___none.factor)=c("Unchecked","Checked")
    levels(data$p_ent_prob___hearing.factor)=c("Unchecked","Checked")
    levels(data$p_ent_prob___deafness.factor)=c("Unchecked","Checked")
    levels(data$p_ent_prob___ear_infec.factor)=c("Unchecked","Checked")
    levels(data$p_ent_prob___sinus_infec.factor)=c("Unchecked","Checked")
    levels(data$p_ent_prob___ringing.factor)=c("Unchecked","Checked")
    levels(data$p_ent_prob___dizzy.factor)=c("Unchecked","Checked")
    levels(data$p_ent_prob___tracheo.factor)=c("Unchecked","Checked")
    levels(data$p_ent_prob___nose_bleed.factor)=c("Unchecked","Checked")
    levels(data$p_ent_prob___mouth_sore.factor)=c("Unchecked","Checked")
    levels(data$p_ent_prob___oth.factor)=c("Unchecked","Checked")
    levels(data$p_heart_prob___none.factor)=c("Unchecked","Checked")
    levels(data$p_heart_prob___murmur.factor)=c("Unchecked","Checked")
    levels(data$p_heart_prob___chd.factor)=c("Unchecked","Checked")
    levels(data$p_heart_prob___high_blood.factor)=c("Unchecked","Checked")
    levels(data$p_heart_prob___faint.factor)=c("Unchecked","Checked")
    levels(data$p_heart_prob___irreg_beat.factor)=c("Unchecked","Checked")
    levels(data$p_heart_prob___easy_tired.factor)=c("Unchecked","Checked")
    levels(data$p_heart_prob___pots.factor)=c("Unchecked","Checked")
    levels(data$p_heart_prob___chest_pain.factor)=c("Unchecked","Checked")
    levels(data$p_heart_prob___oth.factor)=c("Unchecked","Checked")
    levels(data$p_lung_prob___none.factor)=c("Unchecked","Checked")
    levels(data$p_lung_prob___asthma.factor)=c("Unchecked","Checked")
    levels(data$p_lung_prob___apnea.factor)=c("Unchecked","Checked")
    levels(data$p_lung_prob___pneum.factor)=c("Unchecked","Checked")
    levels(data$p_lung_prob___cough.factor)=c("Unchecked","Checked")
    levels(data$p_lung_prob___sob.factor)=c("Unchecked","Checked")
    levels(data$p_lung_prob___cpap.factor)=c("Unchecked","Checked")
    levels(data$p_lung_prob___oth.factor)=c("Unchecked","Checked")
    levels(data$p_sleep_prob___none.factor)=c("Unchecked","Checked")
    levels(data$p_sleep_prob___apnea.factor)=c("Unchecked","Checked")
    levels(data$p_sleep_prob___snore.factor)=c("Unchecked","Checked")
    levels(data$p_sleep_prob___fall_asleep.factor)=c("Unchecked","Checked")
    levels(data$p_sleep_prob___stay_asleep.factor)=c("Unchecked","Checked")
    levels(data$p_sleep_prob___pm_terror.factor)=c("Unchecked","Checked")
    levels(data$p_sleep_prob___day_drowsy.factor)=c("Unchecked","Checked")
    levels(data$p_sleep_prob___oth.factor)=c("Unchecked","Checked")
    levels(data$p_gi_prob___none.factor)=c("Unchecked","Checked")
    levels(data$p_gi_prob___reflux.factor)=c("Unchecked","Checked")
    levels(data$p_gi_prob___nausea.factor)=c("Unchecked","Checked")
    levels(data$p_gi_prob___constipa.factor)=c("Unchecked","Checked")
    levels(data$p_gi_prob___diarrhea.factor)=c("Unchecked","Checked")
    levels(data$p_gi_prob___abd_pain.factor)=c("Unchecked","Checked")
    levels(data$p_gi_prob___tube.factor)=c("Unchecked","Checked")
    levels(data$p_gi_prob___oth.factor)=c("Unchecked","Checked")
    levels(data$p_gu_prob___none.factor)=c("Unchecked","Checked")
    levels(data$p_gu_prob___kidney.factor)=c("Unchecked","Checked")
    levels(data$p_gu_prob___fre_uti.factor)=c("Unchecked","Checked")
    levels(data$p_gu_prob___urine_prob.factor)=c("Unchecked","Checked")
    levels(data$p_gu_prob___menstrual.factor)=c("Unchecked","Checked")
    levels(data$p_gu_prob___enuresis.factor)=c("Unchecked","Checked")
    levels(data$p_gu_prob___incont.factor)=c("Unchecked","Checked")
    levels(data$p_gu_prob___oth.factor)=c("Unchecked","Checked")
    levels(data$p_musc_prob___none.factor)=c("Unchecked","Checked")
    levels(data$p_musc_prob___joint_pain.factor)=c("Unchecked","Checked")
    levels(data$p_musc_prob___neck_pain.factor)=c("Unchecked","Checked")
    levels(data$p_musc_prob___back_pain.factor)=c("Unchecked","Checked")
    levels(data$p_musc_prob___scolio.factor)=c("Unchecked","Checked")
    levels(data$p_musc_prob___muscle_weak.factor)=c("Unchecked","Checked")
    levels(data$p_musc_prob___osteopenia.factor)=c("Unchecked","Checked")
    levels(data$p_musc_prob___oth.factor)=c("Unchecked","Checked")
    levels(data$p_skin_prob___none.factor)=c("Unchecked","Checked")
    levels(data$p_skin_prob___eczema.factor)=c("Unchecked","Checked")
    levels(data$p_skin_prob___birthmark.factor)=c("Unchecked","Checked")
    levels(data$p_skin_prob___rash.factor)=c("Unchecked","Checked")
    levels(data$p_skin_prob___acne.factor)=c("Unchecked","Checked")
    levels(data$p_skin_prob___oth.factor)=c("Unchecked","Checked")
    levels(data$p_endo_prob___none.factor)=c("Unchecked","Checked")
    levels(data$p_endo_prob___thyroid.factor)=c("Unchecked","Checked")
    levels(data$p_endo_prob___diab.factor)=c("Unchecked","Checked")
    levels(data$p_endo_prob___grow_prob.factor)=c("Unchecked","Checked")
    levels(data$p_endo_prob___puberty.factor)=c("Unchecked","Checked")
    levels(data$p_endo_prob___oth.factor)=c("Unchecked","Checked")
    levels(data$p_hema_prob___none.factor)=c("Unchecked","Checked")
    levels(data$p_hema_prob___sickle.factor)=c("Unchecked","Checked")
    levels(data$p_hema_prob___anemia.factor)=c("Unchecked","Checked")
    levels(data$p_hema_prob___abnl_bleed.factor)=c("Unchecked","Checked")
    levels(data$p_hema_prob___bruise.factor)=c("Unchecked","Checked")
    levels(data$p_hema_prob___bleed.factor)=c("Unchecked","Checked")
    levels(data$p_hema_prob___cancer.factor)=c("Unchecked","Checked")
    levels(data$p_hema_prob___oth.factor)=c("Unchecked","Checked")
    levels(data$p_hema_prob___.factor)=c("Unchecked","Checked")
    levels(data$p_immu_prob___none.factor)=c("Unchecked","Checked")
    levels(data$p_immu_prob___allergies.factor)=c("Unchecked","Checked")
    levels(data$p_immu_prob___lupus.factor)=c("Unchecked","Checked")
    levels(data$p_immu_prob___arth.factor)=c("Unchecked","Checked")
    levels(data$p_immu_prob___imm_def.factor)=c("Unchecked","Checked")
    levels(data$p_immu_prob___fre_ill.factor)=c("Unchecked","Checked")
    levels(data$p_immu_prob___autoimmune.factor)=c("Unchecked","Checked")
    levels(data$p_immu_prob___oth.factor)=c("Unchecked","Checked")
    levels(data$p_psych_prob___none.factor)=c("Unchecked","Checked")
    levels(data$p_psych_prob___adhd.factor)=c("Unchecked","Checked")
    levels(data$p_psych_prob___anxiety.factor)=c("Unchecked","Checked")
    levels(data$p_psych_prob___depress.factor)=c("Unchecked","Checked")
    levels(data$p_psych_prob___behavior.factor)=c("Unchecked","Checked")
    levels(data$p_psych_prob___odd.factor)=c("Unchecked","Checked")
    levels(data$p_psych_prob___ocd.factor)=c("Unchecked","Checked")
    levels(data$p_psych_prob___pdd.factor)=c("Unchecked","Checked")
    levels(data$p_psych_prob___sw.factor)=c("Unchecked","Checked")
    levels(data$p_psych_prob___psychol.factor)=c("Unchecked","Checked")
    levels(data$p_psych_prob___psychi.factor)=c("Unchecked","Checked")
    levels(data$p_psych_prob___oth.factor)=c("Unchecked","Checked")
    levels(data$p_psych_prob___.factor)=c("Unchecked","Checked")
    levels(data$p_neur_prob___none.factor)=c("Unchecked","Checked")
    levels(data$p_neur_prob___seiz_epil.factor)=c("Unchecked","Checked")
    levels(data$p_neur_prob___ha.factor)=c("Unchecked","Checked")
    levels(data$p_neur_prob___tics.factor)=c("Unchecked","Checked")
    levels(data$p_neur_prob___stroke.factor)=c("Unchecked","Checked")
    levels(data$p_neur_prob___learn.factor)=c("Unchecked","Checked")
    levels(data$p_neur_prob___neuromus.factor)=c("Unchecked","Checked")
    levels(data$p_neur_prob___devt_prob.factor)=c("Unchecked","Checked")
    levels(data$p_neur_prob___concentrate.factor)=c("Unchecked","Checked")
    levels(data$p_neur_prob___balance.factor)=c("Unchecked","Checked")
    levels(data$p_neur_prob___mening.factor)=c("Unchecked","Checked")
    levels(data$p_neur_prob___conc.factor)=c("Unchecked","Checked")
    levels(data$p_neur_prob___enceph.factor)=c("Unchecked","Checked")
    levels(data$p_neur_prob___numb.factor)=c("Unchecked","Checked")
    levels(data$p_neur_prob___motion_sick.factor)=c("Unchecked","Checked")
    levels(data$p_neur_prob___oth.factor)=c("Unchecked","Checked")
    levels(data$p_curr_interven___none.factor)=c("Unchecked","Checked")
    levels(data$p_curr_interven___pt.factor)=c("Unchecked","Checked")
    levels(data$p_curr_interven___ot.factor)=c("Unchecked","Checked")
    levels(data$p_curr_interven___speech.factor)=c("Unchecked","Checked")
    levels(data$p_curr_interven___behavior.factor)=c("Unchecked","Checked")
    levels(data$p_curr_interven___vision.factor)=c("Unchecked","Checked")
    levels(data$p_curr_interven___feeding.factor)=c("Unchecked","Checked")
    levels(data$p_curr_interven___develop.factor)=c("Unchecked","Checked")
    levels(data$p_past_interven___none.factor)=c("Unchecked","Checked")
    levels(data$p_past_interven___pt.factor)=c("Unchecked","Checked")
    levels(data$p_past_interven___ot.factor)=c("Unchecked","Checked")
    levels(data$p_past_interven___speech.factor)=c("Unchecked","Checked")
    levels(data$p_past_interven___behavior.factor)=c("Unchecked","Checked")
    levels(data$p_past_interven___vision.factor)=c("Unchecked","Checked")
    levels(data$p_past_interven___feeding.factor)=c("Unchecked","Checked")
    levels(data$p_past_interven___develop.factor)=c("Unchecked","Checked")
    levels(data$p_ha_psych_ques.factor)=c("Yes","No")
    levels(data$p_fam_hist_dev___none.factor)=c("Unchecked","Checked")
    levels(data$p_fam_hist_dev___devt_delay.factor)=c("Unchecked","Checked")
    levels(data$p_fam_hist_dev___learn.factor)=c("Unchecked","Checked")
    levels(data$p_fam_hist_dev___mental.factor)=c("Unchecked","Checked")
    levels(data$p_fam_hist_dev___autistic.factor)=c("Unchecked","Checked")
    levels(data$p_fam_hist_dev___oth.factor)=c("Unchecked","Checked")
    levels(data$p_fam_hist_behav___none.factor)=c("Unchecked","Checked")
    levels(data$p_fam_hist_behav___add.factor)=c("Unchecked","Checked")
    levels(data$p_fam_hist_behav___depress.factor)=c("Unchecked","Checked")
    levels(data$p_fam_hist_behav___anx.factor)=c("Unchecked","Checked")
    levels(data$p_fam_hist_behav___sub_abuse.factor)=c("Unchecked","Checked")
    levels(data$p_fam_hist_behav___bipolar.factor)=c("Unchecked","Checked")
    levels(data$p_fam_hist_behav___oth.factor)=c("Unchecked","Checked")
    levels(data$p_fam_hist_neuro___none.factor)=c("Unchecked","Checked")
    levels(data$p_fam_hist_neuro___ha.factor)=c("Unchecked","Checked")
    levels(data$p_fam_hist_neuro___mig.factor)=c("Unchecked","Checked")
    levels(data$p_fam_hist_neuro___seiz.factor)=c("Unchecked","Checked")
    levels(data$p_fam_hist_neuro___epi.factor)=c("Unchecked","Checked")
    levels(data$p_fam_hist_neuro___tics.factor)=c("Unchecked","Checked")
    levels(data$p_fam_hist_neuro___tourette.factor)=c("Unchecked","Checked")
    levels(data$p_fam_hist_neuro___ms.factor)=c("Unchecked","Checked")
    levels(data$p_fam_hist_neuro___neuromus.factor)=c("Unchecked","Checked")
    levels(data$p_fam_hist_neuro___aneurysm.factor)=c("Unchecked","Checked")
    levels(data$p_fam_hist_neuro___vascular.factor)=c("Unchecked","Checked")
    levels(data$p_fam_hist_neuro___stroke.factor)=c("Unchecked","Checked")
    levels(data$p_fam_hist_neuro___tumor.factor)=c("Unchecked","Checked")
    levels(data$p_fam_hist_neuro___oth.factor)=c("Unchecked","Checked")
    levels(data$p_fam_hist_med___none.factor)=c("Unchecked","Checked")
    levels(data$p_fam_hist_med___bleed.factor)=c("Unchecked","Checked")
    levels(data$p_fam_hist_med___venous_throm.factor)=c("Unchecked","Checked")
    levels(data$p_fam_hist_med___pulm_emb.factor)=c("Unchecked","Checked")
    levels(data$p_fam_hist_med___miscarriage.factor)=c("Unchecked","Checked")
    levels(data$p_fam_hist_med___autoimmune.factor)=c("Unchecked","Checked")
    levels(data$p_fam_hist_med___gene.factor)=c("Unchecked","Checked")
    levels(data$p_fam_hist_med___early_deaths.factor)=c("Unchecked","Checked")
    levels(data$p_fam_hist_med___hear_loss.factor)=c("Unchecked","Checked")
    levels(data$p_fam_hist_med___vision_loss.factor)=c("Unchecked","Checked")
    levels(data$p_fam_hist_med___heart_disease.factor)=c("Unchecked","Checked")
    levels(data$p_fam_hist_med___pots.factor)=c("Unchecked","Checked")
    levels(data$p_fam_hist_med___high_blood.factor)=c("Unchecked","Checked")
    levels(data$p_fam_hist_med___high_choles.factor)=c("Unchecked","Checked")
    levels(data$p_fam_hist_med___obese.factor)=c("Unchecked","Checked")
    levels(data$p_fam_hist_med___cancer.factor)=c("Unchecked","Checked")
    levels(data$p_fam_hist_med___thyroid.factor)=c("Unchecked","Checked")
    levels(data$p_fam_hist_med___oth.factor)=c("Unchecked","Checked")
    levels(data$p_lives_w_child___mom.factor)=c("Unchecked","Checked")
    levels(data$p_lives_w_child___dad.factor)=c("Unchecked","Checked")
    levels(data$p_lives_w_child___sibling.factor)=c("Unchecked","Checked")
    levels(data$p_lives_w_child___grand_par.factor)=c("Unchecked","Checked")
    levels(data$p_lives_w_child___aunt_unc.factor)=c("Unchecked","Checked")
    levels(data$p_lives_w_child___step_par.factor)=c("Unchecked","Checked")
    levels(data$p_lives_w_child___foster_par.factor)=c("Unchecked","Checked")
    levels(data$p_lives_w_child___facility.factor)=c("Unchecked","Checked")
    levels(data$p_lives_w_child___oth.factor)=c("Unchecked","Checked")
    levels(data$p_legal_decision___parent.factor)=c("Unchecked","Checked")
    levels(data$p_legal_decision___mom.factor)=c("Unchecked","Checked")
    levels(data$p_legal_decision___dad.factor)=c("Unchecked","Checked")
    levels(data$p_legal_decision___grandma.factor)=c("Unchecked","Checked")
    levels(data$p_legal_decision___grandpa.factor)=c("Unchecked","Checked")
    levels(data$p_legal_decision___grandprnt.factor)=c("Unchecked","Checked")
    levels(data$p_legal_decision___fosterpar.factor)=c("Unchecked","Checked")
    levels(data$p_legal_decision___dhs_dyfs.factor)=c("Unchecked","Checked")
    levels(data$p_legal_decision___oth.factor)=c("Unchecked","Checked")
    levels(data$p_recent_change.factor)=c("Yes","No")
    levels(data$p_school_type.factor)=c("Daycare","Preschool","Babysitter","Kindergarten","1st grade","2nd grade","3rd grade","4th grade","5th grade","6th grade","7th grade","8th grade","9th grade","10th grade","11th grade","12th grade","13 (first year of college)","14 (second year of college)","15 (third year of college)","16 (senior year of college or beyond)","Special Education","Homeschool","Homebound instruction","Cyber school","Vocational/Technical","Other")
    levels(data$p_school_concerns.factor)=c("Yes","No")
    levels(data$p_iep_504.factor)=c("IEP","504","Neither","Unsure")
    levels(data$patient_ha_complete.factor)=c("Incomplete","Unverified","Complete")
    levels(data$c_reason_for_visit.factor)=c("Headache","Other")
    levels(data$c_visit_type.factor)=c("New Patient Visit","Consultation","Second Opinion","Follow-Up Visit","Hospital Follow-Up")
    levels(data$c_prov_seen___none.factor)=c("Unchecked","Checked")
    levels(data$c_prov_seen___pcp.factor)=c("Unchecked","Checked")
    levels(data$c_prov_seen___neuro.factor)=c("Unchecked","Checked")
    levels(data$c_prov_seen___eye.factor)=c("Unchecked","Checked")
    levels(data$c_prov_seen___ent.factor)=c("Unchecked","Checked")
    levels(data$c_prov_seen___allergy.factor)=c("Unchecked","Checked")
    levels(data$c_prov_seen___conc.factor)=c("Unchecked","Checked")
    levels(data$c_prov_seen___nsg.factor)=c("Unchecked","Checked")
    levels(data$c_prov_seen___gi.factor)=c("Unchecked","Checked")
    levels(data$c_prov_seen___osteo.factor)=c("Unchecked","Checked")
    levels(data$c_prov_seen___onco.factor)=c("Unchecked","Checked")
    levels(data$c_prov_seen___cardio.factor)=c("Unchecked","Checked")
    levels(data$c_prov_seen___psych.factor)=c("Unchecked","Checked")
    levels(data$c_prov_seen___psychol.factor)=c("Unchecked","Checked")
    levels(data$c_prov_seen___couns.factor)=c("Unchecked","Checked")
    levels(data$c_prov_seen___ed.factor)=c("Unchecked","Checked")
    levels(data$c_prov_seen___oth.factor)=c("Unchecked","Checked")
    levels(data$c_stud_eval___none.factor)=c("Unchecked","Checked")
    levels(data$c_stud_eval___brain.factor)=c("Unchecked","Checked")
    levels(data$c_stud_eval___spine.factor)=c("Unchecked","Checked")
    levels(data$c_stud_eval___ct.factor)=c("Unchecked","Checked")
    levels(data$c_stud_eval___eeg.factor)=c("Unchecked","Checked")
    levels(data$c_stud_eval___emg.factor)=c("Unchecked","Checked")
    levels(data$c_stud_eval___genetic.factor)=c("Unchecked","Checked")
    levels(data$c_stud_eval___lp.factor)=c("Unchecked","Checked")
    levels(data$c_stud_eval___npsych.factor)=c("Unchecked","Checked")
    levels(data$c_stud_eval___metabolic.factor)=c("Unchecked","Checked")
    levels(data$c_stud_eval___blood.factor)=c("Unchecked","Checked")
    levels(data$c_stud_eval___notsure.factor)=c("Unchecked","Checked")
    levels(data$c_stud_eval___oth.factor)=c("Unchecked","Checked")
    levels(data$c_ha_in_lifetime.factor)=c("1","A few (2 to 4)","Many (5 or more)")
    levels(data$c_current_ha_pattern.factor)=c("Sometimes I have a headache, and sometimes I have no headache.  Also use for constant headache for less than 2 weeks.","Some headache is there all the time, and it doesnt change much.","Some headache is there all the time.  The pain is better sometimes, and worse sometimes.")
    levels(data$c_epi_prec___none.factor)=c("Unchecked","Checked")
    levels(data$c_epi_prec___conc.factor)=c("Unchecked","Checked")
    levels(data$c_epi_prec___oth_inj.factor)=c("Unchecked","Checked")
    levels(data$c_epi_prec___sxg.factor)=c("Unchecked","Checked")
    levels(data$c_epi_prec___infect.factor)=c("Unchecked","Checked")
    levels(data$c_epi_prec___oth_ill.factor)=c("Unchecked","Checked")
    levels(data$c_epi_prec___mens.factor)=c("Unchecked","Checked")
    levels(data$c_epi_prec___stress.factor)=c("Unchecked","Checked")
    levels(data$c_epi_prec___oth.factor)=c("Unchecked","Checked")
    levels(data$c_epi_conc_moi.factor)=c("fell and hit","struck by object","playing sports","motor vehicle accident","bike accident","as a pedestrian struck by a vehicle","other")
    levels(data$c_epi_conc_sport.factor)=c("football","ice hockey","soccer","lacrosse","baseball","softball","volleyball","basketball","field hockey","wrestling","skiing","cheerleading","martial arts","other")
    levels(data$c_epi_pattern_change___often.factor)=c("Unchecked","Checked")
    levels(data$c_epi_pattern_change___longer.factor)=c("Unchecked","Checked")
    levels(data$c_epi_pattern_change___none.factor)=c("Unchecked","Checked")
    levels(data$c_epi_inc_fre_prec___none.factor)=c("Unchecked","Checked")
    levels(data$c_epi_inc_fre_prec___conc.factor)=c("Unchecked","Checked")
    levels(data$c_epi_inc_fre_prec___oth_inj.factor)=c("Unchecked","Checked")
    levels(data$c_epi_inc_fre_prec___sxg.factor)=c("Unchecked","Checked")
    levels(data$c_epi_inc_fre_prec___infect.factor)=c("Unchecked","Checked")
    levels(data$c_epi_inc_fre_prec___oth_ill.factor)=c("Unchecked","Checked")
    levels(data$c_epi_inc_fre_prec___mens.factor)=c("Unchecked","Checked")
    levels(data$c_epi_inc_fre_prec___stress.factor)=c("Unchecked","Checked")
    levels(data$c_epi_inc_fre_prec___oth.factor)=c("Unchecked","Checked")
    levels(data$c_epi_inc_fre_conc_moi.factor)=c("fell and hit","struck by object","playing sports","motor vehicle accident","bike accident","as a pedestrian struck by a vehicle","other")
    levels(data$c_epi_inc_fre_conc_sport.factor)=c("football","ice hockey","soccer","lacrosse","baseball","softball","volleyball","basketball","field hockey","wrestling","skiing","cheerleading","martial arts","other")
    levels(data$c_epi_inc_fre_time.factor)=c("Less than 2 weeks","2 to 4 weeks","4 to 8 weeks","8 to 12 weeks","3 to 6 months","6 to 12 months","1 to 2 years","2 to 3 years",">3 years")
    levels(data$c_epi_fre.factor)=c("Less than 1 per month","1 to 3 per month","1 per week","2 to 3 per week","More than 3 per week","Daily","Never","Other")
    levels(data$c_epi_fre_dur.factor)=c("< 1 month","1-3 months",">3 months")
    levels(data$c_pattern_to_con.factor)=c("Headaches came more and more often, then constant pain started","Headaches came infreuently, then constant pain started","No headaches, then constant pain started")
    levels(data$c_con_st_epi_prec_ep___none.factor)=c("Unchecked","Checked")
    levels(data$c_con_st_epi_prec_ep___conc.factor)=c("Unchecked","Checked")
    levels(data$c_con_st_epi_prec_ep___oth_inj.factor)=c("Unchecked","Checked")
    levels(data$c_con_st_epi_prec_ep___sxg.factor)=c("Unchecked","Checked")
    levels(data$c_con_st_epi_prec_ep___infect.factor)=c("Unchecked","Checked")
    levels(data$c_con_st_epi_prec_ep___oth_ill.factor)=c("Unchecked","Checked")
    levels(data$c_con_st_epi_prec_ep___mens.factor)=c("Unchecked","Checked")
    levels(data$c_con_st_epi_prec_ep___stress.factor)=c("Unchecked","Checked")
    levels(data$c_con_st_epi_prec_ep___oth.factor)=c("Unchecked","Checked")
    levels(data$c_con_st_epi_conc_moi.factor)=c("fell and hit","struck by object","playing sports","motor vehicle accident","bike accident","as a pedestrian struck by a vehicle","other")
    levels(data$c_con_st_epi_conc_sport.factor)=c("football","ice hockey","soccer","lacrosse","baseball","softball","volleyball","basketball","field hockey","wrestling","skiing","cheerleading","martial arts","other")
    levels(data$c_con_prec___none.factor)=c("Unchecked","Checked")
    levels(data$c_con_prec___conc.factor)=c("Unchecked","Checked")
    levels(data$c_con_prec___oth_inj.factor)=c("Unchecked","Checked")
    levels(data$c_con_prec___sxg.factor)=c("Unchecked","Checked")
    levels(data$c_con_prec___infect.factor)=c("Unchecked","Checked")
    levels(data$c_con_prec___oth_ill.factor)=c("Unchecked","Checked")
    levels(data$c_con_prec___mens.factor)=c("Unchecked","Checked")
    levels(data$c_con_prec___stress.factor)=c("Unchecked","Checked")
    levels(data$c_con_prec___oth.factor)=c("Unchecked","Checked")
    levels(data$c_con_conc_moi.factor)=c("fell and hit","struck by object","playing sports","motor vehicle accident","bike accident","as a pedestrian struck by a vehicle","other")
    levels(data$c_con_conc_sport.factor)=c("football","ice hockey","soccer","lacrosse","baseball","softball","volleyball","basketball","field hockey","wrestling","skiing","cheerleading","martial arts","other")
    levels(data$c_con_start_epi_time.factor)=c("Less than 2 weeks","2 to 4 weeks","4 to 8 weeks","8 to 12 weeks","3 to 6 months","6 to 12 months","1 to 2 years","2 to 3 years",">3 years")
    levels(data$c_con_pattern_duration.factor)=c("Less than 2 weeks","2 to 4 weeks","4 to 8 weeks","8 to 12 weeks","3 to 6 months","6 to 12 months","1 to 2 years","2 to 3 years",">3 years")
    levels(data$c_fre_bad.factor)=c("Never","Less than 1 per month","1 to 3 per month","1 per week","2 to 3 per week","More than 3 per week","Daily","Always","Other")
    levels(data$c_timing___none.factor)=c("Unchecked","Checked")
    levels(data$c_timing___wake.factor)=c("Unchecked","Checked")
    levels(data$c_timing___morning.factor)=c("Unchecked","Checked")
    levels(data$c_timing___noon.factor)=c("Unchecked","Checked")
    levels(data$c_timing___evening.factor)=c("Unchecked","Checked")
    levels(data$c_timing___night.factor)=c("Unchecked","Checked")
    levels(data$c_timing___sleep.factor)=c("Unchecked","Checked")
    levels(data$c_timing___spring.factor)=c("Unchecked","Checked")
    levels(data$c_timing___summer.factor)=c("Unchecked","Checked")
    levels(data$c_timing___fall.factor)=c("Unchecked","Checked")
    levels(data$c_timing___winter.factor)=c("Unchecked","Checked")
    levels(data$c_timing___mon.factor)=c("Unchecked","Checked")
    levels(data$c_timing___tue.factor)=c("Unchecked","Checked")
    levels(data$c_timing___wed.factor)=c("Unchecked","Checked")
    levels(data$c_timing___thur.factor)=c("Unchecked","Checked")
    levels(data$c_timing___fri.factor)=c("Unchecked","Checked")
    levels(data$c_timing___sat.factor)=c("Unchecked","Checked")
    levels(data$c_timing___sun.factor)=c("Unchecked","Checked")
    levels(data$c_timing_wake_up.factor)=c("Yes","No")
    levels(data$c_ha_quality___throb.factor)=c("Unchecked","Checked")
    levels(data$c_ha_quality___pound.factor)=c("Unchecked","Checked")
    levels(data$c_ha_quality___stab.factor)=c("Unchecked","Checked")
    levels(data$c_ha_quality___pushin.factor)=c("Unchecked","Checked")
    levels(data$c_ha_quality___pushout.factor)=c("Unchecked","Checked")
    levels(data$c_ha_quality___dull.factor)=c("Unchecked","Checked")
    levels(data$c_ha_quality___burn.factor)=c("Unchecked","Checked")
    levels(data$c_ha_quality___sharp.factor)=c("Unchecked","Checked")
    levels(data$c_ha_quality___tight.factor)=c("Unchecked","Checked")
    levels(data$c_ha_quality___pinch.factor)=c("Unchecked","Checked")
    levels(data$c_ha_quality___pulse.factor)=c("Unchecked","Checked")
    levels(data$c_ha_quality___cant_desc.factor)=c("Unchecked","Checked")
    levels(data$c_ha_quality___oth.factor)=c("Unchecked","Checked")
    levels(data$c_location_side___right.factor)=c("Unchecked","Checked")
    levels(data$c_location_side___left.factor)=c("Unchecked","Checked")
    levels(data$c_location_side___both.factor)=c("Unchecked","Checked")
    levels(data$c_location_side___cant_desc.factor)=c("Unchecked","Checked")
    levels(data$c_location_area___sides.factor)=c("Unchecked","Checked")
    levels(data$c_location_area___front.factor)=c("Unchecked","Checked")
    levels(data$c_location_area___top.factor)=c("Unchecked","Checked")
    levels(data$c_location_area___back.factor)=c("Unchecked","Checked")
    levels(data$c_location_area___neck.factor)=c("Unchecked","Checked")
    levels(data$c_location_area___around.factor)=c("Unchecked","Checked")
    levels(data$c_location_area___behind.factor)=c("Unchecked","Checked")
    levels(data$c_location_area___allover.factor)=c("Unchecked","Checked")
    levels(data$c_location_area___oth.factor)=c("Unchecked","Checked")
    levels(data$c_location_area___cant_desc.factor)=c("Unchecked","Checked")
    levels(data$c_sev_overall.factor)=c("Mild","Moderate","Severe")
    levels(data$c_sev_usual.factor)=c("0","1","2","3","4","5","6","7","8","9","10")
    levels(data$c_sev_morning.factor)=c("0","1","2","3","4","5","6","7","8","9","10")
    levels(data$c_sev_hr_after_bed.factor)=c("0","1","2","3","4","5","6","7","8","9","10")
    levels(data$c_sev_rate_rise.factor)=c("I wake up with bad pain.","Seconds","Minutes","Hours","My pain level doesnt change")
    levels(data$c_sev_dur.factor)=c("Seconds","Minutes","Hours","1 to 3 days","More than 3 days")
    levels(data$c_relief_sleep.factor)=c("Yes","No")
    levels(data$c_relief___no.factor)=c("Unchecked","Checked")
    levels(data$c_relief___ice.factor)=c("Unchecked","Checked")
    levels(data$c_relief___heat.factor)=c("Unchecked","Checked")
    levels(data$c_relief___sunglasses.factor)=c("Unchecked","Checked")
    levels(data$c_relief___caffeine.factor)=c("Unchecked","Checked")
    levels(data$c_relief___quiet.factor)=c("Unchecked","Checked")
    levels(data$c_relief___lying_down.factor)=c("Unchecked","Checked")
    levels(data$c_relief___active.factor)=c("Unchecked","Checked")
    levels(data$c_relief___oth.factor)=c("Unchecked","Checked")
    levels(data$c_trigger___none.factor)=c("Unchecked","Checked")
    levels(data$c_trigger___period.factor)=c("Unchecked","Checked")
    levels(data$c_trigger___much_sleep.factor)=c("Unchecked","Checked")
    levels(data$c_trigger___little_sleep.factor)=c("Unchecked","Checked")
    levels(data$c_trigger___fatigue.factor)=c("Unchecked","Checked")
    levels(data$c_trigger___exercise.factor)=c("Unchecked","Checked")
    levels(data$c_trigger___overheat.factor)=c("Unchecked","Checked")
    levels(data$c_trigger___dehyd.factor)=c("Unchecked","Checked")
    levels(data$c_trigger___skip_meals.factor)=c("Unchecked","Checked")
    levels(data$c_trigger___food.factor)=c("Unchecked","Checked")
    levels(data$c_trigger___meds.factor)=c("Unchecked","Checked")
    levels(data$c_trigger___chew.factor)=c("Unchecked","Checked")
    levels(data$c_trigger___stress.factor)=c("Unchecked","Checked")
    levels(data$c_trigger___let_down.factor)=c("Unchecked","Checked")
    levels(data$c_trigger___screen.factor)=c("Unchecked","Checked")
    levels(data$c_trigger___concentrate.factor)=c("Unchecked","Checked")
    levels(data$c_trigger___read.factor)=c("Unchecked","Checked")
    levels(data$c_trigger___light.factor)=c("Unchecked","Checked")
    levels(data$c_trigger___noises.factor)=c("Unchecked","Checked")
    levels(data$c_trigger___smells.factor)=c("Unchecked","Checked")
    levels(data$c_trigger___smoke.factor)=c("Unchecked","Checked")
    levels(data$c_trigger___weather.factor)=c("Unchecked","Checked")
    levels(data$c_trigger___high_alt.factor)=c("Unchecked","Checked")
    levels(data$c_trigger___oth.factor)=c("Unchecked","Checked")
    levels(data$c_allodynia_hurt___none.factor)=c("Unchecked","Checked")
    levels(data$c_allodynia_hurt___ponytail.factor)=c("Unchecked","Checked")
    levels(data$c_allodynia_hurt___comb.factor)=c("Unchecked","Checked")
    levels(data$c_allodynia_hurt___hat.factor)=c("Unchecked","Checked")
    levels(data$c_allodynia_hurt___headphones.factor)=c("Unchecked","Checked")
    levels(data$c_valsalva_position___none.factor)=c("Unchecked","Checked")
    levels(data$c_valsalva_position___sneeze.factor)=c("Unchecked","Checked")
    levels(data$c_valsalva_position___cough.factor)=c("Unchecked","Checked")
    levels(data$c_valsalva_position___laugh.factor)=c("Unchecked","Checked")
    levels(data$c_valsalva_position___stand.factor)=c("Unchecked","Checked")
    levels(data$c_valsalva_position___lie.factor)=c("Unchecked","Checked")
    levels(data$c_valsalva_dur.factor)=c("Just while I sneeze/cough/laugh","A few seconds","Minutes","Hours")
    levels(data$c_activity.factor)=c("No change","Pain gets better","Pain gets worse","I feel like I need to move or pace when I have a headache")
    levels(data$c_assoc_sx_vis___none.factor)=c("Unchecked","Checked")
    levels(data$c_assoc_sx_vis___spot.factor)=c("Unchecked","Checked")
    levels(data$c_assoc_sx_vis___star.factor)=c("Unchecked","Checked")
    levels(data$c_assoc_sx_vis___light.factor)=c("Unchecked","Checked")
    levels(data$c_assoc_sx_vis___zigzag.factor)=c("Unchecked","Checked")
    levels(data$c_assoc_sx_vis___blur.factor)=c("Unchecked","Checked")
    levels(data$c_assoc_sx_vis___double_vis.factor)=c("Unchecked","Checked")
    levels(data$c_assoc_sx_vis___heat.factor)=c("Unchecked","Checked")
    levels(data$c_assoc_sx_vis___loss_vis.factor)=c("Unchecked","Checked")
    levels(data$c_assoc_sx_vis___oth.factor)=c("Unchecked","Checked")
    levels(data$c_assoc_sx_vis___cant_desc.factor)=c("Unchecked","Checked")
    levels(data$c_assoc_sx_neur_bil___none.factor)=c("Unchecked","Checked")
    levels(data$c_assoc_sx_neur_bil___weak.factor)=c("Unchecked","Checked")
    levels(data$c_assoc_sx_neur_bil___numb.factor)=c("Unchecked","Checked")
    levels(data$c_assoc_sx_neur_bil___tingle.factor)=c("Unchecked","Checked")
    levels(data$c_assoc_sx_neur_bil___run_nose.factor)=c("Unchecked","Checked")
    levels(data$c_assoc_sx_neur_bil___tear.factor)=c("Unchecked","Checked")
    levels(data$c_assoc_sx_neur_bil___ptosis.factor)=c("Unchecked","Checked")
    levels(data$c_assoc_sx_neur_bil___red_eye.factor)=c("Unchecked","Checked")
    levels(data$c_assoc_sx_neur_bil___puff_eye.factor)=c("Unchecked","Checked")
    levels(data$c_assoc_sx_neur_bil___flush.factor)=c("Unchecked","Checked")
    levels(data$c_assoc_sx_neur_bil___sweat.factor)=c("Unchecked","Checked")
    levels(data$c_assoc_sx_neur_bil___full_ear.factor)=c("Unchecked","Checked")
    levels(data$c_assoc_sx_neur_bil___oth.factor)=c("Unchecked","Checked")
    levels(data$c_assoc_sx_neur_bil___.factor)=c("Unchecked","Checked")
    levels(data$c_assoc_sx_neur_uni___none.factor)=c("Unchecked","Checked")
    levels(data$c_assoc_sx_neur_uni___weak.factor)=c("Unchecked","Checked")
    levels(data$c_assoc_sx_neur_uni___numb.factor)=c("Unchecked","Checked")
    levels(data$c_assoc_sx_neur_uni___tingle.factor)=c("Unchecked","Checked")
    levels(data$c_assoc_sx_neur_uni___run_nose.factor)=c("Unchecked","Checked")
    levels(data$c_assoc_sx_neur_uni___tear.factor)=c("Unchecked","Checked")
    levels(data$c_assoc_sx_neur_uni___ptosis.factor)=c("Unchecked","Checked")
    levels(data$c_assoc_sx_neur_uni___red_eye.factor)=c("Unchecked","Checked")
    levels(data$c_assoc_sx_neur_uni___puff_eye.factor)=c("Unchecked","Checked")
    levels(data$c_assoc_sx_neur_uni___pupilbig.factor)=c("Unchecked","Checked")
    levels(data$c_assoc_sx_neur_uni___flush.factor)=c("Unchecked","Checked")
    levels(data$c_assoc_sx_neur_uni___sweat.factor)=c("Unchecked","Checked")
    levels(data$c_assoc_sx_neur_uni___full_ear.factor)=c("Unchecked","Checked")
    levels(data$c_assoc_sx_neur_uni___oth.factor)=c("Unchecked","Checked")
    levels(data$c_assoc_sx_gi___none.factor)=c("Unchecked","Checked")
    levels(data$c_assoc_sx_gi___decreased_app.factor)=c("Unchecked","Checked")
    levels(data$c_assoc_sx_gi___diarr.factor)=c("Unchecked","Checked")
    levels(data$c_assoc_sx_gi___naus.factor)=c("Unchecked","Checked")
    levels(data$c_assoc_sx_gi___stom_pain.factor)=c("Unchecked","Checked")
    levels(data$c_assoc_sx_gi___vomiting.factor)=c("Unchecked","Checked")
    levels(data$c_assoc_sx_gi___oth.factor)=c("Unchecked","Checked")
    levels(data$c_assoc_sx_oth_sx___none.factor)=c("Unchecked","Checked")
    levels(data$c_assoc_sx_oth_sx___light.factor)=c("Unchecked","Checked")
    levels(data$c_assoc_sx_oth_sx___smell.factor)=c("Unchecked","Checked")
    levels(data$c_assoc_sx_oth_sx___sound.factor)=c("Unchecked","Checked")
    levels(data$c_assoc_sx_oth_sx___lighthead.factor)=c("Unchecked","Checked")
    levels(data$c_assoc_sx_oth_sx___spinning.factor)=c("Unchecked","Checked")
    levels(data$c_assoc_sx_oth_sx___balance.factor)=c("Unchecked","Checked")
    levels(data$c_assoc_sx_oth_sx___hear.factor)=c("Unchecked","Checked")
    levels(data$c_assoc_sx_oth_sx___ringing.factor)=c("Unchecked","Checked")
    levels(data$c_assoc_sx_oth_sx___unrespons.factor)=c("Unchecked","Checked")
    levels(data$c_assoc_sx_oth_sx___neck_pain.factor)=c("Unchecked","Checked")
    levels(data$c_assoc_sx_oth_sx___think.factor)=c("Unchecked","Checked")
    levels(data$c_assoc_sx_oth_sx___talk.factor)=c("Unchecked","Checked")
    levels(data$c_assoc_sx_oth_sx___oth.factor)=c("Unchecked","Checked")
    levels(data$c_assoc_sx_pul_ear___none.factor)=c("Unchecked","Checked")
    levels(data$c_assoc_sx_pul_ear___standing.factor)=c("Unchecked","Checked")
    levels(data$c_assoc_sx_pul_ear___lying.factor)=c("Unchecked","Checked")
    levels(data$c_assoc_sx_pul_ear___ha_bad.factor)=c("Unchecked","Checked")
    levels(data$c_assoc_sx_pul_ear___oth.factor)=c("Unchecked","Checked")
    levels(data$c_med_stop_ha___none.factor)=c("Unchecked","Checked")
    levels(data$c_med_stop_ha___apap.factor)=c("Unchecked","Checked")
    levels(data$c_med_stop_ha___ibupro.factor)=c("Unchecked","Checked")
    levels(data$c_med_stop_ha___naprox.factor)=c("Unchecked","Checked")
    levels(data$c_med_stop_ha___asp.factor)=c("Unchecked","Checked")
    levels(data$c_med_stop_ha___ketorolac.factor)=c("Unchecked","Checked")
    levels(data$c_med_stop_ha___ketoprof.factor)=c("Unchecked","Checked")
    levels(data$c_med_stop_ha___diclof.factor)=c("Unchecked","Checked")
    levels(data$c_med_stop_ha___celec.factor)=c("Unchecked","Checked")
    levels(data$c_med_stop_ha___exced.factor)=c("Unchecked","Checked")
    levels(data$c_med_stop_ha___butal.factor)=c("Unchecked","Checked")
    levels(data$c_med_stop_ha___midrin.factor)=c("Unchecked","Checked")
    levels(data$c_med_stop_ha___methylpred.factor)=c("Unchecked","Checked")
    levels(data$c_med_stop_ha___pred.factor)=c("Unchecked","Checked")
    levels(data$c_med_stop_ha___suma.factor)=c("Unchecked","Checked")
    levels(data$c_med_stop_ha___riza.factor)=c("Unchecked","Checked")
    levels(data$c_med_stop_ha___nara.factor)=c("Unchecked","Checked")
    levels(data$c_med_stop_ha___almo.factor)=c("Unchecked","Checked")
    levels(data$c_med_stop_ha___frova.factor)=c("Unchecked","Checked")
    levels(data$c_med_stop_ha___eletrip.factor)=c("Unchecked","Checked")
    levels(data$c_med_stop_ha___zolmit.factor)=c("Unchecked","Checked")
    levels(data$c_med_stop_ha___metoclop.factor)=c("Unchecked","Checked")
    levels(data$c_med_stop_ha___proch.factor)=c("Unchecked","Checked")
    levels(data$c_med_stop_ha___prometh.factor)=c("Unchecked","Checked")
    levels(data$c_med_stop_ha___ond.factor)=c("Unchecked","Checked")
    levels(data$c_med_stop_ha___diphen.factor)=c("Unchecked","Checked")
    levels(data$c_med_stop_ha___dhe.factor)=c("Unchecked","Checked")
    levels(data$c_med_stop_ha___tram.factor)=c("Unchecked","Checked")
    levels(data$c_med_stop_ha___t3.factor)=c("Unchecked","Checked")
    levels(data$c_med_stop_ha___morph.factor)=c("Unchecked","Checked")
    levels(data$c_med_stop_ha___hydromor.factor)=c("Unchecked","Checked")
    levels(data$c_med_stop_ha___nb.factor)=c("Unchecked","Checked")
    levels(data$c_med_stop_ha___oth.factor)=c("Unchecked","Checked")
    levels(data$c_when_take_med.factor)=c("before the pain starts, with a warning sign","as soon as the pain starts","when the pain is mild","when the pain is moderate/medium","when the pain is bad","when the pain is much worse than usual")
    levels(data$c_how_oft_med.factor)=c("less than one day a week","1-3 days per week","4 or more days a week","every day")
    levels(data$c_duration_overuse.factor)=c("Less than 1 month","1-3 months",">3 months")
    levels(data$c_med_prev_ha___none.factor)=c("Unchecked","Checked")
    levels(data$c_med_prev_ha___acetaz.factor)=c("Unchecked","Checked")
    levels(data$c_med_prev_ha___amitrip.factor)=c("Unchecked","Checked")
    levels(data$c_med_prev_ha___ateno.factor)=c("Unchecked","Checked")
    levels(data$c_med_prev_ha___botox.factor)=c("Unchecked","Checked")
    levels(data$c_med_prev_ha___cefaly.factor)=c("Unchecked","Checked")
    levels(data$c_med_prev_ha___cypro.factor)=c("Unchecked","Checked")
    levels(data$c_med_prev_ha___doxy.factor)=c("Unchecked","Checked")
    levels(data$c_med_prev_ha___dulox.factor)=c("Unchecked","Checked")
    levels(data$c_med_prev_ha___fluox.factor)=c("Unchecked","Checked")
    levels(data$c_med_prev_ha___gaba.factor)=c("Unchecked","Checked")
    levels(data$c_med_prev_ha___lamotrig.factor)=c("Unchecked","Checked")
    levels(data$c_med_prev_ha___lisin.factor)=c("Unchecked","Checked")
    levels(data$c_med_prev_ha___lvt.factor)=c("Unchecked","Checked")
    levels(data$c_med_prev_ha___metopro.factor)=c("Unchecked","Checked")
    levels(data$c_med_prev_ha___minocy.factor)=c("Unchecked","Checked")
    levels(data$c_med_prev_ha___nb.factor)=c("Unchecked","Checked")
    levels(data$c_med_prev_ha___nebivo.factor)=c("Unchecked","Checked")
    levels(data$c_med_prev_ha___nortrip.factor)=c("Unchecked","Checked")
    levels(data$c_med_prev_ha___pregab.factor)=c("Unchecked","Checked")
    levels(data$c_med_prev_ha___propano.factor)=c("Unchecked","Checked")
    levels(data$c_med_prev_ha___sertra.factor)=c("Unchecked","Checked")
    levels(data$c_med_prev_ha___topa.factor)=c("Unchecked","Checked")
    levels(data$c_med_prev_ha___vpa.factor)=c("Unchecked","Checked")
    levels(data$c_med_prev_ha___venla.factor)=c("Unchecked","Checked")
    levels(data$c_med_prev_ha___verap.factor)=c("Unchecked","Checked")
    levels(data$c_med_prev_ha___zonis.factor)=c("Unchecked","Checked")
    levels(data$c_med_prev_ha___oth.factor)=c("Unchecked","Checked")
    levels(data$c_vit_sup_ha___none.factor)=c("Unchecked","Checked")
    levels(data$c_vit_sup_ha___vitb2.factor)=c("Unchecked","Checked")
    levels(data$c_vit_sup_ha___vitd.factor)=c("Unchecked","Checked")
    levels(data$c_vit_sup_ha___mag.factor)=c("Unchecked","Checked")
    levels(data$c_vit_sup_ha___fishoil.factor)=c("Unchecked","Checked")
    levels(data$c_vit_sup_ha___coenzq10.factor)=c("Unchecked","Checked")
    levels(data$c_vit_sup_ha___feverfew.factor)=c("Unchecked","Checked")
    levels(data$c_vit_sup_ha___melatonin.factor)=c("Unchecked","Checked")
    levels(data$c_vit_sup_ha___butterbur.factor)=c("Unchecked","Checked")
    levels(data$c_vit_sup_ha___oth.factor)=c("Unchecked","Checked")
    levels(data$c_non_med_trea_ha___none.factor)=c("Unchecked","Checked")
    levels(data$c_non_med_trea_ha___acupunc.factor)=c("Unchecked","Checked")
    levels(data$c_non_med_trea_ha___biofeed.factor)=c("Unchecked","Checked")
    levels(data$c_non_med_trea_ha___chirop.factor)=c("Unchecked","Checked")
    levels(data$c_non_med_trea_ha___counsel.factor)=c("Unchecked","Checked")
    levels(data$c_non_med_trea_ha___exercise.factor)=c("Unchecked","Checked")
    levels(data$c_non_med_trea_ha___massage.factor)=c("Unchecked","Checked")
    levels(data$c_non_med_trea_ha___ot.factor)=c("Unchecked","Checked")
    levels(data$c_non_med_trea_ha___osteo.factor)=c("Unchecked","Checked")
    levels(data$c_non_med_trea_ha___pt.factor)=c("Unchecked","Checked")
    levels(data$c_non_med_trea_ha___vision.factor)=c("Unchecked","Checked")
    levels(data$c_non_med_trea_ha___oth.factor)=c("Unchecked","Checked")
    levels(data$c_iv_med_ha___none.factor)=c("Unchecked","Checked")
    levels(data$c_iv_med_ha___ketorolac.factor)=c("Unchecked","Checked")
    levels(data$c_iv_med_ha___metoclop.factor)=c("Unchecked","Checked")
    levels(data$c_iv_med_ha___prochlor.factor)=c("Unchecked","Checked")
    levels(data$c_iv_med_ha___methylpred.factor)=c("Unchecked","Checked")
    levels(data$c_iv_med_ha___dexameth.factor)=c("Unchecked","Checked")
    levels(data$c_iv_med_ha___mag.factor)=c("Unchecked","Checked")
    levels(data$c_iv_med_ha___vpa.factor)=c("Unchecked","Checked")
    levels(data$c_iv_med_ha___diphen.factor)=c("Unchecked","Checked")
    levels(data$c_iv_med_ha___opio.factor)=c("Unchecked","Checked")
    levels(data$c_iv_med_ha___lvt.factor)=c("Unchecked","Checked")
    levels(data$c_iv_med_ha___dhe.factor)=c("Unchecked","Checked")
    levels(data$c_iv_med_ha___ond.factor)=c("Unchecked","Checked")
    levels(data$c_iv_med_ha___oth.factor)=c("Unchecked","Checked")
    levels(data$clinician_ha_complete.factor)=c("Incomplete","Unverified","Complete")
  
    return(data)
  }
  
  load_imaging_data <- function(csv) {
    
    data=read.csv(csv)
    
    #Setting Labels
    label(data$record_id)="Record ID"
    label(data$redcap_repeat_instrument)="Repeat Instrument"
    label(data$redcap_repeat_instance)="Repeat Instance"
    label(data$img_proc)="Procedure name"
    label(data$img_ord_dt)="Ordering date"
    label(data$img_findings)="Findings"
    label(data$img_impression)="Impression"
    label(data$imaging_complete)="Complete?"
    #Setting Units
    
    
    #Setting Factors(will create new variable for factors)
    data$redcap_repeat_instrument.factor = factor(data$redcap_repeat_instrument,levels=c("visit_diagnoses","lab","prior_labs","all_problems","imaging"))
    data$imaging_complete.factor = factor(data$imaging_complete,levels=c("0","1","2"))
    
    levels(data$redcap_repeat_instrument.factor)=c("Visit Diagnoses","Lab","Prior Labs","All Problems","Imaging")
    levels(data$imaging_complete.factor)=c("Incomplete","Unverified","Complete")
    
    return(data)
  }
  
  load_labs_data <- function(csv){
    data=read.csv(csv)
    
    #Setting Labels
    label(data$record_id)="Record ID"
    label(data$redcap_repeat_instrument)="Repeat Instrument"
    label(data$redcap_repeat_instance)="Repeat Instance"
    label(data$lab_nm)="Lab name"
    label(data$lab_comp)="Component"
    label(data$lab_res)="Lab result"
    label(data$lab_unit)="Lab Unit"
    label(data$lab_complete)="Complete?"
    label(data$lab_nm_prior)="Lab name"
    label(data$lab_comp_prior)="Component"
    label(data$lab_res_prior)="Lab result"
    label(data$lab_unit_prior)="Lab Unit"
    label(data$prior_labs_complete)="Complete?"
    #Setting Units
    
    
    #Setting Factors(will create new variable for factors)
    data$redcap_repeat_instrument.factor = factor(data$redcap_repeat_instrument,levels=c("visit_diagnoses","lab","prior_labs","all_problems","imaging"))
    data$lab_complete.factor = factor(data$lab_complete,levels=c("0","1","2"))
    data$prior_labs_complete.factor = factor(data$prior_labs_complete,levels=c("0","1","2"))
    
    levels(data$redcap_repeat_instrument.factor)=c("Visit Diagnoses","Lab","Prior Labs","All Problems","Imaging")
    levels(data$lab_complete.factor)=c("Incomplete","Unverified","Complete")
    levels(data$prior_labs_complete.factor)=c("Incomplete","Unverified","Complete")
    
    return(data)
  }
  
  load_pmh_data <- function(csv){
    data=read.csv(csv)
    
    #Setting Labels
    label(data$record_id)="Record ID"
    label(data$redcap_repeat_instrument)="Repeat Instrument"
    label(data$redcap_repeat_instance)="Repeat Instance"
    label(data$pl_icd10)="ICD10 Code"
    label(data$pl_dx_nm)="Diagnosis name"
    label(data$all_problems_complete)="Complete?"
    label(data$cardiac)="Cardiac"
    label(data$craniofacial)="Craniofacial"
    label(data$dermatological)="Dermatological"
    label(data$endocrinological)="Endocrinological"
    label(data$gastrointestinal)="Gastrointestinal"
    label(data$genetic)="Genetic"
    label(data$genitourinary)="Genitourinary"
    label(data$hematological)="Hematological"
    label(data$neurological)="Neurological"
    label(data$immunological)="Immunological"
    label(data$pulmonary_respiratory)="Pulmonary/Respiratory"
    label(data$malignancy)="Malignancy"
    label(data$renal)="Renal"
    label(data$mental_health)="Mental health"
    label(data$ophthalmological)="Ophthalmological"
    label(data$metabolic)="Metabolic"
    label(data$otologic)="Otologic"
    label(data$musculoskeletal)="Musculoskeletal"
    label(data$otolaryngological)="Otolaryngological"
    label(data$progressive)="Progressive"
    label(data$condition_type)="Condition Type"
    label(data$total_body_system)="Total number of body systems"
    label(data$chronic_conditions_complete)="Complete?"
    #Setting Units
    
    
    #Setting Factors(will create new variable for factors)
    data$redcap_repeat_instrument.factor = factor(data$redcap_repeat_instrument,levels=c("visit_diagnoses","lab","prior_labs","all_problems","imaging"))
    data$all_problems_complete.factor = factor(data$all_problems_complete,levels=c("0","1","2"))
    data$cardiac.factor = factor(data$cardiac,levels=c("1","0"))
    data$craniofacial.factor = factor(data$craniofacial,levels=c("1","0"))
    data$dermatological.factor = factor(data$dermatological,levels=c("1","0"))
    data$endocrinological.factor = factor(data$endocrinological,levels=c("1","0"))
    data$gastrointestinal.factor = factor(data$gastrointestinal,levels=c("1","0"))
    data$genetic.factor = factor(data$genetic,levels=c("1","0"))
    data$genitourinary.factor = factor(data$genitourinary,levels=c("1","0"))
    data$hematological.factor = factor(data$hematological,levels=c("1","0"))
    data$neurological.factor = factor(data$neurological,levels=c("1","0"))
    data$immunological.factor = factor(data$immunological,levels=c("1","0"))
    data$pulmonary_respiratory.factor = factor(data$pulmonary_respiratory,levels=c("1","0"))
    data$malignancy.factor = factor(data$malignancy,levels=c("1","0"))
    data$renal.factor = factor(data$renal,levels=c("1","0"))
    data$mental_health.factor = factor(data$mental_health,levels=c("1","0"))
    data$ophthalmological.factor = factor(data$ophthalmological,levels=c("1","0"))
    data$metabolic.factor = factor(data$metabolic,levels=c("1","0"))
    data$otologic.factor = factor(data$otologic,levels=c("1","0"))
    data$musculoskeletal.factor = factor(data$musculoskeletal,levels=c("1","0"))
    data$otolaryngological.factor = factor(data$otolaryngological,levels=c("1","0"))
    data$progressive.factor = factor(data$progressive,levels=c("1","0"))
    data$condition_type.factor = factor(data$condition_type,levels=c("1","2","3"))
    data$chronic_conditions_complete.factor = factor(data$chronic_conditions_complete,levels=c("0","1","2"))
    
    levels(data$redcap_repeat_instrument.factor)=c("Visit Diagnoses","Lab","Prior Labs","All Problems","Imaging")
    levels(data$all_problems_complete.factor)=c("Incomplete","Unverified","Complete")
    levels(data$cardiac.factor)=c("Yes","No")
    levels(data$craniofacial.factor)=c("Yes","No")
    levels(data$dermatological.factor)=c("Yes","No")
    levels(data$endocrinological.factor)=c("Yes","No")
    levels(data$gastrointestinal.factor)=c("Yes","No")
    levels(data$genetic.factor)=c("Yes","No")
    levels(data$genitourinary.factor)=c("Yes","No")
    levels(data$hematological.factor)=c("Yes","No")
    levels(data$neurological.factor)=c("Yes","No")
    levels(data$immunological.factor)=c("Yes","No")
    levels(data$pulmonary_respiratory.factor)=c("Yes","No")
    levels(data$malignancy.factor)=c("Yes","No")
    levels(data$renal.factor)=c("Yes","No")
    levels(data$mental_health.factor)=c("Yes","No")
    levels(data$ophthalmological.factor)=c("Yes","No")
    levels(data$metabolic.factor)=c("Yes","No")
    levels(data$otologic.factor)=c("Yes","No")
    levels(data$musculoskeletal.factor)=c("Yes","No")
    levels(data$otolaryngological.factor)=c("Yes","No")
    levels(data$progressive.factor)=c("Yes","No")
    levels(data$condition_type.factor)=c("Non-Chronic","Non-complex Chronic","Complex Chronic")
    levels(data$chronic_conditions_complete.factor)=c("Incomplete","Unverified","Complete")
    
    return(data)
  }
  
  load_visitdx_data <- function(csv){
    data=read.csv(csv)
    
    #Setting Labels
    
    label(data$record_id)="Record ID"
    label(data$redcap_repeat_instrument)="Repeat Instrument"
    label(data$redcap_repeat_instance)="Repeat Instance"
    label(data$icd10)="ICD10 code"
    label(data$dx_name)="Diagnosis Name"
    label(data$snomed_cd_1)="Snomed Code 1"
    label(data$snomed_nm_1)="Snomed Name 1"
    label(data$snomed_cd_2)="Snomed Code 2"
    label(data$snomed_nm_2)="Snomed Name 2"
    label(data$snomed_cd_3)="Snomed Code 3"
    label(data$snomed_nm_3)="Snomed Name 3"
    label(data$snomed_cd_4)="Snomed Code 4"
    label(data$snomed_nm_4)="Snomed Name 4"
    label(data$snomed_cd_5)="Snomed Code 5"
    label(data$snomed_nm_5)="Snomed Name 5"
    label(data$visit_diagnoses_complete)="Complete?"
    #Setting Units
    
    
    #Setting Factors(will create new variable for factors)
    data$redcap_repeat_instrument.factor = factor(data$redcap_repeat_instrument,levels=c("visit_diagnoses","lab","prior_labs","all_problems","imaging"))
    data$visit_diagnoses_complete.factor = factor(data$visit_diagnoses_complete,levels=c("0","1","2"))
    
    levels(data$redcap_repeat_instrument.factor)=c("Visit Diagnoses","Lab","Prior Labs","All Problems","Imaging")
    levels(data$visit_diagnoses_complete.factor)=c("Incomplete","Unverified","Complete")
    
    return(data)
  }
  
  
  demo_data <- load_demo_data("raw_data/Outpatient_Demographics_2020-11-17_0837.csv")
  ha_data <- load_ha_data("raw_data/Outpatient_HA_DATA_2020-11-17_0840.csv")
  imaging_data <- load_imaging_data("raw_data/Outpatient_Imaging_2020-11-17_0847.csv")
  labs_data <- load_labs_data("raw_data/Outpatient_Labs_2020-11-17_0845.csv")
  pmh_data <- load_pmh_data("raw_data/Outpatient_PMH_2020-11-17_0846.csv")
  visitDx_data <- load_visitdx_data("raw_data/Outpatient_VisitDx_2020-11-17_0844.csv")
  
  
  write_feather(demo_data, "raw_data/demo_data.feather")
  write_feather(ha_data, "raw_data/ha_data.feather")
  write_feather(imaging_data, "raw_data/imaging_data.feather")
  write_feather(labs_data, "raw_data/labs_data.feather")
  write_feather(pmh_data, "raw_data/pmh_data.feather")
  write_feather(visitDx_data, "raw_data/visitDx_data.feather")

} else {
  
  demo_data <- read_feather("raw_data/demo_data.feather")
  ha_data <- read_feather("raw_data/ha_data.feather")
  imaging_data <- read_feather("raw_data/imaging_data.feather")
  labs_data <- read_feather("raw_data/labs_data.feather")
  pmh_data <- read_feather("raw_data/pmh_data.feather")
  visitDx_data <- read_feather("raw_data/visitDx_data.feather")
  
}

