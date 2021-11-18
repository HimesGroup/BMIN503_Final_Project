# BMIN503/EPID600 Final Project

This repository contains the details, data and code for the final project of the Data Science for Biomedical Informatics course.


This project is an analysis of a public dataset available at Gene Expression Omnibus (GEO) and can be accessed at https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE34607. It contains data of an experiment performed on Affymetrix Human Genome U133A 2.0 Array to study how Airborne particulate matter affects gene expression in BEAS-2B bronchial epithelial cells. The data contains the gene expression values measured in BEAS 2B cells incubated in three different conditions, (indoor, outdoor and control) and three different treatment times (4h, 10h and 24h). All the experiments were carried out in triplicates. 

The initial data analysis were performed with the help of an open source tool, RAVED, created at the Himes Laboratory (University of Pennsylvania). This helped in quality control analysis of the overall raw data, resulting in the generation of raw and modified phenotype files which were then utilized for differential expression analysis. The differential expression analysis was carried out for six different combinations (ind vs cont - 4h/10h/24h and out vs cont - 4h/10h/24h) which resulted in the generation of gene expression values and pathway analysis data in CSV format. The rmd files of QC and six DE can be found in this repo under the folder "RAVED - QC and DE" and the output files corresponding to these in .txt and .csv formats are available in the folder "RequiredFilesforMainCode. 

The final results and analysis for the whole dataset is performed for the final project and the file "FinalAnalysis_GSE34607" contains details of this code. Pleasure ensure to have all the files present in the "RequiredFilesforMainCode" folder in the pwd before runnning the rmd on your machine. 




