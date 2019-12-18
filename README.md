# nsong1/BMIN503_Final_Project

This is Nianfu Song's repo for the Final Project of BMIN503/EPID600 Data Science for Biomedical Informatics 

This project is an analysis of associations between some chronic diseases and measures of demographic variables and lifestyles of US adults using the National Health Survey Data 2018. Rare event logistic is applied to deal with the category imbalance of rare event data. Cross validation is used to evaluate the power of risk predicitons.

This project contains a R markdown file (.Rmd) and a HTML file produced by the markdown file. The .Rmd file can be run independently. Data will be retrieved by the code chunks of the .Rmd from the CDC website. it may take some time to completely run the code. Please be patient to wait for the results. You are welcome to use any sections of the code. 

This project features heatmaps that represent the significance of logistic and rare event logistic estimates. The rare event logistic models are theoratically better in the estimation of associations between covariates and the rare event responses. 

Please be aware that the resulted correlations do not represent causality. However, these correlations could be candidate causes in risk analyses of diseases. With low rate of occurence, low precision is a company of the high sensitivity. The highest F-score of the prediction often occures at low sensitivity. 

Thank you for your interest and please leave your comments.

