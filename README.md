# BMIN503/EPID600 Final Project
**Project Title**: # Serum Amyloid A promotes Th17 responses in naive CD4+ T cells

# Overview
Using the publically available RNASeq dataset [GSE132761](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE132761) from the Gene Expression Omnibus (GEO) repository, my goal was to understand transcriptomic changes in naive CD4 T cells in response to the acute phase protein Serum Amyloid A (SAA).

## GEO Accession
![Dataset GSE132761 on the Gene Expression Omnibus (GEO) public repository](https://github.com/ceirehay/BMIN503_Final_Project/blob/master/GSE132761_GEO.JPG)


**GEO/SRA Terminology**

1. **GEO Platform (GPL)**: A particular type of microrray or sequencing platform. Contains the annotation files so that probes can be matched to corresponding genes at downstream analysis steps.
    - [GPL24247](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GPL24247): This data uses the 'NovaSeq 6000' from Illumina. The link brings you to a page that shows all of the other experiments that have used this particular sequencing platform.
2. **GEO Sample (GSM)**: Files that contain all of the data generated from a single sequencing experiment 
3. **GEO Series (GSE)**: List of GSM's that form a single experiment
4. **Simple Omnibus Format in Text (SOFT)**: A plain text document that contains
5. **Sequence Read Archive (SRA)**: 
6. **SRA Study Accession (SRP)**: This is the set of experiments (SRX) used to answer a hypothesis. 
7. **SRA Experiment Accession (SRX)**: Contains the metadata describing the library, platform selection, and processing parameters involved in a particular sequencing experiment.An experiment generally refers to a biological perturbation preformed on a single sample.
8. **SRA Run Accession (SRR)**: Contains actual sequencing data/reults for a particular sequencing experiment. Experiments may contain many Runs depending on the number of sequencing instrument runs that were needed.
9. **SRA Sample Accession (SRS)**: Contains the metadata describing the physical sample upon which a sequencing experiment was performed.

[GEO Terms](https://www.ncbi.nlm.nih.gov/geo/info/datasets.html)
[SRA Terms](https://www.ncbi.nlm.nih.gov/books/NBK56913/)
https://hbctraining.github.io/Accessing_public_genomic_data/lessons/downloading_from_SRA.html
https://linsalrob.github.io/ComputationalGenomicsManual/Databases/SRA.html


## Experimental Design
![Overview of the experimental model](https://github.com/ceirehay/BMIN503_Final_Project/blob/master/ExpOverview.png)

In this paper, the authors harvested the spleen from n=3 healthy mice and subsequently isolated naive CD4+ T cells from each donor. The naive cells were then cultured in the presence of 3 unique cytokine cocktails for 3, 12 and 48 hours. The 3 gray cell culture plates represents the negative control, IL-6 alone, as this cytokine on its own is not able to induce Th17 polarization. The 3 blue plates represent the positive control condition, IL-6 + TGFb, a combination of cytokines known to induce non-pathogenic Tcell polarization. Finally, the 3 plates in red represent the experimental condition, IL-6 + SAA1, a combination of cytokines that the authors demonstrate results in a previously unreported pathogenic Th17 response. 

# Methods
Methodology described by the Himes Lab in the [RAVED](https://github.com/HimesGroup/raved) and [taffeta](https://github.com/HimesGroup/taffeta) pipelines

### I. Obtain Raw Data
*The following steps were completed in a lab server that behaves similarly to a HPC*

1. Download raw data files using the SRA Toolkit, explained [here](https://wikis.utexas.edu/display/bioiteam/SRA+toolkit)
2. Merge fastq files
3. Preform preliminary quality control of raw fastq files with [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/)

### II. Align Reads to Reference Genome
*The following steps were completed in a lab server that behaves similarly to a HPC*

1. Create a data-set specific phenotype file
2. Align raw reads to reference genome using the [STAR aligner](https://github.com/alexdobin/STAR/blob/master/doc/STARmanual.pdf) and the [mm10](https://www.ncbi.nlm.nih.gov/assembly/GCF_000001635.20/) mouse reference genome
3. Quantification and statistics from  aligned reads using [HTSeq](https://pypi.org/project/HTSeq/)
4. Preform QC on aligned reads using samtools, bamtools and picardtools

### III. Determine Differentially Expressed Genes (DEGs)
*The following steps were completed in a lab server that behaves similarly to a HPC*

1. Create a [dataframe](https://github.com/ceirehay/BMIN503_Final_Project/blob/master/SRP201470_comp_file.txt) that lists the pairwise comparisons of interest 
2. Use [DESeq2](https://bioc.ism.ac.jp/packages/2.14/bioc/vignettes/DESeq2/inst/doc/beginner.pdf)to determine the differtially expressed genes between each pairwise condition specified in the above file
3. QC and normalizaiton of DEGs

### IV. Functional Enrichment Analysis Using DEG Results
*The following steps were completed in my local environment*

1. Read in and tidy results from DESeq2
2. Create a ranked-list of genes from each pairwise comparison. (In this case, I had n=9 pairwise comparisons and the DEGs were ranked by the t-statistic)
3. Read in and tidy gene set collections from the [Molecular Signature Database (MSigDb)](https://www.gsea-msigdb.org/gsea/msigdb/collections.jsp) using the `msigdbr` [package](https://cran.r-project.org/web/packages/msigdbr/index.html)
4. Read in and tidy a curated gene set collection of genes known to be upregulated or downregulated in exhausted human T cells
5. Run gsea using the `fgsea` [package](https://github.com/ctlab/fgsea) of the ranked gene lists compared to the gene set collections
6. Visualize results using `ggplot2`

# Results

## Organization of Data Files

**Raw Data Downloaded from GEO/SRA**

1. [GPL24247.soft:](https://github.com/ceirehay/BMIN503_Final_Project/blob/master/GPL24247.soft) Contains the metadata and normalized abundance data about the experiment 
2. [GSE132761_series_matrix.txt.gz:](https://github.com/ceirehay/BMIN503_Final_Project/blob/master/GSE132761_series_matrix.txt.gz) Pre-processed experimental data
3. [SRP201470.metadata.csv:](https://github.com/ceirehay/BMIN503_Final_Project/blob/master/SRP201470.metadata.csv) Contains the metadata about the experiment
4. [GSE132761_withoutQC.txt:](https://github.com/ceirehay/BMIN503_Final_Project/blob/master/GSE132761_withoutQC.txt) Contains the phenotype data about the experiment
5. [SRP201470_sraFile.info:](https://github.com/ceirehay/BMIN503_Final_Project/blob/master/SRP201470_sraFile.info) A datafile in a format specific to the Sequencing Read Archive (SRA) that is ultimatley used to estraxt raw read in the ".fastq" format with `sra-toolkit`
6. [SRP201470_SRAdownload_RnaSeqReport.html](https://github.com/ceirehay/BMIN503_Final_Project/blob/master/SRP201470_SRAdownload_RnaSeqReport.html):html file describing steps taken to retrieve and tidy raw data
7. [SRP201470_SRAdownload_RnaSeqReport.Rmd](https://github.com/ceirehay/BMIN503_Final_Project/blob/master/SRP201470_SRAdownload_RnaSeqReport.Rmd):as above, but in Rmd format

**Files Used for or Generated by Preliminary QC**

1. [fastqfile_merge.txt:](https://github.com/ceirehay/BMIN503_Final_Project/blob/master/fastqfile_merge.txt) Some samples were run more that 1 time, meaning there were duplicates runs that corresponded to the same biological sample/ This file is used to merge duplicate files into a sinlge fastq file for downstream analysis.
2. [SRP201470_Phenotype_withoutQC.txt:](https://github.com/ceirehay/BMIN503_Final_Project/blob/master/SRP201470_Phenotype_withoutQC.txt): Tidied phenotypic data related to the dataset. This df does not include a parameter specifying wether a samples has passed or failed quality control

**QC of Aligned Reads**

1. [SRP201470_QC_RnaSeqReport.Rmd:](https://github.com/ceirehay/BMIN503_Final_Project/blob/master/SRP201470_QC_RnaSeqReport.Rmd)
2. [SRP201470_QC_RnaSeqReport.html:](https://github.com/ceirehay/BMIN503_Final_Project/blob/master/SRP201470_QC_RnaSeqReport.html)

**Differentially Expressed Genes**

1. [SRP201470_comp_file.txt:](https://github.com/ceirehay/BMIN503_Final_Project/blob/master/SRP201470_comp_file.txt)
2. Normalized Counts:
  - (2.1) [SRP201470_IL6_rmSAA1_3_vs_IL6_3_counts_normalized_by_DESeq2.txt](https://github.com/ceirehay/BMIN503_Final_Project/blob/master/SRP201470_IL6_rmSAA1_3_vs_IL6_3_counts_normalized_by_DESeq2.txt)
  - (2.2) [SRP201470_IL6_rmSAA1_3_vs_IL6_TGFb_3_counts_normalized_by_DESeq2.txt](https://github.com/ceirehay/BMIN503_Final_Project/blob/master/SRP201470_IL6_rmSAA1_3_vs_IL6_TGFb_3_counts_normalized_by_DESeq2.txt)
  - (2.3) [SRP201470_IL6_rmSAA1_12_vs_IL6_12_counts_normalized_by_DESeq2.txt](https://github.com/ceirehay/BMIN503_Final_Project/blob/master/SRP201470_IL6_rmSAA1_12_vs_IL6_12_counts_normalized_by_DESeq2.txt)
  - (2.4) [SRP201470_IL6_rmSAA1_12_vs_IL6_TGFb_12_counts_normalized_by_DESeq2](https://github.com/ceirehay/BMIN503_Final_Project/blob/master/SRP201470_IL6_rmSAA1_12_vs_IL6_TGFb_12_counts_normalized_by_DESeq2)
  - (2.5) [SRP201470_IL6_rmSAA1_48_vs_IL6_48_counts_normalized_by_DESeq2.txt](https://github.com/ceirehay/BMIN503_Final_Project/blob/master/SRP201470_IL6_rmSAA1_48_vs_IL6_48_counts_normalized_by_DESeq2.txt)
  - (2.6) [SRP201470_IL6_rmSAA1_48_vs_IL6_TGFb_48_counts_normalized_by_DESeq2.txt](https://github.com/ceirehay/BMIN503_Final_Project/blob/master/SRP201470_IL6_rmSAA1_48_vs_IL6_TGFb_48_counts_normalized_by_DESeq2.txt)
  - (2.7) [SRP201470_IL6_TGFb_3_vs_IL6_3_counts_normalized_by_DESeq2](https://github.com/ceirehay/BMIN503_Final_Project/blob/master/SRP201470_IL6_TGFb_3_vs_IL6_3_counts_normalized_by_DESeq2)
  - (2.8) [SRP201470_IL6_TGFb_12_vs_IL6_12_counts_normalized_by_DESeq2](https://github.com/ceirehay/BMIN503_Final_Project/blob/master/SRP201470_IL6_TGFb_12_vs_IL6_12_counts_normalized_by_DESeq2)
  - (2.9) [SRP201470_IL6_TGFb_48_vs_IL6_48_counts_normalized_by_DESeq2](https://github.com/ceirehay/BMIN503_Final_Project/blob/master/[SRP201470_IL6_TGFb_48_vs_IL6_48_counts_normalized_by_DESeq2)
3. Log fold change:
  - (3.1) [SRP201470_IL6_rmSAA1_3_vs_IL6_3_full_DESeq2_results.txt](https://github.com/ceirehay/BMIN503_Final_Project/blob/master/SRP201470_IL6_rmSAA1_3_vs_IL6_3_full_DESeq2_results.txt)
  - (3.2) [SRP201470_IL6_rmSAA1_3_vs_IL6_TGFb_3_full_DESeq2_results.txt](https://github.com/ceirehay/BMIN503_Final_Project/blob/master/SRP201470_IL6_rmSAA1_3_vs_IL6_TGFb_3_full_DESeq2_results.txt)
  - (3.3) [SRP201470_IL6_rmSAA1_12_vs_IL6_12_full_DESeq2_results.txt](https://github.com/ceirehay/BMIN503_Final_Project/blob/master/SRP201470_IL6_rmSAA1_12_vs_IL6_12_full_DESeq2_results.txt)
  - (3.4) [SRP201470_IL6_rmSAA1_12_vs_IL6_TGFb_12_full_DESeq2_results.txt](https://github.com/ceirehay/BMIN503_Final_Project/blob/master/SRP201470_IL6_rmSAA1_12_vs_IL6_TGFb_12_full_DESeq2_results.txt)
  - (3.5) [SRP201470_IL6_rmSAA1_48_vs_IL6_48_full_DESeq2_results.txt](https://github.com/ceirehay/BMIN503_Final_Project/blob/master/SRP201470_IL6_rmSAA1_48_vs_IL6_48_full_DESeq2_results.txt)
  - (3.6) [SRP201470_IL6_rmSAA1_48_vs_IL6_TGFb_48_full_DESeq2_results.txt](https://github.com/ceirehay/BMIN503_Final_Project/blob/master/SRP201470_IL6_rmSAA1_48_vs_IL6_TGFb_48_full_DESeq2_results.txt)
  - (3.7) [SRP201470_IL6_TGFb_3_vs_IL6_3_full_DESeq2_results.txt](https://github.com/ceirehay/BMIN503_Final_Project/blob/master/SRP201470_IL6_TGFb_3_vs_IL6_3_full_DESeq2_results.txt)
  - (3.8) [SRP201470_IL6_TGFb_12_vs_IL6_12_full_DESeq2_results.txt](https://github.com/ceirehay/BMIN503_Final_Project/blob/master/SRP201470_IL6_TGFb_12_vs_IL6_12_full_DESeq2_results.txt)
  - (3.9) [SRP201470_IL6_TGFb_48_vs_IL6_48_full_DESeq2_results](https://github.com/ceirehay/BMIN503_Final_Project/blob/master/SRP201470_IL6_TGFb_48_vs_IL6_48_full_DESeq2_results.txt)
4. [SRP201470_DESeq2_Report.Rmd:](https://github.com/ceirehay/BMIN503_Final_Project/blob/master/SRP201470_DESeq2_Report.Rmd)
5. [SRP201470_DESeq2_Report.html:](https://github.com/ceirehay/BMIN503_Final_Project/blob/master/SRP201470_DESeq2_Report.html)

**Functional Enrichment Analysis Results**

1. [GSEA_GO_results.csv]
2. [GSEA_hallmark_results.csv]
3. [GSEA_KEGG_results.csv]
4. [GSEA_reactome_results.csv]
5. [GSEA_WP_results.csv]
6. [GSEA_TexhDN_results.csv]
7. [GSEA_TexhUP_results.csv]
8. [SRP201470_FunctionalEnrichment_03.Rmd]
9. [SRP201470_FunctionalEnrichment_03.html]

