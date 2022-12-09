#test script for playing with data, reading in with readxl package, cleaning w dplyr

#install and load packages----

install.packages("BiocManager")
BiocManager::install(c("GEOquery", 
                       "oligo", 
                       "limma", 
                       "hgu133plus2.db", 
                       "pd.hg.u133.plus.2", 
                       "viridis", 
                       "fgsea", 
                       "edgeR",
                       "gplots"))
install.packages("tidyverse")
install.packages("reshape2")
install.packages("edgeR")
install.packages("readxl")
install.packages("ggplot2")
install.packages("fgsea")
install.packages("stringr")
install.packages("readr")
install.packages("purrr")
install.packages("plotly")
install.packages("gt")
install.packages("magrittr")
install.packages("geosphere")
BiocManager::install("ensembldb") 
BiocManager::install("AnnotationHub") 
BiocManager::install("rhdf5") 
BiocManager::install("mixOmics") 
BiocManager::install('EnhancedVolcano')
BiocManager::install("factoextra")
BiocManager::install("GSVA")
BiocManager::install("gprofiler2")
BiocManager::install("GSEABase")
BiocManager::install("clusterProfiler")
BiocManager::install("enrichplot")
install.packages("DT")


library(BiocManager)
library(tidyverse)
library(reshape2)
library(rhdf5)
library(edgeR)
library(readxl)
library(GEOquery)
library(oligo)
library(limma)
library(viridis)
library(pd.hg.u133.plus.2)
library(hgu133plus2.db)
library(ggplot2)
library(gplots)
library(fgsea)
library(stringr)
library(readr)
library(ensembldb)
library(AnnotationHub)
library(purrr)
library(plotly)
library(mixOmics)
library(gt)
library(EnhancedVolcano)
library(magrittr)
library(factoextra)
library(GSVA)
library(gprofiler2)
library(GSEABase)
library(clusterProfiler)
library(enrichplot)
library(geosphere)
library(DT)

#Gosselin Data, Fetal Ex-Vivo Microglia (Reference) ----

#This Reference dataset contains 24  ex-vivo microglia samples from 
#pediatric patients isolated following surgical resection
#The number of observations (expressed genes) for this dataset is 14,528
#The processed data frames containing these data are stored in tbl's 
#"ExVivo_Juvenile_MG_Reference_Gosselin" (no GeneID column, gene names are row names) 
#or "Gosselin_log2_cpm_filtered_norm" (maintains GeneID as a separate column)

#These data are published but the .xlsx file containing the raw counts, 
#sample labels, and gene names were sent to me by a collaborator
#Therefore, I can just read the counts into a data frame and begin cleaning, 
#filtering, and normalizing without having to access any 
#Transcriptomic repositories or databases. That makes the processing for this data 
#set simpler but less generalizeable. The following 
#Datasets make use of either EnsembleDB or ArchS4 and are 
#therefore more informative for directly accessing published data without any personal connections. 

#Read in raw counts
microglia_fetal_ExVivo_Gosselin <- read_xlsx("Human_RNA-seq_data_Gosselin_Fetal_ExVivo.xlsx", sheet = 1, skip = 1) 
microglia_fetal_ExVivo_Gosselin <- dplyr::rename(microglia_fetal_ExVivo_Gosselin, Gene_ID = ...1)

#remove any duplicated genes symbols (2) and ove gene labels from column to rowname
microglia_fetal_ExVivo_Gosselin <- microglia_fetal_ExVivo_Gosselin[!duplicated(microglia_fetal_ExVivo_Gosselin$Gene_ID), ]  
microglia_fetal_ExVivo_Gosselin <- column_to_rownames(microglia_fetal_ExVivo_Gosselin, var = "Gene_ID") 

#Removes 40 columns of unneeded monocyte/in vitro/lysate data
microglia_fetal_ExVivo_Gosselin <- microglia_fetal_ExVivo_Gosselin %>%    
  dplyr::select(!contains("InVitro") & !contains("Monocytes") & !contains("Lysate"))  
sample_Labels_Gosselin <- colnames(microglia_fetal_ExVivo_Gosselin)

#Convert to DGE list to facilitate normalization and count visualization
#Then get counts per million (cpm) to visualize unexpressed / lowly expressed probes
DGEList_Gosselin <- DGEList(microglia_fetal_ExVivo_Gosselin) 
Gosselin_cpm <- cpm(DGEList_Gosselin$counts)                

#Table shows number of non-expressed genes across all samples, indicates roughly how many should be filtered out
table(rowSums(DGEList_Gosselin$counts==0)==24)               

#Create and reshape (melt) tibble of log transformed raw counts to visualized unfiltered / unnormalized data
#reshape2::melt() is a method that transforms tbl.df's from a wide or user friendly format
# to a 'tall' or processing friendly format. see below 
Gosselin_log2_cpm <- as_tibble(cpm(DGEList_Gosselin$counts, log = TRUE) , rownames = "GeneID") 
Gosselin_log2_cpm_melt <- melt(Gosselin_log2_cpm)
head(Gosselin_log2_cpm_melt)

#visualize overall expression to show excessive influence of unexpressed / lowly expressed genes
ggplot(Gosselin_log2_cpm_melt, aes(x=variable, y=value, fill=variable)) +     
  geom_violin(trim = FALSE, show.legend = FALSE) +
  stat_summary(fun.y = "median", 
               geom = "point", 
               shape = 124, 
               size = 6, 
               color = "black", 
               show.legend = FALSE) +
  theme(axis.text.x=element_blank()) +
  labs(y="log2 expression",
       title="Log2 Counts per Million (CPM)",
       subtitle="Gosselin, unfiltered, non-normalized",
       caption=paste0("produced on ", Sys.time()))

#create logical vector that evaluates to TRUE when at least 6 of 24 samples express a given gene 
filtrate_gosselin <- rowSums(Gosselin_cpm > 1) >= 6  
table(filtrate_gosselin)

#subset DGE list so that only genes expressed in at least 6 samples remain
#the get counts per million / reshape to re-visualize distribution of expression without unexpressed probes
DGEList_Gosselin_filtered <- DGEList_Gosselin[filtrate_gosselin, ] 
Gosselin_log2_cpm_filtered <- as_tibble(cpm(DGEList_Gosselin_filtered, log = TRUE), rownames = "GeneID") 
Gosselin_log2_cpm_filtered_melt <- melt(Gosselin_log2_cpm_filtered)
ggplot(Gosselin_log2_cpm_filtered_melt, aes(x=variable, y=value, fill=variable)) +     
  geom_violin(trim = FALSE, show.legend = FALSE) +
  stat_summary(fun.y = "median", 
               geom = "point", 
               shape = 124, 
               size = 6, 
               color = "black", 
               show.legend = FALSE) +
  theme(axis.text.x=element_blank()) +
  labs(y="log2 expression",
       title="Log2 Counts per Million (CPM)",
       subtitle="Gosselin, filtered, non-normalized",
       caption=paste0("produced on ", Sys.time()))

#TPM normalization of filtered DGE list, then store data in tbl.df's
DGEList_Gosselin_filtered_norm <- calcNormFactors(DGEList_Gosselin_filtered, method = "TMM") 
Gosselin_log2_cpm_filtered_norm <- as_tibble(cpm(DGEList_Gosselin_filtered_norm, log = TRUE), rownames = "GeneID") 
ExVivo_Juvenile_MG_Reference_Gosselin <- column_to_rownames(Gosselin_log2_cpm_filtered_norm, var = "GeneID") 

#clean up lengthy sample labels for this dataset. haters will suggest rewriting with vapply. I will never learn vapply!
labels_Gosselin <- rep(NA, 24)  
i <- 1
while (i <= 24){
  labels_Gosselin[i] = paste0(paste0("J", substring(sample_Labels_Gosselin[i], 16, 32)), as.character(i))
  i = i + 1
}
colnames(ExVivo_Juvenile_MG_Reference_Gosselin) <- labels_Gosselin
colnames(Gosselin_log2_cpm_filtered_norm)[2:ncol(Gosselin_log2_cpm_filtered_norm)] <- labels_Gosselin


#Eggen Data, Adult Ex-Vivo Microglia (Reference)----

