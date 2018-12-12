# BMIN503/EPID600 Final Project

title: "Differential Gene Expression in Adult Versus Pediatric Septic Shock"
author: "Michael Bonk"
contact: "michael.bonk@uphs.upenn.edu""

**Summary**
This project is a retrospective secondary analysis of prospective cohort studies examining whole blood differential gene expression of septic shock patients within 24 hours of diagnosis compared to healthy controls. The objective is to perform a meta-analysis of publically available gene expression datasets in both pediatric and adult patient cohorts in order to identify which transcripts are differentially expressed both in common and unique to each population. Functional gene annotation enrichment analysis will then be performed utilizing the Database for Annotation, Visualization, and Integrated Discovery (DAVID) in order to identify which biologic and cellular processes are differentially regulated both in common and unique to each patient group. These results will help to characterize the transcriptomic response to septic shock in each patient population. 

**Files included in this repo include the following:**

MBonk_final_project.Rmd # Final project Rmd file

**Meta-analyses sample information .csv files:**

Microarray_data_infosheet_R.csv #Pediatric dataset sample information

Microarray_data_infosheet_R2.csv #Adult dataset sample information; 2 should be removed prior to using this file for adult datasets

**R and python files for meta-analysis:**

csv2rds.R

integration_utility.R

meta_analysis_geneexpr.py

meta_analysis_geneexpr.R

meta_analysis_RankProd.R

study.rankprod.combine.R

MetaAnalysis_GeneExpression_example.pdf #Description of the files used in meta-analysis written by Mengyuan Kan

**Text file results of meta-analyses:**

Sepsis_peds_metaranef.txt #Results of Pediatric dataset meta-analysis

Sepsis_structure.metaranef.txt #Results of Adult dataset meta-analysis

**Functional annotation of common and unique differentially expressed gene lists:**

Common_functional.csv

Peds_unique_functional.csv

Adult_unique_functional.csv



