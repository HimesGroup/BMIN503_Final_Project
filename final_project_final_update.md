---
title: "Finding Associations Between Individual Factors, Virtual Driving Behaviors, and On-Road Outcomes"
author: "Natalie Oppenheimer"
date: December 11, 2020
output: 
  html_document:
    keep_md: true
    toc: true 
    toc_depth: 3 
    toc_float: true
    theme: paper 
    highlight: tango
    df_print: paged
    smart: true
---

***
### Overview

This project explores the personal risk of a novice driver experiencing a crash based on individual factors like their age, sex, performance on the on-road licensing exam (ORE), and performance on a virtual driving test (VDT). The data set is a linked and de-identified sample of ~36,000 drivers across the state of Ohio who interacted with the state's Bureau of Motor Vehicles (BMV) in 2017-2018. The data set contains 
1) Licensing information - on-road exam scores & outcomes, number of attempts, age at attempt(s), etc.
2) Virtual Driving Test (VDT) information - performance, speed, score, etc.
3) Police-reported crash information - type, location, severity, weather, etc.

To guide this work, I sought input from:
1) Dr. Allison Curry, a CHOP Epidemiologist who studies motor vehicle crashes in non-typically developing populations (ex. individuals with ADD, ADHD, and Autism).
2) Dr. Kate McDonald, Associate Professor at Penn's School of Nursing who was deeply involved in the evolution of the virtual driving test from a lab-based simulator to a portable assessment tool in the field.
3) Dr. Megan Ryerson, Associate Dean for Research at PennDesign, within the Weitzman School of Design who is a city planning, urban design, and transportation expert.

Dr. Curry suggested I explore categorical groups within the data, which led to my decision to "bucket" the sample into age categories rather than exclusively treat this as a continuous variable. Dr. McDonald recommended finding explicit ties, where possible, between observed behavior/skills in the VDT and driving outcomes after licensure. Dr. Ryerson's team brought up potential variation across the various licensing test sites, and even across individual examiners. The ORE is not standardized, and certain testing sites or examiners may be - perhaps significantly - more or less stringent than average.