##This processed Reference dataset will contain 39 total samples 
#(all Ex Vivo microglia surgically resected from adult patients)
#The number of observations (expressed genes) for this dataset is 14,397
#The processed data frames containing these data are stored in tbl's 
#"ExVivo_Adult_MG_Reference_Eggen" (no GeneID column, gene names are row names) 
#or "Eggen_log2_cpm_filtered_norm" (maintains GeneID as a separate column)

#This dataset was accessed by directly downloading the tsv containing the 
#raw counts from GEO. However, these data contained only
#transcript IDs instead of gene names like the other datasets. Therefore, 
#I needed to use AnnotationHub() to access the Ensemble Data base
#in order to map the transcript IDs to the appropriate gene names. 
#This is comparable to the use of hgu133plus2.db in Practicum 9,
#But is optimized for Bulk RNA sequencing data rather than MicroArrays, 
#which are somewhat out of date (no shade)

#This is an alternative approach to using the ArchS4 database, which I employ for 
#the next 3 datasets. This Method was mainly included to showcase alternate approaches 
#to access GEO data without downloading and reading in the  large (16 GB!) Archs4 database
#This is also a more beginner friendly approach that allows the user to avoid working with 
#the somewhat cumbersome HDF5 files that ArchS4 uses to organize data


ah <- AnnotationHub()
ahDb <- query(ah, pattern = c("Homo Sapiens", "EnsDb"))  

#Query for available H.Sapiens EnsDb databases, using for mapping probe id's to gene names
EndDB_Hs <- ahDb[["AH104864"]]
EnsDB_Hs <- EndDB_Hs  
EnsDB_Hs_DF <- genes(EnsDB_Hs, return.type = "data.frame") %>%
  dplyr::select(gene_id, gene_name)
EnsDB_Hs_DF <- dplyr::rename(EnsDB_Hs_DF, Tx_ID = gene_id)

#read in data, will need to add gene names using EnsDB information
microglia_adult_ExVivo_Eggen <- read_tsv("GSE99074_HumanMicrogliaBrainCounts.txt")       
microglia_adult_ExVivo_Eggen <- dplyr::rename(microglia_adult_ExVivo_Eggen, Tx_ID = ...1)

#subset list of matched tx_id's and gene names to only include tx's present in dataset
EnsDB_Hs_DF <- dplyr::filter(EnsDB_Hs_DF, EnsDB_Hs_DF$Tx_ID %in% microglia_adult_ExVivo_Eggen$Tx_ID)  
microglia_adult_ExVivo_Eggen <- inner_join(microglia_adult_ExVivo_Eggen, EnsDB_Hs_DF, by = "Tx_ID")
microglia_adult_ExVivo_Eggen <- relocate(microglia_adult_ExVivo_Eggen, gene_name, .before = spm09)
microglia_adult_ExVivo_Eggen <- microglia_adult_ExVivo_Eggen[ , 1:67]
microglia_adult_ExVivo_Eggen <- dplyr::rename(microglia_adult_ExVivo_Eggen, GeneID = gene_name)

#5116 transcripts ID's for which there is no corresponding gene name, we remove using dplyr::filter
table(microglia_adult_ExVivo_Eggen$GeneID == "") 

microglia_adult_ExVivo_Eggen <- dplyr::filter(microglia_adult_ExVivo_Eggen, GeneID != "")
microglia_adult_ExVivo_Eggen <- microglia_adult_ExVivo_Eggen[ , 2:67]
microglia_adult_ExVivo_Eggen <- microglia_adult_ExVivo_Eggen[1:40]
microglia_adult_ExVivo_Eggen <- microglia_adult_ExVivo_Eggen[!duplicated(microglia_adult_ExVivo_Eggen$GeneID), ]
microglia_adult_ExVivo_Eggen <- column_to_rownames(microglia_adult_ExVivo_Eggen, var = "GeneID")

#Create DGElist, find counts per million, visualize distribution of data, and filter out unexpressed probes
DGEList_Eggen <- DGEList(microglia_adult_ExVivo_Eggen)      
Eggen_cpm <- cpm(DGEList_Eggen)                
table(rowSums(DGEList_Eggen$counts==0)==20)     

#Create and reshape (melt) tibble of log transformed raw counts to visualized unfiltered / unnormalized data
Eggen_log2_cpm <- as_tibble(cpm(DGEList_Eggen, log = TRUE) , rownames = "GeneID") 
Eggen_log2_cpm_melt <- melt(Eggen_log2_cpm)

#visualize overall expression to show excessive influence of unexpressed / lowly expressed genes
ggplot(Eggen_log2_cpm_melt, aes(x=variable, y=value, fill=variable)) +     
  geom_violin(trim = FALSE, show.legend = FALSE) +
  stat_summary(fun.y = "median", 
               geom = "point", 
               shape = 124, 
               size = 6, 
               color = "black", 
               show.legend = FALSE) +
  theme(axis.text.x=element_blank()) +
  labs(y="log2 expression",
       title="Log2 Counts per Million (CPM)",
       subtitle="Eggen, unfiltered, non-normalized",
       caption=paste0("produced on ", Sys.time()))

#create logical vector that evaluates to TRUE when at least 20 of 39 samples express a given gene 
filtrate_eggen <- rowSums(Eggen_cpm > 1) >= 20  
table(filtrate_eggen)

#subset DGE list so that only genes expressed in at least 24 samples remain, remove 8110 unexpressed genes
#then reformat to log2 counts per million to reshape and revisualize distribution of data
DGEList_Eggen_filtered <- DGEList_Eggen[filtrate_eggen, ]
Eggen_log2_cpm_filtered <- as_tibble(cpm(DGEList_Eggen_filtered, log = TRUE), rownames = "GeneID") 

Eggen_log2_cpm_filtered_melt <- melt(Eggen_log2_cpm_filtered)
ggplot(Eggen_log2_cpm_filtered_melt, aes(x=variable, y=value, fill=variable)) +     
  geom_violin(trim = FALSE, show.legend = FALSE) +
  stat_summary(fun.y = "median", 
               geom = "point", 
               shape = 124, 
               size = 6, 
               color = "black", 
               show.legend = FALSE) +
  theme(axis.text.x=element_blank()) +
  labs(y="log2 expression",
       title="Log2 Counts per Million (CPM)",
       subtitle="Eggen, filtered, non-normalized",
       caption=paste0("produced on ", Sys.time()))

#TPM normalization, store proccessed data as tbl.df
DGEList_Eggen_filtered_norm <- calcNormFactors(DGEList_Eggen_filtered, method = "TMM") 
Eggen_log2_cpm_filtered_norm <- as_tibble(cpm(DGEList_Eggen_filtered_norm, log = TRUE), rownames = "GeneID") 
ExVivo_Adult_MG_Reference_Eggen <- column_to_rownames(Eggen_log2_cpm_filtered_norm, var = "GeneID") 

#Clean up non-intuitive sample labels. 
labels_Eggen <- rep(NA, ncol(ExVivo_Adult_MG_Reference_Eggen))  
j <- 1

while (j <= length(labels_Eggen)){
  labels_Eggen[j] = paste0("A_Microllia_ExVivo", as.character(j))
  j = j + 1
}
colnames(ExVivo_Adult_MG_Reference_Eggen) <- labels_Eggen

#Format maintaining GeneID column, needed for join function
Eggen_log2_cpm_filtered_norm <- rownames_to_column(ExVivo_Adult_MG_Reference_Eggen, var = "GeneID")

#KJS Lab internal data, IPSC-Microglia and Monocyte Derived Macrophages, Pre-Processed ----

#This data set was previously prepared for my thesis lab. 
#Contains 3 IPSC-Microglia samples and 3 Monocyte-derived Macrophage (MDM) samples
#The total number of observations (expressed genes) for this dataset is 14,139
#Only handling here is adding the prefix "KJS_" to the start of the existing 
#sample labels to facilitate downstream aggregation / analysis
#Tbl "KJS_iMG_MDM" contains this dataset and maintains a GeneID column

KJS_iMG_MDM <- read_xlsx("KJS_iMG_MDM_TMM_Normalized.xlsx")
labels_KJS <- c(rep(NA, ncol(KJS_iMG_MDM)))
labels_KJS[1] <- "GeneID"
for(n in 2: ncol(KJS_iMG_MDM)){
  labels_KJS[n] <- paste0("KJS_", colnames(KJS_iMG_MDM[n]))
}
colnames(KJS_iMG_MDM) <- labels_KJS


