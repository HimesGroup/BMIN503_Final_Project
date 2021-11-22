## BMIN503 Final Project: Predicting SARS-CoV-2 Cases in the Delaware Valley Region

This repository contains filed related to the final project for BMIN503. The project uses publicly available data from the CDC and Google to predict SARS-CoV-2 cases in the following U.S. counties:
1. Bucks County, PA
2. Chester County, PA
3. Delaware County, PA
4. Montgomery County, PA
5. Philadelphia County, PA
6. Burlington County, NJ
7. Camden County, NJ
8. Gloucester County, NJ
9. Mercer County, NJ
10. Newcastle County, DE

Specifically, the analysis investigates the relationship between vaccination data from the CDC and Google Community Mobility Reports and CDC case data. 

### Files
The main file for running this analysis is **final_project_Cressman.Rmd.**

The accompanying files for this analysis are:
1. Final_Project.Rproj - R project file; must be saved in same folder as final_project_Cressman.Rmd in order to run. 
2. all_counties_population.csv - Contains 2019 population estimates for above counties.
3. cdc_cases_bucks.csv, cdc_cases_burlington.csv, etc. - Each county has an individual case file downloaded from the CDC website.

All other files are smaller chunks of code which make up final_project_Cressman.Rmd and can be ignored.