[final project GitHub repository](https://github.com/natalieopp/BMIN503_Final_Project)


### Introduction 

Motor vehicle crashes remain the leading cause of injury and death among young adults ([WHO, 2018](https://www.who.int/publications/i/item/9789241565684)). Research estimates that motor vehicle crashes (MVCs) account for between one in three to one in five adolescent deaths; and we know that lifetime crash risk is highest in the months immediately following independent licensure ([CDC WISQARS](https://webappa.cdc.gov/sasweb/ncipc/leadcaus10_us.html), [Curry et al, 2011](https://pubmed.ncbi.nlm.nih.gov/21545856/)). We also know, however, that driving is essential for many adolescents to achieve personal independence, and to access educational and occupational opportunities and other resources. Therefore, a crucial public health question emerges: how can we increase young driver safety without compromising mobility? One intervention, Graduated Driver Licensing (GDL), has been implemented across the United States. GDL aims to "allow young drivers to safely gain driving experience before obtaining full driving privileges" through a staged approach to getting behind the wheel. GDL begins with supervised learner or permit-ed driving, followed by an intermediate limited license, and finally advances to a full-privilege license ([Governors Highway Safety Association](https://www.ghsa.org/taxonomy/term/331#:~:text=Graduated%20Driver%20Licensing%20(GDL)%20programs,in%20high%20risk%20situations%3B%20and)). GDL has successfully reduced the number of MVCs among 16- and 17-year old drivers, but this policy does not necessarily ensure that new drivers acquire the skills needed to drive safely, as evidenced by the fact that the vast majority of crashes that occur in the months immediately after licensure are due to driver error (as opposed to driver risk-taking)([Gershon et al, 2018](https://www.sciencedirect.com/science/article/abs/pii/S1054139X18301897)). This suggests that the point of licensure is a critical moment for assessing new driver skills to ensure they are ready to safely begin independent driving. Unfortunately, the ORE is extremely limited in its ability to test for these key skills due to variability in examiner assessment of applicant readiness to drive, time constraints, the inability to safely expose applicants to common crash risk scenarios, and a host of other factors. To combat some of these limitations, simulated or virtual driving assessment can be used to complement the ORE by consistently and safely exposing applicants to common crash risk scenarios, and thoroughly evaluating their driving skills ([McDonald et al, 2012](https://journals.sagepub.com/doi/10.3141/2321-10)).

Through a partnership between Diagnostic Driving, Inc., a CHOP spin-out company, the Ohio Bureau of Motor Vehicles (OBMV), and the CHOP Neuroscience of Driving (NoD) team, such a virtual assessment was implemented in driving test sites across the state of Ohio ([Walshe et al, 2020](https://www.healthaffairs.org/doi/abs/10.1377/hlthaff.2020.00802)). This interdisciplinary team combined a variety of experiences and perspectives including public health, traffic safety & public policy, health technology research, cognitive & neuroscience, and developmental medicine. Our shared goal: scale and sustain the virtual driving test (VDT) as a screener and skills assessment at the time of licensure to identify applicants with critical skill deficits who are at risk of failing the ORE, and/or may be at a higher risk of crashing post-licensure. 
In order to do this, CHOP has received, linked, and de-identified 
   a) data from Ohio's state-wide licensing database, 
   b) Ohio's police-reported crash outcomes, 
   c) Diagnostic Driving's VDT process and outcome data. 
Utilizing this rich and unique data source, we aim to address a number of crucial research questions with potential major policy implications: How do crash rates vary by personal factors such as sex, age at licensure, time since licensure, and VDT performance? Are these factors (sex, age, time since licensure, VDT performance) related, and if so, what does this tell us about young driver skill development and experience?
In an effort to begin to address these questions and further tailor safe driving interventions, my analyses will focus on 

1. How pass and crash rates vary by personal factors such as sex and age at attempt/license.
2. Exploring any explicit ties between measures on the VDT that assess/capture skills--or skill deficits--that are associated with corresponding on-road outcomes like passing/failing, crashing, or experiencing a particular type of crash.


### Methods

The data set used for this project is a consists of linked, de-identified data from three sources: VDT data from Diagnostic Driving, Inc., Licensing data from OBMV, Police-reported crash outcome data from ODPS
Please see the [README in the GitHub repo](https://github.com/natalieopp/BMIN503_Final_Project) for additional details about these data sources and the linking & honest brokering process.

Analyses are conducted on two sample groups within the data set:

1. All applicants who took the VDT
    + Age breakdown
    + Sex & Age breakdown
    + VDT and ORE Score breakdowns by Age
    + VDT and ORE Score breakdowns by Age & Sex
    + BMV location breakdown

2. Applicants who went on to have a MVC
    + Age breakdown
    + Sex & Age breakdown
    + Crash breakdown by type & frequency
    + Crash type by relevant VDT variable(s) related to associated skill deficits
    
Finally, looking across the two cohorts, comparing  

* relevant VDT variable(s) related to specific skill deficit(s)
* ORE and VDT scores

Note: In order to simplify this analysis and maintain the focus on young novice drivers, an upper bound of 25 years old at the time of the VDT/ORE was implemented.


```r
# set-up and basic cleaning/formatting

# loading in libraries used throughout
library(dplyr)
library(ggplot2)
library(gt)
library(gtsummary)
library(ggpubr)
library(forcats)
library(knitr)

# reading in combined VDT, licensing, crash outcomes data set
d <- read.csv(file = 'Research_dataset_HSG.csv')

# checking variable class for cleaning (printing head to save space)
head(lapply(d, class))
```

```
## $customer_deidentified
## [1] "character"
## 
## $TestDateAge
## [1] "integer"
## 
## $vdt_test_year
## [1] "integer"
## 
## $DxD_cohort
## [1] "integer"
## 
## $BMVLocation
## [1] "character"
## 
## $completed_intro_drive
## [1] "character"
```

```r
# cleaning & re-coding variables in order
dc <- d %>%
  mutate(TestDateAge = (TestDateAge/365.25),
         BMVLocation = as.factor(BMVLocation),
         completed_intro_drive = as.factor(completed_intro_drive),
         started_comprehension = as.factor(started_comprehension),
         completed_comprehension = as.factor(completed_comprehension),
         started_assessment_drive = as.factor(started_assessment_drive),
         completed_assessment_drive = as.factor(completed_assessment_drive),
         passed_comprehension = as.factor(passed_comprehension),
         Map = as.factor(Map),
         Variant = as.factor(Variant)) %>%
  rename(Total_VDT_Duration = Total_Duration,
         U_ttc_3_10 = U_CE_3_10,
         U_120_over_limit = U_spd_limit_120,
         U_no_scan = U_f2scan_X,
         VDT_score_timeseries = VDT_score_tsc) %>%
  mutate(Sex = as.factor(Sex),
         IsManeuverPassing = factor(IsManeuverPassing, levels = c(0, 1),
                                    labels = c("Fail", "Pass"))) %>%
  rename(Maneuvertest_attempt = Maneuvertest_seq) %>%
  mutate(IsDrivingPassing = factor(IsDrivingPassing, levels = c(0, 1),
                                   labels = c("Fail", "Pass"))) %>%
  rename(Drivingtest_attempt = Drivingtest_seq,
         VDTtest_attempt = VDTtest_seq) %>%
  mutate(LicenseType = factor(LicenseType, levels = c("O", "G", "F", "R"),
                              labels = c("Full License", "Temporary Permit", "License Duplicate", "License Renewal"))) %>%
  rename(LicenseClass = ClassNew) %>%
  mutate(DLIssueDateAge = (DLIssueDateAge/365.25),
         FirstPermitStartAge = (FirstPermitStartAge/365.25),
         CurrentPermitStartAge = (CurrentPermitStartAge/365.25),
         AgeAtFirstORE_currentPermit = (AgeAtFirstORE_currentPermit/365.25),
         AgeAtLastORE_currentPermit = (AgeAtLastORE_currentPermit/365.25),
         AgeAtFirstORE_allPermits = (AgeAtFirstORE_allPermits/365.25),
         AgeAtLastORE_allPermits = (AgeAtLastORE_allPermits/365.25),
         DrivingSchoolFlag = factor(DrivingSchoolFlag, levels = c(0, 1),
                                    labels = c("Complete", "Not Complete")),
         PreExistingDLFlag = factor(PreExistingDLFlag, levels = c(0, 1),
                                    labels = c("PreExisting DL", "No PreExisting DL")),
         CrashDateAge = (CrashDateAge/365.25),
         Crash_Severity = as.factor(Crash_Severity),
         Crash_LightCondition = as.factor(Crash_LightCondition),
         Crash_RoadCondition = as.factor(Crash_RoadCondition),
         Crash_Weather = as.factor(Crash_Weather),
         Crash_Location = as.factor(Crash_Location),
         Crash_MannerOfCollision = as.factor(Crash_MannerOfCollision),
         Vehicle_type = as.factor(Vehicle_type),
         Vehicle_DamageScale = as.factor(Vehicle_DamageScale),
         Vehicle_Make = as.factor(Vehicle_Make),
         Vehicle_Model = as.factor(Vehicle_Model),
         Vehicle_Pre_Crash_Action = as.factor(Vehicle_Pre_Crash_Action),
         Vehicle_SequenceOfEvent_1 = as.factor(Vehicle_SequenceOfEvent_1),
         Vehicle_SequenceOfEvent_2 = as.factor(Vehicle_SequenceOfEvent_2),
         Vehicle_Circumstances = as.factor(Vehicle_Circumstances),
         Driver_InjuryType = as.factor(Driver_InjuryType),
         Driver_condition = as.factor(Driver_condition),
         Driver_Distraction = as.factor(Driver_Distraction),
         Driver_InjuryTransportation = as.factor(Driver_InjuryTransportation),
         Driver_AirbagDeploy = as.factor(Driver_AirbagDeploy),
         Driver_Ejection = as.factor(Driver_Ejection))
```
Now that the variables are reformatted for analysis, the data needs to be cleaned.

```r
# cleaning data based on missingness in key variables to create cohorts

# cohort 1 - all VDT-takers
# cleaning for Age and Sex: 
  # has a value for Sex 
  # was between 16-25 at time of VDT/ORE
dcl <- dc %>% 
  filter(between(TestDateAge,16,25)) %>%
  filter(Sex != "") 
dcl$Sex <- ifelse(dcl$Sex == "M", "Male", "Female")
# cleaning for VDT: completed the entire test/course at one of the pilot sites
dcl <- dcl %>%
  filter(!is.na(VDT_score_timeseries))
dcl <- dcl %>%
  filter(BMVLocation != "")
dcl$BMVLocation <- fct_collapse(dcl$BMVLocation, 
                                Hilliard = "Hilliard  - 4738 Cemetery Rd., 43026",
                                Alum_Creek = "Columbus - 1583 Alum Creek Dr., 43209",
                                Morse_Rd = "Columbus - 990 Morse Rd., 43229",
                                Zanesville = "Zanesville - 2324 June Parkway Plaza, 43701",
                                Springfield = c("Springfield - 1139 N. Bechtle Ave., 45504", ""))

# new variable: creating age "buckets" (making categorical age groups)
dcl$TestDateAgeBucket <- cut(dcl$TestDateAge,
                             breaks = c(15.9, 16.49, 16.99, 17.49, 17.99, 19, 21, 25),
                             labels = c("16.0-16.5", "16.5-17", "17-17.5", "17.5-18", "18-19", "19-21", "21-25"))

# new variable: indicator for whether individual crashed
dcl$Crash_Status <- ifelse(is.na(dcl$CrashDateAge), "No", "Yes")

# new variable: indicator for whether individual received driver's license
dcl$got_licence <- ifelse(!is.na(dcl$CountofFullLicense), "Yes", "No")


# cohort 2 - experienced a police-reported crash (within available data)
crashers <- dcl %>%
  filter(!is.na(CrashDateAge))
# new variables: pulling out crash types of interest
crashers$Crash_Manner_Rear_End <- ifelse(crashers$Crash_MannerOfCollision == "Rear-end", "Rear-end", "Other")
crashers$Crash_Manner_Angle <- ifelse(crashers$Crash_MannerOfCollision == "Angle", "Angle", "Other")
crashers$Crash_Manner_Sideswipe <- ifelse(crashers$Crash_MannerOfCollision == "Sideswipe, Same direction", "Sideswipe, Same Direction", "Other")
crashers$Crash_MannerOfCollision <- fct_collapse(crashers$Crash_MannerOfCollision,
                        Angle = "Angle",
                        Backing = "Backing",
                        Head_on = "Head-on",
                        Non_MVC = "Not collision between two motor vehicles in transport",
                        Rear_end = "Rear-end",
                        Rear_to_rear = "Rear-to-rear",
                        Sideswipe_OppositeDirection = "Sideswipe, Opposite direction",
                        Sideswipe_SameDirection = "Sideswipe, Same direction",
                        Unknown = c("Unknown",""))
```

Now that we have our two cohorts of interest, let's get a brief "snapshot" of what these groups look like.


```r
cohort1summaryt <- dcl %>% 
  select(Sex, BMVLocation, got_licence, TestDateAge, VDT_score_timeseries, DrivingScore) %>%
  tbl_summary( 
    by = Sex,
    missing = "no",
    label = list(BMVLocation ~ "BMV Site", got_licence ~ "Earned License", TestDateAge ~ "Age at VDT/ORE", VDT_score_timeseries ~ "VDT Score", DrivingScore ~ "ORE Skills Test Score")) %>%
  add_overall() %>%
  modify_header(label = "**Variable**")

as_gt(cohort1summaryt) %>%
  tab_header("Summary of All ORE & VDT-Takers")
```

<!--html_preserve--><style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#jqdhmlhmpt .gt_table {
  display: table;
  border-collapse: collapse;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#jqdhmlhmpt .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#jqdhmlhmpt .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#jqdhmlhmpt .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#jqdhmlhmpt .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#jqdhmlhmpt .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#jqdhmlhmpt .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#jqdhmlhmpt .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#jqdhmlhmpt .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#jqdhmlhmpt .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#jqdhmlhmpt .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#jqdhmlhmpt .gt_group_heading {
  padding: 8px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
}

#jqdhmlhmpt .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#jqdhmlhmpt .gt_from_md > :first-child {
  margin-top: 0;
}

#jqdhmlhmpt .gt_from_md > :last-child {
  margin-bottom: 0;
}

