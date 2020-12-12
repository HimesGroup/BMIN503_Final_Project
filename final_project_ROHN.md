---
title: "BMIN503/EPID600 Final Project"
author: "Killian Rohn"
output: 
  html_document:
    keep_md: true
    toc: false 
    depth: 3 
    theme: paper 
    highlight: tango
---

```
## [1] 56000
```
***
### Overview

I want to look at if/how marital status impacts survival across different genders and cancer  sites. I know in general epi literature, there is a tendency to see that marriage typically is a stronger predictor of survival in men than in women depending on the disease.I plan to further stratify by race.


### Introduction 

It has been found across social epidemiological studies that marital status can be a predictor of survival outcomes for various diseases. Sometimes it is found that there is a  stronger association between being married and longer survival for men than for women. I  intend to investigate whether or not this pattern holds true for those diagnosed with various forms of cancer in the US and Puerto Rico, utilizing the SEER dataset. I would also like to further explore the effects of race on these potential associations. Epidemiology itself is an interdisciplinary field, and this project will also utilize the fields of social epidemiology, oncology, and biostatistics.

### Methods
I am using the SEER database below (over 8 million observations so far, so I can't upload it):
Surveillance, Epidemiology, and End Results (SEER) Program (www.seer.cancer.gov) SEER*Stat Database: Incidence - SEER 18 Regs Research Data + Hurricane Katrina Impacted Louisiana Cases, Nov 2018 Sub (1975-2016 varying) - Linked To County Attributes - Total U.S., 1969-2017 Counties,National Cancer Institute, DCCPS, Surveillance Research Program, released April 2019, based on the November 2018 submission. 

```r
library(tidyverse)
#load raw dataset
seer <- read.csv("C:/Users/kmroh/Documents/BMI Cert/BMIN503/dataset1.csv", header = T)
#view column names and rename variables of interest
colnames(seer)
```

```
##  [1] "Patient.ID"                               "Sex"                                      "Race.recode..White..Black..Other."        "Year.of.birth"                            "Year.of.diagnosis"                        "Marital.status.at.diagnosis"              "Survival.months"                          "COD.to.site.recode"                       "SEER.cause.specific.death.classification"
## [10] "Vital.status.recode..study.cutoff.used."  "Primary.Site...labeled"
```

```r
seer <- seer %>%
  rename(patid = Patient.ID, 
         sex = Sex, 
         year.dx = Year.of.diagnosis,
         mstatus = Marital.status.at.diagnosis,
         race = Race.recode..White..Black..Other.,
         surv.months = Survival.months,
         cod.site = COD.to.site.recode,
         cod = SEER.cause.specific.death.classification,
         vital.status = Vital.status.recode..study.cutoff.used.,
         yob = Year.of.birth,
         prim.site = Primary.Site...labeled) %>%
  select(-year.dx,-yob)
seer$surv.months <- as.integer(seer$surv.months)
#see possible marital statuses
table(seer$mstatus)
```

```
## 
##                       Divorced Married (including common law)                      Separated         Single (never married)                        Unknown  Unmarried or Domestic Partner                        Widowed 
##                         775276                        5171073                         105821                        1271327                         636193                           8124                        1449457
```

```r
#remove entries which are not married, partnered, or single at time of diagnosis
seer <- seer %>%
  filter(mstatus == "Married (including common law)" |
         mstatus == "Unmarried or Domestic Partner" |
         mstatus == "Single (never married)")
#recode to those who are partnered or not at the time of diagnosis
seer$part <- ifelse(seer$mstatus != "Single (never married)",
                    1,
                    0)
seer$part <- factor(seer$part, labels = c("Single","Partnered"))
#recode race variable
table(seer$race)
```

```
## 
##                                                     Black Other (American Indian/AK Native, Asian/Pacific Islander)                                                   Unknown                                                     White 
##                                                    601671                                                    449192                                                     30447                                                   5369214
```

```r
seer$race <- ifelse(seer$race == "Other (American Indian/AK Native, Asian/Pacific Islander)",
                    "Other", ifelse(seer$race == "White",
                                    "White", ifelse(seer$race == "Black",
                                                    "Black", ifelse(seer$race == "Unknown",
                                                                    "Unknown", 0))))
#remove those of unknown race 
seer <- seer %>%
  filter(race != "Unknown")
#remove those whose cause of death is unknown, or whose tumor is not the first
table(seer$cod)
```

```
## 
##          Alive or dead of other cause Dead (attributable to this cancer dx)            Dead (missing/unknown COD)                   N/A not first tumor 
##                               3471983                               1910445                                 42447                                995202
```

```r
seer <- seer %>%
  filter(cod == "Alive or dead of other cause Dead" |
         cod == "Dead (attributable to this cancer dx)")
#remove observations with unknown primary site and those that were alive at the study close
seer <- seer %>%
  filter(prim.site != "C80.9-Unknown primary site" |
           cod != "Alive")
#per classmate's feedback I'm setting a cap for survival months at 120 (10 years)
seer$surv.months <- ifelse(seer$surv.months >= 120, 120, seer$surv.months)
#create group average of survival month by part variable
seer <- seer %>%
  group_by(part) %>%
  mutate(avg.pstatus = mean(surv.months, na.rm = T))

#create group average of survival month by sex
seer <- seer %>%
  ungroup() %>%
  group_by(sex) %>%
  mutate(avg.sex = mean(surv.months, na.rm = T))

#create group average of survival month by mar and sex variables
seer <- seer %>%
  ungroup() %>%
  group_by(part,sex) %>%
  mutate(avg.part.sex = mean(surv.months, na.rm = T))

#recode primary site variable to body category
seer$c.code <- str_extract(seer$prim.site, "C[0-9][0-9]")
seer$c.code <- as.numeric(str_extract(seer$c.code, "[0-9][0-9]"))
seer$group <- ifelse(seer$c.code <= 14, "Lip, Oral Cavity and Pharynx",
 ifelse(seer$c.code <= 26,  "Digestive Organs",
 ifelse(seer$c.code <= 30,  NA,
 ifelse(seer$c.code <= 39,  "Respiratory and Intrathoracic Organs",
 ifelse(seer$c.code <= 41,  "Bone and Articular Cartilage",
 ifelse(seer$c.code == 42,  NA,
 ifelse(seer$c.code <= 44,  "Skin",
 ifelse(seer$c.code <= 49,  "Mesothelial and Soft Tissue",
 ifelse(seer$c.code == 50,  "Breast",
 ifelse(seer$c.code <= 58,  "Genital Organs",
 ifelse(seer$c.code == 59,  NA,
 ifelse(seer$c.code <= 63,  "Genital Organs",
 ifelse(seer$c.code <= 68,  "Urinary Tract",
 ifelse(seer$c.code <= 72,  "Eye, Brain or Central Nervous System",
 ifelse(seer$c.code <= 75,  "Thyroid & Endocrine Glands",
 ifelse(seer$c.code <= 80,  "Ill-Defined Sites",
 ifelse(seer$c.code <= 96,  "Lymphoid, Hematopoietic and Related Tissue", NA)))))))))))))))))
seer <- seer %>%
  ungroup() %>%
  group_by(part,sex,race) %>%
  mutate(avg.race = mean(surv.months, na.rm = T)) %>%
  ungroup() %>%
  group_by(part,sex,group) %>%
  mutate(avg.grp = mean(surv.months, na.rm = T)) %>%
  na.omit()

#create groups for pairwise ttests and anovas (there was probably a more elegant way to do this but this worked)
seer$psgroup[seer$sex == "Female" & seer$part == "Partnered"] <- "Part.Fem"
seer$psgroup[seer$sex == "Female" & seer$part == "Single"] <- "Sing.Fem"
seer$psgroup[seer$sex == "Male" & seer$part == "Partnered"] <- "Part.Male"
seer$psgroup[seer$sex == "Male" & seer$part == "Single"] <- "Sing.Male"
table(seer$psgroup)
```

```
## 
##  Part.Fem Part.Male  Sing.Fem Sing.Male 
##    529872    872233    160083    209728
```

```r
seer$psrgroup[seer$sex == "Female" & seer$part == "Single" & seer$race == "White"] <- "White.Sing.Fem"
seer$psrgroup[seer$sex == "Female" & seer$part == "Single" & seer$race == "Black"] <- "Black.Sing.Fem"
seer$psrgroup[seer$sex == "Female" & seer$part == "Single" & seer$race == "Other"] <- "Oth.Sing.Fem"
seer$psrgroup[seer$sex == "Female" & seer$part == "Partnered" & seer$race == "White"] <- "White.Part.Fem"
seer$psrgroup[seer$sex == "Female" & seer$part == "Partnered" & seer$race == "Black"] <- "Black.Part.Fem"
seer$psrgroup[seer$sex == "Female" & seer$part == "Partnered" & seer$race == "Other"] <- "Oth.Part.Fem"
seer$psrgroup[seer$sex == "Male" & seer$part == "Single" & seer$race == "White"] <- "White.Sing.Male"
seer$psrgroup[seer$sex == "Male" & seer$part == "Single" & seer$race == "Black"] <- "Black.Sing.Male"
seer$psrgroup[seer$sex == "Male" & seer$part == "Single" & seer$race == "Other"] <- "Oth.Sing.Male"
seer$psrgroup[seer$sex == "Male" & seer$part == "Partnered" & seer$race == "White"] <- "White.Part.Male"
seer$psrgroup[seer$sex == "Male" & seer$part == "Partnered" & seer$race == "Black"] <- "White.Part.Male"
seer$psrgroup[seer$sex == "Male" & seer$part == "Partnered" & seer$race == "Other"] <- "Oth.Part.Male"
table(seer$psrgroup)
```

```
## 
##  Black.Part.Fem  Black.Sing.Fem Black.Sing.Male    Oth.Part.Fem   Oth.Part.Male    Oth.Sing.Fem   Oth.Sing.Male  White.Part.Fem White.Part.Male  White.Sing.Fem White.Sing.Male 
##           38071           36727           44788           40081           66154            9637           11778          451720          806079          113719          153162
```

```r
seer$psbgroup[seer$sex == "Female" & seer$part == "Single" & seer$group == "Bone and Articular Cartilage"] <- "Bone.Sing.Fem"
seer$psbgroup[seer$sex == "Female" & seer$part == "Single" & seer$group == "Breast"] <- "Breast.Sing.Fem"
seer$psbgroup[seer$sex == "Female" & seer$part == "Single" & seer$group == "Digestive Organs"] <- "Dig.Sing.Fem"
seer$psbgroup[seer$sex == "Female" & seer$part == "Single" & seer$group == "Eye, Brain or Central Nervous System"] <- "Eye.Sing.Fem"
seer$psbgroup[seer$sex == "Female" & seer$part == "Single" & seer$group == "Genital Organs"] <- "Gen.Sing.Fem"
seer$psbgroup[seer$sex == "Female" & seer$part == "Single" & seer$group == "Ill-Defined Sites"] <- "Ill.Sing.Fem"
seer$psbgroup[seer$sex == "Female" & seer$part == "Single" & seer$group == "Lip, Oral Cavity and Pharynx"] <- "Lip.Sing.Fem"
seer$psbgroup[seer$sex == "Female" & seer$part == "Single" & seer$group == "Mesothelial and Soft Tissue"] <- "Meso.Sing.Fem"
seer$psbgroup[seer$sex == "Female" & seer$part == "Single" & seer$group == "Respiratory and Intrathoracic Organs"] <- "Resp.Sing.Fem"
seer$psbgroup[seer$sex == "Female" & seer$part == "Single" & seer$group == "Skin"] <- "Skin.Sing.Fem"
seer$psbgroup[seer$sex == "Female" & seer$part == "Single" & seer$group == "Thyroid & Endocrine Glands"] <- "Thy.Sing.Fem"
seer$psbgroup[seer$sex == "Female" & seer$part == "Single" & seer$group == "Urinary Tract"] <- "Uri.Sing.Fem"
seer$psbgroup[seer$sex == "Male" & seer$part == "Single" & seer$group == "Bone and Articular Cartilage"] <- "Bone.Sing.Male"
seer$psbgroup[seer$sex == "Male" & seer$part == "Single" & seer$group == "Breast"] <- "Breast.Sing.Male"
seer$psbgroup[seer$sex == "Male" & seer$part == "Single" & seer$group == "Digestive Organs"] <- "Dig.Sing.Male"
seer$psbgroup[seer$sex == "Male" & seer$part == "Single" & seer$group == "Eye, Brain or Central Nervous System"] <- "Eye.Sing.Male"
seer$psbgroup[seer$sex == "Male" & seer$part == "Single" & seer$group == "Genital Organs"] <- "Gen.Sing.Male"
seer$psbgroup[seer$sex == "Male" & seer$part == "Single" & seer$group == "Ill-Defined Sites"] <- "Ill.Sing.Male"
seer$psbgroup[seer$sex == "Male" & seer$part == "Single" & seer$group == "Lip, Oral Cavity and Pharynx"] <- "Lip.Sing.Male"
seer$psbgroup[seer$sex == "Male" & seer$part == "Single" & seer$group == "Mesothelial and Soft Tissue"] <- "Meso.Sing.Male"
seer$psbgroup[seer$sex == "Male" & seer$part == "Single" & seer$group == "Respiratory and Intrathoracic Organs"] <- "Resp.Sing.Male"
seer$psbgroup[seer$sex == "Male" & seer$part == "Single" & seer$group == "Skin"] <- "Skin.Sing.Male"
seer$psbgroup[seer$sex == "Male" & seer$part == "Single" & seer$group == "Thyroid & Endocrine Glands"] <- "Thy.Sing.Male"
seer$psbgroup[seer$sex == "Male" & seer$part == "Single" & seer$group == "Urinary Tract"] <- "Uri.Sing.Male"
seer$psbgroup[seer$sex == "Female" & seer$part == "Partnered" & seer$group == "Bone and Articular Cartilage"] <- "Bone.Part.Fem"
seer$psbgroup[seer$sex == "Female" & seer$part == "Partnered" & seer$group == "Breast"] <- "Breast.Part.Fem"
seer$psbgroup[seer$sex == "Female" & seer$part == "Partnered" & seer$group == "Digestive Organs"] <- "Dig.Part.Fem"
seer$psbgroup[seer$sex == "Female" & seer$part == "Partnered" & seer$group == "Eye, Brain or Central Nervous System"] <- "Eye.Part.Fem"
seer$psbgroup[seer$sex == "Female" & seer$part == "Partnered" & seer$group == "Genital Organs"] <- "Gen.Part.Fem"
seer$psbgroup[seer$sex == "Female" & seer$part == "Partnered" & seer$group == "Ill-Defined Sites"] <- "Ill.Part.Fem"
seer$psbgroup[seer$sex == "Female" & seer$part == "Partnered" & seer$group == "Lip, Oral Cavity and Pharynx"] <- "Lip.Part.Fem"
seer$psbgroup[seer$sex == "Female" & seer$part == "Partnered" & seer$group == "Mesothelial and Soft Tissue"] <- "Meso.Part.Fem"
seer$psbgroup[seer$sex == "Female" & seer$part == "Partnered" & seer$group == "Respiratory and Intrathoracic Organs"] <- "Resp.Part.Fem"
seer$psbgroup[seer$sex == "Female" & seer$part == "Partnered" & seer$group == "Skin"] <- "Skin.Part.Fem"
seer$psbgroup[seer$sex == "Female" & seer$part == "Partnered" & seer$group == "Thyroid & Endocrine Glands"] <- "Thy.Part.Fem"
seer$psbgroup[seer$sex == "Female" & seer$part == "Partnered" & seer$group == "Urinary Tract"] <- "Uri.Part.Fem"
seer$psbgroup[seer$sex == "Male" & seer$part == "Partnered" & seer$group == "Bone and Articular Cartilage"] <- "Bone.Part.Male"
seer$psbgroup[seer$sex == "Male" & seer$part == "Partnered" & seer$group == "Breast"] <- "Breast.Part.Male"
seer$psbgroup[seer$sex == "Male" & seer$part == "Partnered" & seer$group == "Digestive Organs"] <- "Dig.Part.Male"
seer$psbgroup[seer$sex == "Male" & seer$part == "Partnered" & seer$group == "Eye, Brain or Central Nervous System"] <- "Eye.Part.Male"
seer$psbgroup[seer$sex == "Male" & seer$part == "Partnered" & seer$group == "Genital Organs"] <- "Eye.Part.Male"
seer$psbgroup[seer$sex == "Male" & seer$part == "Partnered" & seer$group == "Ill-Defined Sites"] <- "Ill.Part.Male"
seer$psbgroup[seer$sex == "Male" & seer$part == "Partnered" & seer$group == "Lip, Oral Cavity and Pharynx"] <- "Lip.Part.Male"
seer$psbgroup[seer$sex == "Male" & seer$part == "Partnered" & seer$group == "Mesothelial and Soft Tissue"] <- "Meso.Part.Male"
seer$psbgroup[seer$sex == "Male" & seer$part == "Partnered" & seer$group == "Respiratory and Intrathoracic Organs"] <- "Resp.Part.Male"
seer$psbgroup[seer$sex == "Male" & seer$part == "Partnered" & seer$group == "Skin"] <- "Skin.Part.Male"
seer$psbgroup[seer$sex == "Male" & seer$part == "Partnered" & seer$group == "Thyroid & Endocrine Glands"] <- "Thy.Part.Male"
seer$psbgroup[seer$sex == "Male" & seer$part == "Partnered" & seer$group == "Urinary Tract"] <- "Uri.Part.Male"
```

### Results
Describe your results and include relevant tables, plots, and code/comments used to obtain them. End with a brief conclusion of your findings related to the question you set out to address. You can include references if you'd like, but this is not required.

Overall, both female sex and being partnered are associated with prolonged survival in cancer patients with statistically significant p-values of less than 0.05 in all ANOVAs and t-tests performed. The one caveat to the statistical significance of these results is that survival is generally only prolongued by a matter of a few months; while this may be emotionally meaningful for the loved ones of cancer patients, I also think that this could also mean prolongued suffering for terminally ill patients. Further, although the cleaned dataset has ~1.7 million observations, it is possible that that means the dataset is overpowered to detect significance. There are a few exceptions to the above stated pattern when subsetting the dataset by cancer sites. Specifically, bone and articular cartiledge patients survive longer when partnered, however this tendency is not statistically significant and there is virtually no difference between sexes; skin cancer patients are statistically differentiated between groups, except for single males and partnered females; mesothial single males are not statistically differentiated from females, whether single or partnered; breast patients are significantly differentiated by sex but not by partnership status; partnered genital patients survive longer than single patients, however in this group men survive longer than women and these findings are statistically significant -- this pattern is also true for urinary tract patients; single male and female thyroid patients and ill-defined sites patients are not statistically differentiated.

```r
library(rstatix)
library(ggpubr)

#plot survival months by recoded marital status
ggplot(seer, aes(x=as.factor(part), y=surv.months)) +
  geom_boxplot(aes(middle = mean(surv.months))) +
  theme(plot.title = element_text(hjust = 0.5),
        panel.border = element_blank(), 
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(), 
        axis.line = element_line(colour = "black")) +
  labs(title = "Survival Months by Marital Status at Diagnosis \nAll Sexes", 
       x = "Relationship status", 
       y = "Survival Months") +
  stat_summary(fun.y=mean, colour="yellow") +
  geom_text(aes(label = round(avg.pstatus,2), y = avg.pstatus))
```

![](final_project_ROHN_files/figure-html/unnamed-chunk-2-1.png)<!-- -->

```r
#t-test for significance
t.test(seer$surv.months~seer$part)
```

```
## 
## 	Welch Two Sample t-test
## 
## data:  seer$surv.months by seer$part
## t = -98.691, df = 660132, p-value < 2.2e-16
## alternative hypothesis: true difference in means is not equal to 0
## 95 percent confidence interval:
##  -5.622102 -5.403146
## sample estimates:
##    mean in group Single mean in group Partnered 
##                20.80908                26.32170
```

```r
#plot survival months by sex
ggplot(seer, aes(x=as.factor(sex), y=surv.months)) +
  geom_boxplot(aes(middle = mean(surv.months))) +
  theme(plot.title = element_text(hjust = 0.5),
        panel.border = element_blank(), 
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(), 
        axis.line = element_line(colour = "black")) +
  labs(title = "Survival Months by Sex", 
       x = "Sex", 
       y = "Survival Months") +
  stat_summary(fun.y=mean, colour="yellow") +
  geom_text(aes(label = round(avg.sex,2), y = avg.sex))
```

![](final_project_ROHN_files/figure-html/unnamed-chunk-2-2.png)<!-- -->

```r
#t-test for significance
t.test(seer$surv.months~seer$sex)
```

```
## 
## 	Welch Two Sample t-test
## 
## data:  seer$surv.months by seer$sex
## t = 99.076, df = 1389519, p-value < 2.2e-16
## alternative hypothesis: true difference in means is not equal to 0
## 95 percent confidence interval:
##  5.020211 5.222844
## sample estimates:
## mean in group Female   mean in group Male 
##             28.29847             23.17694
```

```r
#plot survival months by part and sex
ggplot(seer, aes(x=as.factor(part), y=surv.months)) +
  geom_boxplot(aes(color = sex, middle = mean(surv.months))) +
  theme(plot.title = element_text(hjust = 0.5),
        panel.border = element_blank(), 
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(), 
        axis.line = element_line(colour = "black"),
        legend.position = "none") +
  labs(title = "Survival Months by Marital Status at Diagnosis \nand Sex", 
       x = "Relationship status", 
       y = "Survival Months") +
  stat_summary(fun.y=mean, colour="yellow") +
  geom_text(aes(label = round(avg.part.sex,2), y = avg.part.sex)) +
  facet_wrap(~sex)
```

![](final_project_ROHN_files/figure-html/unnamed-chunk-2-3.png)<!-- -->

```r
#pairwise t-test and anova based on partner status and sex
summary(aov(surv.months ~ psgroup, data = seer))
```

```
##                  Df    Sum Sq Mean Sq F value Pr(>F)    
## psgroup           3 2.090e+07 6967150    6427 <2e-16 ***
## Residuals   1771912 1.921e+09    1084                   
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

```r
pairwise.t.test(seer$surv.months, seer$psgroup, p.adjust.method = "bonferroni")
```

```
## 
## 	Pairwise comparisons using t tests with pooled SD 
## 
## data:  seer$surv.months and seer$psgroup 
## 
##           Part.Fem Part.Male Sing.Fem
## Part.Male < 2e-16  -         -       
## Sing.Fem  < 2e-16  1.3e-09   -       
## Sing.Male < 2e-16  < 2e-16   < 2e-16 
## 
## P value adjustment method: bonferroni
```

```r
#plot survival months by part, sex, and race
ggplot(seer, aes(x=as.factor(part), y=surv.months)) +
  geom_boxplot(aes(color = sex, middle = mean(surv.months))) +
  theme(plot.title = element_text(hjust = 0.5),
        panel.border = element_blank(), 
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(), 
        axis.line = element_line(colour = "black"),
        legend.position = "none") +
  labs(title = "Survival Months by Marital Status at Diagnosis, \nSex, and Race", 
       x = "Relationship status", 
       y = "Survival Months") +
  stat_summary(fun.y=mean, colour="yellow") +
  facet_grid(~ race + sex) +
  geom_text(aes(label = round(avg.race,2), y = avg.race))
```

![](final_project_ROHN_files/figure-html/unnamed-chunk-2-4.png)<!-- -->

```r
#pairwise t-test and anova based on partner status, sex and race
summary(aov(surv.months ~ psrgroup, data = seer))
```

```
##                  Df    Sum Sq Mean Sq F value Pr(>F)    
## psrgroup         10 2.252e+07 2251604    2079 <2e-16 ***
## Residuals   1771905 1.919e+09    1083                   
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

```r
pairwise.t.test(seer$surv.months, seer$psrgroup, p.adjust.method = "bonferroni")
```

```
## 
## 	Pairwise comparisons using t tests with pooled SD 
## 
## data:  seer$surv.months and seer$psrgroup 
## 
##                 Black.Part.Fem Black.Sing.Fem Black.Sing.Male Oth.Part.Fem Oth.Part.Male Oth.Sing.Fem Oth.Sing.Male White.Part.Fem White.Part.Male White.Sing.Fem
## Black.Sing.Fem  < 2e-16        -              -               -            -             -            -             -              -               -             
## Black.Sing.Male < 2e-16        < 2e-16        -               -            -             -            -             -              -               -             
## Oth.Part.Fem    3.5e-06        < 2e-16        < 2e-16         -            -             -            -             -              -               -             
## Oth.Part.Male   < 2e-16        1.00000        < 2e-16         < 2e-16      -             -            -             -              -               -             
## Oth.Sing.Fem    0.00017        < 2e-16        < 2e-16         2.9e-14      < 2e-16       -            -             -              -               -             
## Oth.Sing.Male   < 2e-16        < 2e-16        0.14091         < 2e-16      < 2e-16       < 2e-16      -             -              -               -             
## White.Part.Fem  < 2e-16        < 2e-16        < 2e-16         < 2e-16      < 2e-16       < 2e-16      < 2e-16       -              -               -             
## White.Part.Male < 2e-16        < 2e-16        < 2e-16         < 2e-16      < 2e-16       1.00000      < 2e-16       < 2e-16        -               -             
## White.Sing.Fem  < 2e-16        < 2e-16        < 2e-16         < 2e-16      < 2e-16       0.28486      < 2e-16       < 2e-16        1.00000         -             
## White.Sing.Male < 2e-16        < 2e-16        < 2e-16         < 2e-16      < 2e-16       < 2e-16      0.00121       < 2e-16        < 2e-16         < 2e-16       
## 
## P value adjustment method: bonferroni
```

```r
#pairwise t-test and anova based on partner status, sex and cancer site
summary(aov(surv.months ~ psbgroup, data = seer))
```

```
##                  Df    Sum Sq Mean Sq F value Pr(>F)    
## psbgroup         46 3.512e+08 7635376    8506 <2e-16 ***
## Residuals   1771869 1.590e+09     898                   
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

```r
#plot survival months by part, sex and group
ggplot(subset(seer, group %in% c("Lip, Oral Cavity and Pharynx")), aes(x=as.factor(part), y=surv.months)) +
  geom_boxplot(aes(color = sex, middle = mean(surv.months))) +
  theme(plot.title = element_text(hjust = 0.5),
        panel.border = element_blank(), 
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(), 
        axis.line = element_line(colour = "black"),
        legend.position = "none") +
  labs(title = "Survival Months by Marital Status at Diagnosis \nand Sex \nGroup: Lip, Oral Cavity and Pharynx", 
       x = "Relationship status", 
       y = "Survival Months") + 
  stat_summary(fun.y=mean, colour="yellow") +
  geom_text(aes(label = round(avg.grp,2), y = avg.grp)) +
  facet_wrap(~sex)
```

![](final_project_ROHN_files/figure-html/unnamed-chunk-2-5.png)<!-- -->

```r
#pairwise t-test and anova based on partner status, sex and cancer site
summary(aov(surv.months ~ psbgroup, data = subset(seer, group %in% c("Lip, Oral Cavity and Pharynx"))))
```

```
##                Df   Sum Sq Mean Sq F value Pr(>F)    
## psbgroup        3   983177  327726   291.8 <2e-16 ***
## Residuals   46631 52373598    1123                   
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

```r
seer1 <- subset(seer, group %in% c("Lip, Oral Cavity and Pharynx"))
pairwise.t.test(seer1$surv.months, seer1$psbgroup, p.adjust.method = "bonferroni")
```

```
## 
## 	Pairwise comparisons using t tests with pooled SD 
## 
## data:  seer1$surv.months and seer1$psbgroup 
## 
##               Lip.Part.Fem Lip.Part.Male Lip.Sing.Fem
## Lip.Part.Male < 2e-16      -             -           
## Lip.Sing.Fem  < 2e-16      < 2e-16       -           
## Lip.Sing.Male < 2e-16      < 2e-16       3.4e-05     
## 
## P value adjustment method: bonferroni
```

```r
ggplot(subset(seer, group %in% c("Digestive Organs")), aes(x=as.factor(part), y=surv.months)) +
  geom_boxplot(aes(color = sex, middle = mean(surv.months))) +
  theme(plot.title = element_text(hjust = 0.5),
        panel.border = element_blank(), 
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(), 
        axis.line = element_line(colour = "black"),
        legend.position = "none") +
  labs(title = "Survival Months by Marital Status at Diagnosis \nand Sex \nGroup: Digestive Organs", 
       x = "Relationship status", 
       y = "Survival Months")  +
  stat_summary(fun.y=mean, colour="yellow") +
  geom_text(aes(label = round(avg.grp,2), y = avg.grp)) +
  facet_wrap(~sex)
```

![](final_project_ROHN_files/figure-html/unnamed-chunk-2-6.png)<!-- -->

```r
#pairwise t-test and anova based on partner status, sex and cancer site
summary(aov(surv.months ~ psbgroup, data = subset(seer, group %in% c("Digestive Organs"))))
```

```
##                 Df    Sum Sq Mean Sq F value Pr(>F)    
## psbgroup         3   1395750  465250   724.9 <2e-16 ***
## Residuals   503053 322869666     642                   
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

```r
seer2 <- subset(seer, group %in% c("Digestive Organs"))
pairwise.t.test(seer2$surv.months, seer2$psbgroup, p.adjust.method = "bonferroni")
```

```
## 
## 	Pairwise comparisons using t tests with pooled SD 
## 
## data:  seer2$surv.months and seer2$psbgroup 
## 
##               Dig.Part.Fem Dig.Part.Male Dig.Sing.Fem
## Dig.Part.Male <2e-16       -             -           
## Dig.Sing.Fem  <2e-16       <2e-16        -           
## Dig.Sing.Male <2e-16       <2e-16        <2e-16      
## 
## P value adjustment method: bonferroni
```

```r
ggplot(subset(seer, group %in% c("Respiratory and Intrathoracic Organs")), aes(x=as.factor(part), y=surv.months)) +
  geom_boxplot(aes(color = sex, middle = mean(surv.months))) +
  theme(plot.title = element_text(hjust = 0.5),
        panel.border = element_blank(), 
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(), 
        axis.line = element_line(colour = "black"),
        legend.position = "none") +
  labs(title = "Survival Months by Marital Status at Diagnosis \nand Sex \nGroup: Respiratory and Intrathoracic Organs", 
       x = "Relationship status", 
       y = "Survival Months") +
  stat_summary(fun.y=mean, colour="yellow") +
  geom_text(aes(label = round(avg.grp,2), y = avg.grp)) +
  facet_wrap(~sex)
```

![](final_project_ROHN_files/figure-html/unnamed-chunk-2-7.png)<!-- -->

```r
#pairwise t-test and anova based on partner status, sex and cancer site
summary(aov(surv.months ~ psbgroup, data = subset(seer, group %in% c("Respiratory and Intrathoracic Organs"))))
```

```
##                 Df    Sum Sq Mean Sq F value Pr(>F)    
## psbgroup         3   1197052  399017   827.8 <2e-16 ***
## Residuals   499189 240615650     482                   
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

```r
seer3 <- subset(seer, group %in% c("Respiratory and Intrathoracic Organs"))
pairwise.t.test(seer3$surv.months, seer3$psbgroup, p.adjust.method = "bonferroni")
```

```
## 
## 	Pairwise comparisons using t tests with pooled SD 
## 
## data:  seer3$surv.months and seer3$psbgroup 
## 
##                Resp.Part.Fem Resp.Part.Male Resp.Sing.Fem
## Resp.Part.Male < 2e-16       -              -            
## Resp.Sing.Fem  < 2e-16       5.4e-07        -            
## Resp.Sing.Male < 2e-16       < 2e-16        < 2e-16      
## 
## P value adjustment method: bonferroni
```

```r
ggplot(subset(seer, group %in% c("Bone and Articular Cartilage")), aes(x=as.factor(part), y=surv.months)) +
  geom_boxplot(aes(color = sex, middle = mean(surv.months))) +
  theme(plot.title = element_text(hjust = 0.5),
        panel.border = element_blank(), 
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(), 
        axis.line = element_line(colour = "black"),
        legend.position = "none") +
  labs(title = "Survival Months by Marital Status at Diagnosis \nand Sex \nGroup: Bone and Articular Cartilage", 
       x = "Relationship status", 
       y = "Survival Months") +
  stat_summary(fun.y=mean, colour="yellow") +
  geom_text(aes(label = round(avg.grp,2), y = avg.grp)) +
  facet_wrap(~sex)
```

![](final_project_ROHN_files/figure-html/unnamed-chunk-2-8.png)<!-- -->

```r
#pairwise t-test and anova based on partner status, sex and cancer site
summary(aov(surv.months ~ psbgroup, data = subset(seer, group %in% c("Bone and Articular Cartilage"))))#not stat. sig
```

```
##               Df  Sum Sq Mean Sq F value Pr(>F)  
## psbgroup       3    9014    3005   2.779 0.0396 *
## Residuals   6155 6655004    1081                 
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

```r
seer4 <- subset(seer, group %in% c("Bone and Articular Cartilage"))
pairwise.t.test(seer4$surv.months, seer4$psbgroup, p.adjust.method = "bonferroni") #not stat. sig
```

```
## 
## 	Pairwise comparisons using t tests with pooled SD 
## 
## data:  seer4$surv.months and seer4$psbgroup 
## 
##                Bone.Part.Fem Bone.Part.Male Bone.Sing.Fem
## Bone.Part.Male 1.00          -              -            
## Bone.Sing.Fem  0.50          0.28           -            
## Bone.Sing.Male 0.33          0.13           1.00         
## 
## P value adjustment method: bonferroni
```

```r
ggplot(subset(seer, group %in% c("Skin")), aes(x=as.factor(part), y=surv.months)) +
  geom_boxplot(aes(color = sex, middle = mean(surv.months))) +
  theme(plot.title = element_text(hjust = 0.5),
        panel.border = element_blank(), 
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(), 
        axis.line = element_line(colour = "black"),
        legend.position = "none") +
  labs(title = "Survival Months by Marital Status at Diagnosis \nand Sex \nGroup: Skin", 
       x = "Relationship status", 
       y = "Survival Months") +
  stat_summary(fun.y=mean, colour="yellow") +
  geom_text(aes(label = round(avg.grp,2), y = avg.grp)) +
  facet_wrap(~sex)
```

![](final_project_ROHN_files/figure-html/unnamed-chunk-2-9.png)<!-- -->

```r
#pairwise t-test and anova based on partner status, sex and cancer site
summary(aov(surv.months ~ psbgroup, data = subset(seer, group %in% c("Skin"))))
```

```
##                Df   Sum Sq Mean Sq F value Pr(>F)    
## psbgroup        3  2776317  925439   762.4 <2e-16 ***
## Residuals   41151 49953116    1214                   
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

```r
seer5 <- subset(seer, group %in% c("Skin"))
pairwise.t.test(seer5$surv.months, seer5$psbgroup, p.adjust.method = "bonferroni") #not stat. sig between single females and partnered males
```

```
## 
## 	Pairwise comparisons using t tests with pooled SD 
## 
## data:  seer5$surv.months and seer5$psbgroup 
## 
##                Skin.Part.Fem Skin.Part.Male Skin.Sing.Fem
## Skin.Part.Male <2e-16        -              -            
## Skin.Sing.Fem  <2e-16        1              -            
## Skin.Sing.Male <2e-16        <2e-16         <2e-16       
## 
## P value adjustment method: bonferroni
```

```r
ggplot(subset(seer, group %in% c("Mesothelial and Soft Tissue")), aes(x=as.factor(part), y=surv.months)) +
  geom_boxplot(aes(color = sex, middle = mean(surv.months))) +
  theme(plot.title = element_text(hjust = 0.5),
        panel.border = element_blank(), 
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(), 
        axis.line = element_line(colour = "black"),
        legend.position = "none") +
  labs(title = "Survival Months by Marital Status at Diagnosis \nand Sex \nGroup: Mesothelial and Soft Tissue", 
       x = "Relationship status", 
       y = "Survival Months") +
  stat_summary(fun.y=mean, colour="yellow") +
  geom_text(aes(label = round(avg.grp,2), y = avg.grp)) +
  facet_wrap(~sex)
```

![](final_project_ROHN_files/figure-html/unnamed-chunk-2-10.png)<!-- -->

```r
#pairwise t-test and anova based on partner status, sex and cancer site
summary(aov(surv.months ~ psbgroup, data = subset(seer, group %in% c("Mesothelial and Soft Tissue"))))
```

```
##                Df   Sum Sq Mean Sq F value Pr(>F)    
## psbgroup        3   133920   44640   47.49 <2e-16 ***
## Residuals   21319 20039676     940                   
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

```r
seer6 <- subset(seer, group %in% c("Mesothelial and Soft Tissue"))
pairwise.t.test(seer6$surv.months, seer6$psbgroup, p.adjust.method = "bonferroni") #not stat. sig between single males and partnered females or between single females and single males
```

```
## 
## 	Pairwise comparisons using t tests with pooled SD 
## 
## data:  seer6$surv.months and seer6$psbgroup 
## 
##                Meso.Part.Fem Meso.Part.Male Meso.Sing.Fem
## Meso.Part.Male <2e-16        -              -            
## Meso.Sing.Fem  1e-13         1.00           -            
## Meso.Sing.Male <2e-16        0.01           0.56         
## 
## P value adjustment method: bonferroni
```

```r
ggplot(subset(seer, group %in% c("Breast")), aes(x=as.factor(part), y=surv.months)) +
  geom_boxplot(aes(color = sex, middle = mean(surv.months))) +
  theme(plot.title = element_text(hjust = 0.5),
        panel.border = element_blank(), 
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(), 
        axis.line = element_line(colour = "black"),
        legend.position = "none") +
  labs(title = "Survival Months by Marital Status at Diagnosis \nand Sex \nGroup: Breast", 
       x = "Relationship status", 
       y = "Survival Months") +
  stat_summary(fun.y=mean, colour="yellow") +
  geom_text(aes(label = round(avg.grp,2), y = avg.grp)) +
  facet_wrap(~sex)
```

![](final_project_ROHN_files/figure-html/unnamed-chunk-2-11.png)<!-- -->

```r
#pairwise t-test and anova based on partner status, sex and cancer site
summary(aov(surv.months ~ psbgroup, data = subset(seer, group %in% c("Breast"))))
```

```
##                 Df    Sum Sq Mean Sq F value Pr(>F)    
## psbgroup         3   3572150 1190717   744.5 <2e-16 ***
## Residuals   138411 221365209    1599                   
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

```r
seer7 <- subset(seer, group %in% c("Breast"))
pairwise.t.test(seer7$surv.months, seer7$psbgroup, p.adjust.method = "bonferroni")# not stat. sig between partnered males and females or between single males and females
```

```
## 
## 	Pairwise comparisons using t tests with pooled SD 
## 
## data:  seer7$surv.months and seer7$psbgroup 
## 
##                  Breast.Part.Fem Breast.Part.Male Breast.Sing.Fem
## Breast.Part.Male 1.00            -                -              
## Breast.Sing.Fem  < 2e-16         < 2e-16          -              
## Breast.Sing.Male 4.0e-11         1.7e-08          0.62           
## 
## P value adjustment method: bonferroni
```

```r
ggplot(subset(seer, group %in% c("Genital Organs")), aes(x=as.factor(part), y=surv.months)) +
  geom_boxplot(aes(color = sex, middle = mean(surv.months))) +
  theme(plot.title = element_text(hjust = 0.5),
        panel.border = element_blank(), 
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(), 
        axis.line = element_line(colour = "black"),
        legend.position = "none") +
  labs(title = "Survival Months by Marital Status at Diagnosis \nand Sex \nGroup: Genital Organs", 
       x = "Relationship status", 
       y = "Survival Months") +
  stat_summary(fun.y=mean, colour="yellow") +
  geom_text(aes(label = round(avg.grp,2), y = avg.grp)) +
  facet_wrap(~sex)
```

![](final_project_ROHN_files/figure-html/unnamed-chunk-2-12.png)<!-- -->

```r
#pairwise t-test and anova based on partner status, sex and cancer site
summary(aov(surv.months ~ psbgroup, data = subset(seer, group %in% c("Genital Organs"))))
```

```
##                 Df    Sum Sq  Mean Sq F value Pr(>F)    
## psbgroup         3  48291542 16097181   11197 <2e-16 ***
## Residuals   210982 303324789     1438                   
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

```r
seer8 <- subset(seer, group %in% c("Genital Organs"))
pairwise.t.test(seer8$surv.months, seer8$psbgroup, p.adjust.method = "bonferroni")
```

```
## 
## 	Pairwise comparisons using t tests with pooled SD 
## 
## data:  seer8$surv.months and seer8$psbgroup 
## 
##               Eye.Part.Male Gen.Part.Fem Gen.Sing.Fem
## Gen.Part.Fem  <2e-16        -            -           
## Gen.Sing.Fem  <2e-16        <2e-16       -           
## Gen.Sing.Male <2e-16        <2e-16       <2e-16      
## 
## P value adjustment method: bonferroni
```

```r
ggplot(subset(seer, group %in% c("Urinary Tract")), aes(x=as.factor(part), y=surv.months)) +
  geom_boxplot(aes(color = sex, middle = mean(surv.months))) +
  theme(plot.title = element_text(hjust = 0.5),
        panel.border = element_blank(), 
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(), 
        axis.line = element_line(colour = "black"),
        legend.position = "none") +
  labs(title = "Survival Months by Marital Status at Diagnosis \nand Sex \nGroup: Urinary Tract", 
       x = "Relationship status", 
       y = "Survival Months") +
  stat_summary(fun.y=mean, colour="yellow") +
  geom_text(aes(label = round(avg.grp,2), y = avg.grp)) +
  facet_wrap(~sex)
```

![](final_project_ROHN_files/figure-html/unnamed-chunk-2-13.png)<!-- -->

```r
#pairwise t-test and anova based on partner status, sex and cancer site
summary(aov(surv.months ~ psbgroup, data = subset(seer, group %in% c("Urinary Tract"))))
```

```
##                Df    Sum Sq Mean Sq F value Pr(>F)    
## psbgroup        3   1561995  520665   374.4 <2e-16 ***
## Residuals   97138 135102051    1391                   
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

```r
seer9 <- subset(seer, group %in% c("Urinary Tract"))
pairwise.t.test(seer9$surv.months, seer9$psbgroup, p.adjust.method = "bonferroni")
```

```
## 
## 	Pairwise comparisons using t tests with pooled SD 
## 
## data:  seer9$surv.months and seer9$psbgroup 
## 
##               Uri.Part.Fem Uri.Part.Male Uri.Sing.Fem
## Uri.Part.Male < 2e-16      -             -           
## Uri.Sing.Fem  < 2e-16      < 2e-16       -           
## Uri.Sing.Male < 2e-16      < 2e-16       3.6e-06     
## 
## P value adjustment method: bonferroni
```

```r
ggplot(subset(seer, group %in% c("Eye, Brain or Central Nervous System")), aes(x=as.factor(part), y=surv.months)) +
  geom_boxplot(aes(color = sex, middle = mean(surv.months))) +
  theme(plot.title = element_text(hjust = 0.5),
        panel.border = element_blank(), 
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(), 
        axis.line = element_line(colour = "black"),
        legend.position = "none") +
  labs(title = "Survival Months by Marital Status at Diagnosis \nand Sex \nGroup: Eye, Brain or Central Nervous System", 
       x = "Relationship status", 
       y = "Survival Months") +
  stat_summary(fun.y=mean, colour="yellow") +
  geom_text(aes(label = round(avg.grp,2), y = avg.grp)) +
  facet_wrap(~sex)
```

![](final_project_ROHN_files/figure-html/unnamed-chunk-2-14.png)<!-- -->

```r
#pairwise t-test and anova based on partner status, sex and cancer site
summary(aov(surv.months ~ psbgroup, data = subset(seer, group %in% c("Eye, Brain or Central Nervous System"))))
```

```
##                Df   Sum Sq Mean Sq F value Pr(>F)    
## psbgroup        3   309508  103169   131.2 <2e-16 ***
## Residuals   66700 52461349     787                   
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

```r
seer10 <- subset(seer, group %in% c("Eye, Brain or Central Nervous System"))
pairwise.t.test(seer10$surv.months, seer10$psbgroup, p.adjust.method = "bonferroni")
```

```
## 
## 	Pairwise comparisons using t tests with pooled SD 
## 
## data:  seer10$surv.months and seer10$psbgroup 
## 
##               Eye.Part.Fem Eye.Part.Male Eye.Sing.Fem
## Eye.Part.Male < 2e-16      -             -           
## Eye.Sing.Fem  < 2e-16      < 2e-16       -           
## Eye.Sing.Male 8.9e-08      < 2e-16       0.0016      
## 
## P value adjustment method: bonferroni
```

```r
ggplot(subset(seer, group %in% c("Thyroid & Endocrine Glands")), aes(x=as.factor(part), y=surv.months)) +
  geom_boxplot(aes(color = sex, middle = mean(surv.months))) +
  theme(plot.title = element_text(hjust = 0.5),
        panel.border = element_blank(), 
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(), 
        axis.line = element_line(colour = "black"),
        legend.position = "none") +
  labs(title = "Survival Months by Marital Status at Diagnosis \nand Sex \nGroup: Thyroid & Endocrine Glands", 
       x = "Relationship status", 
       y = "Survival Months") +
  stat_summary(fun.y=mean, colour="yellow") +
  geom_text(aes(label = round(avg.grp,2), y = avg.grp)) +
  facet_wrap(~sex)
```

![](final_project_ROHN_files/figure-html/unnamed-chunk-2-15.png)<!-- -->

```r
#pairwise t-test and anova based on partner status, sex and cancer site
summary(aov(surv.months ~ psbgroup, data = subset(seer, group %in% c("Thyroid & Endocrine Glands"))))
```

```
##               Df   Sum Sq Mean Sq F value Pr(>F)    
## psbgroup       3   231917   77306   43.26 <2e-16 ***
## Residuals   8569 15312601    1787                   
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

```r
seer11 <- subset(seer, group %in% c("Thyroid & Endocrine Glands"))
pairwise.t.test(seer11$surv.months, seer11$psbgroup, p.adjust.method = "bonferroni")#not stat. sig
```

```
## 
## 	Pairwise comparisons using t tests with pooled SD 
## 
## data:  seer11$surv.months and seer11$psbgroup 
## 
##               Thy.Part.Fem Thy.Part.Male Thy.Sing.Fem
## Thy.Part.Male 0.00022      -             -           
## Thy.Sing.Fem  8.1e-15      3.8e-06       -           
## Thy.Sing.Male < 2e-16      2.9e-11       0.70821     
## 
## P value adjustment method: bonferroni
```

```r
ggplot(subset(seer, group %in% c("Ill-Defined Sites")), aes(x=as.factor(part), y=surv.months)) +
  geom_boxplot(aes(color = sex, middle = mean(surv.months))) +
  theme(plot.title = element_text(hjust = 0.5),
        panel.border = element_blank(), 
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(), 
        axis.line = element_line(colour = "black"),
        legend.position = "none") +
  labs(title = "Survival Months by Marital Status at Diagnosis \nand Sex \nGroup: Ill-Defined Sites", 
       x = "Relationship status", 
       y = "Survival Months") +
  stat_summary(fun.y=mean, colour="yellow") +
  geom_text(aes(label = round(avg.grp,2), y = avg.grp)) +
  facet_wrap(~sex)
```

![](final_project_ROHN_files/figure-html/unnamed-chunk-2-16.png)<!-- -->

```r
#pairwise t-test and anova based on partner status, sex and cancer site
summary(aov(surv.months ~ psbgroup, data = subset(seer, group %in% c("Ill-Defined Sites"))))
```

```
##                 Df    Sum Sq Mean Sq F value Pr(>F)    
## psbgroup         3    460461  153487     163 <2e-16 ***
## Residuals   132570 124830544     942                   
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

```r
seer12 <- subset(seer, group %in% c("Ill-Defined Sites"))
pairwise.t.test(seer12$surv.months, seer12$psbgroup, p.adjust.method = "bonferroni")#not stat. sig
```

```
## 
## 	Pairwise comparisons using t tests with pooled SD 
## 
## data:  seer12$surv.months and seer12$psbgroup 
## 
##               Ill.Part.Fem Ill.Part.Male Ill.Sing.Fem
## Ill.Part.Male 3.2e-08      -             -           
## Ill.Sing.Fem  < 2e-16      < 2e-16       -           
## Ill.Sing.Male < 2e-16      < 2e-16       0.12        
## 
## P value adjustment method: bonferroni
```
