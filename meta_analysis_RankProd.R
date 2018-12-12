#!/usr/bin/R
args = commandArgs(trailingOnly=TRUE)

###
# Pass Arguments
###

# usage: Rscript --vanilla integration_RankProd.R nperm rand

if (length(args)!=7) {
    stop("Please specify 6 input variables:
	  V1: script directory that has R utility file integration_utility.R
	  V2: input rank data list RDS file name
          V3: nperm (number of permutations)
	  V4: rand (random seed)
	  V5: ncore (number of cores used)
	  V6: out_prefix (output file prefix)
	  V7: result directory")
}

script_dir=as.character(args[1])
input_fn=as.character(args[2])
nperm=as.numeric(args[3])
rand=as.numeric(args[4])
ncore=as.numeric(args[5])
out_prefix=as.character(args[6])
resdir=as.character(args[7])

cat("script_dir =", script_dir,"\n")
cat("input_fn =",input_fn,"\n")
cat("nperm =",nperm,"\n")
cat("rand =", rand,"\n")
cat("ncore =", ncore,"\n")
cat("out_prefix =", out_prefix,"\n")
cat("resdir =", resdir,"\n")

# utility file
utility_fn=paste0(script_dir,"integration_utility.R")

# load utility resource
if (!(file.exists(utility_fn))) stop(paste0("The utility file "),utility_fn," does not exist")
source(utility_fn)

rank_list <- readRDS(input_fn)
res=rankprodt_perm(dat.list=rank_list,nperm=nperm,rand=rand,ncore=ncore,getERP=FALSE)
saveRDS(res, paste0(resdir,"/rank.",out_prefix,".RDS"))