#Abud 2017 data (IPSC-Microglia +/- coculture with Rat Hippocampal neurons)----

#This processed dataset will contain 15 total samples (9 monocultured IPSC-iMg, 
#6 iMg cocultured with rat hippocampal neurons. Cocultured iMg are notated 'rHcN')
#The number of observations (expressed genes) for this dataset is 12,968
#The processed data frames containing these data are stored in tbl's "IPSC_Microglia_Abud" 
#(no GeneID column, gene names are row names) 
#or "DGEList_Abud_filtered_norm" (maintains GeneID as a separate column)

#This dataset, as well as those from the Svoboda and Blurton-Jones Publications 
#were accessed and cleaned using the Archs4 database which contains
#All of the samples ever uploaded to the Gene Expression Omnibus Repository 
#and includes - among other information -  raw counts for samples as
#Well as descriptions of different samples and overall study design. 

#This is the most efficient way to access and clean data from GEO, 
#as the available metadata typically provides a work around for 
#digging into the supplementary information of a given publication 
#to find sample information

#bring in downloaded ArchS4 database containing all GEO accessible transcriptomic data
archs4.human <- "/Users/jamesgesualdi/Desktop/BMIN_5030/BMIN503_Final_Project_Local/human_matrix_v11.h5"  
h5ls(archs4.human)  #List the contents of the loaded Database

#Read in all 441,356 GEO Accession numbers (eg all total human samples on GEO)
all.samples.human <- h5read(archs4.human, name="meta/samples/geo_accession")    

#Query the ArchS4 database for the samples I need from the Abud study, based on descriptions in the paper and on the GEO Entry
Abud_Samples <- c("GSM2360252",	#10318X2
                  "GSM2360253",	#7028X2
                  "GSM2360254",	#x2-1
                  "GSM2360255",	#x2-2
                  "GSM2360256",	#x2-3
                  "GSM2360257",	#x2-4
                  "GSM2360283",	#HC-1
                  "GSM2360284",	#HC-2
                  "GSM2360285",	#HC-3
                  "GSM2360286",	#HC-4
                  "GSM2360287",	#HC-5
                  "GSM2360288",	#HC-6
                  "GSM2445478",	#n200 -2
                  "GSM2445479",	#n200 -3
                  "GSM2445480"	#n200 -4
)	

#Find the indices of the above samples using their accession numbers
Abud_Sample_Locations <- which(all.samples.human %in% Abud_Samples)     
genes <- h5read(archs4.human, "meta/genes/genes")   #Bring in gene labels provided by ArchS4

#Read in raw counts for my samples of interest
Expression_Abud <- t(h5read(archs4.human, "data/expression",                  
                     index=list(Abud_Sample_Locations, 1:length(genes))))   
H5close()
rownames(Expression_Abud) <- genes
colnames(Expression_Abud) <- all.samples.human[Abud_Sample_Locations]

#Below, I access some meta-data from the study to verify that the appropriate 
#data was extracted from ArchS4, and clean up colnames to more informative labels
Sample_source_name_ch1 <- h5read(archs4.human, "meta/samples/source_name_ch1")     
Sample_title <- h5read(archs4.human, name= "meta/samples/title")                   
Sample_characteristics <- h5read(archs4.human, name="meta/samples/characteristics_ch1")   

studyDesign_Abud <- tibble(Sample_title_Abud = Sample_title[Abud_Sample_Locations], 
                      Sample_source_name_ch1 = Sample_source_name_ch1[Abud_Sample_Locations],
                      Sample_characteristics = Sample_characteristics[Abud_Sample_Locations])

head(studyDesign_Abud)                                #Just for context

colnames(Expression_Abud) <- studyDesign_Abud$Sample_title_Abud

#Create DGE list and get cpm values for filtering / normalization
DGEList_Abud <- DGEList(Expression_Abud)     
Abud_cpm <- cpm(DGEList_Abud)                
table(rowSums(DGEList_Abud$counts==0)==15)              

#Create and reshape (melt) tibble of log transformed raw counts to visualized unfiltered / unnormalized data
Abud_log2_cpm <- as_tibble(cpm(DGEList_Abud, log = TRUE) , rownames = "GeneID") 
Abud_log2_cpm_melt <- melt(Abud_log2_cpm)

#visualize overall expression to show excessive influence of unexpressed / lowly expressed genes
ggplot(Abud_log2_cpm_melt, aes(x=variable, y=value, fill=variable)) +     
  geom_violin(trim = FALSE, show.legend = FALSE) +
  stat_summary(fun.y = "median", 
               geom = "point", 
               shape = 124, 
               size = 6, 
               color = "black", 
               show.legend = FALSE) +
  theme(axis.text.x=element_blank()) +
  labs(y="log2 expression",
       title="Log2 Counts per Million (CPM)",
       subtitle="Abud, unfiltered, non-normalized",
       caption=paste0("produced on ", Sys.time()))

#create logical vector that evaluates to TRUE when at least 4 of 15 samples express a given gene
filtrate_abud <- rowSums(Abud_cpm > 1) >= 4   
table(filtrate_abud)

#subset DGE list so that only genes expressed in at least 3 samples remain, remove 24,138 unexpressed genes
#Redo cpm / log transformation and reshape / revisualize data
DGEList_Abud_filtered <- DGEList_Abud[filtrate_abud, ] 
Abud_log2_cpm_filtered <- as_tibble(cpm(DGEList_Abud_filtered, log = TRUE), rownames = "GeneID") 

Abud_log2_cpm_filtered_melt <- melt(Abud_log2_cpm_filtered)     
ggplot(Abud_log2_cpm_filtered_melt, aes(x=variable, y=value, fill=variable)) +   
  geom_violin(trim = FALSE, show.legend = FALSE) +
  stat_summary(fun.y = "median", 
               geom = "point", 
               shape = 124, 
               size = 6, 
               color = "black", 
               show.legend = FALSE) +
  theme(axis.text.x=element_blank()) +   
  labs(y="log2 expression",
       title="Log2 Counts per Million (CPM)",
       subtitle="Abud, filtered, non-normalized",
       caption=paste0("produced on ", Sys.time()))

#TPM normalization
DGEList_Abud_filtered_norm <- calcNormFactors(DGEList_Abud_filtered, method = "TMM") 
DGEList_Abud_filtered_norm <- as_tibble(cpm(DGEList_Abud_filtered_norm, log = TRUE), rownames = "GeneID") 
IPSC_Microglia_Abud <- column_to_rownames(DGEList_Abud_filtered_norm, var = "GeneID")                 
IPSC_Microglia_Abud <- IPSC_Microglia_Abud  %>%
  dplyr::select(order(colnames(IPSC_Microglia_Abud)))

#clean up non-intuitive sample labels
labels_Abud <- c(rep("IPSC_Microglia_Abud", 2), rep("IPSC_Microglia_Abud_rHcN", 6), rep("IPSC_Microglia_Abud", 7))  
labels_Abud_Numbers <- c("1", "2", "1", "2", "3", "4", "5", "6", "3", "4", "5", "6", "7", "8", "9")
for(l in 1:length(labels_Abud)){
  labels_Abud[l] <- paste0(labels_Abud[l], labels_Abud_Numbers[l])
}
colnames(IPSC_Microglia_Abud) <- labels_Abud

#reorder again for convenient grouping of now renamed samples,
#Add inproved labels to DGEList_Abud_filtered_norm
IPSC_Microglia_Abud <- dplyr::select(IPSC_Microglia_Abud, order(colnames(IPSC_Microglia_Abud)))
DGEList_Abud_filtered_norm <- rownames_to_column(IPSC_Microglia_Abud, var = "GeneID")

#Blurton jones 2019 data (IPSC-Microglia +/- Transplant ("Xenograft") into chimeric mice) ----

#This processed dataset will contain 16 total samples (10 transplanted iMg, 
#6 in vitro. Transplanted iMg are notated 'xMG')
#The number of observations (expressed genes) for this dataset is 13,421
#The processed data frames containing these data are stored in tbl's 
#"IPSC_Microglia_Blurton" (no GeneID column, gene names are row names) 
#or "DGEList_Blurton_filtered_norm" (maintains GeneID as a separate column)