#jqdhmlhmpt .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#jqdhmlhmpt .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 12px;
}

#jqdhmlhmpt .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#jqdhmlhmpt .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#jqdhmlhmpt .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#jqdhmlhmpt .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#jqdhmlhmpt .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#jqdhmlhmpt .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#jqdhmlhmpt .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#jqdhmlhmpt .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#jqdhmlhmpt .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#jqdhmlhmpt .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#jqdhmlhmpt .gt_left {
  text-align: left;
}

#jqdhmlhmpt .gt_center {
  text-align: center;
}

#jqdhmlhmpt .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#jqdhmlhmpt .gt_font_normal {
  font-weight: normal;
}

#jqdhmlhmpt .gt_font_bold {
  font-weight: bold;
}

#jqdhmlhmpt .gt_font_italic {
  font-style: italic;
}

#jqdhmlhmpt .gt_super {
  font-size: 65%;
}

#jqdhmlhmpt .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="jqdhmlhmpt" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  <thead class="gt_header">
    <tr>
      <th colspan="4" class="gt_heading gt_title gt_font_normal" style>Summary of All ORE &amp; VDT-Takers</th>
    </tr>
    <tr>
      <th colspan="4" class="gt_heading gt_subtitle gt_font_normal gt_bottom_border" style></th>
    </tr>
  </thead>
  <thead class="gt_col_headings">
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1"><strong>Variable</strong></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1"><strong>Overall</strong>, N = 22,606<sup class="gt_footnote_marks">1</sup></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1"><strong>Female</strong>, N = 10,791<sup class="gt_footnote_marks">1</sup></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1"><strong>Male</strong>, N = 11,815<sup class="gt_footnote_marks">1</sup></th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">BMV Site</td>
      <td class="gt_row gt_center"></td>
      <td class="gt_row gt_center"></td>
      <td class="gt_row gt_center"></td>
    </tr>
    <tr>
      <td class="gt_row gt_left" style="text-align: left; text-indent: 10px;">Springfield</td>
      <td class="gt_row gt_center">1,751 (7.7%)</td>
      <td class="gt_row gt_center">818 (7.6%)</td>
      <td class="gt_row gt_center">933 (7.9%)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left" style="text-align: left; text-indent: 10px;">Alum_Creek</td>
      <td class="gt_row gt_center">5,599 (25%)</td>
      <td class="gt_row gt_center">2,776 (26%)</td>
      <td class="gt_row gt_center">2,823 (24%)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left" style="text-align: left; text-indent: 10px;">Morse_Rd</td>
      <td class="gt_row gt_center">3,992 (18%)</td>
      <td class="gt_row gt_center">1,826 (17%)</td>
      <td class="gt_row gt_center">2,166 (18%)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left" style="text-align: left; text-indent: 10px;">Hilliard</td>
      <td class="gt_row gt_center">8,484 (38%)</td>
      <td class="gt_row gt_center">4,028 (37%)</td>
      <td class="gt_row gt_center">4,456 (38%)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left" style="text-align: left; text-indent: 10px;">Zanesville</td>
      <td class="gt_row gt_center">2,780 (12%)</td>
      <td class="gt_row gt_center">1,343 (12%)</td>
      <td class="gt_row gt_center">1,437 (12%)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">Earned License</td>
      <td class="gt_row gt_center">20,522 (91%)</td>
      <td class="gt_row gt_center">9,730 (90%)</td>
      <td class="gt_row gt_center">10,792 (91%)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">Age at VDT/ORE</td>
      <td class="gt_row gt_center">18.01 (16.46, 19.69)</td>
      <td class="gt_row gt_center">17.93 (16.41, 19.71)</td>
      <td class="gt_row gt_center">18.03 (16.50, 19.66)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">VDT Score</td>
      <td class="gt_row gt_center">0.20 (0.12, 0.33)</td>
      <td class="gt_row gt_center">0.21 (0.12, 0.35)</td>
      <td class="gt_row gt_center">0.19 (0.11, 0.31)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">ORE Skills Test Score</td>
      <td class="gt_row gt_center">15 (5, 25)</td>
      <td class="gt_row gt_center">15 (5, 25)</td>
      <td class="gt_row gt_center">15 (5, 25)</td>
    </tr>
  </tbody>
  
  <tfoot>
    <tr class="gt_footnotes">
      <td colspan="4">
        <p class="gt_footnote">
          <sup class="gt_footnote_marks">
            <em>1</em>
          </sup>
           
          Statistics presented: n (%); Median (IQR)
          <br />
        </p>
      </td>
    </tr>
  </tfoot>
</table></div><!--/html_preserve-->

```r
cohort2summaryt <- crashers %>%
  select(Sex, TestDateAge, VDT_score_timeseries, DrivingScore, CrashDateAge, Crash_MannerOfCollision) %>%
  tbl_summary(
    by = Sex,
    missing = "no",
    label = list(TestDateAge ~ "Age at VDT/ORE", VDT_score_timeseries ~ "VDT Score", DrivingScore ~ "ORE Skills Test Score", CrashDateAge ~ "Age at Crash", Crash_MannerOfCollision ~ "Collision Type")) %>%
  add_overall() %>%
  modify_header(label = "**Variable**")

as_gt(cohort2summaryt) %>%
  tab_header("Summary of Those who had Police-reported Crash")
```

