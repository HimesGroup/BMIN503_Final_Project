# BMIN503/EPID600 Final Project

This repository contains templates for my final written report and GitHub repository. A description of each of these files appears below:

* The "schnellinger_final_project_UNOS.html" file contains my final report (including introduction, methods, and results). The html version of this report was generated using all adult patients listed in the United Network for Organ Sharing (UNOS) database who received a lung transplant between 2007 and 2015. 
* The "final_project_template.Rmd" file contains the code used to generate the "schnellinger_final_project_UNOS.html" file. While the UNOS data is publicly available, researchers must submit a [Data Request](https://optn.transplant.hrsa.gov/data/) prior to using it. Thus, for the purposes of this project, I have provided a simulated data set, _simdat.RData_, on my [GitHub repository](https://github.com/eschnell/BMIN503_Final_Project).) The "final_project_template.Rmd" file will run using this simulated data set, and will produce the output shown in the "schnellinger_final_project_SIMULATED.html" file. However, please note the following:
    + The results in the SIMULATED html file differ from those in the UNOS html file, as ths former was produced using the simulated data, while the latter was produced using the real UNOS data.
    + The section of code which uses last-observation-carried-forward (LOCF) to fill in missing data relies on additional, "LAS history" files, which are available from UNOS upon request. Although we did perform these steps to generate the results shown in the "schnellinger_final_project_UNOS.html" file, these steps take considerable time to run (e.g., 20 minutes). Furthermore, they are not necessary when using _simdat.RData_, as the simulated data contains no missingness. Thus, we have set the options for the LOCF code chunk in the "final_project_template.Rmd" file (i.e., lines 82-445) to "eval=FALSE". This will allow users to run the program on the simulated data. 
    + Similarly, the section of code in the "final_project_template.Rmd" file which loads the cleaned UNOS data (i.e., lines 469-474) will only work if researchers have access to this data. We have set the options for this code chunk to "eval=FALSE" so that users can run the program on the simulated data.

* The "DataGeneration.Rmd" file contains the code to generate the simulated data. This code essentially simulates continuous covariates by conducting random draws from normal distributions with means and variances equal to those observed in the real UNOS data. Dichotomous covariates are simulated by randomly drawing from binomial distribution with success probabilities equal to the proportion of individuals receiving a "1" in the UNOS data. Separate cohorts of individuals are created for each year between 2007 and 2015, with the size of each cohort comparable to the UNOS post-transplant sample size at that year. The number of individuals within each diagnosis category are consistent with UNOS data as well. **Please note that because the "DataGeneration.Rmd" file relies on the observed means, variances, and proportions in the UNOS data, this code will not run unless researchers have access to the true UNOS data. It is provided in my final project repository only for reference.**



1. To start, **fork** this BMIN503_Final_Project repository.
1. **Clone** the forked repository to your computer.
1. Modify the files provided, add your own, and **commit** changes to complete your final project.
1. **Push**/sync the changes up to your GitHub account.
1. Create a **pull request** on this, the original BMIN503_Final_Project, repository to turn in your final project.

Follow the instructions [here][forking] if you are unsure what the above steps mean.

DUE DATE FOR FINAL VERSION: 12/12/18 11:59PM. This is a hard deadline. Turn in whatever you have by this date.


<!-- Links -->
[forking]: https://guides.github.com/activities/forking/