Blurton_Samples <- c("GSM3908536",	#MBJ_iMGL_SAL_1
  "GSM3908537",	#MBJ_iMGL_SAL_2
  "GSM3908538",	#MBJ_iMGL_SAL_3
  "GSM3908539",	#MBJ_iMGL_LPS_1
  "GSM3908540",	#MBJ_iMGL_LPS_2
  "GSM3908541",	#MBJ_iMGL_LPS_3
  "GSM3908542",	#MBJ_xMG_GFP_1
  "GSM3908543",	#MBJ_xMG_GFP_2
  "GSM3908544",	#MBJ_xMG_GFP_3
  "GSM3908545",	#MBJ_xMG_GFP_LPS_1
  "GSM3908546",	#MBJ_xMG_GFP_LPS_2
  "GSM3908547",	#MBJ_xMG_GFP_LPS_3
  "GSM3908548",	#MBJ_xMG_GFP_LPS_4
  "GSM3908549",	#MBJ_xMG_GFP_LPS_5
  "GSM3908550",	#MBJ_xMG_CDI_1
  "GSM3908551",	#MBJ_xMG_CDI_2
  "GSM3908552",	#MBJ_xMG_CDI_3
  "GSM3908553",	#MBJ_xMG_CDI_4
  "GSM3908554",	#MBJ_xMG_CDI_5
  "GSM3908555",	#MBJ_xMG_CDI_6
  "GSM3908556",	#MBJ_xMG_10C_1
  "GSM3908557",	#MBJ_xMG_10C_2
  "GSM3908558",	#MBJ_xMG_10C_3
  "GSM3908559",	#MBJ_xMG_10C_4
  "GSM3908560",	#MBJ_ExVivo_1
  "GSM3908561",	#MBJ_ExVivo_2
  "GSM3908562",	#MBJ_iMGL_GFP_1
  "GSM3908563",	#MBJ_iMGL_GFP_2
  "GSM3908564",	#MBJ_iMGL_GFP_3
  "GSM3908565",	#MBJ_iMGL_GFP_4
  "GSM3908566",	#MBJ_iMGL_GFP_5
  "GSM3908567"	#MBJ_iMGL_GFP_6
)

Blurton_Sample_Locations <- which(all.samples.human %in% Blurton_Samples)
Expression_Blurton <- t(h5read(archs4.human, "data/expression", 
                               index=list(Blurton_Sample_Locations, 1:length(genes))))
H5close()
rownames(Expression_Blurton) <- genes
colnames(Expression_Blurton) <- all.samples.human[Blurton_Sample_Locations]

#Below, I access some meta-data from the study to verify that the appropriate data was 
#extracted from ArchS4, and clean up colnames to more informative labels
studyDesign_Blurton <- tibble(Sample_title_Blurton = Sample_title[Blurton_Sample_Locations], 
                              Sample_source_name_ch1_Blurton = Sample_source_name_ch1[Blurton_Sample_Locations],
                              Sample_characteristics_Blurton = Sample_characteristics[Blurton_Sample_Locations])
head(studyDesign_Blurton)

colnames(Expression_Blurton) <- studyDesign_Blurton$Sample_title_Blurton

#Remove samples unnecessary for this analysis based on sample characteristics accessed above
Expression_Blurton <- Expression_Blurton[ , c(15:24, 27:32)]              

#Create DGE list for filtering / normalizing Blurton Data
DGEList_Blurton <- DGEList(Expression_Blurton)      
Expression_Blurton_cpm <- cpm(DGEList_Blurton)                
table(rowSums(DGEList_Blurton$counts==0)==18)              

#Create and reshape (melt) tibble of log transformed raw counts to visualized unfiltered / unnormalized data
Blurton_log2_cpm <- as_tibble(cpm(DGEList_Blurton, log = TRUE) , rownames = "GeneID") 
Blurton_log2_cpm_melt <- melt(Blurton_log2_cpm)

#visualize overall expression to show excessive influence of unexpressed / lowly expressed genes
ggplot(Blurton_log2_cpm_melt, aes(x=variable, y=value, fill=variable)) +     
  geom_violin(trim = FALSE, show.legend = FALSE) +
  stat_summary(fun.y = "median", 
               geom = "point", 
               shape = 124, 
               size = 6, 
               color = "black", 
               show.legend = FALSE) +
  theme(axis.text.x=element_blank()) +                    
  labs(y="log2 expression",
       title="Log2 Counts per Million (CPM)",
       subtitle="Blurton-Jones, unfiltered, non-normalized",
       caption=paste0("produced on ", Sys.time()))

#create logical vector that evaluates to TRUE when at least 6 of 16 samples express a given gene 
filtrate_Blurton<- rowSums(Expression_Blurton_cpm > 1) >= 6  
table(filtrate_Blurton)

#subset DGE list so that only genes expressed in at least 6 samples remain, remove 21817 unexpressed genes
#Redo counts per million, log transformation, and reshaping to visualize the filtered dataset
DGEList_Blurton_filtered <- DGEList_Blurton[filtrate_Blurton, ] 
Blurton_log2_cpm_filtered <- as_tibble(cpm(DGEList_Blurton_filtered, log = TRUE), rownames = "GeneID") 
Blurton_log2_cpm_filtered_melt <- melt(Blurton_log2_cpm_filtered)

ggplot(Blurton_log2_cpm_filtered_melt, aes(x=variable, y=value, fill=variable)) +   
  geom_violin(trim = FALSE, show.legend = FALSE) +
  stat_summary(fun.y = "median", 
               geom = "point", 
               shape = 124, 
               size = 6, 
               color = "black", 
               show.legend = FALSE) +
  theme(axis.text.x=element_blank()) + 
  labs(y="log2 expression",
       title="Log2 Counts per Million (CPM)",
       subtitle="Blurton-Jones, filtered, non-normalized",
       caption=paste0("produced on ", Sys.time()))

#TPM normalization
DGEList_Blurton_filtered_norm <- calcNormFactors(DGEList_Blurton_filtered, method = "TMM") 
DGEList_Blurton_filtered_norm <- as_tibble(cpm(DGEList_Blurton_filtered_norm, log = TRUE), rownames = "GeneID") 
IPSC_Microglia_Blurton <- column_to_rownames(DGEList_Blurton_filtered_norm, var = "GeneID")                

#Svoboda 2019 data, (IPSC-Microglia +/- Transplant ("Xenograft") into chimeric mice) ---- 

#This processed dataset will contain 18 total samples of IPSC microglia 
#(6 in transplant for 60 days, 6 in transplant for 10 days, and 6 differentiated in vitro (10 days))
#The number of observations (expressed genes) for this dataset is 13,433
#The processed data frames containing these data are stored in tbl's 
#"IPSC_Microglia_Svoboda" (no GeneID column, gene names are row names) 
#or "DGEList_Svoboda_filtered_norm" (maintains GeneID as a separate column)

Svoboda_Samples <- c("GSM4133389", #iMP1
                    "GSM4133390",	#iMP2
                    "GSM4133391",	#iMP3
                    "GSM4133392",	#iMP4
                    "GSM4133393",	#iMP5
                    "GSM4133394",	#iMP6
                    "GSM4133395",	#In vivo iMG 10dpi rep 1
                    "GSM4133396",	#In vivo iMG 10dpi rep 2
                    "GSM4133397",	#In vivo iMG 10dpi rep 3
                    "GSM4133398",	#In vivo iMG 10dpi rep 4
                    "GSM4133399",	#In vivo iMG 10dpi rep 5
                    "GSM4133400",	#In vivo iMG 10dpi rep 6
                    "GSM4133401",	#In vivo iMG 60dpi rep 1
                    "GSM4133402",	#In vivo iMG 60dpi rep 2
                    "GSM4133403",	#In vivo iMG 60dpi rep 3
                    "GSM4133404",	#In vivo iMG 60dpi rep 4
                    "GSM4133405",	#In vivo iMG 60dpi rep 5
                    "GSM4133406",	#In vivo iMG 60dpi rep 6
                    "GSM4133407",	#In vitro iMG 10dpi rep 1
                    "GSM4133408",	#In vitro iMG 10dpi rep 2
                    "GSM4133409",	#In vitro iMG 10dpi rep 3
                    "GSM4133410",	#In vitro iMG 10dpi rep 4
                    "GSM4133411",	#In vitro iMG 10dpi rep 5
                    "GSM4133412",	#In vitro iMG 10dpi rep 6
                    "GSM4133413", #In vitro iMG 60dpi rep 1
                    "GSM4133414", #In vitro iMG 60dpi rep 2
                    "GSM4133415",	#In vitro iMG 60dpi rep 3
                    "GSM4133416",	#In vitro iMG 60dpi rep 4
                    "GSM4133417",	#In vitro iMG 60dpi rep 5
                    "GSM4133418",	#In vitro iMG 60dpi rep 6
                    "GSM4133419",	#In Vivo 2 [M543]
                    "GSM4133420",	#In Vivo 1 [M544]
                    "GSM4133421",	#In Vivo 4 [M1]
                    "GSM4133422",	#In Vivo 3 [M2]
                    "GSM4133423",	#In Vitro 1 [IV1]
                    "GSM4133424"	#In Vitro 2 [IV2]
)

