---
title: "Follow Up Documentation After Clinical Genetics Consultation"
author: "Ian Campbell"
output: 
  html_document:
    keep_md: true
    toc: false 
    depth: 3 
    theme: paper 
    highlight: tango
---

```r
options(width = 400)
library(data.table)
library(tidyverse)
library(magrittr)
library(lubridate)
```
***

### Overview
Clinical Genetics consultation during hospitalization attempts to identify an underlying cause of a patient’s multiple medical problems and may include genetic testing which takes many weeks or months to complete. Because the patient may be discharged from the hospital before the testing results become available, ensuring that the results are effectively communicated to the patient or family and their healthcare team is challenging. I used data extracted from the Children’s Hospital of Philadelphia electronic health record to identify factors which increase the risk of failed follow up. I used this information to inform implementation of a system including clinical decision support in an attempt to improve timely delivery of care.

### Introduction 
Genetic testing has the ability to provide an overarching reason for a patient’s medical problems. Likewise, it can inform prognosis, management, surveillance and recurrence risk. However, to be useful, the testing must be reviewed and interpreted by professionals that can implement care based on the knowledge gained and inform the patient or their family members of its meaning. Too frequently, genetic testing is sent and never followed up on by a provider. When sent as an inpatient, this testing is often performed at the expense of the hospital. If the patient or family member never realizes the benefit of the testing, there is the potential that this hospital resource could be wasted. 

To reduce the rate of testing that is never followed up on, we will implement a comprehensive tracking system that takes the place of disparate systems used by individual providers. To facilitate the implementation, we will model the characteristics of patients that appear to be at increased risk of never having documented follow up. Information gained through this analysis will be used to design the tracking system; it will aim to decrease the time and effort needed for providers to access needed data and perform follow-up tasks. We will also aim to measure follow up before and after the intervention. 


### Methods
As part of a quality improvement project, I extracted from the CHOP Data Warehouse. This Netezza SQL database houses data that is loaded via Extract Transform Load processes from the Clarity database of the CHOP Epic electronic health record implementation. Due to institutional restrictions, I extracted the data using a separate IDE.

I obtained a list of patients who had an evaluation by the consulting service of Clinical Genetics while hospitalized between the dates of `2019-08-01` and `2020-08-01`. I identified these patients by searching for clinical notes of type `CONSULT NOTE`. I also extracted other information about their hospitalization, insurance coverage and demographic information. 

```sql
SELECT EI.MRN,
       NI.PAT_KEY,
	     NI.NOTE_SVC_DT,
	     days_between(NI.NOTE_SVC_DT, PA.DOB) "Age in Days",
	     PA.gestational_age_complete_weeks + (PA.gestational_age_remainder_days /7) "Gestational Age",
	     EI.admission_service,
	     EI.hospital_los_days,
	     EI.payor_group,
	     EI.icu_los_days,
	     EI.patient_address_zip_code,
	     EI.admission_source,
	     EI.sex
FROM CDWPRD.ADMIN.NOTE_INFO NI
INNER JOIN CHOP_ANALYTICS.NOTE_EDIT_METADATA_HISTORY NEMH
ON NI.NOTE_KEY = NEMH.NOTE_KEY
AND LAST_EDIT_IND = 1 
AND NEMH.NOTE_TYPE_ID = 400005 --CONSULT NOTE
AND NEMH.VERSION_AUTHOR_SERVICE_ID = 14 --GENETICS
AND NEMH.VERSION_AUTHOR_TITLE = 'MD' --Exclude GC Only consults (from ENGIN)
INNER JOIN CHOP_ANALYTICS.PATIENT_ALL PA
ON NI.PAT_KEY = PA.PAT_KEY 
INNER JOIN CHOP_ANALYTICS.ENCOUNTER_INPATIENT EI
ON NI.VISIT_KEY = EI.VISIT_KEY 
WHERE NI.NOTE_SVC_DT >= '2019-08-01' AND NI.NOTE_SVC_DT < '2020-08-01'
AND NI.UNSIGN_IND <> 1 --NOT Unsigned
AND NEMH.MRN <> 'UNKNOWN'
AND NI.DIM_DEL_CAT_KEY = 0
```
Next I obtained a list of follow up clinical notes. 

