#!/usr/bin/R

###
# Usage
###

# Functions and utilities used for integration analysis

library(ggplot2)

###
# Basic Function Module
###


# function to convert two-sided p-value to one-sided p-value based on beta direction
pcomp_withbeta <- function(dt,col_var) { # col_var: adj.P.val or P.value
    if (missing(col_var)) stop("Please specify the column of which the two-sided p values to convert")
    dt$col_var <- dt[,col_var]
    ref_study <- dt[order(-dt$Total,dt$P.Value),"Unique_ID"][1] # the study with largest sample size (if the studies have equal sample size, take the one with smallest unajusted p-values) is used for reference effect direction, and is used as a discovery study with two-sided p-values. Sort sample size by decreasing order and p-values by increasing order
    ref_sign <- sign(dt$logFC[which(dt$Unique_ID==ref_study)]) # use direction in reference study as reference
    dt$stats <- rep(NA,length(dt$Total))
    dt$stats[which(dt$Unique_ID==ref_study)] <- dt$col_var[which(dt$Unique_ID==ref_study)] # use two-sided p-value for reference study
    dt$stats[which((dt$Unique_ID!=ref_study)&(sign(dt$logFC)==ref_sign))] <- dt$col_var[which((dt$Unique_ID!=ref_study)&(sign(dt$logFC)==ref_sign))]/2 # if direction is same as the reference direction, convert two-sided p-value to one-sided p-value
    dt$stats[which((dt$Unique_ID!=ref_study)&(sign(dt$logFC)!=ref_sign))] <- 1-dt$col_var[which((dt$Unique_ID!=ref_study)&(sign(dt$logFC)!=ref_sign))]/2 # if direction is opposite to the reference direction, convert two-sided p-value to one-sided p-value and invert using 1-(p-value/2)
    dt$col_var <- NULL
    return(dt)
}

# function to convert two-sided p-value to one-sided p-value without beta information
pcomp_withoutbeta <- function(dt) {
    dt$col_var <- dt[,col_var]	
    ref_study <- dt[order(-dt$Total,dt$P.Val),"Unique_ID"][1] # the study with largest sample size (if the studies have equal sample size, take the one with smallest p-values) is used for reference effect direction, and is used as a discovery study with two-sided p-values. Sort sample size by decreasing order and p-values by increasing order
    dt$stats <- rep(NA,length(dt$Total))
    dt$stats[which(dt$Unique_ID==ref_study)] <- dt$col_var[which(dt$Unique_ID==ref_study)] # use two-sided p-value for reference study
    dt$stats[which(dt$Unique_ID!=ref_study)] <- dt$col_var[which(dt$Unique_ID!=ref_study)]/2 # convert two-sided p-value to one-sided p-value
    dt$col_var <- NULL
    return(dt)
}

# zscore computation
zcal <- function(p) {
    p[!((p > 0) & (p <= 1))] <- NA # convert pvalues not in (0,1) to NA
    z <- qnorm(p, lower.tail = FALSE)
    return(z)
}

# z-score sum
zscoresum <- function(p) {
    keep <- (p > 0) & (p <= 1) & (!is.na(p))
    z <- qnorm(p[keep], lower.tail = FALSE)
    # Xiong et al.: for convenience, we shift all these scores to be positive by adding a constant c that is the absolute value of the most negative score across all standard gene expression score and standard SNP set association scores. Note it is not implemented here
    sumz <- mean(z,na.rm=T)
    if (length(p[keep]) <= 1) {sumz <- NA}
    names(sumz)="Score"
    return(sumz)
}

# Fisher's method: use p-values
fishermethod <- function(p) {
    keep <- (p > 0) & (p <= 1) & (!is.na(p))
    lnp <- log(p[keep])
    chisq <- ((-2) * sum(lnp))/length(p[keep])
    if (length(p[keep]) <= 1) {chisq <- NA}
    names(chisq)="Score"
    return(chisq)
}

# rank sum
ranksum <- function(rank) {
    keep <- (rank > 0) & (!is.na(rank))
    ranksum <- mean(rank[keep],na.rm=T)
    if (length(rank[keep]) <= 1) {ranksum <- NA}
    names(ranksum)="Score"
    return(ranksum)
}

# rank product
rankprodt <- function(rank) {
    keep <- (rank > 0) & (!is.na(rank))
    rankprodt <- (prod(rank[keep],na.rm=T))^(1/(length(rank[keep])))
    if (length(rank[keep]) <= 1) {rankprodt <- NA}
    names(rankprodt)="Score"
    return(rankprodt)
}