<!--html_preserve--><style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#dbfbfejlvr .gt_table {
  display: table;
  border-collapse: collapse;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#dbfbfejlvr .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#dbfbfejlvr .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#dbfbfejlvr .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#dbfbfejlvr .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#dbfbfejlvr .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#dbfbfejlvr .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#dbfbfejlvr .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#dbfbfejlvr .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#dbfbfejlvr .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#dbfbfejlvr .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#dbfbfejlvr .gt_group_heading {
  padding: 8px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
}

#dbfbfejlvr .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#dbfbfejlvr .gt_from_md > :first-child {
  margin-top: 0;
}

#dbfbfejlvr .gt_from_md > :last-child {
  margin-bottom: 0;
}

#dbfbfejlvr .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#dbfbfejlvr .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 12px;
}

#dbfbfejlvr .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#dbfbfejlvr .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#dbfbfejlvr .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#dbfbfejlvr .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#dbfbfejlvr .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#dbfbfejlvr .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#dbfbfejlvr .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#dbfbfejlvr .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#dbfbfejlvr .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#dbfbfejlvr .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#dbfbfejlvr .gt_left {
  text-align: left;
}

#dbfbfejlvr .gt_center {
  text-align: center;
}

#dbfbfejlvr .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#dbfbfejlvr .gt_font_normal {
  font-weight: normal;
}

#dbfbfejlvr .gt_font_bold {
  font-weight: bold;
}

#dbfbfejlvr .gt_font_italic {
  font-style: italic;
}

#dbfbfejlvr .gt_super {
  font-size: 65%;
}

#dbfbfejlvr .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="dbfbfejlvr" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  <thead class="gt_header">
    <tr>
      <th colspan="4" class="gt_heading gt_title gt_font_normal" style>Summary of Those who had Police-reported Crash</th>
    </tr>
    <tr>
      <th colspan="4" class="gt_heading gt_subtitle gt_font_normal gt_bottom_border" style></th>
    </tr>
  </thead>
  <thead class="gt_col_headings">
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1"><strong>Variable</strong></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1"><strong>Overall</strong>, N = 3,073<sup class="gt_footnote_marks">1</sup></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1"><strong>Female</strong>, N = 1,443<sup class="gt_footnote_marks">1</sup></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1"><strong>Male</strong>, N = 1,630<sup class="gt_footnote_marks">1</sup></th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">Age at VDT/ORE</td>
      <td class="gt_row gt_center">18.12 (16.65, 19.85)</td>
      <td class="gt_row gt_center">18.05 (16.56, 19.74)</td>
      <td class="gt_row gt_center">18.19 (16.80, 19.93)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">VDT Score</td>
      <td class="gt_row gt_center">0.20 (0.12, 0.33)</td>
      <td class="gt_row gt_center">0.20 (0.12, 0.34)</td>
      <td class="gt_row gt_center">0.19 (0.12, 0.31)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">ORE Skills Test Score</td>
      <td class="gt_row gt_center">15 (5, 25)</td>
      <td class="gt_row gt_center">15 (5, 25)</td>
      <td class="gt_row gt_center">15 (5, 25)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">Age at Crash</td>
      <td class="gt_row gt_center">18.75 (17.38, 20.55)</td>
      <td class="gt_row gt_center">18.63 (17.28, 20.43)</td>
      <td class="gt_row gt_center">18.83 (17.49, 20.75)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">Collision Type</td>
      <td class="gt_row gt_center"></td>
      <td class="gt_row gt_center"></td>
      <td class="gt_row gt_center"></td>
    </tr>
    <tr>
      <td class="gt_row gt_left" style="text-align: left; text-indent: 10px;">Unknown</td>
      <td class="gt_row gt_center">49 (1.6%)</td>
      <td class="gt_row gt_center">21 (1.5%)</td>
      <td class="gt_row gt_center">28 (1.7%)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left" style="text-align: left; text-indent: 10px;">Angle</td>
      <td class="gt_row gt_center">1,034 (34%)</td>
      <td class="gt_row gt_center">507 (35%)</td>
      <td class="gt_row gt_center">527 (32%)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left" style="text-align: left; text-indent: 10px;">Backing</td>
      <td class="gt_row gt_center">57 (1.9%)</td>
      <td class="gt_row gt_center">29 (2.0%)</td>
      <td class="gt_row gt_center">28 (1.7%)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left" style="text-align: left; text-indent: 10px;">Head_on</td>
      <td class="gt_row gt_center">77 (2.5%)</td>
      <td class="gt_row gt_center">44 (3.0%)</td>
      <td class="gt_row gt_center">33 (2.0%)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left" style="text-align: left; text-indent: 10px;">Non_MVC</td>
      <td class="gt_row gt_center">499 (16%)</td>
      <td class="gt_row gt_center">179 (12%)</td>
      <td class="gt_row gt_center">320 (20%)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left" style="text-align: left; text-indent: 10px;">Rear_end</td>
      <td class="gt_row gt_center">1,033 (34%)</td>
      <td class="gt_row gt_center">502 (35%)</td>
      <td class="gt_row gt_center">531 (33%)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left" style="text-align: left; text-indent: 10px;">Rear_to_rear</td>
      <td class="gt_row gt_center">15 (0.5%)</td>
      <td class="gt_row gt_center">5 (0.3%)</td>
      <td class="gt_row gt_center">10 (0.6%)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left" style="text-align: left; text-indent: 10px;">Sideswipe_OppositeDirection</td>
      <td class="gt_row gt_center">57 (1.9%)</td>
      <td class="gt_row gt_center">28 (1.9%)</td>
      <td class="gt_row gt_center">29 (1.8%)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left" style="text-align: left; text-indent: 10px;">Sideswipe_SameDirection</td>
      <td class="gt_row gt_center">252 (8.2%)</td>
      <td class="gt_row gt_center">128 (8.9%)</td>
      <td class="gt_row gt_center">124 (7.6%)</td>
    </tr>
  </tbody>
  
  <tfoot>
    <tr class="gt_footnotes">
      <td colspan="4">
        <p class="gt_footnote">
          <sup class="gt_footnote_marks">
            <em>1</em>
          </sup>
           
          Statistics presented: Median (IQR); n (%)
          <br />
        </p>
      </td>
    </tr>
  </tfoot>
</table></div><!--/html_preserve-->

### Results

#### Building plots for cohort 1:


```r
# VDT by age breakdown across the entire data set
age_overall <- ggplot(data = dc, aes(x = TestDateAge)) +
  geom_histogram(binwidth = 3, col = "gray44", fill = "deepskyblue", size = 1)
print(age_overall + labs(title = "Distribution of VDTs by Age",
                         y = "Count of VDTs",
                         x = "Age (years)"))
```

![](final_project_final_update_files/figure-html/unnamed-chunk-4-1.png)<!-- -->
  