```sql
SELECT NEMH.MRN, NI.PAT_KEY,
	   NI.NOTE_SVC_DT "Initial Date",
	   NI.NOTE_KEY "Initial Key",
	   NEMHF.NOTE_KEY "Subsequent Key",
	   NIF.NOTE_SVC_DT "Subsequent Date",
	   NEMHF.NOTE_TYPE "Type",
	   NIF.AMBUL_NOTE_IND "AMB",
	   D.DICT_NM "Encounter Type"
FROM CDWPRD.ADMIN.NOTE_INFO NI
INNER JOIN CHOP_ANALYTICS.NOTE_EDIT_METADATA_HISTORY NEMH
ON NI.NOTE_KEY = NEMH.NOTE_KEY
AND NEMH.LAST_EDIT_IND = 1 
AND NEMH.NOTE_TYPE_ID = 400005 --CONSULT NOTE
AND NEMH.VERSION_AUTHOR_SERVICE_ID = 14 --GENETICS
AND NEMH.VERSION_AUTHOR_TITLE = 'MD' --Exclude GC Only consults (from ENGIN)
LEFT JOIN CHOP_ANALYTICS.NOTE_EDIT_METADATA_HISTORY NEMHF
ON NI.PAT_KEY = NEMHF.PAT_KEY 
AND NEMHF.NOTE_ENTRY_DATE > NEMH.NOTE_ENTRY_DATE 
AND NI.NOTE_KEY <> NEMHF.NOTE_KEY
AND NEMHF.VERSION_AUTHOR_SERVICE_ID = 14
AND NEMHF.NOTE_TYPE_ID <> 400005
AND NEMHF.LAST_EDIT_IND = 1 
LEFT JOIN CDWPRD.ADMIN.NOTE_INFO NIF
ON NEMHF.NOTE_KEY = NIF.NOTE_KEY
AND NIF.DIM_DEL_CAT_KEY = 0
LEFT JOIN CDWPRD.ADMIN.VISIT V
ON NIF.VISIT_KEY = V.VISIT_KEY 
LEFT JOIN CDWPRD.ADMIN.CDW_DICTIONARY D
ON V.DICT_ENC_TYPE_KEY = D.DICT_KEY 
WHERE NI.NOTE_SVC_DT >= '2019-08-01' AND NI.NOTE_SVC_DT < '2020-08-01'
AND NI.UNSIGN_IND <> 1 --NOT Unsigned
AND NEMH.MRN <> 'UNKNOWN'
AND NI.DIM_DEL_CAT_KEY = 0
ORDER BY NI.PAT_KEY DESC
```
Finally, I obtained a list of genetic tests that were performed for each patient. I manually reviewed each order name to identify genetic tests. 

