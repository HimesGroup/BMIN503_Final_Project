# BMIN503/EPID600 Final Project

This project seeks to explore the question: how are citation metrics of a researcher associated with the funding they receive from the NIH? My hypothesis is that publication counts and impact factor of journals in which PIs publish is positively associated with receiving additional grant funding. This is in spite of the fact that researchers largely agree that these metrics are poor measures of the quality of scientific inquiry.  

00_data_prep.R contains code that imports and merges data from the NIH ExPORTER API as well as SCImago data from the sjrdata package. 
01_data_clean.R contains code that removes duplicates, recodes variables, processes dates, addressing missingness, and constructs predictors of interest for the final model. 
02_descriptives.R contains code that compiles univariate and bivariate descriptive statistics and plots. 
03_analysis.R contains fixed and mixed effects regression models that test my hypothesis. 

This is a work in progress, and appreciate any comments or thoughts. Enjoy!
