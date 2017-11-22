#' ---
#' title: "creating_and_merging_datasets_final_project"
#' output: html_document
#' ---
#' 
#' 
## ----include=FALSE-------------------------------------------------------
library(knitr)
library(kableExtra)
library(lubridate)
library(tidyverse)
library(dplyr)
purl("load_and_clean_final_project_code.Rmd", output = "load_and_clean_final_project_code.R", documentation = 2)
source(file="load_and_clean_final_project_code.R")

#' 
#' #creating unique data sets
## ------------------------------------------------------------------------
 #create FI reg w/one line per visit (i.e. total screens) - returns 16,297
distinctFI<-FIreg [!duplicated(FIreg[c(1,11)]),] #includes 13 with no screening results?
x<-dim(distinctFI)

#create FI unique fams - returns 11,438
distinctFIfams<-as_tibble(distinctFI [!duplicated(distinctFI[c(1)]),]) #includes 9 with no screening data?
y<-dim(distinctFIfams)

#create RX reg w/one line per visit, begins Feb '15 - returns 2433 (by ID and FISdate)
distinctRX<-RXreg [!duplicated(RXreg[c(1,11)]),]
z<-dim(distinctRX)

#create RX reg unique fams - returns 2245
distinctRXfams<-as_tibble(distinctRX [!duplicated(distinctRX[c(1)]),])
a<-dim(distinctRXfams)

#create RX track w/one line per visit, begins Feb '14 - returns 2678
distinctRXtrack<-FullRX [!duplicated(FullRX[c(1,6,7)]),]
b<-dim(distinctRXtrack)

#create RX track uinique fams - returns 2504
distinctRXtrackfams<- as_tibble(distinctRXtrack [!duplicated(distinctRXtrack[c(6,7)]),])
c<-dim(distinctRXtrackfams)

#' 
#' #merging unique data sets
## ------------------------------------------------------------------------
library(dplyr)
NGmerge<-full_join(distinctFI,distinctRX) #returns 18,730 - makes sense, more receive RXes than are screened for FI
fullmerge<-full_join(NGmerge,distinctRXtrack)#returns 20,285 - adds in about 1500 paper RXes
f<-dim(fullmerge)

#create total unique visits - returns 18,058
fulluniquevisits<-as_tibble(fullmerge[!duplicated(fullmerge[c(1,11)]),])
g<-dim(fulluniquevisits)

#create total unique fams - returns 12,518
fulluniquefams<-as_tibble(fullmerge[!duplicated(fullmerge[c(1)]),])
h<-dim(fulluniquefams)



#create RX recipients dataset (not unique, multivisits) - returns 4743 (on FreshRX & RXType not blank)
RXrecips<-fullmerge %>%
  filter(FreshRX=="FreshRX"|Rx_Type!="")
r<-dim(RXrecips)

#create unique RX recipient visits dataset - returns 3427 (match on patient last and visitdate)
distinctRXrecips<-as_tibble(RXrecips [!duplicated(RXrecips[c(2,30)]),])
s<-dim(distinctRXrecips)

#create unique RX recipient families
distinctRXrecipfams<-as_tibble(distinctRXrecips [!duplicated(RXrecips[c(2,4)]),])
t<-dim(distinctRXrecipfams)



#create RX redemptions per visit dataset (not unique) - returns 355 (includes all diagnoses)
RXredemps<-fullmerge %>%
  filter(Status=="Complete")
u<-dim(RXredemps)

#create distinct RX redemptions dataset - returns 329 (match on patient last and visitdate)
distinctRXredemps<-as_tibble(RXredemps [!duplicated(RXredemps[c(2,30)]),])
v<-dim(distinctRXredemps)

#create distinct RX redemption families dataset - returns 309 (on patient last and first purch)
distinctRXredempfams<-as_tibble(RXredemps [!duplicated(RXredemps[c(2,46)]),])
w<-dim(distinctRXredempfams)



dataset<-c("FIreg","RXreg","FullRX","Fullmerge","RXrecips","RXredemps")
observations<-c(FR[1],RR[1],FRX[1],f[1],r[1],u[1])
distinct_visits<-c(x[1],z[1],b[1],g[1],s[1],v[1])
distinct_families<-c(y[1],a[1],c[1],h[1],t[1],w[1])
datasettable<-as.data.frame(cbind(dataset,observations,distinct_visits,distinct_families))
datasettable

#' 
#' 
## ------------------------------------------------------------------------
#create ever/never category
fullmerge$participation <- ifelse(fullmerge$Status == "Complete","ever", "never")

#' 
