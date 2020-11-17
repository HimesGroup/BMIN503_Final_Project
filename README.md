# BMIN503/EPID600 Final Project (Danielle Kellier)

This repository contains code for a predictive model for abnormal findings on imaging based on symptom profile.

There is a sub-folder labeled "raw_data" which contains sensitive health information and has been added to .gitignore as a result. .RData was also added to .gitignore to reduce chances of sensitive data being pushed to GitHub

load_data.R is a script with code generated from RedCap that reads and processes CSV data stored in a RedCap database and saves data as feather files due to their size.

renv.lock specifies the packages that were installed and used. This involves the (`renv` package)[https://cran.r-project.org/web/packages/renv/index.html] which can be installed and used to recreate the package environment

references.bib contains references to journal articles mentioned within the report
This repository contains templates for your final written report and GitHub repository. Follow the instructions below to clone this repository, and then turn in your final project's code via a pull request to this repository.

1. To start, **fork** this BMIN503_Final_Project repository.
1. **Clone** the forked repository to your computer.
1. Modify the files provided, add your own, and **commit** changes to complete your final project.
1. **Push**/sync the changes up to your GitHub account.
1. Create a **pull request** on this, the original BMIN503_Final_Project, repository to turn in your final project.

Follow the instructions [here][forking] if you are unsure what the above steps mean.

DUE DATE FOR FINAL VERSION: 12/11/20 11:59PM. This is a hard deadline. Turn in whatever you have by this date.


<!-- Links -->
[forking]: https://guides.github.com/activities/forking/

