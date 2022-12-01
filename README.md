# BMIN503/EPID600 Final Project

**Alzheimer's Disease GWAS Analysis**
I am going to look at Alzheimer’s GWAS data for Chr1-22 and generate a Manhatten Plot and Q-Q plot to visualize statistically significant associations. I will then functionally annotate and map these variants using the FUMA platform. 

This repository contains:

BMIN503_Final_Project/R_script/ManhattanPlot_QQ_Plot_Chr19_Rscript:    Rscript to load Chromosome 19 GWAS SNPTEST output and generate plots
BMIN503_Final_Project/

relevant files to analyze GWAS Data for Chr1-22. 

The GWAS summary outputs can be found in the GWAS_output directory.
The Rscript used to generate the Manhattan Plots can be found in the R_Script directory


### Overview
Analyze GWAS Autosomal Datasets and determine genes/variants associated with AD and their chromosomal locations. Use the FUMA platform to annotate and map these associations to their perspective genes and visualize GWAS results. Compare results with that of well known associations and determine the role of most significant genes and their pathways.

Use ADC10 study --> Use SNPTEST to generate GWAS Summary Output --> Use Rscript to clean and generate plots --> Use FUMA to annotate and get functional genomic information


### Introduction 
Alzheimer’s Disease is a debilitating illness with no treatment or cure. I plan to find significantly associated variants with AD and use functional genomics to annotate their locations, determine the role and pathways implicated of these genes. AD can be classified into two categories, Late-onset AD (95%) and early-onset AD(5%) . Early-onset AD is known to have a significant genomic component and the genes involved are APP, PSEN1, PSEN2. For LOAD, gene polymorphisms such as e4 and e2 variants of APOE are implicated. I hope to reproduce results showing well known genes, as well getting significant hits for genes which are less significant than the hallmark genes.

The data used is ADC10 which is from the dataset of ADC1-10. This NIA ADC cohort includes subjects evaluated by the clinical and neuropathology core. Data collection is coordinated by the National Alzheimer's Coordinating Center (NAAC). NAAC coordinates collection of phenotypes from ADCs, cleans all data, coordinates implementation of Alzheimer's definitions cases and controls, and collection of samples. The cohort contains 3,311 autopsy-confirmed cases and 2,889 clinically-confirmed disease cases, and 247 cognitively normal elders (CNEs) with complete neuropathology data > 60 years old at death, and 3,687 living CNEs

### Methods
Data is initially prepared using SNPTEST, a tool to analyze SNP association in GWAS.

#Show commands for SNPTEST

R is then used to clean the data and generate plots


DATA is uploaded into FUnctional Mapping and Annotation platform to understand functional component of results


### Results
**Currently only Chr19 is shown (where APOE is located)**

Manhattan plot indicates significant hits of SNPS with a P-value of <=1*10-8 with a very strong signal on Chr19 at around 45Mb (APOE region)

![Manhattan Plot](https://github.com/Tahai93/BMIN503_Final_Project/blob/master/output_files/Multraits-Manhattan.pvalue.jpg)
![QQ Plot](https://github.com/Tahai93/BMIN503_Final_Project/blob/master/output_files/QQplot.pvalue.jpg)

