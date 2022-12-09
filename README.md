# BMIN503 Data Science Final Project
This repository contains the final project of my data science class as part of a Masters in Biomedical Informatics. I used open source data published by the Centers for Medicare and Medicaid to investigate the following:
1. **Measuring the Association of CMS “Accountable Care” Contracting Models to Skilled Nursing Facility Staffing Ratios**
2. **Can Logistic Regression Surface Gamesmenship By Skilled Nursing Facility Administrators?**

The detailed reports reports are available in the root directory as html files.
```
├── report_pt1.html
├── report_pt2.html
```

# Directory Structure
```
├── analysis: *Messy* R and Excel analysis underlying the final reports
├── data
│   ├── data_dictionaries: a non-exhaustive collection of data dictionaries
│   ├── interim: result of `.py ` ETL scripts
│   ├── raw: diretory for raw data files (not included in repo)
│   ├── inventory.qmd: A table outlining available data sources
├── transform: Python scripts for loading and transforming data
├── report_pt1.Rmd
├── report_pt1.html
├── report_pt2.Rmd
├── report_pt2.html
```