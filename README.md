# BMIN503/EPID600 Final Project: Improving time to heart failure diagnosis using EHR data (unstructured) 

Authors: 
Godefroy Chery, MD, MHS
Danielle L. Mowery, Ph.D., MS, FAMIA


Introduction: 
Heart failure is the primary reason for preventable hospital stays in the elderly population in the USA. Unfortunately, it is  associated with significant mortality and morbidity with a projected cost of ~70 billion dollars by 2030. While the reason for the associated morbidity and mortality is multifactorial, failure to recognize its onset (underdiagnosis) and failure to adhere to guideline-directed trial-proven medical therapy both play significant contributory roles, further leading to poor cardiovascular outcomes including higher mortality. This is particularly the case for HFrEF which accounts for the majority of heart failure incidence. 

Herein, our ultimate goal is to improve on the early recognition of HFrEF and the time to diagnosis of HFrEF by leveraging unstructured and structured data in the electronic health record (EHR). For this course specifically (BMIN503), we are seeking to extract the left ventricular ejection fraction (LVEF) which is a critical diagnostic AND prognostic indicator of heart failure status and cardiovascular outcomes from unstructured data such as free-text clinical notes (e.g., outside hospital discharge summary notes, clinician notes, etc.). 

The LVEF is obtained following assessment of the cardiac function with an echocardiogram. While it can be documented in table format in the echocardiogram report, more often than not, it is documented in free-text clinical notes (e.g., clinician notes) or reports. This is particularly true for patients that are coming from other hospitals where it is not feasible to transfer echocardiogram DICOM images to the receiving hospital, further impeding appropriate and timely patient care. 



Aim and significance:
The primary aim for this project is to leverage the unstructured text from medical notes using NLP to assist in HF diagnosis. Specifically, we are seeking to determine the FEASIBILITY of extracting the left ventricular function ejection fractin (LVEF) from unstructured text of medical note (e.g. discharge summary) using natural language processing (NLP) methods. Secondarily, we aim to compare the predictic power (i.e., accuracy, precision, and recall) of the NLP logic. 

Method:
Step 1: Getting access to the MIMIC-III dataset which is a large, freely-available database comprising deidentified health-related data associated with over forty thousand patients who stayed in critical care units of the Beth Israel Deaconess Medical Center between 2001 and 2012. 
Step 2: Querying and cleaning the data. Merge pertinent datatables together. Provide a descriptive analysis including basic demographics of the MIMIC-III cohort. 
Step 3: Defying case and cohort of for the population based on ICD 9 codes. Case definition for heart failure with reduced ejection fraction (HFrEF) was adapted from https://phekb.org/ and modified. 
Step 4: Assessing for any significant association between pertinent variables and outcome (heart failure). 
Step 5: Querying notes associated with heart failure encoded encounters. Developing and then applying open-source NLP tools to encode and retrieve LVEF.
Step 6: Lastly, we evaluated how well the predictive power of rule logic using accuracy, precision, and recall.

Result:
Using our rule logic NLP tool, it is feasible to extract the left ventricular ejection fraction (LVEF) from unstructured data such as free-text medical notes (e.g., physician notes, clinic notes, discharge summaries, clinical reports). Herein, as shown above, it has great accuracy (0.79), precision (0.86), recall (0.97) and F-1 score (0.91). Moreove, we have found statistically significant associations between type of insurance (Medicare) and admission types to the ICU (emergency, newborn) with heart failure status. While these associations remain statistically significant even after adjusting for other variables in our cohort, it would be ill-advised to derive plausible causative explanations for such findings. As such, have made the decision not to conduct further exploratory analyses of those associations.  

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