# Fisher combined p-values: compute x2 and convert to p-values
fisherp <- function(p) {
    keep <- (p > 0) & (p <= 1)
    lnp <- log(p[keep])
    chisq <- (-2) * sum(lnp)
    df <- 2 * length(lnp)
    # res <- list(chisq = chisq, df = df, p = pchisq(chisq, df, lower.tail = FALSE), validp = p[keep])
    fisherp = pchisq(chisq, df, lower.tail = FALSE)
    # if (length(p) <= 1) {res <- list(chisq=0,df=0,p=NA,validp=NA)}
    if (length(p) <= 1) {fisherp=NA}
    names(fisherp)="Score"
    return(fisherp)
}

# This script is used for meta-analysis. The function meta.summaries is modified from rmeta package
# It estimates the variance of a weighted average using the squares of the weights (standard error). Random model is applied.

meta.summaries<-function(d,se,method=c("fixed","random"),
                         weights=NULL,logscale=FALSE,names=NULL,data=NULL,
                         conf.level=.95,subset=NULL,na.action=na.fail)
{

  if (conf.level>1 & conf.level<100)
    conf.level<-conf.level/100
    if ( is.null( data ) ) 
        data <- sys.frame( sys.parent() )
    mf <- match.call()

    keep <- (!is.na(d)) & (!is.na(se)) # exclude NA in both d and se
    mf$d <- d[keep]
    mf$se <- se[keep]

    mf$data <- NULL 
    mf$method<-NULL  
    mf$logscale<-NULL
    mf$subset <- NULL
    mf[[1]] <- as.name( "data.frame" )
    mf <- eval( mf,data )
    if ( !is.null( subset ) ) 
        mf <- mf[subset,]
    mf <- na.action( mf )
  
    if (is.null(mf$names)){
	if (is.null(mf$d) || is.null(names(mf$d)))
	   mf$names<-seq(along=mf$d)
	else
	  mf$names<-names(mf$d)
    }
  mf$names<-as.character(mf$names)
  method<-match.arg(method)
  vars<-mf$se^2
  
  vwts<-1/vars
  fixedsumm<-sum(vwts*mf$d)/sum(vwts)
  Q<-sum( ( ( mf$d - fixedsumm )^2 ) / vars ) 
  df<-NROW(mf)-1
  
  tau2<-max(0, (Q-df)/(sum(vwts)-sum(vwts^2)/sum(vwts)))
  
  if(is.null(mf$weights)){
    if (method=="fixed"){
      wt<-1/vars
    } else {
      wt<-1/(vars+tau2)
    }
  } else
  wt<-mf$weights
  
  summ<-sum(wt*mf$d)/sum(wt)
  if (method=="fixed")
	varsum<-sum(wt*wt*vars)/(sum(wt)^2)
  else
	varsum<-sum(wt*wt*(vars+tau2))/(sum(wt)^2)
  
  summtest<-summ/sqrt(varsum)

  df<-length(vars)-1
  rval<-list(effects=mf$d, stderrs=mf$se, summary=summ,se.summary=sqrt(varsum),
	     test=c(summtest,1-pchisq(summtest^2,1)),
	     df=df,
	     Q=Q,
	     het=c(Q,df,1-pchisq(Q,df)),
	     call=match.call(), names=mf$names,tau2=tau2,
	     variance.method=method, weights=wt, 
	     weight.method=if(is.null(mf$weights)) method else "user",
	     conf.level=conf.level,logscale=logscale)
  class(rval)<-"meta.summaries"
  rval
}

metaranef <- function(d,se,method="random") {
  conf.level=0.95
  x <- meta.summaries(d=d, se=se, method=method, conf.level=conf.level, logscale=FALSE)
  summ <- x$summary
  se.summ <- x$se.summary
  df <- x$df
  Q <- x$Q
  het <- x$het
  pval <- 2*pnorm( abs(summ/se.summ), lower.tail=FALSE )
  ci.value<- -qnorm((1-conf.level)/2)
  ci<-x$summary+c(-ci.value,0,ci.value)*x$se.summary
  ci_lower=ci[1]
  ci_upper=ci[3]
  res=c(summ,se.summ,ci_lower,ci_upper,df,pval)
  names(res)=c("logFC","SE","CI_lower","CI_upper","df","P.Value")
  return(res)
}


