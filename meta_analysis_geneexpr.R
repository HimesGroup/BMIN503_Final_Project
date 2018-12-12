#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

###
# Usage
###

# Select datasets and run integration analysis. Variables are imported from meta_analysis_geneexpr.py

samp_info=args[1]
DE_dir=args[2]
script_dir=args[3]
study=args[4]
tissue=args[5]
disease=args[6]
treatment=args[7]
out=args[8]
method=args[9]

cat("samp_info =", samp_info,"\n")
cat("DE_dir =", DE_dir,"\n")
cat("script_dir =", script_dir,"\n")
cat("study =", study,"\n")
cat("tissue =", tissue,"\n")
cat("disease =", disease,"\n")
cat("treatment =", treatment,"\n")
cat("out =", out,"\n")
cat("method =", method,"\n")

# utility file
#script_dir = "/home/mengykan/Projects/asthmagene/scripts/meta-analysis"
utility_fn=paste0(script_dir,"integration_utility.R")

###
# Change Here
###

# gene expression data path and files
geneexpr_dir=DE_dir # "/project/bhimeslab/databases/AsthmaApp/databases/Microarray_data_infosheet_R.RDS"
geneexpr_datinfo_fn=samp_info # "/project/bhimeslab/databases/AsthmaApp/databases/microarray_results"

if (!(dir.exists(geneexpr_dir))) stop(paste0("The gene expression data directory "),geneexpr_dir," does not exist")
if (!(file.exists(geneexpr_datinfo_fn))) stop(paste0("The gene expression data information file "),geneexpr_datinfo_fn," does not exist")
datinfo=readRDS(geneexpr_datinfo_fn)

# output date varialbe for output filename creation
# date=Sys.Date()
# date=gsub("-","",date)
date="" # no longer use date in filenames

# load utility resource
if (!(file.exists(utility_fn))) stop(paste0("The utility file "),utility_fn," does not exist")
source(utility_fn)

# Convert arguments into variables
if (study=="NA") {
  tissue=strsplit(tissue, "\\s")[[1]]

  if (disease!="NA") {
    disease=strsplit(disease, "\\s")[[1]]
  }
  if (treatment!="NA") {
    treatment=strsplit(treatment, "\\s")[[1]]
  }
} else {
  study=strsplit(study, "\\s")[[1]]
}

# create output file name prefix and related directory
geneexpr_out_prefix=out

rankmethod_func <- function(datinfo, genes) {
  # create rank list R object for rank-based integration
  rankdat_list=lapply(readinlist_func(datinfo),function(x){x[x$Gene%in%genes,c("Gene","rank")]})
  # perform permutation
  # res=rankprodt_perm(dat.list=rankdat_list,nperm=1000,rand=1)
  # As we need 1000,000 permutations, create 20 jobs each with 50,000 permutations and run them separately
  ranklist_fn=paste0(geneexpr_out_prefix,".ranklist.RDS")
  if (file.exists(ranklist_fn)) cat("The ranklist file already exists and is overwritten now.\n")
  saveRDS(rankdat_list,ranklist_fn)
  cat("Obtain ranklist object.\n")
  # compute real rank product
  dat <- Reduce(function(x,y){merge(x,y,by="Gene",all=T)},rankdat_list)
  # compute real rank product
  rankprod=apply(dat[,!names(dat)%in%"Gene"],1,rankprodt)
  res=data.frame(Gene=dat$Gene,rankprod=rankprod)
  write.table(res[order(res$rankprod),],paste0(geneexpr_out_prefix,".rankprodt.txt"),sep="\t",row.names=F,col.names=T,quote=F)
}