While people apply for a driver's license across the lifespan, this confirms that the majority of VDTs & OREs were taken by applicants aged 25 and younger. Next, we'll look at the distribution within just that younger sample considering age as both a continuous and categorical variable.


```r
# VDT by age across sub-sample of interest (25 and under)
age_under25 <- ggplot(data = dcl, aes(x = TestDateAge)) +
  geom_histogram(binwidth = 1, col = "gray44", fill = "deepskyblue", size = 1)
print(age_under25 + labs(title = "Distribution of VDTs Among Applicants Aged 25 & Under",
                         y = "Count of VDTs",
                         x = "Age (years)"))
```

![](final_project_final_update_files/figure-html/unnamed-chunk-5-1.png)<!-- -->

```r
# VDT by age "buckets"
age_buckets <- ggplot(data = dcl, aes(x = TestDateAgeBucket)) +
  geom_bar(col = "gray44", fill = "deepskyblue", size = 1)
print(age_buckets + labs(title = "VDT Totals by Age Group",
                         y = "Count of VDTs",
                         x = "Age Group"))
```

![](final_project_final_update_files/figure-html/unnamed-chunk-5-2.png)<!-- -->
  
This distribution fits with our expectations based on knowledge of Ohio's GDL and driver training laws. We see the biggest spike at 16, the age when individuals become eligible to take the ORE and earn a driver's license after completing driver training and their learners permit phase. We also see a second spike at 18, the age at which applicants can take the ORE without completing mandatory behind-the-wheel driver training or holding a learner's permit.

Note: While this plot shows age groups without standardized ranges, this trend holds true when groups are standardized - see below.


```r
# creating standardized age groupings (all one-year increments)
dcl$TestDateAgeEvenBucket <- cut(dcl$TestDateAge,
                                 breaks = c(15.99, 16.99, 17.99, 18.99, 19.99, 20.99, 21.99, 22.99, 23.99, 25),
                                 labels = c("16 - <17", "17 - <18", "18 - <19", "19 - <20", "20 - <21", "21 - <22", "22 - <23", "23 - <24", "24-25"))

# plotting these evenly-distributed age groups
age_even_buckets <- ggplot(data = dcl, aes(x = TestDateAgeEvenBucket)) +
  geom_bar(col = "gray44", fill = "deepskyblue", size = 1) +
  ggtitle("VDT Totals by One-Year Age Groups") +
  xlab("Age Group") +
  ylab("Count of VDTs")
print(age_even_buckets)
```

![](final_project_final_update_files/figure-html/unnamed-chunk-6-1.png)<!-- -->

##### Plotting applicants by sex & age


```r
cols <- c("#ff146c", "deepskyblue")
sex_age <- ggplot(data = dcl, aes(x = TestDateAgeBucket, fill = Sex)) +
  geom_bar(position = "dodge") +
  scale_fill_manual(values = cols) +
  ggtitle("Sex by Age Category") +
  xlab("Age Group") +
  ylab("Count of VDTs")
sex_age
```

![](final_project_final_update_files/figure-html/unnamed-chunk-7-1.png)<!-- -->

```r
# taking a closer look at sex in the 18-19 year old category
length(dcl$customer_deidentified[dcl$Sex == "Male" & dcl$TestDateAgeBucket == "18-19"])
```

```
## [1] 2497
```

```r
length(dcl$customer_deidentified[dcl$Sex == "Female" & dcl$TestDateAgeBucket == "18-19"])
```

```
## [1] 1918
```
  
With the exception of 18-19 year olds, sex is about evenly distributed across the age groups. The difference seen in this age group could indicate that males are taking greater advantage than females of the delay in licensure to avoid driver training and GDL requirements, but this hypothesis is unproven and we don't know for certain what it driving this difference.


##### Distribution of applicants & scores across BMV sites

Looking at the distribution of this cohort (25 & under) across the different BMV sites where the VDT was implemented.


```r
# number of VDTs at each site 
sites <- ggplot(data = dcl, aes(x = BMVLocation)) +
  geom_bar(col = "gray44", fill = "deepskyblue", size = 1) +
  ggtitle("VDT Totals by BMV Location") +
  xlab("BMV Site") +
  ylab("Count of VDTs")
sites
```

![](final_project_final_update_files/figure-html/unnamed-chunk-8-1.png)<!-- -->

```r
# ORE pass rates by site
sites_ORE <- ggplot(data = dcl, aes(x = BMVLocation, y = DrivingScore)) +
  geom_boxplot() +
  scale_fill_manual(values = cols) +
  ggtitle("ORE Skills Test Score by BMV Location") +
  xlab("BMV Site") +
  ylab("ORE Skills Test Score") +
    stat_summary(fun = mean, geom = "point", shape = 8, color = "deepskyblue") +
  geom_hline(yintercept = 26, color = "#ff146c")
sites_ORE
```

![](final_project_final_update_files/figure-html/unnamed-chunk-8-2.png)<!-- -->

```r
# VDT scores by site
sites_vdt <- ggplot(data = dcl, aes(x = BMVLocation, y = VDT_score_timeseries)) +
  geom_boxplot() +
  scale_fill_manual(values = cols) +
  ggtitle("VDT Score by BMV Location") +
  xlab("BMV Site") +
  ylab("VDT Score") +
    stat_summary(fun = mean, geom = "point", shape = 8, color = "deepskyblue")
sites_vdt
```

![](final_project_final_update_files/figure-html/unnamed-chunk-8-3.png)<!-- -->

There are visible differences between the various sites' distributions of ORE and VDT scores. However, these score differences are confounded by the fact that there is also notable variation in the number of applicants from each site. Given that the sites with larger samples also have larger distributions, a lack of data from sites like Springfield and Zanesvilles could account for some of this inter-site variability.

##### ORE and VDT Performance by age & sex 

Next we'll look at performance on both the VDT and ORE by age and sex. Note that scoring for the ORE is reversed - points are accumulated as errors are committed, and a score of 25 points or less is considered a passing score.


```r
# ORE scores across age categories
age_scores <- ggplot(data = dcl, aes(x = TestDateAgeBucket, y = DrivingScore)) +
  geom_boxplot(outlier.colour = "red")
age_scores
```

![](final_project_final_update_files/figure-html/unnamed-chunk-9-1.png)<!-- -->

```r
# lots of outliers in every group!
# taking a cleaner & closer look at the distributions
age_scores_clean <- ggplot(data = dcl, aes(x = TestDateAgeBucket, y = DrivingScore)) +
  geom_boxplot(outlier.colour = "#ff146c") +
  scale_y_continuous(limits = c(0,70)) +
  ggtitle("ORE Skills Test Score by Age Group") +
  xlab("Age Group") +
  ylab("ORE Skills Test Score") +
  stat_summary(fun = mean, geom = "point", shape = 8, color = "deepskyblue") +
  geom_hline(yintercept = 26, color = "#ff146c")
age_scores_clean
```

![](final_project_final_update_files/figure-html/unnamed-chunk-9-2.png)<!-- -->

