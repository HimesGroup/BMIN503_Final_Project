# BMIN503/EPID600 Final Project
**Project Title**: Serum Amyloid A promotes Th17 responses in murine models of colitis and multiple sclerosis

# Overview
Using the publically available RNASeq dataset [GSE132761](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE132761) from the Gene Expression Omnibus (GEO) repository, my goal was to understand transcriptomic changes in naive CD4 T cells in response to the acute phase protein Serum Amyloid A (SAA). 

**Faculty mentors**:

1. **Sarah Henrickson, M.D.,Ph.D.:** Assistant Professor of Pediatrics in the Allergy and Immunology Division at CHOP. 

2. **Mengyuan Kan, Ph.D:** Postdoctoral Researcher in Blanca Himes' lab. 
  
3. 


## GEO Accession
![Dataset GSE132761 on the Gene Expression Omnibus (GEO) public repository](https://github.com/ceirehay/BMIN503_Final_Project/blob/master/GSE132761_GEO.JPG)


**GEO Terminology**

1. GEO Platform (GPL): A particular type of microrray or sequencing platform. Contains the annotation files so that probes can be matched to corresponding genes at downstream analysis steps.
  - [GPL24247](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GPL24247): This data uses the 'NovaSeq 6000' from Illumina. The hyperlink brings you to a page that shows all of the other experiments that have used this particular sequencing platform.
2. GEO Sample (GSM): Files that contain all of the data generated from a single sequencing experiment
3. GEO Series (GSE): List of GSM's that form a single experiment




## Experimental Design
![Overview of the experimental model used by the authors of this dataset](https://github.com/ceirehay/BMIN503_Final_Project/blob/master/ExpOverview.png)

# Introduction
I am interested in understanding inflammatory pathways common to both obesity and asthma. As a graduate student in the Immunology Graduate Group (IGG), my research focuses on understanding the mechanisms of immunological and metabolic dysregulation in pediatric patients with obese asthma (OA). OA is unique disease entity at the intersect of the two most commonly occurring chronic inflammatory disorders in children. Both adults and children with OA experience increased frequency and severity of asthma exacerbation and are typically refractory to treatment. While there is an overwhelming amount or research that the two inflammatory disorders are closely *associated*, the *mechanistic relationship* between asthma and obesity is yet to be determined. 

There is a limited number of studies that attempt to elucidate the pathophysiological link between asthma and obesity in children. Most studies focus instead on adult cohorts or on animal models of the disease. Given this, I chose to learn more about the complex inflammatory pathways e a [publically available data set](https://www-ncbi-nlm-nih-gov.proxy.library.upenn.edu/geo/query/acc.cgi?acc=GSE132761) that focuses on immune mediators common to both asthma and obesity. This dataset is included in [Cell](https://pubmed-ncbi-nlm-nih-gov.proxy.library.upenn.edu/31866067/) published earlier this year by the Littman lab. The authors found the acute-phase response protein Serum Amyloid A (SAA) altered CD4+ T cell differentiation patterns to a pathogenic Th17 phenotype in mouse models of colitis and multiple sclerosis. They show that the pathogenic pro-inflammatory Th17 program induced by SAA is distinct from other well-established signaling pathways known to drive Th17 differentiation. 

I chose this data set because SAA is associated with increased risk of asthma incidence and increased risk of obesity. Moreover, because Th17 cells are the major effector cells in severe, treatment resistant asthma, I was especially excited to find this paper. 
My final project focuses on transcriptomic 

# Methods
Methodology described by the Himes Lab in the [RAVED](https://github.com/HimesGroup/raved) and [taffeta](https://github.com/HimesGroup/taffeta) pipelines

### I. Obtain Raw Data
The following steps were completed in a lab server that behaves similiarly to a HPC

1. Download raw data files using the SRA Toolkit, explained [here](https://wikis.utexas.edu/display/bioiteam/SRA+toolkit)
2. Preform prelimary quality control of raw fastq files with [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/)

### II. Quality Control of Raw Data
The following steps were completed in a lab server that behaves similiarly to a HPC

1. Create a data-set specific phenotype file
2. Align raw reads to reference genome using the [STAR aligner](https://github.com/alexdobin/STAR/blob/master/doc/STARmanual.pdf) and the [mm10](https://www.ncbi.nlm.nih.gov/assembly/GCF_000001635.20/) mouse reference genome
3. Quantification and statistics from  aligned reads using [HTSeq](https://pypi.org/project/HTSeq/)
4. Preform QC on aligned reads using samtools, bamtools and picardtools

### III. Determine Differentially Expressed Genes (DEGs)
The following steps were completed in a lab server that behaves similiarly to a HPC

1. Create a dataframe ([comp_file]()) that lists the pairwise comparisons of interest 
2. Use [DESeq2](https://bioc.ism.ac.jp/packages/2.14/bioc/vignettes/DESeq2/inst/doc/beginner.pdf)to determine the differtially expressed genes between each pairwise condition specified in the above file
3. QC and normalizaiton of DEGs

### IV. Functional Enrichment Analysis Using DEG Results
The following steps were completed in my local environment


# Results

**Raw Data Downloaded from GEO/SRA**

1. [GPL24247.soft:](https://github.com/ceirehay/BMIN503_Final_Project/blob/master/GPL24247.soft)
2. [GSE132761_series_matrix.txt.gz:](https://github.com/ceirehay/BMIN503_Final_Project/blob/master/GSE132761_series_matrix.txt.gz)
3. [SRP201470.metadata.csv:](https://github.com/ceirehay/BMIN503_Final_Project/blob/master/SRP201470.metadata.csv)
4. [GSE132761_withoutQC.txt:](https://github.com/ceirehay/BMIN503_Final_Project/blob/master/GSE132761_withoutQC.txt)
5. [SRP201470_sraFile.info:](https://github.com/ceirehay/BMIN503_Final_Project/blob/master/SRP201470_sraFile.info)
6. [SRP201470_SRAdownload_RnaSeqReport.html](https://github.com/ceirehay/BMIN503_Final_Project/blob/master/SRP201470_QC_RnaSeqReport.html):
7. [SRP201470_SRAdownload_RnaSeqReport.Rmd](https://github.com/ceirehay/BMIN503_Final_Project/blob/master/SRP201470_QC_RnaSeqReport.Rmd):

**Preliminary QC and Merging of Raw Reads**

1. [fastqfile_merge.txt:](https://github.com/ceirehay/BMIN503_Final_Project/blob/master/fastqfile_merge.txt)
2. [SRP201470_Phenotype_withoutQC.txt:](https://github.com/ceirehay/BMIN503_Final_Project/blob/master/SRP201470_Phenotype_withoutQC.txt)
3. [MultiQC]():

**Preliminary QC and Aligned Reads**

1. [SRP201470_QC_RnaSeqReport.Rmd:]()
2. [SRP201470_QC_RnaSeqReport.html:]()
3. [SRP201470_AlignedReads_multiqc_report.html:]()

**Differentially Expressed Genes**

1. [SRP201470_comp_file.txt:]()
2. Normalized Counts:
  - (2.1) [SRP201470_IL6_rmSAA1_3_vs_IL6_3_counts_normalized_by_DESeq2.txt]()
  - (2.2) [SRP201470_IL6_rmSAA1_3_vs_IL6_TGFb_3_counts_normalized_by_DESeq2.txt]()
  - (2.3) [SRP201470_IL6_rmSAA1_12_vs_IL6_12_counts_normalized_by_DESeq2.txt]()
  - (2.4) [SRP201470_IL6_rmSAA1_12_vs_IL6_TGFb_12_counts_normalized_by_DESeq2]()
  - (2.5) [SRP201470_IL6_rmSAA1_48_vs_IL6_48_counts_normalized_by_DESeq2.txt]()
  - (2.6) [SRP201470_IL6_rmSAA1_48_vs_IL6_TGFb_48_counts_normalized_by_DESeq2.txt]()
  - (2.7) [SRP201470_IL6_TGFb_3_vs_IL6_3_counts_normalized_by_DESeq2]()
  - (2.8) [SRP201470_IL6_TGFb_12_vs_IL6_12_counts_normalized_by_DESeq2]()
  - (2.9) [SRP201470_IL6_TGFb_48_vs_IL6_48_counts_normalized_by_DESeq2]()
3. Log fold change:
  - (3.1) [SRP201470_IL6_rmSAA1_3_vs_IL6_3_full_DESeq2_results.txt]()
  - (3.2) [SRP201470_IL6_rmSAA1_3_vs_IL6_TGFb_3_full_DESeq2_results.txt]()
  - (3.3) [SRP201470_IL6_rmSAA1_12_vs_IL6_12_full_DESeq2_results.txt]()
  - (3.4) [SRP201470_IL6_rmSAA1_12_vs_IL6_TGFb_12_full_DESeq2_results.txt]()
  - (3.5) [SRP201470_IL6_rmSAA1_48_vs_IL6_48_full_DESeq2_results.txt]()
  - (3.6) [SRP201470_IL6_rmSAA1_48_vs_IL6_TGFb_48_full_DESeq2_results]()
  - (3.7) [SRP201470_IL6_TGFb_3_vs_IL6_3_full_DESeq2_results]()
  - (3.8) [SRP201470_IL6_TGFb_12_vs_IL6_12_full_DESeq2_results]()
  - (3.9) [SRP201470_IL6_TGFb_48_vs_IL6_48_full_DESeq2_results]()
4. [SRP201470_DESeq2_Report.Rmd:]()
5. [SRP201470_DESeq2_Report.html:]()

# Conclusion



