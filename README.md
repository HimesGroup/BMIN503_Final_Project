# BMIN503/EPID600 Final Project: Improving time to heart failure diagnosis using EHR data (unstructured) 

Authors: 
Godefroy Chery, MD, MHS
Danielle L. Mowery, Ph.D., MS, FAMIA


Introduction: 
Heart failure is the primary reason for hospitalization in the elderly population and is associated with significant mortality and morbidity. While the reason for the  associated morbidity and mortality is multifactorial, failure to adhere to guideline-directed trial-proven medical regimen and underdiagnosis of heart failure both play significant contributory roles leading to poor cardiovascular outcomes including higher mortality. Herein, we are seeking to improve both the early recognition and the time to diagnosis to heart failure with reducted ejectiion fraction (HFrEF) diagnosis by leveraging electronic health record (EHR) data. For this project, we are interested in the heart failure with reduced ejection fraction cohort and thus, we are seeking to extract the left ventricular ejection fraction (LVEF) which is a critical diagnostic AND prognostic indicator of heart failure status and cardiovascular outcomes. Clinically, it is used to guide therapeutic management including the implementation of guideline-directed medical regimen (GDMT). 

The LVEF is obtained followoing assessment with an echocardiogram. While it is documented in table from the echocardiogram report, it is more often documented in free-text clinical notes or reports. This is particularly true for patients that are coming from other hospitals where it is not feasible to transfer echocardiogram DICOM images to the receiving hospital. As such, the variation in LVEF reporting remains a challenge for convenient extractiong further impeding patient care. 



Aim and significance:
The primary aim for this project is to leverage the unstructured text from medical notes using NLP to assist in HF diagnosis. Specifically, we are seeking to determine the FEASIBILITY of extracting the left ventricular function ejection fractin (LVEF) from unstructured text of medical note (e.g. discharge summary) using natural language processing (NLP) methods. Secondarily, we aim to compare the predictic power (i.e., accuracy, precision, and recall) of the NLP logic. 

Method:
Step 1: Getting access to the MIMIC-III dataset which is a large, freely-available database comprising deidentified health-related data associated with over forty thousand patients who stayed in critical care units of the Beth Israel Deaconess Medical Center between 2001 and 2012. It comes in form of many variables in various data tables.  
Step 2: Querying and cleaing the data. Merge pertinent datasets together. Provide a descriptive analysis including basic demographics of the MIMIC-III dataset.
Step 3: Defying case and cohort of for the population based on ICD 9 codes. Case definition for heart failure with reduced ejection fraction (HFrEF) was adapted from https://phekb.org/ and modified. 
Step 4: Querying notes associated with HFrEF encoded encounters. Developping and then applying open-source NLP tools to encode and retrieve LVEF.  
Step 5: Lastly, we evaluated how well the predictive power of rule logic using accuracy, precision, and recall.

Result:
As shown by our resulst session, it is feasible to use NLP to retrieve pertinent diagnostic components (herein is the LVEF). As shown, descriptive analysis including basic demographics of the case and control cohort (tables, barplots, etc.) are provided in the html files. More importantly, our NLP rule logic has an accuracy of 0.79, precision of 0.86, recall of 0.97, and a F-1 score of 0.91. 

Limitation
There are several limitations including case and control ICD9-based definition, patient population selection, data formats. Particularly, ICD9 codes can underestimate or overestimate a specific disease condition within a population as it is primarily used for billing and not for diagnostic purposes. It often does not reflect a true representation of a specific condition. As for patient population selection, we used a ICU cohort which is inherently a different population than patients that are on the stepdown and are seeing outpatient. Lastly, while our NLP rule logic can further improved on, it's accuracy, precision and recall are very reassuring.  


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

