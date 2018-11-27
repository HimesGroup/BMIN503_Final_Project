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

The objective of this project is to determine if morphological features of the placenta in a first-trimester 3D ultrasound exam can be used to predict low fetal birth weight. The project is a collaboration between the Departments of Radiology and Maternal Fetal Medicine (Penn MFM). Penn MFM provided the patient data and images used in this study (60 first-trimester 3D ultrasound exams, 17 of which were associated with low fetal birthweight).

The R markdown file _Pouch_final_project.Rmd_ contains the project writeup and R code. This file imports three spreadsheets that are not currently located in the repository since they contain HIPAA-protected data. (Mock spreadsheets will be created when the final project is submitted.) The first spreadsheet contains maternal and fetal characterstics (e.g., maternal age and fetal sex), the second contains placenta volume measurements made using a commercial software package, and the third contains a collection of placenta measurements created from custom 3D ultrasound image analysis. Information from the three spreadsheets is merged based on a study identifier. 

The primary outcome variable in this project is membership to the small-for-gestation-age "SGA_10th" category (i.e., the 10th percentile of birth weight normalized with respect to gestational age). Feature selection is first performed to reduce the number of correlated placenta morphology measurements. Logistic regression and random forest are used to create a classifer that relates placenta measurements and maternal/fetal characteristics with the primary outcome variable. The models are evaluated with and without the maternal/fetal characteristics and are assessed by ROC analysis.
