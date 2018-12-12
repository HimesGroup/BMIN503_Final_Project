#!/usr/bin/env Rscript

###
# Usage
###

# This script is used to combine permutation results from rank-based integration method and combine results from p-value-based and effect-size-based methods.

args = commandArgs(trailingOnly=TRUE)
studies=as.character(args[1])
out_dir=as.character(args[2])

###
# Change Here
###

#studies=c("ASM_GC") # out prefix
#out_dir="/home/mengykan/Projects/RNA-Seq_BUD/results/integration/ASM_GC"

# output date varialbe for output filename creation
#date=Sys.Date()
#date=gsub("-","",date)
date="" # no longer use date in filenames

# obtain studies
studies=strsplit(studies, "\\s")[[1]]

###
# Combine function
###

comb_func <- function(study) {
  cat(paste0("Combine study: "),study,"...\n")
  # create output directory
  out_dir=paste0(out_dir,"/")
  # obtain 20 sub-permutation RDS results
  files=list.files(path=paste0(out_dir,study,"_rankperm"),pattern=".RDS",full.names=T)
  if (length(files)!=20){stop("Permutation files are less than 20. Please check!")}
  cat("Read in RDS files...\n")
  res_list <- lapply(files,readRDS)
  cat("Combine permutation results...\n")
  # combine 20 sub-permutation counts
  count_mat=do.call(cbind,lapply(res_list,function(x){x$count}))
  # sum up counts
  count=apply(count_mat,1,sum)
  # read in real RP
  RP_fn=list.files(path=out_dir, pattern=paste0(study,".rankprodt"),full.names=T)
  cat("Read in original Rank Product...\n")
  RP <- read.table(RP_fn, header=T, sep="\t")
  # create output data frame
  gene=res_list[[1]]$Gene
  cat("Create table...\n")
  res=data.frame(Gene=gene,RP=RP$rankprod,Count=count,P.Value=count/1000000)
  res$rank=rank(res$P.Value)
  res=res[order(res$rank),]
  res$FDR=res$P.Value*nrow(res)/res$rank
  res$P.Value[which(res$Count==0)]<-1/1000001
  write.table(res,paste0(out_dir,study,".rankprodperm.txt"),sep="\t",quote=F,row.names=F,col.names=T)
  cat("Done!\n")
}

sapply(studies, comb_func)

# Combine with rank-based and p-value-based results

combmethod_func <- function(study) {
  out_dir=paste0(out_dir,"/")
  metaranef_fn=paste0(out_dir,study,".metaranef.txt")
  fisherp_fn=paste0(out_dir,study,".fisherp.txt")
  rankprodperm_fn=paste0(out_dir,study,".rankprodperm.txt")
  # check missing file
  missing=sapply(c(fisherp_fn,metaranef_fn,rankprodperm_fn),file.exists)
  if (!all(missing)) {
    missing_fn=c(fisherp_fn,metaranef_fn,rankprodperm_fn)[!missing]
    cat("missing files: ",paste(missing_fn,collapse=", "),"\n")
  } else { # if all the integration files exist
    cat("Combine integration files:\n")
    cat(paste(c(fisherp_fn,metaranef_fn,rankprodperm_fn),collapse=", "),"\n")
    metaranef=read.table(metaranef_fn, sep="\t", header=T)
    names(metaranef)[names(metaranef)%in%c("P.Value", "qval","rank")]=paste0("metaranef_",names(metaranef)[names(metaranef)%in%c("P.Value", "qval","rank")])
    fisherp=read.table(fisherp_fn, sep="\t", header=T)
    names(fisherp)[names(fisherp)%in%c("P.Value", "qval","rank")]=paste0("fisherp_",names(fisherp)[names(fisherp)%in%c("P.Value", "qval","rank")])
    rankprodperm=read.table(rankprodperm_fn, sep="\t", header=T)
    names(rankprodperm)[names(rankprodperm)%in%c("P.Value","rank")]=paste0("rankprodperm_",names(rankprodperm)[names(rankprodperm)%in%c("P.Value", "rank")])
    dat=Reduce(function(x,y)merge(x,y,by="Gene"),list(metaranef,fisherp,rankprodperm))
    dat=dat[order(dat$metaranef_P.Value),]
    write.table(dat,paste0(out_dir,study,".txt"),sep="\t",quote=F,row.names=F,col.names=T)
    cat("Done!\n")
    cat("Generated combined file:",paste0(out_dir,study,".txt"),"\n")
  }
}
sapply(studies, combmethod_func)