# Density and histogram plots
distplot_func <- function(df,xlab,title) {
    ggplot(df,aes(x=values)) + geom_density(alpha=.2) + geom_histogram(aes(y=..density..),alpha=0.5) +
        theme_bw() +
	ggtitle(title) +
        xlab(xlab) +
        ylab("Density") #+
        #scale_color_manual("Scan Date",values=cols)
}

###
# Extended Function Module
###

# select GWAS studies
gwas_select <- function(gwas_pop,gwas_study) {
    gwas_datinfo <- readRDS(gwas_datinfo_fn)
    gwas_datinfo <- gwas_datinfo[which(gwas_datinfo$Population%in%gwas_pop & gwas_datinfo$Study%in%gwas_study),]
    cat(paste0(nrow(gwas_datinfo)," asthma GWAS datasets have been selected:\n"))
    if (nrow(gwas_datinfo)>0) {cat(paste0(as.character(gwas_datinfo$Unique_ID)),"\n")}
    return(gwas_datinfo)
}

# select gene expression asthma studies
geneexpr_disease_select <- function(tissue,disease) {
    geneexpr_datinfo <- readRDS(geneexpr_datinfo_fn)
    geneexpr_datinfo <- subset(geneexpr_datinfo, App=="asthma")
    if (all(!tissue%in%c("entire",unique(as.character(geneexpr_datinfo$Tissue)))))cat("Selected tissues are not found in gene expression datinfo file file.\n")
    if (all(!disease%in%c("entire",unique(as.character(geneexpr_datinfo$Asthma)))))cat("Selected disease endotypes are not found in gene expression datinfo file.\n")
    if (!"entire"%in%tissue) {geneexpr_datinfo <- geneexpr_datinfo[geneexpr_datinfo$Tissue%in%tissue,]}
    if (!"entire"%in%disease) {geneexpr_datinfo <- geneexpr_datinfo[geneexpr_datinfo$Asthma%in%disease,]}
    print(paste0(nrow(geneexpr_datinfo)," disease gene expression datasets have been selected"))
    if (nrow(geneexpr_datinfo)>0) {print(as.character(geneexpr_datinfo$Unique_ID))}
    return(geneexpr_datinfo)
}

# select gene expression treatment studies
geneexpr_GC_select <- function(tissue,treatment) {
    geneexpr_datinfo <- readRDS(geneexpr_datinfo_fn)
    geneexpr_datinfo <- subset(geneexpr_datinfo, App=="GC")
    if (all(!tissue%in%c("entire",unique(as.character(geneexpr_datinfo$Tissue)))))cat("Selected tissues are not found in gene expression datinfo file.\n")
    if (all(!treatment%in%c("entire",unique(as.character(geneexpr_datinfo$Asthma)))))cat("Selected treatments are not found in gene expression datinfo file.\n")
    if (!"entire"%in%tissue) {geneexpr_datinfo <- geneexpr_datinfo[(geneexpr_datinfo$Tissue%in%tissue),]}
    geneexpr_datinfo <- geneexpr_datinfo[geneexpr_datinfo$Asthma%in%treatment,]
    cat(paste0(nrow(geneexpr_datinfo)," treatment gene expression datasets have been selected\n"))
    if (nrow(geneexpr_datinfo)>0) {print(as.character(geneexpr_datinfo$Unique_ID))}
    return(geneexpr_datinfo)
}


# select gene expression studies based on Unique_ID
geneexpr_study_select <- function(study) {
    geneexpr_datinfo <- readRDS(geneexpr_datinfo_fn)
    geneexpr_datinfo <- geneexpr_datinfo[which(geneexpr_datinfo$Unique_ID%in%study),]
    cat(paste0(nrow(geneexpr_datinfo)," gene expression datasets have been selected\n"))
    if (nrow(geneexpr_datinfo)>0) {print(as.character(geneexpr_datinfo$Unique_ID))}
    return(geneexpr_datinfo)
}


# function to obtain genes shared in studies based on the appearing frequency
sharegene_func <- function(dat.list, minnum) {
  if (missing(minnum)) {minnum=length(dat.list)}
  allgenes=table(unname(unlist(lapply(dat.list,function(x){as.character(x$Gene)})))) # compute gene frequency
  allgenes <- allgenes[!(is.na(allgenes) | allgenes=="NA")]
  genes=names(allgenes)[which(allgenes>=minnum)] # obtain genes appear in how many number of datasets
  return(genes)
}

