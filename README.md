# BMIN503/EPID600 Final Project

This repository contains templates for my final written report and GitHub repository. A description of each of these files appears below:

* The "final_project_template.html" file contains my final report (including introduction, methods, and results). The html version of this report was generated using all adult patients listed in the United Network for Organ Sharing (UNOS) database who received a lung transplant between 2007 and 2015. 

* The "final_project_template.Rmd" file contains the code used to generate the "final_project_template.html" file. Note that while the UNOS data is publicly available, researchers must submit a [Data Request](https://optn.transplant.hrsa.gov/data/) prior to using it. Thus, for the purposes of this project, I have provided a simulated data set, _simdat.RData_ on my [GitHub repository](https://github.com/eschnell/BMIN503_Final_Project).) The "final_project_template.Rmd" file should be able to run using this simulated data set, although the results will likely differ slightly from those in the html file, as the html file was produced using the real UNOS data set. 

* The "DataGeneration.Rmd" file contains the code to generate the simulated data. This code essentially simulates continuous covariates by conducting random draws from normal distributions with means and variances equal to those observed in the real UNOS data. Dichotomous covariates are simulated by randomly drawing from binomial distribution with success probabilities equal to the proportion of individuals receiving a "1" in the UNOS data. Separate cohorts of individuals are created for each year between 2007 and 2015, with the size of each cohort comparable to the UNOS post-transplant sample size at that year. The number of individuals within each diagnosis category are consistent with UNOS data as well. Please note that because the "DataGeneration.Rmd" file relies on the observed means, variances, and proportions in the UNOS data, this code will only run if researchers have access to the true UNOS data. It is provided in my final project repository only for reference.




1. To start, **fork** this BMIN503_Final_Project repository.
1. **Clone** the forked repository to your computer.
1. Modify the files provided, add your own, and **commit** changes to complete your final project.
1. **Push**/sync the changes up to your GitHub account.
1. Create a **pull request** on this, the original BMIN503_Final_Project, repository to turn in your final project.

Follow the instructions [here][forking] if you are unsure what the above steps mean.

DUE DATE FOR FINAL VERSION: 12/12/18 11:59PM. This is a hard deadline. Turn in whatever you have by this date.


<!-- Links -->
[forking]: https://guides.github.com/activities/forking/

