###
# Usage
###

# modify DE results in .csv/.txt files and convert them to .rds file for the app/integration use

###
# Change Here
###

# files in HPC
datinfo_fn_hpc<-"/home/bonkmp/Microarray_data_infosheet_R.csv" # sample info sheet
resdir_hpc <- "/home/bonkmp/results" # directory for .csv files
appdir_hpc <- "/home/bonkmp/rdsfiles" # directory for output .rds files

# files to use
datinfo_fn=datinfo_fn_hpc
resdir=resdir_hpc
appdir=appdir_hpc

library(dplyr)

print("Converting .csv gene expression results to modified .rds file")

# read in datinfo
datinfo <- read.csv(datinfo_fn)
# convert NA in batchadj to "no"
datinfo$batchadj=sapply(datinfo$batchadj,function(x){if (is.na(x)|x!="yes") {"no"} else {"yes"}}) # for no_batch, one_batch, or NA, assign "no"; otherwise "yes"

# The arraydat_func function modifies gene expression array results
arraydat_func <- function(Unique_ID,batchadj) {
  # read original DE results from .csv files
  DE_res <- read.csv(paste0(resdir,"/",Unique_ID,".csv"))
  if (batchadj=="yes") {DE_res$P.Value <- DE_res$pValuesBatch; DE_res$adj.P.Val <- DE_res$qValuesBatch}  # if batchadj is "yes", use the batch adjusted p- and q-values
  # modify
  DE_res <- DE_res %>%
    dplyr::filter(!is.na(SYMBOL)) %>% # remove probes cannot be mapped to genes
    dplyr::filter(!is.na(P.Value)) %>% # remove probes with NA p.value
    dplyr::mutate(SD=logFC/t) %>% # compute standard deviation
    dplyr::select(SYMBOL,logFC,SD,P.Value,adj.P.Val) %>% # select useful columns
    dplyr::arrange(SYMBOL,P.Value,-abs(logFC)) %>% # order by gene name, p value and descending absolute logFC values
    dplyr::group_by(SYMBOL) %>% # group by gene name
    dplyr::filter(row_number()==1) %>% # select first row in each gene
    dplyr::ungroup() %>%
    dplyr::mutate(rank=rank(P.Value,ties.method="average",na.last="keep")) %>%
    dplyr::mutate(rank=rank/length(rank[!is.na(rank)])) %>% # create rank column for Pvalue rank not adj.P.Val in case several genes have same adjusted p-values; rank from smallest to the largest, and then scale the rank to the same distribution (rank=position/number_of_gene)
    dplyr::rename(Gene=SYMBOL) %>%
    as.data.frame()
  # convert P.Value=0 to the second small p-value
  DE_res[which(DE_res$P.Value==0),"P.Value"] <- min(DE_res$P.Value[which(DE_res$P.Value>0)], na.rm=T)
  return(DE_res)
}

# The deseq2dat_func function modifies deseq2 results
deseq2dat_func <- function(Unique_ID) {
  # read original DE results from .csv files
  DE_res <- read.table(paste0(resdir,"/",Unique_ID,".txt"),header=T,sep="\t",as.is=T)
  # modify
  DE_res <- DE_res %>%
    dplyr::filter(gene_symbol!="") %>% # remove Ensemble ID cannot be mapped to genes
    dplyr::filter(!is.na(gene_symbol)) %>%
    dplyr::filter(!is.na(pvalue)) %>% # remove genes with missing p-values
    dplyr::mutate(SYMBOL=gene_symbol,P.Value=pvalue,adj.P.Val=padj,logFC=log2FoldChange,SD=lfcSE) %>% # replace column names
    dplyr::select(SYMBOL,logFC,SD,P.Value,adj.P.Val) %>% # select useful columns
    dplyr::arrange(SYMBOL,P.Value,-abs(logFC)) %>% # order by gene name, p-values and descending absolute logFC values
    dplyr::group_by(SYMBOL) %>% # group by gene name
    dplyr::filter(row_number()==1) %>% # select first row in each gene
    dplyr::ungroup() %>%
    dplyr::mutate(rank=rank(P.Value,ties.method="average",na.last="keep")) %>%
    dplyr::mutate(rank=rank/length(rank[!is.na(rank)])) %>% # create rank column for Pvalue rank not adj.P.Val in case several genes have same adjusted p-values; rank from smallest to the largest, and then scale the rank to the same distribution (rank=position/number_of_gene)
    dplyr::rename(Gene=SYMBOL) %>%
    as.data.frame()
  # convert P.Value=0 to the second small p-value
  DE_res[which(DE_res$P.Value==0),"P.Value"] <- min(DE_res$P.Value[which(DE_res$P.Value>0)], na.rm=T)
  return(DE_res)
}

# The conv_func function converts .csv files to modified .RDS files
conv_func <- function(Unique_ID) {
  cat("Processing", Unique_ID, "\n")
  # grep datinfo
  datinfo <- datinfo[which(datinfo$Unique_ID%in%Unique_ID),]
  batchadj=as.character(datinfo$batchadj)
  
  if (grepl("DESeq2",Unique_ID)) { # RNAseq DE results with "DESeq2" in filename
    res=deseq2dat_func(Unique_ID=Unique_ID)
  } else {res=arraydat_func(Unique_ID=Unique_ID,batchadj=batchadj)} # microarray DE results without "DESeq2" in filename
  # create rds file
  rds_fn <- paste0(appdir,"/",Unique_ID,".RDS")
  saveRDS(res, rds_fn)
  cat("Generated .RDS file for", Unique_ID, "\n")
}

# obtain all unique ids
ids=as.character(datinfo$Unique_ID)

# convert and save RDS
sapply(ids, conv_func)

# save RDS for datinfo
saveRDS(datinfo, paste0(dirname(resdir_hpc),"/Microarray_data_infosheet_R.RDS"))
