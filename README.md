# BMIN503/EPID600 Final Project

Hello! This repository contains my analysis from my final project for the BMIN503/EPID600 Data Science course at the University of Pennsylvania. 

### Project Overview
Over the last decade, hospital readmissions have become a major focus area of healthcare policy and research, and many initiatives to understand, reduce, and prevent future readmissions have emerged. While these initiatives have helped decrease readmissions in certain groups like Medicare patients, readmission rates have remained stable among Medicaid and privately insured patients, and even increased among uninsured patients (Bailey et al, 2019). To date, most prediction models for hospital readmissions have focused on important clinical factors like medications, lab values, and comorbidities (Zhou et al, 2016). Newer research suggests that social determinants of health impact hospital readmissions (CDC, 2020), so the goals of this project are to describe characteristics of readmitted patients and explore factors associated with 30-day readmissions with an emphasis on social factors. 

#### Aims:
* Conduct an exploratory analysis comparing patients with 30-day readmissions to those wtihout
* Identify factors early in the hospitalization associated with readmission 

This project will use MIMIC-III, an openly available dataset developed by MIT with de-identified data for approximately 60,000 intensive care unit hospitalizations including demographics, vital signs, laboratory data, medications, and unstructured notes. No MIMIC files have been uplaoded to the repository due to data use agreements, but once you receive access to the database through their website you can download the csv files and import them accordingly.

[MIMIC-III](https://mimic.physionet.org/)

### Files in the Repository  

* kennedy_main_analysis.Rmd ---------------> Project overview, introduction, methods, results, and conclusions. Main analytic file  
* kennedy_main_analysis.html --------------> HTML version for easier reading
* kennedy_preliminary_statistics.Rmd ------> Univariable analysis for all predictors in the logistic regression models that led to the creation of the final models. Aligns with the middle section of the kennedy_main_analysis files 
* kennedy_preliminary_statistics.html -----> HTML version for easier reading
* Plot_Images -----------------------------> Summary Graphs and Tables

### Final Model Performance  

![Curves](https://github.com/erinken/BMIN503_Final_Project/blob/master/Plot_Images/ROC_Curves.png)