```sql
SELECT NI.PAT_KEY,
       PROC_ORD_NM,
       PO.PLACED_DT,
       POR.RSLT_DT, 
       PO.SPECIMEN_TAKEN_DT,
       RC.COMP_NM,
       POR.RSLT_VAL
FROM CDWPRD.ADMIN.NOTE_INFO NI
INNER JOIN CHOP_ANALYTICS.NOTE_EDIT_METADATA_HISTORY NEMH
ON NI.NOTE_KEY = NEMH.NOTE_KEY
AND LAST_EDIT_IND = 1 
AND NEMH.NOTE_TYPE_ID = 400005 --CONSULT NOTE
AND NEMH.VERSION_AUTHOR_SERVICE_ID = 14 --GENETICS
AND NEMH.VERSION_AUTHOR_TITLE = 'MD' --Exclude GC Only consults (from ENGIN)
LEFT JOIN CDWPRD.ADMIN.PROCEDURE_ORDER PO
ON NI.PAT_KEY = PO.PAT_KEY
AND PO.DICT_LAB_STAT_KEY = 21038 --Status FINAL
AND PO.DICT_ORD_TYPE_KEY = 21554 --Lab
LEFT JOIN CDWPRD.ADMIN.PROCEDURE P 
ON PO.PROC_KEY = P.PROC_KEY
LEFT JOIN CDWPRD.ADMIN.PROCEDURE_ORDER_RESULT POR
ON PO.PROC_ORD_KEY = POR.PROC_ORD_KEY 
LEFT JOIN CDWPRD.ADMIN.RESULT_COMPONENT RC 
ON POR.RSLT_COMP_KEY = RC.RSLT_COMP_KEY 
WHERE NI.NOTE_SVC_DT >= '2019-08-01' AND NI.NOTE_SVC_DT < '2020-08-01'
AND NI.UNSIGN_IND <> 1 --NOT Unsigned
AND NEMH.MRN <> 'UNKNOWN'
AND NI.DIM_DEL_CAT_KEY = 0
AND PROC_ORD_NM IN ('Chromosomal SNP Microarray','MISC Genetic Referred Testing','Exome Sequencing, Proband (CHOP Medical Exome Version 2)','Karyotype, Constitutional','22q11.2 Del/Dup','MitoGenome Seq + Del','Beckwith-Wiedemann Meth-Copy','Noonan Panel SEQ','Exome Sequencing, Proband (Send Out)','Comprehensive Pulmonary-Vascular SEQ + Del/Dup Panel','Exome Sequencing, Proband','Osteogenesis Imperfecta SEQ + Del/Dup Panel','PRADER-WILLI/ANGELMAN Methylation','CHD7 SEQ + Del/Dup','Kabuki SEQ + Del/Dup Panel','Russell Silver Panel w/Reflex','Fragile X Syndrome','Cancer, FISH Analysis','Exome Reanalysis','Very Early Onset Inflam Bowel Dis Panel','Chromosome Breakage Studies','Stickler syndrome SEQ + Del/Dup Panel','CFTR SEQ + Del/Dup Analysis','Pulmonary Hypertension SEQ + Del/Dup Panel','Pneumothorax SEQ + Del/Dup Panel','XomeDx Trio','MSOG- Genetics Send Out','Ketotic Hypoglycemia SEQ + Del/Dup Panel','Ipex Syndrome - FOXP3','Exome & mtDNA-GeneDx (XomeDX Plus)','Exome + MitoGenome Combined Test  (Send Out)','Alagille Syndrome SEQ + Del/Dup Panel','Seq Known Genetic Variant','CHOP Epilepsy Panel','TPMT Genotyping','Exome DNA Extract Family Member','Inherited Neutropenia Panel','Full Exome Analysis from Exome Panel','CCHS PHOX2B SEQ + Del/Dup','Cholestasis SEQ + Del/Dup Panel','Severe combined immunodeficiency SEQ + Del/Dup Panel','Connective Tissue SEQ + Del/Dup Panel','TBX1 Gene Sequencing','MID1 SEQ + Del/Dup','Chromosome Stress Test','FISH, Constitutional','MECP2 Del/Dup','Marfan SEQ + Del/Dup Analysis','Fanconi Anemia/Rare Chrom Breakage Panel','NUDT15 Genotyping','GJB2 SEQ Analysis','Glycogen Storage Disease SEQ + Del/Dup Panel','SPINK1 N34S Variant','Chromosomal Microarray, Postnatal -Q','Humoral dysfunction SEQ Panel','(MSOG) Cholestasis Liver Panel- (Emory)','MECP2 SEQ + Del/Dup','SMN1 Deletion Testing','Pancreatitis SEQ + Del/Dup Panel','Cornelia de Lange SEQ + Del/Dup Panel','MSOG Genetic Send Out','Primary Ciliary Dyskinesia SEQ +Del/Dup Panel','PTEN SEQ + Del/Dup','Primary Ciliary Dyskinesia SEQ+Del/Dup Panel')
ORDER BY PAT_KEY DESC
```
I saved each dataset as a `.csv` file for further analysis in `R`.



```r
InitialConsult <- fread("~/Penn/BMIN503/Project/Queries/Initial Consults.csv")
setnames(InitialConsult,
         c("Patient", "ConsultDate", "AgeDays", "GestationalAge","AdmissionService", "HospitalLOS", "PayorGroup",
           "CriticalCareLOS", "ZipFirstThree", "AdmissionSource", "LegalSex"))

SubsequentNotes <- fread("~/Penn/BMIN503/Project/Queries/Subsequent Notes.csv")
setnames(SubsequentNotes,c("Patient", "InitialDate", "InitialKey", "SubsequentKey", "SubsequentDate", "Type",
                           "AmbulatoryContext", "EncounterType"))

GeneticResults <- fread("~/Penn/BMIN503/Project/Queries/Genetic Results.csv")
setnames(GeneticResults,c("Patient", "OrderName", "PlacedDate", "ResultDate", "SpecimenCollectDate", "ResultComponent",
                          "ResultValue"))
```
### Results

#### Timing and Hospital Service of Inpatient Genetics Consults
There were a total of `772` inpatient consults performed during the study period (`2019-08-01 - 2020-08-01`).