```r
# looking at a violin plot to compare group densities
age_scores_v <- ggplot(data = dcl, aes(x = TestDateAgeBucket, y = DrivingScore)) +
  geom_violin() +
  scale_y_continuous(limits = c(0,70)) +
  ggtitle("ORE Skills Test Score by Age Group") +
  xlab("Age Group") +
  ylab("ORE Skills Test Score") +
  stat_summary(fun = mean, geom = "point", shape = 8, color = "deepskyblue") +
  geom_hline(yintercept = 26, color = "#ff146c")
age_scores_v
```

![](final_project_final_update_files/figure-html/unnamed-chunk-9-3.png)<!-- -->

```r
# adding in age
sex_age_score <- ggplot(data = dcl, aes(x = TestDateAgeBucket, y = DrivingScore)) +
  geom_boxplot(aes(fill = Sex)) +
  scale_fill_manual(values = cols) +
  scale_y_continuous(limits = c(0,70)) +
  ggtitle("ORE Skills Test Score by Sex & Age Group") +
  xlab("Age Group") +
  ylab("ORE Skills Test Score") +
  geom_hline(yintercept = 26, color = "gray44", size = 1.2, linetype = "dashed")
sex_age_score
```

![](final_project_final_update_files/figure-html/unnamed-chunk-9-4.png)<!-- -->

```r
# now for VDT scores - first by age
age_vdt_scores <- ggplot(data = dcl, aes(x = TestDateAgeBucket, y = VDT_score_timeseries)) +
  geom_boxplot(outlier.colour = "#ff146c") + 
  ggtitle("VDT Score by Age Group") +
  xlab("Age Group") +
  ylab("VDT Score") +
  stat_summary(fun = mean, geom = "point", shape = 8, color = "deepskyblue")
age_vdt_scores
```

![](final_project_final_update_files/figure-html/unnamed-chunk-9-5.png)<!-- -->

```r
#VDT scores by age & sex
age_sex_vdt_scores <- ggplot(data = dcl, aes(x = TestDateAgeBucket, y = VDT_score_timeseries)) +
  geom_boxplot(aes(fill = Sex)) +
  scale_fill_manual(values = cols) +
  ggtitle("VDT Score by Sex & Age Group") +
  xlab("Age Group") +
  ylab("VDT Score")
age_sex_vdt_scores
```

![](final_project_final_update_files/figure-html/unnamed-chunk-9-6.png)<!-- -->
  
Some key takeaways from these plots:

* ORE score does vary across age groups, but across all ages the majority are passing 
    + mean for all of these groups is being dragged up by high outliers--people with extreme scores who bombed the ORE
* based on the violin/density plot, several age groups have a "bump out" just below the 25 point cut-off for passing. In other words, there are a considerable number of individuals, across various ages, who _just barely_ pass the ORE
* ORE score does vary across age & sex groups, but across all ages the majority are passing, regardless of sex
    + VDT score varies much less across sex and age category than does the ORE
* the VDT absorbs much of the variation by age that we see in ORE scores
    + there are few VDT score outliers which keeps the group mean more centered compared to the ORE
* VDT scores appear to vary slightly by sex, with females tending to score higher across all age groups
    + this variation is similar to that which we see for ORE by age & sex


#### Building plots for cohort 2:

Plotting distributions of key factors among those who passed the ORE and earned their license, but went on to have a police-reported MVC.

```r
# age distribution
age_crash_dist<- ggplot(data = crashers, aes(x = TestDateAgeBucket)) +
  geom_bar(col = "gray44", fill = "deepskyblue", size = 1) +
  ggtitle("Crashes by Age Group at Licensure") +
  xlab("Age Group") +
  ylab("Crash Count")
age_crash_dist
```

![](final_project_final_update_files/figure-html/unnamed-chunk-10-1.png)<!-- -->

```r
#age and sex distribution
age_sex_crash_dist <- ggplot(data = crashers, aes(x = TestDateAgeBucket, fill = Sex)) +
  geom_bar(position = "dodge") +
  scale_fill_manual(values = cols) +
  ggtitle("Crashes by Sex by Age Category") +
  xlab("Age Group") +
  ylab(" Crash Count")
age_sex_crash_dist
```

![](final_project_final_update_files/figure-html/unnamed-chunk-10-2.png)<!-- -->
  
The patterns of these distributions match those seen for age and age & sex breakdowns among everyone who took the VDT and ORE. This is consistent with prior research which has established that an individual's highest lifetime crash risk is in the months immediately after starting independent licensed driving. Therefore, when ORE rates increase, license issuance increases, and crash rates increase with little delay.

One intervention that may help to mitigate these negative outcomes is providing feedback to license applicants based on their VDT performance. This feedback could prove particularly valuable if

  1. It could be targeted at performance variables in the VDT, and the skills/skill deficits underlying them, that are associated with negative on-road outcomes. 
  
  2. It addresses the most common & serious crash scenarios.

Therefore, we'll seek to identify what some of these key indicators and outcomes might be. 

##### Plotting crash types & frequencies


```r
# plotting counts of different types of crashes
crash_types<- ggplot(data = crashers, aes(x = Crash_MannerOfCollision)) +
  geom_bar(col = "gray44", fill = "deepskyblue", size = 1) +
  coord_flip() +
  ggtitle("Totals by Crash Type") +
  xlab("Crash Type") +
  ylab("Crash Count")
crash_types
```

![](final_project_final_update_files/figure-html/unnamed-chunk-11-1.png)<!-- -->
  
The most common MVC types are:

* Rear-end
* Angle (AKA side impacts or T-bone collisions)
* Sideswipe between vehicles traveling in the same direction

Note: Collisions are also common between two objects that are not both traveling vehicles. These are categorized as "Not collision between two motor vehicles in transport" (named "non_MVC" in the crash plot) and include collisions like hitting a stationary object such as a pole, parked car, hydrant, etc. or hitting a moving object that is not another vehicle, such as a biker or pedestrian. These types of collisions are also captured in the VDT, however they are calculated separately and weighted differently from crashes with other moving vehicles. 


#### Identifying associations between VDT variables and crash outcomes

##### Rear-end crashes

We begin by looking at rear-end crashes & identifying associated VDT variables:

* G_ttc_mean, average time to collision over the entire VDT
* G_time_ttc_5below, time spent driving where time to collision was less than 5 seconds
* G_time_ttc_3below, time spent driving where time to collision was less than 3 seconds

Note: all of these variables are measures of following distance, where the latter two denote an unsafe following distance behind the vehicle ahead (AKA tailgating)

Examining how these variables play out among those who went on to crash, comparing rear-end to other types of collisions.

```r
# t-test to compare global average time to collision in the VDT among those who had rear-end crashes vs. those who had other crash types
  # H0: average time to collision is the same among rear-end crashers & other crashers
options(scipen = 999)
ttc_t <- t.test(crashers$G_ttc_mean ~ crashers$Crash_Manner_Rear_End, mu = 0, alternative = "two.sided", conf.level = 0.95, var.equal = FALSE, paired = FALSE)
ttc_t$estimate
```

```
##    mean in group Other mean in group Rear-end 
##               9.630838               9.638057
```

```r
ttc_t$p.value
```

```
## [1] 0.2995178
```

```r
# t-test comparing total time during the VDT where time to collision was <5 seconds
ttc5_t <- t.test(crashers$G_time_ttc_5below ~ crashers$Crash_Manner_Rear_End, mu = 0, alternative = "two.sided", conf.level = 0.95, var.equal = FALSE, paired = FALSE)
ttc5_t$estimate
```

