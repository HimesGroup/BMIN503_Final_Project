# BMIN503/EPID600 Final Project: Predicting Multi-Drug Resistant Pathogens at a Veterinary Hospital

This repository contains my final project for EPID600.  The final_project_template.rmd file contains the code and accomanying text introducing my topic, describing the data source, and the analysis.    

The goal of this project is to develop and compare Random Forest models designed to predict whether or not a hospitalized dog is infected with multi-drug resistant (MDR) bacteria. MDR-bacteria pose a threat to other hospital patients and staff, and identifying high risk patients before the results of culture and sensitivity testing are available may reduce the risk.  This project will leverage two years of demographic, procedure, and prescription data for canines at a large tertiary veterinary clinic to predict canine MDR status.

Please note that the final results of the project differ from those presented on 12/5/2017.  After further research, I updated my code to include the sample balancing methodologies within for-loop for cross validation instead of externally. I also implemented a cost-optimizing protocol to address the imbalance in the cost of missclassifying an MDR patient versus a control. These two measures led me to choose a different final model, which led to enhanced predictive performance in the reserved validation data set. 

Due to the sensitive nature of the specific data, it has not been uploaded to git, per discussion with Dr. Himes.

DUE DATE FOR FINAL VERSION: 12/8/17 11:59PM. This is a hard deadline. Turn in whatever you have by this date.


<!-- Links -->
[forking]: https://guides.github.com/activities/forking/
[ref-clone]: http://gitref.org/creating/#clone
[ref-commit]: http://gitref.org/basic/#commit
[ref-push]: http://gitref.org/remotes/#push
[pull-request]: https://help.github.com/articles/creating-a-pull-request
