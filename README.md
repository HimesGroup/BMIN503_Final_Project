# BMIN503/EPID600 Final Project

This repository contains templates for your final written report and GitHub repository. Follow the instructions below to clone this repository, and then turn in your final project's code via a pull request to this repository.


1. To start, **fork** this BMIN503_Final_Project repository.
1. **Clone** the forked repository to your computer.
1. Modify the files provided, add your own, and **commit** changes to complete your final project.
1. **Push**/sync the changes up to your GitHub account.
1. Create a **pull request** on this, the original BMIN503_Final_Project, repository to turn in your final project.


Follow the instructions [here][forking] if you are unsure what the above steps mean.

DUE DATE FOR FINAL VERSION: 12/10/21 11:59PM. This is a hard deadline. Turn in whatever you have by this date.


<!-- Links -->
[forking]: https://guides.github.com/activities/forking/

Contents of this repo include:
-This README file where I describe the project
-Rmd file where I write the code for the project
-Html file which is the output of the rmd file

Introduction

Pima Indians of Arizona have an extremely high prevalence of type 2 diabetes and Diabetic Kidney Disease(DKD). Genetically related Pima Indians living in Mexico, whose lifestyle remains traditional, have a much lower prevalence of these morbidities. The differences in lifestyle indicate that environmental factors play an important role in disease origins and suggest involvement of epigenetic programming. One way to investigate epigenetic programming is through cytosine methylation (5mc) changes.We analyzed cytosine methylation (5mC) changes in Pima Indians from Arizona.

Methods

A nested case control study was conducted in 327 Pima Indians (205 women, 122 men) selected from a longitudinal cohort. DNA methylation from peripheral blood leukocytes was analyzed on an Illumina Infinium HumanMethylation 450 Beadchip. Preprocessing Quality Control  and normalization were performed using Sesame Package, Methylation changes were expressed transformed to log transformed beta values. Covariates included age, sex, duration of diabetes, mean blood pressure, HbA1c, genotype, batch, cell count and conversion efficiency. P-values were corrected for multiple comparison


Results:

I have begun to analyze the phenotype data file (PhenoData) which includes data on covariates I will use in my regression model. I summarized each covariate.

I saw a negative correlation with age and kidney function which is expected. However I ddi not see a clear relationship between hba1c (a marker of glucose severity) and egr which is a little unexpected. But I plan to look at how the hba1c changes over time. 
