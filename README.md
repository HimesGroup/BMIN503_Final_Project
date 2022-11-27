# BMIN503/EPID600 Final Project: Improving time to heart failure diagnosis using EHR data (structured and unstructured) 

This repository contains component files for the final project including the rmd, html and overview below. Of note, this project is ongoing and thus work is still being done including components of the methods and results. 


Introduction: 
Heart failure is the primary reason for hospitalization in the elderly population and is associated with significant mortality and morbidity. While the reason for the  associated morbidity and mortality is multifactorial, underdiagnosis of heart failure plays a significant contributory role leading to poor cardiovascular outcomes. This is mainly because the diagnosis of heart failure is a clinical and thus, it requires compilation of various data points including detailed and thorough history and physical exam. Herein, we are seeking to improve the time to diagnosis to heart failure with reducted ejectiion fraction (HFrEF) diagnosis by leveraging electronic health record (EHR) data. The diagnosis of heart failure is a clinical diagnosis and thus requires various components including a detailed and thorough history and physical exam. 

Aim and significance:
The primary aim for this project is to leverage the unstructured text from medical notes using NLP to assist in HF diagnosis. Specifically, we are seeking to determine the feasibility of extracting pertinent components of the unstructured text of medical note (e.g. discharge summary) using natural language processing (NLP) methods to assist in making a heart failure diagnosis. Secondarily, we aim to compare the predictic power of the unstructured text to conventional factors in making a heart failure diagnosis. 

Method:
For this project, we are using the MIMIC-III dataset which is a large, freely-available database comprising deidentified health-related data associated with over forty thousand patients who stayed in critical care units of the Beth Israel Deaconess Medical Center between 2001 and 2012. It comes in form of various datasets which were then cleaned. Datatables containing basic demographics, ICD codes and note events were then merged. Heart failure with reduced ejection fraction (HFrEF) definition (using definition from https://phekb.org/  was used to define case and control populations. 

Subsequently, we queried notes associated with HFrEF encoded encounters and then applied open-source NLP tools to encode pertinent variables. We then developped and applied logic to features that are indicative to HFrEF definition from notes to predict case label. Lastly, we evaluated how well the predictive power of rule logic for phenotyping HFrEF (extrinsic evaluation) and areas for improvement based on errors in NLP and rules (intrinsic evaluation). 

Result:
We are continuing to work on the result section and should have the results posted soon. Please see final_project_template.rmd file. There has some significant issues with pushing changes to Github. 

Limitation
To be posted soon herein. 



Cleaned the dataset by using baseline and completed case to carry on analysis. The barplot is used to check outcome variable, the GLM, random forest tree and SVM are used as predicted models. ROC curve is used to evaluate the model's performance. The Gini score and p-value are used to create most significant predictors list for further GLM model comparison.


============================================

This repository contains templates for your final written report and GitHub repository. Follow the instructions below to clone this repository, and then turn in your final project's code via a pull request to this repository.


1. To start, **fork** this BMIN503_Final_Project repository.
1. **Clone** the forked repository to your computer.
1. Modify the files provided, add your own, and **commit** changes to complete your final project.
1. **Push**/sync the changes up to your GitHub account.
1. Create a **pull request** on this, the original BMIN503_Final_Project, repository to turn in your final project.


Follow the instructions [here][forking] if you are unsure what the above steps mean.

DUE DATE FOR FINAL VERSION: 12/09/22 11:59PM. This is a hard deadline. Turn in whatever you have by this date.


<!-- Links -->
[forking]: https://guides.github.com/activities/forking/