fisherpmethod_func <- function(datinfo, genes) {
  # convert p-values based on the effect direction
  cat("Convert p-values based on the effect direction\n")
  res_list=pvalconvt(datinfo=datinfo, gene=genes, col_var="P.Value", mode="gene", ncore=10) # convert p-values based on the effect direction, get genes
  # run Fisher's combination for one-tail p-values and save data
  cat("Compute fisher's p-values\n")
  score=genescore_singletype(res_list,col_var="stats",func="fisherp")
  score$P.Value <- score$Score
  score$qval <- p.adjust(score$Score,method="BH")
  score$rank <- rank(score$Score)
  score$Score <- NULL
  score <- score[order(score$rank),]
  write.table(score,paste0(geneexpr_out_prefix,".fisherp.txt"),sep="\t",row.names=F,col.names=T,quote=F)
}


metaranefmethod_func <- function(datinfo, genes) {
  # obtain list by gene
  if ("Population"%in%names(datinfo)) {data_dir=gwas_dir} else {data_dir=geneexpr_dir}
  study_list=list()
  for (i in datinfo$Unique_ID) {study_list[[i]]=readRDS(paste0(data_dir, "/", i, ".RDS"))}
  cat("Perform meta-analysis using random-effects model\n")
  res_list=lapply(genes,function(gene){
    d=sapply(study_list,function(dat){if(gene%in%dat$Gene){dat[which(dat$Gene%in%gene),"logFC"]}else{NA}})
    se=sapply(study_list,function(dat){if(gene%in%dat$Gene){dat[which(dat$Gene%in%gene),"SD"]}else{NA}})
    metaranef(d=d,se=se,method="random")
  })
  score=do.call(rbind,res_list)
  score=data.frame(Gene=genes,score)
  score$qval <- p.adjust(score$P.Value,method="BH")
  score$rank <- rank(score$P.Value)
  score <- score[order(score$rank),]
  write.table(score,paste0(geneexpr_out_prefix,".metaranef.txt"),sep="\t",row.names=F,col.names=T,quote=F)
}


meta_func <- function(geneexpr_datinfo, method){

  # select genes shared within at least two studies
  cat("Select genes shared within at least two studies\n")
  genes=sharegene_func(dat.list=readinlist_func(geneexpr_datinfo),minnum=2)
  cat("Obtain",length(genes),"genes\n")

  # genes=c("CEBPD","TSC22D3") # two genes for testing

  ###
  # Rand product
  ###
  if (method=="rankprodt") {
    rankmethod_func(datinfo=geneexpr_datinfo, genes=genes)
  }

  ###
  # Fisherp
  ###

  if (method=="fisherp") {
    fisherpmethod_func(datinfo=geneexpr_datinfo, gene=genes)
  }

  ###
  # Random-effects model
  ###
  if (method=="metaranef") { 
    metaranefmethod_func(datinfo=geneexpr_datinfo, genes=genes)
  }
}

# Study
if (!"NA"%in%study) {
  # select gene expression study based on Unique_ID
  geneexpr_datinfo=geneexpr_study_select(study)
  print(geneexpr_datinfo)
  if (nrow(geneexpr_datinfo)<2) {cat("Less than 2 gene expression studies selected. Cannot perform integration.\n")} else {meta_func(geneexpr_datinfo=geneexpr_datinfo, method=method)}
}


# Asthma
if (!"NA"%in%disease) {
  # select disease gene expression study
  geneexpr_datinfo=geneexpr_disease_select(tissue,disease)
  print(geneexpr_datinfo)
  if (nrow(geneexpr_datinfo)<2) {cat("Less than 2 disease gene expression studies. Cannot perform integration.\n")} else {meta_func(geneexpr_datinfo=geneexpr_datinfo, method=method)}
}

# Treatment
if (!"NA"%in%treatment) {
  # select treatment gene expression study
  geneexpr_datinfo=geneexpr_GC_select(tissue,treatment)
  print(geneexpr_datinfo)
  if (nrow(geneexpr_datinfo)<2) {cat("Less than 2 treatment gene expression studies. Cannot perform integration.\n")} else {meta_func(geneexpr_datinfo=geneexpr_datinfo, method=method)}
}
