# BMIN503/EPID600 Final Project

This repository contains the details, data and code for the final project of the Data Science for Biomedical Informatics course.


This project is a gene expression analysis of a public dataset available at Gene Expression Omnibus (GEO) and can be accessed at https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE34607. The objective of the project is to analyze this dataset that contains the gene expression values of BEAS-2B airway cells taken from classrooms with high concentrations of PM10 to study how air pollutants influence gene transcription in airway cells. Through the analysis in R, significantly expressed genes and pathways will be identified and thereby help to decide whether interventions are required for vulnerable people.  

The initial data analysis were performed with the help of an open source tool, RAVED, created at the Himes Laboratory (University of Pennsylvania). This helped in quality control analysis of the overall raw data, resulting in the generation of raw and modified phenotype files which were then utilized for differential expression analysis. The differential expression analysis was carried out for six different combinations (ind vs cont - 4h/10h/24h and out vs cont - 4h/10h/24h) which resulted in the generation of gene expression values and pathway analysis data in CSV format. The rmd files of QC and six DE can be found in this repo under the folder "RAVED - QC and DE" and the output files corresponding to these in .TXT and .CSV formats are available in the folder "RequiredFilesforMainCode". 

The final results and analysis for the whole dataset is performed for the final project and the file "FinalAnalysis_GSE34607" contains details of this code. Pleasure ensure to have all the files present in the "RequiredFilesforMainCode" folder in your current working directory before running the rmd on your machine. 




