# BMIN503/EPID600 Final Project (Danielle Kellier)

This repository contains code for a predictive model for abnormal findings on imaging based on symptom profile.

## Subfolders

* raw_data/: sensitive health information and added to .gitignore

* final_project_template_files/: stores figure used in html file


##Files

* Additional ICD Codes.xlsx: Excel file of conditions relevant to headache studies and their associated ICD codes. Used for removing cases with prior abnormalities


* load_data.R: script with code generated from RedCap that reads and processes CSV data stored in a RedCap database and saves data as feather files due to their size.

* renv.lock: specifies packages that were installed and used. This involves the (`renv` package)[https://cran.r-project.org/web/packages/renv/index.html] which can be installed and used to recreate the package environment

* references.bib: contains references to journal articles mentioned within the report


## Ignored
* raw_data/: mentioned above
* .RData: added to reduce chances  of sensitive data being pushed to GitHub