# read in results as a list
readinlist_func <- function(datinfo) {
  if ("Population"%in%names(datinfo)) {data_dir=gwas_dir} else {data_dir=geneexpr_dir}
  study_list=list()
  for (i in datinfo$Unique_ID) {study_list[[i]]=readRDS(paste0(data_dir, "/", i, ".RDS"))}
  return(study_list)
}

# function to generate dataset with one-sided corrected p-values
# output converted p-values and ranks in a list
pvalconvt <- function(datinfo,gene,col_var,mode="gene", ncore=1){ # # gene: genes used, default all genes, specify "shared" get shared genes only; col_var: column variables needs to be convert, default use all columns; mode: output table by gene "gene" or by study "study"
    # ncore: number of cores used for parallele computing

  # For parallele computing, as the function will be sent to different nodes, define external function within this function session

  # function to convert two-sided p-value to one-sided p-value based on beta direction
  pcomp_withbeta <- function(dt,col_var) { # col_var: adj.P.val or P.value
      if (missing(col_var)) stop("Please specify the column of which the two-sided p values to convert")
      dt$col_var <- dt[,col_var]
      ref_study <- dt[order(-dt$Total,dt$P.Value),"Unique_ID"][1] # the study with largest sample size (if the studies have equal sample size, take the one with smallest unajusted p-values) is used for reference effect direction, and is used as a discovery study with two-sided p-values. Sort sample size by decreasing order and p-values by increasing order
      ref_sign <- sign(dt$logFC[which(dt$Unique_ID==ref_study)]) # use direction in reference study as reference
      dt$stats <- rep(NA,length(dt$Total))
      dt$stats[which(dt$Unique_ID==ref_study)] <- dt$col_var[which(dt$Unique_ID==ref_study)] # use two-sided p-value for reference study
      dt$stats[which((dt$Unique_ID!=ref_study)&(sign(dt$logFC)==ref_sign))] <- dt$col_var[which((dt$Unique_ID!=ref_study)&(sign(dt$logFC)==ref_sign))]/2 # if direction is same as the reference direction, convert two-sided p-value to one-sided p-value
      dt$stats[which((dt$Unique_ID!=ref_study)&(sign(dt$logFC)!=ref_sign))] <- 1-dt$col_var[which((dt$Unique_ID!=ref_study)&(sign(dt$logFC)!=ref_sign))]/2 # if direction is opposite to the reference direction, convert two-sided p-value to one-sided p-value and invert using 1-(p-value/2)
      dt$col_var <- NULL
      return(dt)
  }
  
  # function to convert two-sided p-value to one-sided p-value without beta information
  pcomp_withoutbeta <- function(dt) {
      dt$col_var <- dt[,col_var]	
      ref_study <- dt[order(-dt$Total,dt$P.Val),"Unique_ID"][1] # the study with largest sample size (if the studies have equal sample size, take the one with smallest p-values) is used for reference effect direction, and is used as a discovery study with two-sided p-values. Sort sample size by decreasing order and p-values by increasing order
      dt$stats <- rep(NA,length(dt$Total))
      dt$stats[which(dt$Unique_ID==ref_study)] <- dt$col_var[which(dt$Unique_ID==ref_study)] # use two-sided p-value for reference study
      dt$stats[which(dt$Unique_ID!=ref_study)] <- dt$col_var[which(dt$Unique_ID!=ref_study)]/2 # convert two-sided p-value to one-sided p-value
      dt$col_var <- NULL
      return(dt)
  }



    if ("Population"%in%names(datinfo)) {data_dir=gwas_dir} else {data_dir=geneexpr_dir}
    study_list=list()
    for (i in datinfo$Unique_ID) {study_list[[i]]=readRDS(paste0(data_dir, "/", i, ".RDS"))}

    curr_genes=vector()
    if (missing(gene)) {curr_genes<-sharegene_func(study_list,minnum=1)}
    else {if ("shared"%in%gene) {curr_genes<-sharegene_func(study_list)} else {curr_genes=gene}}

    #curr_genes=c("ORMDL3","GSDMB") # top gene for test
    #curr_genes=c("A1BG","A1BG-AS1","A1CF") # three genes for test
    res_bygene=list()
    res_bystudy=list()

    convtbygene_func <- function(curr_gene) {
        curr_gene <- as.character(curr_gene)
        output.table <- data.frame() # initiate output.table to combine results for curr_gene
        output.table <- do.call(rbind,lapply(study_list,function(x){x[which(x$Gene==curr_gene),]}))
	output.table <- data.frame(Unique_ID=row.names(output.table),output.table)
	row.names(output.table) <- NULL
	output.table$Total=datinfo$Total[datinfo$Unique_ID%in%output.table$Unique_ID]
	if (nrow(output.table)>0) {
	    if ("logFC"%in%names(output.table)) {output.table <- pcomp_withbeta(output.table,col_var)} else {output.table <- pcomp_withoutbeta(output.table)}
        } else {output.table=data.frame()}
	return(output.table)
    }

    require(parallel) # parallele computing
    cl <- makeCluster(ncore)
    system.time(conv_list <- parLapply(cl, curr_genes, convtbygene_func))

    all=do.call(rbind,conv_list)
    if (mode=="gene") {
        res_list=lapply(as.character(unique(all$Gene)),function(x){all[which(all$Gene%in%x),]})
        names(res_list)=as.character(unique(all$Gene))
    }
    else if (mode=="study") {
        res_list=lapply(as.character(datinfo$Unique_ID),function(x){all[which(all$Unique_ID%in%x),]})
        names(res_list)=as.character(datinfo$Unique_ID)
    }
    return(res_list)
}
    
