# BMIN503/EPID600 Final Project

This repository contains templates for your final written report and GitHub repository. Follow the instructions below to clone this repository, and then turn in your final project's code via a pull request to this repository.

1. To start, **fork** this BMIN503_Final_Project repository.
1. **Clone** the forked repository to your computer.
1. Modify the files provided, add your own, and **commit** changes to complete your final project.
1. **Push**/sync the changes up to your GitHub account.
1. Create a **pull request** on this, the original BMIN503_Final_Project, repository to turn in your final project.

Follow the instructions [here][forking] if you are unsure what the above steps mean.

DUE DATE FOR FINAL VERSION: 12/11/20 11:59PM. This is a hard deadline. Turn in whatever you have by this date.


<!-- Links -->
[forking]: https://guides.github.com/activities/forking/



### Overview
*Give a brief a description of your project and its goal(s), what data you are using to complete it, and what three faculty/staff in different fields you have spoken to about your project with a brief summary of what you learned from each person. Include a link to your final project GitHub repository.*

Over the last decade, hospital readmissions have become a major focus area of healthcare policy and research, and many initiatives to understand, reduce, and prevent future readmissions have emerged. While these initiatives have helped decrease readmissions in certain groups like Medicare patients, readmission rates have remained stable among Medicaid and privately insured patients, and even increased among uninsured patients (Bailey et al, 2019). To date, most prediction models for hospital readmissions have focused on important clinical factors like medications, lab values, and comorbidities (Zhou et al, 2016). Newer research suggests that social determinants of health impact hospital readmissions (CDC, 2020), so the goals of this project are to describe characteristics of readmitted patients and explore factors associated with 30-day readmissions with an emphasis on social factors. 

####Aims:
* Conduct an exploratory analysis comparing patients with 30-day readmissions to those wtihout
* Identify factors early in the hospitalization associated with readmission 

This project will use MIMIC-III, an openly available dataset developed by MIT with de-identified data for approximately 60,000 intensive care unit hospitalizations including demographics, vital signs, laboratory data, medications, and unstructured notes. I would like to acknowledge this wonderful database. 

[Github Repository](https://github.com/erinken/BMIN503_Final_Project)
[MIMIC-III](https://mimic.physionet.org/)

I would also like to acknowledge the contributions of several experts who assisted with the design and analysis process
* Danielle Mowery: study design, MIMIC data extraction, formulating processes of data wrangling, interpretation of results 
* Blanca Himes: Identifying a dataset and data extraction procedures 
* Anahita Davoudi and Sy Hwang: expertise in extracting and analyzing MIMIC data
* Emily Schriver: expertise in biostatistics using R. Assisted with several packages including ggplot and elixhauser comorbidity
* Gary Weissman: Expertise in wrangling MIMIC data 

### Introduction 
*Describe the problem addressed, its significance, and some background to motivate the problem.Explain why your problem is interdisciplinary, what fields can contribute to its understanding, and incorporate background related to what you learned from meeting with faculty/staff.*

In 2017 alone, 3.5 million potentially preventable readmissions cost 33.7 billion (McDermott & Jiang, 2020). Implementation of readmission-risk prediction models at the point of care is an evidence-based strategy to reduce readmissions, but only 34% of hospitals enrolled in the National Hospital-to-Home quality initiative formally estimate patients' readmission risk (Bradley et al, 2014). In 2019, the president of the American Hospital association encouraged policymakers to dedicate more resources towards understanding the discharge planning process and post-acute care trajectory (Pollack, 2019).According to a recent systematic review of readmission prediction models, most existing models have focused on important acute clinical data to predict readmission risk (Zhou et al, 2016). Recent literature suggests that social determinants of health could play an important role in hospital readmissions, and this information is starting to become more prevalent in structured EHR data (CDC, 2020). Therefore, the aim of this project is to explore the role of social factors in prediction of 30-day hospital readmissions.

A recent human factors study found that most patients have 1-6 different people involved in the discharge planning process, making it a truly interdisciplinary endeavor as different specialties bring different expertise to the team (Prusaczyk et al, 2019). Groups interested in building readmission prediction models should include a holistic mix of both technical and clinical experts such as biostatisticians, informaticians, data scientists, physicians, nurses, case managers, and even other ancillary clinicians like physical therapists. Since I come from a clinical background, my goal was to connect with the technical experts so my main collaborators included a biostatistician (Emily Schriver) and informaticians (Danielle Mowery, Sy Hwang, Anahita Davoudi). Danielle Mowery assisted me with overall study design and workflow for my data cleaning. Sy Hwang and Anahita Davoudi have experiences with general databases and the MIMIC database and helped me determine the appropriate way to extract data and join tables. Emily Schriver has extensive experience analyzing EHR data in R and pointed me to some helpful packages for my analysis. 


### Methods  
*Describe the data used and general methodological approach. Subsequently, incorporate full R code necessary to retrieve and clean data, and perform analysis. Be sure to include a description of code so that others (including your future self) can understand what you are doing and why.* 

The dataset used for this project was obtained from MIMIC-III, an openly available dataset of nearly 60,000 intensive care admissions including demographics, vital signs, laboratory data, medications, and notes. The database can be accessed [here](https://mimic.physionet.org/). Although there are a myriad of tables available in MIMIC, this dataset will focus on the patients, admissions, services, diagnoses, and diagnoses_icd tables. More information about the tables and schema can be found [here](https://mimic.physionet.org/mimicdata/schema/). These tables contain important demographic, comorbidity, and what types of services the patients received during their hospitalization.

The main goal is to define a readmissions cohort and analyze the data with exploratory analysis to build a simple readmissions prediction model. 


First, packages will be loaded for organizational purposes