```
##    mean in group Other mean in group Rear-end 
##               17.46661               17.02373
```

```r
ttc5_t$p.value
```

```
## [1] 0.2365699
```

```r
#t-test comparing total time during the VDT where time to collision was <3 seconds
ttc3_t <- t.test(crashers$G_time_ttc_3below ~ crashers$Crash_Manner_Rear_End, mu = 0, alternative = "two.sided", conf.level = 0.95, var.equal = FALSE, paired = FALSE)
ttc3_t$estimate
```

```
##    mean in group Other mean in group Rear-end 
##               5.474508               5.216559
```

```r
ttc3_t$p.value
```

```
## [1] 0.06428278
```

```r
# rear-end summary table
rear_table_VDT <- c("Avg. TTC (sec)", "Avg. time spent where TTC <5 sec (sec)", "Avg. time spent where TTC <3 sec (sec)")
rear_table_RC <- c (9.64, 17.02, 5.22)
rear_table_other <- c(9.63, 17.47, 5.48)
Rear_table_p <- c (0.29, 0.24, 0.06)
rear_table <- data.frame(rear_table_VDT, rear_table_RC, rear_table_other, Rear_table_p)
colnames(rear_table) <- c("VDT Variable", "Had a Rear-end Collision", "Had Other Collision Type", "P-value")

kable(
  rear_table, 
  format = "simple",
  caption = "**Rear-End Collisions Summary**",
  align = "lccc")
```



Table: **Rear-End Collisions Summary**

VDT Variable                              Had a Rear-end Collision    Had Other Collision Type    P-value 
---------------------------------------  --------------------------  --------------------------  ---------
Avg. TTC (sec)                                      9.64                        9.63               0.29   
Avg. time spent where TTC <5 sec (sec)             17.02                       17.47               0.24   
Avg. time spent where TTC <3 sec (sec)              5.22                        5.48               0.06   
  
Findings: The two groups (those who had rear-end crashes & those who had other kinds of crashes) 

* have almost the same global average time to collision in the VDT.
* spend similar total time in the VDT where time to collision was <5 seconds.
* spend similar total time in the VDT where time to collision was <3 seconds.


##### Angle/Side-Impact Crashes

Turning to angle/side-impact collisions, some related variables in the VDT include:

* U_no_scan, the number of times a participant failed to scan before entering an intersection
    + intersections are higher risk for side impact crashes
* G_spd_limit_20above, the percentage of the VDT spent driven 20 mph over the posted speed limit
    + measure of extreme speeding

```r
# t-test comparing number of failures to scan among those who had angle crashes vs. those who had other crash types
scan_t <- t.test(crashers$U_no_scan ~ crashers$Crash_Manner_Angle, mu = 0, alternative = "two.sided", conf.level = 0.95, var.equal = FALSE, paired = FALSE)
scan_t$estimate
```

```
## mean in group Angle mean in group Other 
##            9.054159            9.069152
```

```r
scan_t$p.value
```

```
## [1] 0.8603457
```

```r
# t-test comparing percentage of the VDT spent driven 20 mph over the speed limit
speed20_t <- t.test(crashers$G_spd_limit_20above ~ crashers$Crash_Manner_Angle, mu = 0, alternative = "two.sided", conf.level = 0.95, var.equal = FALSE, paired = FALSE)
speed20_t$estimate
```

```
## mean in group Angle mean in group Other 
##         0.006151794         0.005280311
```

```r
speed20_t$p.value
```

```
## [1] 0.4785899
```

```r
# angle summary table
angle_table_VDT <- c("Avg. # intersections where driver failed to scan", "% of VDT spent 20+ mph over speed limit")
angle_table_AC <- c(9.04, 0.61)
angle_table_other <- c(9.07, 0.53)
angle_table_p <- c(0.77, 0.48)
angle_table <- data.frame(angle_table_VDT, angle_table_AC, angle_table_other, angle_table_p)
colnames(angle_table) <- c("VDT Variable", "Had Angle/Side-Impact Collision", "Had Other Collision Type", "P-value")

kable(
  angle_table,
  format = "simple",
  caption = "**Angle/Side-Impact Collisions Summary**",
  align = "lccc"
)
```



Table: **Angle/Side-Impact Collisions Summary**

VDT Variable                                        Had Angle/Side-Impact Collision    Had Other Collision Type    P-value 
-------------------------------------------------  ---------------------------------  --------------------------  ---------
Avg. # intersections where driver failed to scan                 9.04                            9.07               0.77   
% of VDT spent 20+ mph over speed limit                          0.61                            0.53               0.48   
  
Findings: The two groups (those who had angle/side-impact crashes & those who had other kinds of crashes)
  + were similarly likely to fail to scan before entering intersections on the VDT.
  + both spend very little time in the VDT driving 20 mph over the posted speed limit.


##### Side-swipe Crashes

Finally, VDT variables that capture skills related to side-swipes:

* G_lanedev_mean, the average lateral displacement of the vehicle from the center of the lane over the course of the VDT
    + measure of lane-keeping
* G_roaddev_mean, the average distance of the vehicle from the center of the road or median over the course of the VDT
    + measure of road-keeping

```r
# t-test comparing average lane deviation among those who had side-swipe crashes vs. those who had other crash types
side_lane_t <- t.test(crashers$G_lanedev_mean ~ crashers$Crash_Manner_Sideswipe, mu = 0, alternative = "two.sided", conf.level = 0.95, var.equal = FALSE, paired = FALSE)
side_lane_t$estimate
```

```
##                     mean in group Other mean in group Sideswipe, Same Direction 
##                               0.4195911                               0.4287736
```

```r
side_lane_t$p.value
```

```
## [1] 0.3882611
```

```r
# t-test comparing road deviation
side_road_t <- t.test(crashers$G_roaddev_mean ~ crashers$Crash_Manner_Sideswipe, mu = 0, alternative = "two.sided", conf.level = 0.95, var.equal = FALSE, paired = FALSE)
side_road_t$estimate
```

```
##                     mean in group Other mean in group Sideswipe, Same Direction 
##                                3.711110                                3.750224
```

```r
side_road_t$p.value
```

```
## [1] 0.2014936
```

```r
# side-swipe summary table
side_table_VDT <- c("Avg. deviation from lane center", "Avg. deviation from road center")
side_table_SS <- c(0.43, 3.75)
side_table_other <- c(0.42, 3.71)
side_table_p <- c(0.38, 0.20)
side_table <- data.frame(side_table_VDT, side_table_SS, side_table_other, side_table_p)
colnames(side_table) <- c("VDT Variable", "Had Side-Swipe Collision", "Had Other Collision Type", "P-value")
 
kable(
  side_table,
  format = "simple",
  caption = "**Side-Swipe Collisions Summary**",
  align = "lccc"
  )
```



Table: **Side-Swipe Collisions Summary**

VDT Variable                       Had Side-Swipe Collision    Had Other Collision Type    P-value 
--------------------------------  --------------------------  --------------------------  ---------
Avg. deviation from lane center              0.43                        0.42               0.38   
Avg. deviation from road center              3.75                        3.71               0.20   
  