#    if (mode=="gene") {return(res_bygene)}
#    else if (mode=="study") {return(res_bystudy)}

# Compute gene score using two-tailed p-values
genescore_singletype_rawp <- function(datinfo,col_var,func) {
    if ("Population"%in%names(datinfo)) {data_dir=gwas_dir} else {data_dir=geneexpr_dir}
    datlist=list()
    for (i in datinfo$Unique_ID) {datlist[[i]] <- readRDS(paste0(data_dir, "/", i, ".RDS"))[,c("Gene",col_var)]}
    dat <- Reduce(function(x,y) merge(x,y,by="Gene",all=T),datlist)
    if (func=="metaranef") {
        d_col=2*(1:(ncol(dat)/2))
	se_col=2*(1:(ncol(dat)/2))+1
	res_list=lapply(1:nrow(dat),function(x){
	    d=sapply(d_col,function(y){dat[x,y]})
            se=sapply(d_col,function(y){dat[x,y]})
	    metaranef(d=d,se=se)
	})
	logFC=sapply(res_list,function(x){x[1]})
	CI_lower=sapply(res_list,function(x){x[2]})
	CI_upper=sapply(res_list,function(x){x[3]})
	Score=sapply(res_list,function(x){x[4]})
	res=data.frame(Gene=dat[,c("Gene")],logFC,CI_lower,CI_upper,Score)
    }
    else {
        Score=apply(dat[,-1],1,eval(func))
        res=data.frame(Gene=dat[,c("Gene")],Score)
    }
    return(res)
}


# Obtain rank product by permutation

rankprodt_perm <- function(dat.list,nperm,rand=123,ncore=1,getERP=TRUE) { # dat.list: DE results data frame by study; getERP: compute ERP and PFP

  # include rank product function as an internal function
  rankprodt <- function(rank) {
    keep <- (rank > 0) & (!is.na(rank))
    rankprodt <- (prod(rank[keep],na.rm=T))^(1/(length(rank[keep])))
    if (length(rank[keep]) <= 1) {rankprodt <- NA}
    names(rankprodt)="Score"
    return(rankprodt)
  }

  dat <- Reduce(function(x,y){merge(x,y,by="Gene",all=T)},dat.list)

  # compute real rank product
  Gene=dat$Gene

  dat$Gene=NULL
  org.rankprod=apply(dat,1,rankprodt) # original real rank product

  # permute rank product
  perm_func <- function(rand) {
    permvec_func <- function(vec){set.seed(rand); vec[!is.na(vec)] <- sample(vec[!is.na(vec)]);return(vec)} # permute a vector but keep the NA position
    perm.dat=apply(dat,2,permvec_func) # permutated data frame
    perm.rankprod=apply(perm.dat,1,rankprodt) # a temporary rankprod after permutation
    perm.res=as.numeric(org.rankprod>=perm.rankprod) # compare if the permutated rankprod is larger than the original one
    names(perm.res)=Gene
    return(perm.res)
  }

  if (ncore==1) {res_list <- lapply(rand:(rand+nperm-1), perm_func)} else { # if users assign one core, no need to use parallel computing
    require(parallel) # parallel computing
    cl <- makeCluster(ncore)
    system.time(res_list <- parLapply(cl, rand:(rand+nperm-1), perm_func)) # each permutation will use the previous seed +1
  }
  names(res_list)=paste0("P",as.character(1:nperm))

  count=apply(data.frame(res_list),1,sum)
  res=data.frame(Gene=names(count),count)
  
  if (getERP) {
    res=data.frame(res, RP=org.rankprod, ERP=count/nperm)
    res$rank=rank(res$ERP,na.last="keep",ties.method="average")
    res$PFP=res$ERP*nrow(res)/res$rank
    res=res[order(res$PFP),]
  }
  return(res)
}