Svoboda_Sample_Locations <- which(all.samples.human %in% Svoboda_Samples)
Expression_Svoboda <- t(h5read(archs4.human, "data/expression", 
                            index=list(Svoboda_Sample_Locations, 1:length(genes))))
H5close()
rownames(Expression_Svoboda) <- genes
colnames(Expression_Svoboda) <- all.samples.human[Svoboda_Sample_Locations]

#Use Meta-data to create study design file and facilitate cleaning
studyDesign_Svoboda <- tibble(Sample_title_Svoboda = Sample_title[Svoboda_Sample_Locations], 
                           Sample_source_name_ch1_Svoboda = Sample_source_name_ch1[Svoboda_Sample_Locations],
                           Sample_characteristics_Svoboda = Sample_characteristics[Svoboda_Sample_Locations])

colnames(Expression_Svoboda) <- studyDesign_Svoboda$Sample_title_Svoboda
Expression_Svoboda <- Expression_Svoboda[ , 9:26] #remove irrelevant samples

##Create DGE list for filtering and normalization
#perform cpm() and log transformation to visualize
#overall distribution of expression data
DGEList_Svoboda <- DGEList(Expression_Svoboda)      
Expression_Svoboda_cpm <- cpm(DGEList_Svoboda)                
table(rowSums(DGEList_Svoboda$counts==0)==18)              

#Create and reshape (melt) tibble of log transformed raw counts to visualized unfiltered / unnormalized data
Svoboda_log2_cpm <- as_tibble(cpm(DGEList_Svoboda, log = TRUE) , rownames = "GeneID") 
Svoboda_log2_cpm_melt <- melt(Svoboda_log2_cpm)

#visualize overall expression to show excessive influence of unexpressed / lowly expressed genes
ggplot(Svoboda_log2_cpm_melt, aes(x=variable, y=value, fill=variable)) +     
  geom_violin(trim = FALSE, show.legend = FALSE) +
  stat_summary(fun.y = "median", 
               geom = "point", 
               shape = 124, 
               size = 6, 
               color = "black", 
               show.legend = FALSE) +
  theme(axis.text.x=element_blank()) +   
  labs(y="log2 expression",
       title="Log2 Counts per Million (CPM)",
       subtitle="Svoboda, unfiltered, non-normalized",
       caption=paste0("produced on ", Sys.time()))

#create logical vector that evaluates to TRUE when at least 6 of 18 samples express a given gene 
filtrate_Svoboda<- rowSums(Expression_Svoboda_cpm > 1) >= 6  
table(filtrate_Svoboda)

#subset DGE list so that only genes expressed in at least 6 samples remain. 
#This will 21805 unexpressed genes, I'll then violin plot again to visualize impact of filtering

DGEList_Svoboda_filtered <- DGEList_Svoboda[filtrate_Svoboda, ]
Svoboda_log2_cpm_filtered <- as_tibble(cpm(DGEList_Svoboda_filtered, log = TRUE), rownames = "GeneID") 
Svoboda_log2_cpm_filtered_melt <- melt(Svoboda_log2_cpm_filtered)

ggplot(Svoboda_log2_cpm_filtered_melt, aes(x=variable, y=value, fill=variable)) +   
  geom_violin(trim = FALSE, show.legend = FALSE) +
  stat_summary(fun.y = "median", 
               geom = "point", 
               shape = 124, 
               size = 6, 
               color = "black", 
               show.legend = FALSE) +
  theme(axis.text.x=element_blank()) +   
  labs(y="log2 expression",
       title="Log2 Counts per Million (CPM)",
       subtitle="Svoboda, filtered, non-normalized",
       caption=paste0("produced on ", Sys.time()))

#TPM normalization
DGEList_Svoboda_filtered_norm <- calcNormFactors(DGEList_Svoboda_filtered, method = "TMM") 
DGEList_Svoboda_filtered_norm <- as_tibble(cpm(DGEList_Svoboda_filtered_norm, log = TRUE), rownames = "GeneID") 
IPSC_Microglia_Svoboda <- column_to_rownames(DGEList_Svoboda_filtered_norm, var = "GeneID")                  

#Add "Svoboda_" to sample lables to facilitate later analysis and visualization. 
labels_Svoboda <- c(rep(NA, ncol(IPSC_Microglia_Svoboda)))     
for(m in 1:length(labels_Svoboda)){
  labels_Svoboda[m] <- paste0("Svoboda_", colnames(IPSC_Microglia_Svoboda[m]))
}
colnames(IPSC_Microglia_Svoboda) <- labels_Svoboda
colnames(DGEList_Svoboda_filtered_norm[2:ncol(DGEList_Svoboda_filtered_norm)]) <- labels_Svoboda

#Data Aggregation ----

#Here, I will add all 6 of the pre-processed datasets into a list, then use purrr::reduce() 
#to apply left_join() to all the elements of this list This will create a tibble of all 118 samples 
#with a total of 14,528 observations (expressed genes). The number of observations comes from the Gosselin 
#reference dataset, which had the largest number of samples (14,528). 

#However, this introduces NA data into the aggregate dataset, since other component
#tibbles may have been missing some of those genes. Removing any genes for which any 
#samples have NA vaues leads to a removal of 4269 genes, leading 
#to a final number of observations of 10,259 in the aggregate dataset. 

#For subsequent exploratory and DGE analysis, the generated tbl.df Aggregation_Set_Math will be used
#This tibble will also be written out to a .tsv for sharing offline/etc

Aggregation_List <- list(Gosselin_log2_cpm_filtered_norm, Eggen_log2_cpm_filtered_norm, KJS_iMG_MDM, 
                         DGEList_Abud_filtered_norm, DGEList_Blurton_filtered_norm, DGEList_Svoboda_filtered_norm)
Aggregation_Set <- Aggregation_List %>%
  purrr::reduce(left_join, by = "GeneID")
Aggregation_Set <- na.omit(Aggregation_Set) #remove NA probes
write_tsv(Aggregation_Set, "BMIN_503_Aggregated_Transcriptomes.tsv") #write to .tsv

#Move the gene names to rownames to eliminate the non numeric column, needed for PCA /
#Other statistical operations
Aggregation_Set_Math <- column_to_rownames(Aggregation_Set, var = "GeneID")  
dim(Aggregation_Set_Math)

#Create Study Design File for Aggregate set to facilitate DGE Analysis
#As well as further sharing of this report / dataset with colleagues. 
#Will contain sample labels and factors corresponding to Study authors
#For each dataset, condition (eg ExVivo, InVitro, Transplanted, etc),
#And cell type (microglia or macrophage, latter included as a sort of negative control)
#Other categorical variables (EG HIV infectable? yes or no, etc) could be added to this study design file
#to check other relationships between the datasets. Expand on this concept later

labels_Aggregate <- colnames(Aggregation_Set_Math)
studies_Aggregate <- c(rep("Gosselin_2017", 24), rep("Eggen_2017", 39), rep("Ryan_2020", 6), 
                       rep("Abud_2017", 15), rep("Blurton-Jones_2019", 16), rep("Svoboda", 18))

