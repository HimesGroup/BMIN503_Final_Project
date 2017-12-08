#' ---
#' title: "creating_datasets"
#' output:
#'   html_document: default
#' ---
#' 
## ----include=FALSE-------------------------------------------------------
library(knitr)
library(kableExtra)
library(lubridate)
library(tidyverse)
library(dplyr)
library(reshape2)
purl("load_and_clean.Rmd", output = "load_and_clean.R", documentation = 2)
source(file="load_and_clean.R")

#' 
## ------------------------------------------------------------------------
#creating registries w/no diagnoses datasets (in order to get one line per visit)
FIregnoD<-FIreg %>%
  select(-DxCode,-DxDesc)
RXregnoD<-RXreg %>% 
  select(-DxCode,-DxDesc)

#' 
#' 
## ------------------------------------------------------------------------
#merging registries with RX tracking set

#create FI reg w/one line per visit (i.e. total screens) - returns 16,297 (by ID & FISdate)
distinctFI<-FIregnoD [!duplicated(FIreg[c(1,11)]),]
x<-dim(distinctFI)

#create RX reg w/one line per visit, begins Feb '15 - returns 2433 (by ID and FISdate)
distinctRX<-RXregnoD [!duplicated(RXreg[c(1,11)]),]
z<-dim(distinctRX)

NGmerge<-merge(distinctFI, distinctRX, by=c("ID","Visitdate","DOB","Plast","FreshRX","Phone"),all=TRUE)


fullmerge<-full_join(NGmerge,FullRX)
f<-dim(fullmerge)


#create total unique visits - returns 19,174 (by ID,Clast,Plast,visitdate)
fulluniquevisits<-as_tibble(fullmerge[!duplicated(fullmerge[c(1,2,3,56)]),])
g<-dim(fulluniquevisits)

#' 
#' 
#' 
## ------------------------------------------------------------------------
#RX tracking breakdown

#create RXtracking unique visits - returns 2674 (by Visitdate, Plast,Phone, ClastRX)
distinctRXtrack<-FullRX[!duplicated(FullRX[c(1,3,5,7)]),]
b<-dim(distinctRXtrack)

#create RXtracking unique families - returns 2584 (by Plast,Phone, ClastRX)
distinctRXtrackfams<-FullRX[!duplicated(distinctRXtrack[c(3,5,7)]),]
c<-dim(distinctRXtrackfams)

#' 
#' 
#' 
## ------------------------------------------------------------------------
#RX recipients and redemptions

#create RX recipients dataset (not unique, multivisits) - returns 4104 (on FreshRX & RXType not blank)
RXrecips<-fullmerge %>%
  filter(FreshRX=="FreshRX"|Rx_Type!="")
r<-dim(RXrecips)

#create unique RX recipient visits dataset - returns 3932 (on Plast, Phone, Clast, Visitdate)
distinctRXrecips<-as_tibble(RXrecips [!duplicated(RXrecips[c(2,4,6,56)]),])
s<-dim(distinctRXrecips)

#create unique RX recipient families - returns 3598 (on Plast, Phone,Clast)
distinctRXrecipfams<-as_tibble(distinctRXrecips [!duplicated(distinctRXrecips[c(4,6,56)]),])
t<-dim(distinctRXrecipfams)


#create RX redemptions per visit dataset (not unique) - returns 375
RXredemps<-fullmerge %>%
  filter(Status=="Complete")
u<-dim(RXredemps)

#create distinct RX redemptions dataset - returns 373 (match on Phone, Plast, Clast, visitdate)
distinctRXredemps<-as_tibble(RXredemps [!duplicated(RXredemps[c(2,4,6,56)]),])
v<-dim(distinctRXredemps)

#create distinct RX redemption families dataset - returns 363 (on Phone,Plast, Clast)
distinctRXredempfams<-as_tibble(RXredemps [!duplicated(RXredemps[c(4,6,56)]),])
w<-dim(distinctRXredempfams)

#' 
#' 
#' 
#'             
## ------------------------------------------------------------------------
#unique fams sets

#create FI unique fams - returns 11,438 (by ID)
distinctFIfams<-as_tibble(distinctFI [!duplicated(distinctFI[c(1)]),]) #includes 9 with no screening data?
y<-dim(distinctFIfams)

#create RX reg unique fams - returns 2245 (by ID)
distinctRXfams<-as_tibble(distinctRX [!duplicated(distinctRX[c(1)]),])
a<-dim(distinctRXfams)

#create total unique fams - returns 12,988 (by Phone, Plast, Clast)
fulluniquefams<-as_tibble(fullmerge[!duplicated(fullmerge[c(4,6,56)]),])
h<-dim(fulluniquefams)

#' 
#' 
## ------------------------------------------------------------------------
#adding columns for later analysis

#adding columns for normal and overweight/obese categories
fulluniquefams<-fulluniquefams %>% 
  mutate(normal=BMI.x<25,
         over=BMI.x>=25)

#create ever/never category
fullmerge$participation <- ifelse(fullmerge$Status == "Complete",1, 0)
fulluniquefams$participation <- ifelse(fulluniquefams$Status == "Complete",1, 0)

#refactor FI.x for regression
fullmerge$FI.x <- ifelse(fullmerge$FI.x=="yes",1,0)
fulluniquefams$FI.x <- ifelse(fulluniquefams$FI.x=="yes",1,0)

#create age
age <- function(dob, age.day = today(), units = "years", floor = TRUE) {
    calc.age = interval(dob, age.day) / duration(num = 1, units = units)
    if (floor) return(as.integer(floor(calc.age)))
    return(calc.age)
}

#add age column to fullmerge set
fullmerge<-fullmerge %>% 
  mutate(age=age(DOB))

#add age column to fulluniquefams set
fulluniquefams<-fulluniquefams %>% 
  mutate(age=age(DOB))

#' 
#' 
#' 
## ------------------------------------------------------------------------
dataset<-c("FIreg","RXreg","FullRX","Fullmerge","RXrecips","RXredemps")
observations<-c(FR[1],RR[1],FRX[1],f[1],r[1],u[1])
distinct_visits<-c(x[1],z[1],b[1],g[1],s[1],v[1])
distinct_families<-c(y[1],a[1],c[1],h[1],t[1],w[1])
datasettable<-as.data.frame(cbind(dataset,observations,distinct_visits,distinct_families))
datasettable

#' 
#' 
#' 
#' 
#' 