# Obtain gene score from single-modality dataset
genescore_singletype <- function(dat_list,col_var,func) { # col_var: column name to use; func: zscoresum, fishermethod, ranksum, fisherp, metaranef
    dat_res=data.frame() # empty data frame to store output table
    dat_var=lapply(dat_list,function(x){x[,col_var]}) # select specific column
    if (func=="metaranef") {res=lapply(dat_list,function(x){d=x$logFC;se=x$SD;metaranef(d=d,se=se)})}
    else {res=lapply(dat_var,eval(func))}
    #score=unlist(unname(res))
    #names(score)=names(res)
    dat_res=data.frame(Gene=names(res),as.data.frame(t(data.frame(res))))
    return(dat_res)
}

# Function to compute gene score for multi-modality datasets
genescore_multitype <- function(datlist,func,names) { # combine multi-modality datasets; func: zscoresum, fishermethod, ranksum, fisherp (metaranef is not applicable)
# load gene range file
    datgene <- readRDS(datgene_fn)
    names(datgene) <- c("Chr","Start","End","Gene")
    if (length(datlist)>1) {
        datlist=lapply(datlist,function(x){x[[func]]}) # obtain score dataframe for specific function
        dat <- Reduce(function(x,y) {merge(x,y,by="Gene")}, datlist) # merge each data frame
        names(dat)[2:ncol(dat)] <- paste0("Score.",names)
	if (func=="fisherp") {
	    dat$Score.integrated <- apply(dat[,-1],1,eval(func))
	} else {
            dat$Score.integrated <- apply(dat[,-1],1,sum)
	}
    } else {
	dat <- datlist[[1]][[func]] # obtain score dataframe for specific function
        names(dat)[2] <- paste0("Score.",names)
    }
    dat <- merge(datgene,dat,by="Gene")
    if (func=="ranksum"|func=="fishserp"|func=="metaranef") {dat <- dat[order(dat[,ncol(dat)]),]} 
    else { # sort score in the last column from smallest to largest
        dat <- dat[order(-dat[,ncol(dat)]),]}
    return(dat)
}

# output top 20 genes for integration results of gwas, gene expression and combined studies
# Obtain filename without extension or without path
file_noext <- function(fn) {tools::file_path_sans_ext(fn)}
file_nopath <- function(fn){basename(fn)}
top20integrate <- function(fn_withpath,func) { # func: zscoresum, fishermethod, ranksum, fisherp
    dat <- read.table(fn_withpath,header=T,sep="\t")
    fn_noext <- file_noext(fn_withpath)
    # multi-modality integrate score
    if ("Score.integrated"%in%names(dat)) {
        fn_top20 <- paste0(fn_noext,".top20integscore.txt")
        if (func=="ranksum"|func=="fishserp") {dat.top <- head(dat[order(dat$Score.integrated),],20)} else {dat.top <- head(dat[order(-dat$Score.integrated),],20)} # sort score from smallest to largest if by rank
        write.table(dat.top,fn_top20,col.names=T,row.names=F,sep="\t",quote=F)
    }
    # gwas integrate score
    if ("Score.gwas"%in%names(dat)) {
        fn_top20 <- paste0(fn_noext,".top20gwasscore.txt")
        if (func=="ranksum"|func=="fishserp") {dat.top <- head(dat[order(dat$Score.gwas),],20)} else {dat.top <- head(dat[order(-dat$Score.gwas),],20)}  # sort score from smallest to largest if by rank
        write.table(dat.top,fn_top20,col.names=T,row.names=F,sep="\t",quote=F)
    }
    # gene expression integrate score
    if ("Score.geneexpr"%in%names(dat)) {
        fn_top20 <- paste0(fn_noext,".top20geneexprscore.txt")
        if (func=="ranksum"|func=="fishserp") {dat.top <- head(dat[order(dat$Score.geneexpr),],20)} else {dat.top <- head(dat[order(-dat$Score.geneexpr),],20)}  # sort score from smallest to largest if by rank
        write.table(dat.top,fn_top20,col.names=T,row.names=F,sep="\t",quote=F)
    }
}