condition_Aggregate <- c(rep("ExVivo_Juvenile", 24), rep("ExVivo_Adult", 39), rep("InVitro_Monoculture", 6),
                         rep("InVitro_rHcN_Coculture", 6), rep("InVitro_Monoculture", 9),
                         rep("Xenografted", 10), rep("InVitro_Monoculture", 6), rep("Xenografted", 6),
                         rep("Xenografted_60d", 6), rep("InVitro_Monoculture", 6))

celltype_Aggregate <- c(rep("Microglia", 63), rep("Monocyte_Derived_Macrophages", 3),
                        rep("Microglia", 52))


Study_Design_Aggregate <- tibble(Sample_Labels = labels_Aggregate, Study = studies_Aggregate,
                                 Conditions = condition_Aggregate, Cell_Types = celltype_Aggregate)
Study_Design_Aggregate <- Study_Design_Aggregate %>%
  dplyr::mutate(Study = factor(Study, levels = c("Gosselin_2017", "Eggen_2017", "Ryan_2020",
                                                 "Abud_2017", "Blurton-Jones_2019", "Svoboda"))) %>%
  dplyr::mutate(Conditions = factor(Conditions, levels = c("ExVivo_Juvenile", "ExVivo_Adult", "InVitro_Monoculture",
                                                 "InVitro_rHcN_Coculture", "Xenografted", "Xenografted_60d"))) %>%
  dplyr::mutate(Cell_Types = factor(Cell_Types, levels = c("Microglia", "Monocyte_Derived_Macrophages")))

head(Study_Design_Aggregate)

#Exploratory Analysis (PCA)----

#Perform Principal Component Analysis (PCA) on the entire aggregated dataset.
#This is a common unsupervised ML approach for exploratory analysis
#of transcriptomic data. It allows us to visualize the degree of similarity / difference
#between various samples through dimensionality reduction. 

pca_res_aggregate <- prcomp(t(Aggregation_Set_Math), scale. = F, retx = T)
ls(pca_res_aggregate)

#The rotations indicate how much each individual gene contributes to each principal component
#Sometimes referred to in formulas as "loadings"
str(pca_res_aggregate$rotation)
head(pca_res_aggregate$rotation[1:5, 1:4])

#Store proportion of variance from each principal component (118 total) 
#in a Vector of Eigenvalues
pc_var_aggregate <- pca_res_aggregate$sdev^2  

#Calculate percentages of variance (eg sdev^2) per principal component, for PCA plot labels
pc_per_aggregate <- round(pc_var_aggregate/sum(pc_var_aggregate)*100, 1) 

#Read the coordinates, the value of each PCA for each sample (all 118 samples), and store in a data frame.
#main data for typical PCA plots of individual samples
head(pca_res_aggregate$x[1:5, 1:10])
pca_res_df_aggregate <- as_tibble(pca_res_aggregate$x)  

#Before creating the PCA plot of the samples, use fviz_eig to show the variation 
#due to each principal component. This is called a scree plot
#The form of this scree plot suggests tha tprincipal components 1, 2, and 3 are worth investigating / retaining

fviz_eig(pca_res_aggregate)


#Plot Principal Components 1 and 2
pca_plot_aggregate_1_2 <- ggplot(pca_res_df_aggregate, aes(x = PC2, y = PC1, 
                          color = condition_Aggregate, shape = studies_Aggregate)) +
                          geom_point(size = 3, alpha = .5) + 
                          xlab(paste0("PC2 (", pc_per_aggregate[2], "%", ")")) +
                          ylab(paste0("PC1 (", pc_per_aggregate[1], "%", ")")) +
                          labs(title = "PCA Plot") + 
                          stat_ellipse(aes(color =  condition_Aggregate), #Add Elipse to help differentiate groups
                          linewidth = 0.9, level = 0.95) 
ggplotly(pca_plot_aggregate_1_2)


#Plot Principal Components 1 and 3
pca_plot_aggregate_1_3 <- ggplot(pca_res_df_aggregate, aes(x = PC3, y = PC1, color = condition_Aggregate, shape = studies_Aggregate)) +
  geom_point(size = 3, alpha = .5) + 
  xlab(paste0("PC3 (", pc_per_aggregate[3], "%", ")")) +
  ylab(paste0("PC1 (", pc_per_aggregate[1], "%", ")")) +
  labs(title = "PCA Plot") + 
  stat_ellipse(aes(color =  condition_Aggregate), #Add Elipse to help differentiate groups
  linewidth = 0.9, level = 0.95) +
  theme_bw()
ggplotly(pca_plot_aggregate_1_3)


#Plot Principal Components 2 and 3
pca_plot_aggregate_2_3 <- ggplot(pca_res_df_aggregate, aes(x = PC3, y = PC2, color = condition_Aggregate, shape = studies_Aggregate)) +
  geom_point(size = 3, alpha = .5) + 
  xlab(paste0("PC3 (", pc_per_aggregate[3], "%", ")")) +
  ylab(paste0("PC2 (", pc_per_aggregate[2], "%", ")")) +
  labs(title = "PCA Plot") + 
  stat_ellipse(aes(color =  condition_Aggregate), #Add Elipse to help differentiate groups
               linewidth = 0.9, level = 0.95) +
  theme_bw()
ggplotly(pca_plot_aggregate_2_3)

#A goal of this analysis was to visualize and quantify the distance
#between different samples on the PCA plots. This ended up being somewhat challenging
#So the approach below is a simplified attempt to quantify the distance of 
#the various sample groups from the reference datasets by using simple centroids (eg arithmetic means of coordinates)
#of each group of samples based on their coordinates for principal components 1 and 2 and a simple
#novel distance function (called 'euclidean', introduced below)

pc1_pc2_ExVivo <- pca_res_aggregate$x[1:63, 1:2]
centroid_ExVivo <- c(mean(pc1_pc2_ExVivo[ , 1]), mean(pc1_pc2_ExVivo[ , 2]))

pc1_pc2_KJS_iMg <- pca_res_aggregate$x[67:69, 1:2]
centroid_KJS <- c(mean(pc1_pc2_KJS_iMg[ , 1]), mean(pc1_pc2_KJS_iMg[ , 2]))

pc1_pc2_Abud_iMg <- pca_res_aggregate$x[76:84, 1:2]
centroid_Abud <- c(mean(pc1_pc2_Abud_iMg[ , 1]), mean(pc1_pc2_Abud_iMg[ , 2]))

pc1_pc2_BlurtonJones_XMg <- pca_res_aggregate$x[85:94, 1:2]
centroid_BJ_XMg <- c(mean(pc1_pc2_BlurtonJones_XMg[ , 1]), mean(pc1_pc2_BlurtonJones_XMg[ , 2]))

pc1_pc2_BlurtonJones_iMg <- pca_res_aggregate$x[95:100, 1:2]
centroid_BJ_iMg <- c(mean(pc1_pc2_BlurtonJones_iMg[ , 1]), mean(pc1_pc2_BlurtonJones_iMg[ , 2]))

pc1_pc2_Svoboda_xMg <- pca_res_aggregate$x[107:112, 1:2]
centroid_Svoboda_xMg <- c(mean(pc1_pc2_Svoboda_xMg[ , 1]), mean(pc1_pc2_Svoboda_xMg[ , 2]))
  
pc1_pc2_Svoboda_iMg <- pca_res_aggregate$x[113:118, 1:2]
centroid_Svoboda_iMg <- c(mean(pc1_pc2_Svoboda_iMg[ , 1]), mean(pc1_pc2_Svoboda_iMg[ , 2]))

euclidean <- function(a, b) sqrt(sum((a - b)^2))

Dist_to_Ref <- data.frame(Samples = c("KJS iMG", "Abud_iMg", "BJ_XMg", "BJ_iMg", "Svoboda_XMg", "Svoboda_iMg"),
                          Distance = rep(NA, 6))
Dist_to_Ref$Distance[1] <- euclidean(centroid_ExVivo, centroid_KJS)
Dist_to_Ref$Distance[2] <- euclidean(centroid_ExVivo, centroid_Abud)
Dist_to_Ref$Distance[3] <- euclidean(centroid_ExVivo, centroid_BJ_XMg)
Dist_to_Ref$Distance[4] <- euclidean(centroid_ExVivo, centroid_BJ_iMg)
Dist_to_Ref$Distance[5] <- euclidean(centroid_ExVivo, centroid_Svoboda_xMg)
Dist_to_Ref$Distance[6] <- euclidean(centroid_ExVivo, centroid_Svoboda_iMg)

