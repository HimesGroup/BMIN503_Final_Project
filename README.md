# COVID-19 Outcomes After mRNA SARS-CoV-2 Vaccine

### By: Sameh Saleh

## Overview
Breakthrough COVID-19 infections in fully vaccinated individuals have been reported. The goal of this project is to assess clinical outcomes in partially or fully vaccinated (BNT162b2 or mRNA-1273) patients with subsequent breakthrough SARS-CoV-2 infection and compare them to unvaccinated individuals with SARS-CoV-2 infection. This retrospective study uses data from the Optum de-identified COVID-19 Electronic Health Record dataset of nearly 7 million patients nationwide. 

### Files
* 'Instructions.md' contains the original project instructions.
* 'README.md' is the current file which contains an overview of the project.
* 'final_project_Saleh.Rmd' contains the current version of the project as .rmd.
* 'final_project_Saleh.html' contains the HTML output from the main .rmd file.
* 'charlson.sql' contains SQL queries to extract and identify comorbidity data from diagnosis codes.
* 'snsCovidVaccineTables.sql' contains SQL queries for defining a COVID-19 vaccine table by 1st and second dose. 
* 'snsCovidPosDefinitions.sql' contains SQL queries for defining COVID-19 cases by testing (PCR or Ag) or diagnosis code.
* 'snsProj2CohortID.sql' contains the SQL queries for defining the groups by vaccination status for the project. 