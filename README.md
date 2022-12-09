# BMIN503/EPID600 Final Project


This repository contains:

-gesualdiJ_503_Final.Rmd
    -R Markdown file containing code, plots, and descriptions of the processes outlined below (Methods and Results)
    
-gesualdiJ_503_Final.html
    - The Final knitted html file composed from the .Rmd

-One compiled aggregate dataset composed of the publicly available datasets queried for this study: BMIN_503_Aggregated_Transcriptomes.tsv. The constituent datasets are listed below:

    -GSE89960: Gosselin, Reference dataset: ExVivo microglia sequenced directly following surgical resection/isolation from pediatric patients
        -Previously provided by a collaborator, read in directly from an excel file
    -GSE99047: Eggen, Reference data set: ExVivo microglia sequenced directly following surgical resection/isolation from adult patients (EnsembleDB)   
    
    -GSE143687: Ryan, IPSC microglia cultured in vitro or monocyte derived macrophages cultured in vitro
        -Previously pre-processed
    -GSE89189: Abud, IPSC Microglia monocultured or cultured with neurons (ArchS4)
    -GSE133432: Blurton Jones, IPSC microglia transplanted into the brain of humanized mice (ArchS4)
    -GSE139194: Svoboda, IPSC Microglia either transplanted into the brain of humanized mice or cultured in vitro (ArchS4)
    


-A Note: This project is limited in its scope, but could serve as a starting point for a more comprehensive literature review and meta-analysis of different approaches used to generate IPSC-microglia including various coculture methods and integration into three dimensional culture systems such as neuronal organoids or spheroids. 

Overview:

My project will be a limited meta-analysis of existing bulk RNAseq data sets detailing the differentiation of induced-pluripotent stem cells (IPSCs) into microglia, a key population of resident immune cells in the central nervous system (CNS). IPSC-based modeling is the future of microglia biology in vitro, thus there are many competing standards - eg different IPSC-derived microglia produced by different groups. My analysis will compare the transcriptomes of these competing microglia to a "Gold Standard" or reference transcriptomic dataset generated using microglia isolated from post-mortem biopsies from human donors. 


Introduction:

Microglia have long been challenging to model in-vitro using conventional approaches such as immortalized cell lines or primary culture because their morphology, function, and (more recently appreciated) transcriptome rapidly deteriorate when cultured in isolation. To address this issue, numerous groups have developed microglial cell lines derived from IPSCs through supplementation of cultures with various factors normally present in the micro-encironment of the CNS. The goal of this project is to interrogte the merit of the various published IPSC-derived microglia lines. 

Addressing this problem involves suject matter knowledge of both immunology and neuroscience, as well as various bioinformatic techniques. This analysis will include only a subset of published microglial lines, prioritizing those models that myself and Drs Schaletzki and Su considered influential. The reference transcriptomes - one from adult donors and one generated from analysis of fetal tissue - add rigor to this project because they represent the closest that we can realistically hope to get to the in vivo gene expression of microglia. Finally, this analysis will be useful to microglia biologists because while many transcriptomic data sets exist, there have been few if any comprehensive meta-analyses of these data and still fewer attempts to harmonize their insights. This project aims to make progress in that direction. 

Methods:

The general overview of the methods for this project is as follows:

- Access six total bulk sequencing transcriptomic sets, two reference data sets of Ex Vivo microglia and four published datasets of individual IPSC microglia           differentiation protocols. 
  - Clean datasets using base R or dplyr, then filter and normalize transcriptomic data using various tools from the edgeR package
  -The corresponding code is in blocks 3 - 8
  
- Aggregate these six datasets into a single data frame
  - The corresponding code is in block 9
  
More detailed descriptions are at the tops of code blocks 3 - 9 as well as interspersed throughout the code sections via comments. 


Results:

- Perform exploratory analysis on the aggregate dataset. I will visualize the relationships between the different microglia datasets via principal component analysis    using the prcomp() function from the stats package and generate interactive plots using ggplotly. 
  - This is an application of unsupervised machine learning to perform dimensionality reduction on the aggregate dataset to approximate the relationships between samples
  - The corresponding code is in block 10
  
- Perform differential gene expression (DGE) analysis using variious functions from the limma package. Pairwise comparisons used for DGE analysis were selected 
  based on the exploratory analysis. 
  - This is an application of fitting a linear model to the individual observations / genes in the dataset to determine which are expressed to significantly distinct        levels across specified comparisons, explained below 
  - The corresponding code is in block 11
  
- Perform GSEA analysis using GSEA() from the clusterProfiler package. Results were visualized using other functions from this package. 
  - The corresponding code is in block 12
  
More detailed descriptions are at the tops of code blocks 10 - 12

Conclusions:

Xenotransplanted microglia from Svoboda and Blurton-Jones studies outperform both in-study in vitro controls and and in vitro IPSC-microglia from Abud and Ryan studies. Of the two xenotransplanted datasets, the Blurton-Jones microglia are closest to the reference dataset based on the (rudimentary) quantification of principal component distances (eg at the end of code block 10)

Xenotransplanted samples were not drastically closer to the reference ex vivo samples based on the PCA plots. Considering that these protocols are much more expensive and technically challenging / intensive than in vitro approaches, labs should carefully consider which protocol makes the most sense for them based on their specific questions and unique logistics/capacity. 

The exclusion of unrelated / non—microglial cell types in aggregate PCA allows us to more realistically interpret relationships between the different microglial preparations. However, the inclusion of other myeloid cell types or partially differentiated IPSCs may be additionally informative and may be worth working into the analysis. 

Differential gene expression analysis showed that datasets that grouped farther apart on the exploratory PCA showed higher numbers of differentially expressed genes, as expected. More in depth GSEA analysis, as began in block 12, would be necessary to draw conclusions about gene signatures peculiar to individual protocols. 

This limited analysis has many limitations, the most critical is the loss of data that occured when aggregating the six constituent datasets, over 4000 observations. Future applications of this code would need to either more effectively join the datasets or otherwise impute this missing date. Additionally, only a small number of studies and published protocols are included in this study; a more extensive meta-analysis would need to incorporate many more studies and of course have more rigid inclusion / exclusion criteria. Finally, the datasets combined in this study may have been generated using different protocols / instruments, which is another source of variation in the final dataset.  