Dist_to_Ref

#Differential Gene Expression Analysis----

#Pairwise comparisons included in this section as of 12/2022:

#Adult ExVivo Microglia (Eggen 2017) vs Juvenile ExVivo Microglia (Gosselin 2017)
#Find differences between juvenile and adult microglia

#InVitro IPSC-Microglia (Blurton-Jones 2017) vs InVitro IPSC-Microglia (Ryan 2020)
#IPSC-Microglia from the Blurton-Jones study cluster closer to the reference datasets, 
#DGE may be useful to show why

#Xenografted IPSC-Microglia (Blurton-Jones 2017) vs Xenografted IPSC-Microglia (Svoboda 2017)
#It is difficult to tell from the PCA but it looks like the Blurton-Jones xenografted cells slightly 
#outperform those from the Svoboda study. DGE should show us some of what makes the former microglia more ”life-like”

#Xenografted IPSC-Microglia (Svoboda 2017) vs InVitro IPSC-Microglia (Ryan 2020)
#Surprisingly, xenografted Microglia from the Svoboda study and InVitro IPSC-Microglia from the Ryan 
#study were of comparable distance from the reference data sets in the PCA plots, therefore worth further investigation

#Create a matrix of sample information and factor wrap to facilitate pairwise comparisons
matrix_DGE <- c(rep("J_Microglia_ExVivo", 24), rep("A_Microglia_ExVivo", 39), rep("Ryan_MDM_InVitro", 3), 
                rep("Ryan_iMG_InVitro", 3), rep("Abud_iMG_InVitro_rHcH1", 6), rep("Abud_iMG_InVitro_", 9),
                rep("BlurtonJones_iMg_Xenotransplant", 10), rep("BlurtonJones_iMG_InVitro", 6), 
                rep("Svoboda_iMg_Xenotransplant", 6), rep("Svoboda_iMg_Xenotransplant_60d", 6), rep("Svoboda_iMg_InVitro", 6))

matrix_DGE <- factor(matrix_DGE, levels = c("J_Microglia_ExVivo", "A_Microglia_ExVivo", "Ryan_MDM_InVitro", 
                                            "Ryan_iMG_InVitro", "Abud_iMG_InVitro_rHcH1", "Abud_iMG_InVitro_",
                                            "BlurtonJones_iMg_Xenotransplant", "BlurtonJones_iMG_InVitro", 
                                            "Svoboda_iMg_Xenotransplant", "Svoboda_iMg_Xenotransplant_60d", "Svoboda_iMg_InVitro"))
summary(matrix_DGE)
design_matrix <-  model.matrix(~0 + matrix_DGE)
colnames(design_matrix) <- levels(matrix_DGE)

#Use limma::voom() to model the mean:variance relationship in our dataset. Necessary 
#for providing weights in downstream linear modeling (lmfit())
#Requires non-negative values, so will need to un log2 transform our aggregate dataset
#Aggregation_Set_Math_no_log still has filtered / normalized data but now the 
#Units are just transcripts per million (TPM) instead of log2(TPM) which is 
#typically reported

Aggregation_Set_Math_no_log <- 2^Aggregation_Set_Math
V_Aggregation_Set_Math <- voom(Aggregation_Set_Math_no_log, design_matrix, plot = TRUE)

#Fir a linear model to the now weighted dataset
fit <- lmFit(V_Aggregation_Set_Math, design_matrix)

#Extract the expression data back out from the EList created by voom
#and redo log transformation. Contains some NA, may have to remove later if necessary
V_Aggregation_Set_Math_tbl <- (as_tibble(log2(V_Aggregation_Set_Math$E), rownames = "GeneID"))

#Use our design matrix file to begin creating contrasts
#corresponding to our pairwise comparisons of interest
#Extracts the linear model created above, get's statistics on it
#using eBayes(), and then summarizes top differentially expressed genes / DEGs in a topTable
#Beginning with a comparison of the two reference data sets (Eggen and Gosselin)
contrast.matrix_Juv_Adlt <- makeContrasts(Juv_v_Adlt = A_Microglia_ExVivo - J_Microglia_ExVivo, levels = design_matrix)    #looper here 
fits_Juv_Adlt <- contrasts.fit(fit, contrast.matrix_Juv_Adlt)
ebFit_Juv_Adlt <- eBayes(fits_Juv_Adlt)
top_hits_Juv_Adlt <- topTable(ebFit_Juv_Adlt, adjust = "BH", coef = 1, number = 1500, sort.by = "logFC")
top_hits_Juv_Adlt <- as_tibble(top_hits_Juv_Adlt, rownames = "GeneID")
gene_names_top_1 <- top_hits_Juv_Adlt$GeneID

#Now Use top table to create an enhanced volcano plot and visualize differentially expressed genes
EnhancedVolcano(top_hits_Juv_Adlt, lab = gene_names_top_1, x = 'logFC',
                y = 'adj.P.Val', title = "Adult vs Pediatric ExVivo MG",
                pCutoff = 10e-6,
                FCcutoff = 2.0,
                pointSize = 3.0,
                labSize = 6.0,
                shape = c(1, 4, 23, 25),
                colAlpha = 1)

#now determine numbers of significant differentially expressed genes, summarize results
#And store all differentially expressed genes for this comparison (in either direction)
#In a data frame, and write those results to a tsv for future sharing or GSEA
results_Juv_Adlt <- decideTests(ebFit_Juv_Adlt, method="global", adjust.method="BH", p.value = 0.01, lfc = 2)
head(results_Juv_Adlt)
summary(results_Juv_Adlt)

ddx_genes_Eggen_Adult<- V_Aggregation_Set_Math$E[results_Juv_Adlt[ , 1] != 0, ]
ddx_genes_Eggen_Adult <- as_tibble(ddx_genes_Eggen_Adult, rownames = "GeneID")
write_tsv(ddx_genes_Eggen_Adult, "ddx_Genes_Eggen_v_Gosselin.tsv") #write to .tsv


#Moving on to comparing Abud vs Ryan InVitro IPSC-Microglia
contrast.matrix_Abud_Ryan <- makeContrasts(Abud_v_Ryan = Ryan_iMG_InVitro - Abud_iMG_InVitro_, levels = design_matrix)    
fits_Abud_Ryan <- contrasts.fit(fit, contrast.matrix_Abud_Ryan)
ebFit_Abud_Ryan <- eBayes(fits_Abud_Ryan)
top_hits_Abud_Ryan <- topTable(ebFit_Abud_Ryan, adjust = "BH", coef = 1, number = 1500, sort.by = "logFC")
top_hits_Abud_Ryan <- as_tibble(top_hits_Abud_Ryan, rownames = "GeneID")
gene_names_top_2 <- top_hits_Abud_Ryan$GeneID

#Now Use top table to create an enhanced volcano plot and visualize differentially expressed genes
EnhancedVolcano(top_hits_Abud_Ryan, lab = gene_names_top_2, x = 'logFC',
                y = 'adj.P.Val', title = "Abud vs Ryan InVitro MG",
                pCutoff = 10e-6,
                FCcutoff = 2.0,
                pointSize = 3.0,
                labSize = 6.0,
                shape = c(1, 4, 23, 25),
                colAlpha = 1)

#now determine numbers of significant differentially expressed genes, summarize results
#And store all differentially expressed genes for this comparison (in either direction)
#In a data frame, and write those results to a tsv for future sharing or GSEA
results_Abud_Ryan <- decideTests(ebFit_Abud_Ryan, method="global", adjust.method="BH", p.value = 0.01, lfc = 2)
head(results_Abud_Ryan)
summary(results_Abud_Ryan)

ddx_genes_Abud_Ryan <- V_Aggregation_Set_Math$E[results_Abud_Ryan[ , 1] != 0, ]
ddx_genes_Abud_Ryan <- as_tibble(ddx_genes_Abud_Ryan, rownames = "GeneID")
write_tsv(ddx_genes_Abud_Ryan, "ddx_Genes_Abud_v_Ryan.tsv") #write to .tsv

