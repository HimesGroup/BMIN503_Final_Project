# BMIN503/EPID600 Final Project

This repository contains templates for your final written report and GitHub repository. Follow the instructions below to clone this repository, and then turn in your final project's code via a pull request to this repository.

1. To start, **fork** this BMIN503_Final_Project repository.
1. **Clone** the forked repository to your computer.
1. Modify the files provided, add your own, and **commit** changes to complete your final project.
1. **Push**/sync the changes up to your GitHub account.
1. Create a **pull request** on this, the original BMIN503_Final_Project, repository to turn in your final project.

Follow the instructions [here][forking] if you are unsure what the above steps mean.

DUE DATE FOR FINAL VERSION: 12/12/18 11:59PM. This is a hard deadline. Turn in whatever you have by this date.


<!-- Links -->
[forking]: https://guides.github.com/activities/forking/

##Files
final_project_template.Rmd = file that the Rmd files were based on.
final_project_temp_Miller_git_v3.Rmd = Rmd file that uses real individual data that I cannot share to generate results in the form of an html file. 
final_project_temp_Miller_git_v3_fakedata_v1.Rmd = the same as final_project_temp_Miller_git_v3.Rmd but I created fake data to run the analysis with. 



### Overview
 Plasma lipid levels is a highly heritable trait that is associated with coronary artery disease (CAD). Statins make up a class of drugs that can reduce cholesterol levels however it is unclear genes expression levels are most predictive of a strong response. As a preliminary study to determine how well baseline measurements can predict phenotypic information, phenotypic and demographic data will be used to predict whether or not an individual has a weak or strong response to statins.

### Introduction 

  Plasma lipid levels can be used to identify risk of CAD such as heart attack. In order to reduce the likilood of developing a CAD, patients are often prescribed statins, a lipid lowering medication. While statins are effective, there can be significant veriability between how patients respond. While previous studies have foccussed on performing association studies, there has yet to be work that has tested how machine learning can be used to make predictions based on gene expression levels as a means to identifiy individuals who will respond well to statins. Furthermore, it remains unclear what features would be best suited for making predictions.

  The problem being addressed in this work is inheritently multi-disceplenary. The data being used is from the CAP study (Theusch et al., 2016) which is focussed on the pharmacogenomics of statins. Therefore, knowlege of biology and pharmacology are at the basis of the questions being addressed. Furthermore, machine-learning methods are being applied to the data which comes from computer science. In order to apply machine learning in this context, it will be important to first perform exploratory data analysis to have a good idea of what the data looks like. It will also be useful to test multiple parameters to make sure the most robust results are found. And results can be interpreted using AUC and/or ROC curves.


### Methods

The data used for this analysis has come from the Cholesterol and Pharmacogenomics (CAP) study. Between 2002 and 2004, 944 African American and European-American men and women were recruited to participate in a research project to study their lipids in response to statins. In addition to demographic information, RNA-seq and limited metabolomic data was also generated pre and post-statin exposure for over 400 individuals. In this study, I am interested in understanding which demographics and lab measures are most predictive for a weak or strong statin response. In other words which features predict if someone has a small or large decrease in LDL. To carry out such an analysis I will first test how well demographic and lab measures perform using linear regression to predict statin response as a binary outcome followed by training models using machine learning methods such as SVM and random forest. The models will be evaluated using 10-fold cross-validation. 