Finding: The two groups (those who had side-swipe crashes & those who had other kinds of crashes) had similar average road and lane deviation in the VDT.


##### Overall crashes

For overall crashes, identifying associated VDT variable(s):

* G_crash_veh, a count of collisions with vehicle traffic in the VDT
    + average number of collisions with other moving vehicles in the VDT
* VDT score
* ORE skills test score

###### Applicants who passed & were licensed


```r
# two-sample t-test to compare total VDT vehicle traffic collisions for crashers vs. non-crashers among those who got a license
licensed_only <- dcl[dcl$got_licence == "Yes",]
  # H0: average number of VDT vehicle traffic collisions is the same among crashers & non-crashers
lic_crash_t <- t.test(licensed_only$G_crash_veh ~ licensed_only$Crash_Status)
lic_crash_t$estimate
```

```
##  mean in group No mean in group Yes 
##         0.3886108         0.4497283
```

```r
lic_crash_t$p.value
```

```
## [1] 0.0000340495
```

```r
# t-test to compare average VDT score for crashers vs. non-crashers among those who got a license
lic_vdt_t <- t.test(licensed_only$VDT_score_var ~ licensed_only$Crash_Status)
lic_vdt_t$estimate
```

```
##  mean in group No mean in group Yes 
##         0.1954556         0.1558570
```

```r
lic_vdt_t$p.value
```

```
## [1] 0.0000000000000000000000000000000000000000000000000000000000002803998
```

```r
# t-test to compare average ORE skills test score for crashers vs. non-crashers among those who got a license
lic_ore_t <- t.test(licensed_only$DrivingScore ~ licensed_only$Crash_Status)
lic_ore_t$estimate
```

```
##  mean in group No mean in group Yes 
##          15.98378          16.63021
```

```r
lic_ore_t$p.value
```

```
## [1] 0.0554325
```

```r
# summary table of those who got a license
lic_table_VDT <- c("# of VDT vehicle traffic collisions", "VDT Score", "ORE skills test score")
lic_table_col <- c(0.45, 0.16, 16.63)
lic_table_nocol <- c(0.39, 0.20, 15.98)
lic_table_p <- c("**<0.01**", "**<0.01**", 0.06)
lic_table <- data.frame(lic_table_VDT, lic_table_col, lic_table_nocol, lic_table_p)
colnames(lic_table) <- c("Variable", "Had any collision", "Did not have a collision", "P-value")

kable(
  lic_table,
  format = "simple",
  caption = "**Outcomes Among Licensed Applicants**",
  align = "lccr")
```



Table: **Outcomes Among Licensed Applicants**

Variable                               Had any collision    Did not have a collision      P-value
------------------------------------  -------------------  --------------------------  ----------
# of VDT vehicle traffic collisions          0.45                     0.39              **<0.01**
VDT Score                                    0.16                     0.20              **<0.01**
ORE skills test score                        16.63                   15.98                   0.06

Looking across rather than within crash outcomes groups, we see there are significant group differences between those who had any type of collision and those who did not have a collision. Among those who got a license, Those who went on to have an on-road collision:

* had significantly more traffic collisions on the VDT than those who didn't.
* scored significantly worse on the VDT than those who didn't.
* tended to score worse on the ORE skills test.
    + Though this difference was not significant

###### All applicants, licensed or not


```r
# two-sided, assuming non-equal variances
crash_t <- t.test(dcl$G_crash_veh~dcl$Crash_Status, mu = 0, alternative = "two.sided", conf.level = 0.95, var.equal = FALSE, paired = FALSE)
crash_t$estimate
```

```
##  mean in group No mean in group Yes 
##         0.3930784         0.4533030
```

```r
crash_t$p.value
```

```
## [1] 0.00003107152
```

```r
vdt_t <- t.test(dcl$VDT_score_var ~ dcl$Crash_Status, mu = 0, alternative = "two.sided", conf.level = 0.95, var.equal = FALSE, paired = FALSE)
vdt_t$estimate
```

```
##  mean in group No mean in group Yes 
##         0.1994880         0.1583218
```

```r
vdt_t$p.value
```

```
## [1] 0.00000000000000000000000000000000000000000000000000000000000000000002321842
```

```r
ore_t <- t.test(dcl$DrivingScore ~ dcl$Crash_Status, mu = 0, alternative = "two.sided", conf.level = 0.95, var.equal = FALSE, paired = FALSE)
ore_t$estimate
```

```
##  mean in group No mean in group Yes 
##          17.24022          16.91972
```

```r
ore_t$p.value
```

```
## [1] 0.3466888
```

```r
# summary table of all applicants
all_table_VDt <- c("# of VDT vehicle traffic collisions", "VDT Score", "ORE skills test score")
all_table_col <- c(0.45, 0.16, 16.92)
all_table_nocol <- c(0.39, 0.20, 17.24)
all_table_p <- c("**<0.01**", "**<0.01**", 0.35)
all_table <- data.frame(all_table_VDt, all_table_col, all_table_nocol, all_table_p)
colnames(all_table) <- c("Variable", "Had any collision", "Did not have a collision", "P-value")

kable(
  all_table,
  format = "simple",
  caption = "**Outcomes Among All Applicants**",
  align = "lccr"
)
```



Table: **Outcomes Among All Applicants**

Variable                               Had any collision    Did not have a collision      P-value
------------------------------------  -------------------  --------------------------  ----------
# of VDT vehicle traffic collisions          0.45                     0.39              **<0.01**
VDT Score                                    0.16                     0.20              **<0.01**
ORE skills test score                        16.92                   17.24                   0.35

In sum, based on an initial visual exploration, ORE pass rates and VDT scores do not appear to vary significantly by personal factors such as sex and age, though additional analysis might be considered to understand sex differences that appeared to emerge among the 18-19 year old group. While the plots displaying crash outcomes by age and sex appear to closely follow the pattern of ORE attempts, further analysis is needed to determine whether a simple increase in number of licensing attempts accounts for a corresponding increase in number of MVCs, or if there are additional underlying factors (such as driver training experience, time since licensure, number of miles travelled on average) that contribute to crash outcome patterns.

Regarding the search for connections between measures on the VDT that capture skill deficits associated with corresponding on-road outcomes, there appear to be no significant differences in these measures among those who experience a MVC to suggest that certain skill deficits are uniquely associated with a related on-road crash outcome. Across all VDT variables that were considered, those who had MVCs were similar. However, looking across groups to compare those who experienced a MVC to those who did not, significant differences began to emerge. This combined finding--no within-group differences among crashers vs. significant between-group differences for those who crash or don't--suggests that experiencing a specific type of crash is not caused by a specific, related skill deficit, but rather by a general lack of skill. This "skill clustering" effect means it is unlikely for an individual to be lacking in one skill area while excelling in another; they either have or lack safe driving skills as a group.

Finally, there is some evidence to suggest that the VDT may be  better than the ORE skills test in accurately predicting who will go on to crash. Though a preliminary finding, this may have powerful implications for future implementation of the VDT: as a mandatory pre-screen for the ORE, as a flag for additional interventions, as a more individualized feedback/training tool, or other applications.