```r
FilteredConsult <- InitialConsult %>% 
                       mutate(ConsultDate = mdy_hm(ConsultDate)) %>%
                       group_by(Patient) %>%
                       dplyr::filter(ConsultDate == min(ConsultDate)) %>%
                       ungroup()  

FilteredConsult %>%
  mutate(ConsultMonth = as.Date(cut(ConsultDate, breaks = "month")),
         Service = fct_other(AdmissionService,
                             keep = c("Neonatology","Cardiology","Cardiac Critical Care","Critical Care","Endocrinology"),
                             other_level = "Other")) %>%
ggplot(aes(x = ConsultMonth, fill = Service)) + 
  geom_bar(stat="count") +
  labs(y = "Number of Patients with Inpatient Consults",
       x = "Month") + 
  ggtitle(paste0("Inpatient Genetics Consults N=",nrow(FilteredConsult))) +
  theme_minimal()
```

![](Campbell_Final_Project_files/figure-html/unnamed-chunk-5-1.png)<!-- -->

The distribution of the consulting hospital service remained stable during the study period. There is a notable decrease in consults in December with a subsequent rise in Janurary, likely due to the effects of winter holidays.

#### Documentation of Follow Up Care Following Initial Consultation


```r
SummarizedSubsequentNotes <- SubsequentNotes %>% 
  mutate(InitialDate = mdy_hm(InitialDate)) %>%
  group_by(Patient) %>%
  dplyr::filter(InitialDate == min(InitialDate)) %>%
  dplyr::summarise(FollowUpType = names(sort(table(EncounterType),decreasing = TRUE))[1],
                   ConsultMonth = as.Date(cut(InitialDate, breaks = "month"))[1]) %>%
  mutate(FollowUpType = replace(FollowUpType, FollowUpType == "", "None")) %>%
  mutate(FollowUpType = str_to_title(FollowUpType)) %>%
  mutate(FollowUpType = factor(FollowUpType,
                               levels = c("Hospital Encounter", "Telephone", "Mobile", "Office Visit",
                                          "Care Coordination","Appointment", "Email Correspondence",
                                          "Orders Only", "Letter (Out)","None")))

ggplot(SummarizedSubsequentNotes, aes(x = ConsultMonth, fill = FollowUpType)) + 
  geom_bar(stat="count") +
  labs(y = "Number of Patients",
       x = "Month",
       fill = "Follow Up Method") + 
  ggtitle("Follow Up Documentation for Genetics Consults") +
  scale_fill_manual(values = c("Hospital Encounter" = "firebrick3", 
                               "Telephone" = "cornflowerblue", 
                               "Mobile" = "forestgreen",
                               "Office Visit" = "aquamarine1",
                               "Care Coordination" = "goldenrod",
                               "Appointment" = "coral1",
                               "Email Correspondence" = "darkorchid2",
                               "None" ="gray")) +
  theme_minimal()
```

![](Campbell_Final_Project_files/figure-html/unnamed-chunk-6-1.png)<!-- -->

Notably, **58%** of patients with completed consults during the study period had no subsequent clinical note documented by any member of the Genetics healthcare team. The rate appeared to remain relatively stable over time.

I hypothesized that a number of consultations actually require no further follow up:

* The patient was evaluated but the clinician felt that no genetic testing nor further follow up was warranted
* The patient previously underwent genetic testing and the Genetics team is being consulted for management during hospitalization
* The patient previously underwent genetic testing and was diagnosed with a specific condition, the family desires further counseling from the CHOP Genetics team, but no long-term follow up is required

In other cases, I hypothesized that genetic testing was recommended, but the results of that testing was either never reviewed or the interpretation and follow up plan was not documented in the patient's chart.


```r
SummarizedSubsequentNotes %>%
  mutate(GeneticResults = Patient %in% GeneticResults$Patient) %>%
  dplyr::filter(FollowUpType  == "None") %>%
ggplot(aes(x = ConsultMonth, fill = GeneticResults)) + 
  geom_bar(stat="count") +
  labs(y = "Number of Patients",
       x = "Month",
       fill = "Genetic Testing Performed") + 
  ggtitle("Was Genetic Testing Performed for Patients without Follow Up?") +
  scale_fill_manual(values = c("TRUE" = "firebrick3", 
                               "FALSE" = "cornflowerblue")) +
  theme_minimal()
```

![](Campbell_Final_Project_files/figure-html/unnamed-chunk-7-1.png)<!-- -->