#Moving on to comparing Xenotransplanted Microglia from Blurton-Jones to the 60D 
#Xenotransplants from the Svoboda study
contrast.matrix_BJ_Svoboda <- makeContrasts(BJ_v_Svoboda = BlurtonJones_iMg_Xenotransplant - Svoboda_iMg_Xenotransplant_60d, levels = design_matrix)    
fits_BJ_Svoboda <- contrasts.fit(fit, contrast.matrix_BJ_Svoboda)
ebFit_BJ_Svoboda  <- eBayes(fits_BJ_Svoboda)
top_hits_BJ_Svoboda <- topTable(ebFit_BJ_Svoboda, adjust = "BH", coef = 1, number = 1500, sort.by = "logFC")
top_hits_BJ_Svoboda <- as_tibble(top_hits_BJ_Svoboda, rownames = "GeneID")
gene_names_top_3 <- top_hits_BJ_Svoboda$GeneID

#Now Use top table to create an enhanced volcano plot and visualize differentially expressed genes
EnhancedVolcano(top_hits_BJ_Svoboda, lab = gene_names_top_3, x = 'logFC',
                y = 'adj.P.Val', title = "Blurton-Jones vs Svoboda Xenotransplanted MG",
                pCutoff = 10e-6,
                FCcutoff = 2.0,
                pointSize = 3.0,
                labSize = 4.0,
                shape = c(1, 4, 23, 25),
                colAlpha = 1)

#now determine numbers of significant differentially expressed genes, summarize results
#And store all differentially expressed genes for this comparison (in either direction)
#In a data frame, and write those results to a tsv for future sharing or GSEA
results_BJ_Svoboda <- decideTests(ebFit_BJ_Svoboda, method="global", adjust.method="BH", p.value = 0.01, lfc = 2)
head(results_BJ_Svoboda)
summary(results_BJ_Svoboda)

ddx_genes_BJ_Svoboda <- V_Aggregation_Set_Math$E[results_BJ_Svoboda[ , 1] != 0, ]
ddx_genes_BJ_Svoboda <- as_tibble(ddx_genes_BJ_Svoboda, rownames = "GeneID")
write_tsv(ddx_genes_BJ_Svoboda, "ddx_Genes_BJ_v_Svoboda.tsv") #write to .tsv

#Moving on to comparing Xenotransplanted Microglia from Svoboda study to 
#InVitro IPSC-Microglia from the Ryan Study
contrast.matrix_Svoboda_Ryan <- makeContrasts(Svoboda_v_Ryan = Ryan_iMG_InVitro - Svoboda_iMg_Xenotransplant_60d, levels = design_matrix)    
fits_Svoboda_Ryan <- contrasts.fit(fit, contrast.matrix_Svoboda_Ryan)
ebFit_Svoboda_Ryan  <- eBayes(fits_Svoboda_Ryan)
top_hits_Svoboda_Ryan <- topTable(ebFit_Svoboda_Ryan, adjust = "BH", coef = 1, number = 2500, sort.by = "logFC")
top_hits_Svoboda_Ryan <- as_tibble(top_hits_Svoboda_Ryan, rownames = "GeneID")
gene_names_top_4 <- top_hits_Svoboda_Ryan$GeneID

#Now Use top table to create an enhanced volcano plot and visualize differentially expressed genes
EnhancedVolcano(top_hits_Svoboda_Ryan, lab = gene_names_top_4, x = 'logFC',
                y = 'adj.P.Val', title = "Svoboda Xenotransplanted MG vs Ryan InVitro IPSC-MG",
                pCutoff = 10e-6,
                FCcutoff = 2.0,
                pointSize = 1.5,
                labSize = 4.0,
                shape = c(1, 4, 23, 25),
                colAlpha = 0.5)

#now determine numbers of significant differentially expressed genes, summarize results
#And store all differentially expressed genes for this comparison (in either direction)
#In a data frame, and write those results to a tsv for future sharing or GSEA
results_Svoboda_Ryan <- decideTests(ebFit_Svoboda_Ryan, method="global", adjust.method="BH", p.value = 0.01, lfc = 2)
head(results_Svoboda_Ryan)
summary(results_Svoboda_Ryan)

ddx_genes_Svoboda_Ryan <- V_Aggregation_Set_Math$E[results_Svoboda_Ryan[ , 1] != 0, ]
ddx_genes_Svoboda_Ryan <- as_tibble(ddx_genes_Svoboda_Ryan, rownames = "GeneID")
write_tsv(ddx_genes_Svoboda_Ryan, "ddx_Genes_Svoboda_v_Ryan.tsv") #write to .tsv

#GSEA Analysis using Pairwise comparisons from DGE Analysis ----

#This will be a simplified GSEA just to show the process
#We will use only the final pairwise comparison, between the Ryan and Svoboda datasets
#Since this comparison yielded the most differentially expressed genes

#read in annotations for popular gene sets
c2cp <- read.gmt("c2.all.v7.1.symbols.gmt")
c5cp <- read.gmt("c5.all.v7.1.symbols.gmt")
cHcp <- read.gmt("c7.all.v7.1.symbols.gmt")

#arrange the top hits from this pairwise comparison in order by logFC
#Eg genes most highly upregulated by Ryan samples compared to 
#Svoboda samples are sorted to the top

top_hits_Svoboda_Ryan <- top_hits_Svoboda_Ryan %>%
  arrange(desc(logFC))

#get a list of the gene names in order of highest logFC for use in GSEA
Gene_list_Svoboda_Ryan <- top_hits_Svoboda_Ryan$logFC
names(Gene_list_Svoboda_Ryan) <- top_hits_Svoboda_Ryan$GeneID

#use our ranked list to perform GSEA, store our results in a tibble
Ryan_iMG_v_Svoboda_xMg_GSEA_res <- GSEA(Gene_list_Svoboda_Ryan, TERM2GENE = c2cp, verbose = FALSE)
Ryan_iMG_v_Svoboda_xMg_GSEA_res_df <- as_tibble(Ryan_iMG_v_Svoboda_xMg_GSEA_res)
dim(Ryan_iMG_v_Svoboda_xMg_GSEA_res_df)
head(Ryan_iMG_v_Svoboda_xMg_GSEA_res_df)

#generate an interactive datatable to more easily visualize the results

datatable(Ryan_iMG_v_Svoboda_xMg_GSEA_res_df[ , c(1, 3, 4:7)], 
          extensions = c("KeyTable", "FixedHeader"),
          caption = "Signatures enriched in Ryan iMg (NES > 0) or Svoboda XMg (NES < 0)",
          options = list(keys = TRUE, searchHighlight = TRUE, pageLength = 10, lengthMenu = c("10", "25", "50"))) %>%
  formatRound(columns=c(2:7), digits=8)

#Plot some of the most highly enriched (either in Ryan or Svoboda) pathways by Normalized Enrichment score,
#plot also automatically includes aesthetics for count (number of genes in our data that are found in a given pathway),
#and adjusted p value

dotplot(Ryan_iMG_v_Svoboda_xMg_GSEA_res, x = "NES", showCategory = 15) + ggtitle("Dot Plot for Ryan iMg vs Svoboda xMg GSEA")

#plot key enrichments

#Several cancer pathways are enriched in the Ryan iMicroglia
#For cultured cells, this can suggest that changes associated with 
#an artificially long life on a plate are occuring. This might suggest
#that these microglia are moving further away from naturel behavior and 
#are becoming quasi-immortalized like cancer cells 
gseaplot2(Ryan_iMG_v_Svoboda_xMg_GSEA_res,
          geneSetID = 22,
          pvalue_table = FALSE,
          title = Ryan_iMG_v_Svoboda_xMg_GSEA_res$Description[22])

#Interferon gamma response is up in the xenografted microglia
#Other interferon related pathways are similarly enriched in the Svoboda
#microglia. These signatures are typically associated with anti-viral activity
#and could inticate that these microglia were behaving as expected in the xenograft 
#environment
gseaplot2(Ryan_iMG_v_Svoboda_xMg_GSEA_res,
          geneSetID = 5,
          pvalue_table = FALSE,
          title = Ryan_iMG_v_Svoboda_xMg_GSEA_res$Description[5])

