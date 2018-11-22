# BMIN503/EPID600 Final Project for Olivia J Veatch

This repository contains files necessary to run a gene prioritization pipeline to identify 'clinically-relevant' genes that have been previously associated with risk for Autism Spectrum Disorders (ASD).

All code is included in the R markdown file 'final_project_Veatch.Rmd'. 

Files required to complete the pipeline are as follows:
1. 'disease_mappings.tsv'= all of the Unified Medical Language System (UMLS)® Concept Unique Identifiers (CUI) and genes associated with these terms available in DisGeNET
2. 'E-MTAB-5214-query-results.tsv'= all genes that have been found expressed at a default cut-off level of FPKM≥0.5 in human brain tissue from RNA-Seq conducted for the Genotype Tissue Expression (GTEx) project 
3. 'MouseKO_ASDtraitsgenes_hsortho.xls'= genes that when knocked out of mice have been observed to have a phenotypic consequence that relates to  'nervous system development' and/or a 'behavioral/neurological phenotype' as defined by the International Mouse Phentyping Consortium
