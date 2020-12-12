# BMIN503/EPID600 Final Project: Air Quality in American Communities: Brian Bayes

These are the materials for my data science final project, in which I build statistical models from American Community Survey data to determine the extent to which certain household and community characteristics are associated with, and how well they predict, air quality as assessed by daily mean levels of fine particulate matter (PM2.5).

Contents: 

* final_project_Bayes.Rmd:  RMarkdown file to run and generate the report
* final_project_Bayes.html: The report itself
* all2019dailyPM25.RDS:     Daily PM2.5 EPA data for 2019 for the "lower 48" states. 1,448,813 obs x 31 vars
* testing_sites_tracts.RDS: Results of spatial join between PM2.5 testing sites and census tracts. 965 obs x 23 vars (sf)
* testing_sites_acs.RDS:    Selected variables from the 2018 5-year American Community Survey for site tracts. 965 obs x 42 vars

The code necessary to produce each of the .RDS files is included in the main final_project_Bayes.Rmd file, but those steps are not executed when the .Rmd file is knitted because (1) these steps are especially time-consuming, and (2) they require working API keys for the respective data sources. Instead, I read in the saved files in the subsequent code chunk in each case. 
