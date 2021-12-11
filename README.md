# BMIN503/EPID600 Final Project

This repository contains templates for your final written report and GitHub repository. Follow the instructions below to clone this repository, and then turn in your final project's code via a pull request to this repository.


1. To start, **fork** this BMIN503_Final_Project repository.
1. **Clone** the forked repository to your computer.
1. Modify the files provided, add your own, and **commit** changes to complete your final project.
1. **Push**/sync the changes up to your GitHub account.
1. Create a **pull request** on this, the original BMIN503_Final_Project, repository to turn in your final project.


BMIN 503

Abstract: This project aims to conduct a large-scale proteomic analysis to screen potential plasma proteins that can A) differentiate PD from normal control B) differentiate fast cognitive progressors from slow cognitive progressors based on change in MoCA score change over time C) differentiate fast motor progressors from slow motor progressors based on change in UPDRS score over time

Background: Parkinson's Disease (PD) is the second most common neurodegenerative disease affecting over 2 million people in the United States. Patients with Parkinson's Disease demonstrated a series of cognitive, motor and psycholic symptoms. However, up to date, there still weren't any cliniaclly validated blood based diagnostic test that can quickly help clinicians to confirm the diagnosis of PD. The fact that different Parkinson's patients displayed highly heterogenous sypmtoms raised further challenges to the development of such tests. Therefore, the goal of this project is to identify any potential biomarkers associated with the diagnosis and prognosis of PD, and based on that trained a classifier that can 1) differente PD patients from non-PD patients 2) different PD patients with a faster progression rate from slowly progressing PD patients with high performance.

Data Source: Datasets used for this project were downloaded from NIH Parkinson's Disease Biomarker Program database. A total of 319 PD + Normal Control Subjects were enrolled in this study through two different cohorts - University of Texas Southwestern School of Medicine and Penn State Hershey School of Medicine. A total of ~1100 plasma proteins were measured in all 319 subjects through a high through-put proteomic platform known as SomaScan. Clinical and demographic information for these patients were also collected at each cohort.

Analysis Plan:

A. Cross Section Analysis

Data Cleaning and Outlier Detection
Since those samples were collected from two different cohorts, it would be helpful to start with a principle component analysis (PCA) to detect any potential batch effect. Besides, PCA analysis can help us quickly identify if there's any significant outliers so that we can remove outliers before formal analysis

Differential Expression Analysis
Compare the proteins expression level between normal control and subjects diagnosed with Parkinson's Disease. Benjamini-Hochberg method was used to adjust for multiple comparison. Proteins that pass the adjusted p-value of 0.05 were considered as proteins that were significantly associated with the phenotype of Parkinson's Disease. Fold change was calculated using log2(Control-PD). Vocalno plot was used to visualize the difference in protein expression between PD and control group.

3). Gene Set Enrichment Analysis (GSEA)

After identifying plasma proteins that differentiate PD from control, we created a dictionary to map protein names into their corresponding gene symbols. Using KEGG pathway files, GESA analysis was conducted to identify any potential underlying mechanisms associated with the proteins identified in the 2) and their associated genes.

4). Classifcation Analysis

Using the top 3 proteins identified through the differential expression analysis, we next trained a logistic-regression based classification model, validated with 5-fold cross validation over 50 iterations, to understand how well the top 3 proteins we identified - BSP, OMD and ApoM - together with age and sex, can help differentiate PD subjects from control subjects.

B) Longitudinal Analysis (Cognitive Function)

Linear-mixed effects model was used to evaluate the effect of the top protein biomarkers identified in (A) on change in MoCA score over time, after age and sex were adjusted for.

Model: MoCA ~ time x top proteins + age + sex + disease duration

C) Longitudinal Analysis (Motor Function)

Linear-mixed efefcts model was used to evaluate the effect of the top protein biomarekrs indentified in (A) on change in UPDRS-III score over time, after age and sex were adjusted for 

Model: UPDRS ~ time x top proteins + age + sex + disease duration

# Discussion

Differential Expression Analysis ended up identifying a total of 47 proteins that are differentially expressed between PD and normal. With only 8 proteins, the model already start to overfitting as you can see that the model with 8 proteins + age showed an AUC score of 0.78 on training cohort but only less than 0.6 on training cohort. However, it is also possible that there existed a significant batch effect when proteins were measured in samples in two different batches. Clustering analysis clearly showed the presence of co-linearlities between proteins, therefore it might be helpful to use some kind of feature selection algorithms to further reduce the dimensions before training the model. It is very interesting that KEGG pathway enrichment analysis showed that chemokine signaling seemed to be most significantly enriched. However, downstream manupilative experiments are needed to understand the biological meaning of that pathway. It is also very interesting that a lot of proteins showed up in the DE analysis were involved in the inflammatory reaction, like C-reactive protein. This might suggested that PD patients have a higher systemic inflammation level compared to normal control, which is consistent with the wide observation that microglia activation level in higher in the CNS of PD patients than normal control. 

Furthermore, generalized linear mixed effect model with random intercept was used to study the effect of top 20 proteins on the long-term clinical outcomes (both on cognitive fucntion and on motor function). Out of the top 20 proteins, FCN1 and BSP seemed to be potential prognostic biomarkers that predict cognitve function. Patients who are in top tertile of BSP measurements developed cognitive function decline much more rapidly compared to patients in the lower two tertiles. Patients who are in the first tertile (the lowest tertile of FCN1 measuremnts) seem to have a faster cognitive function decline than those who are in the first two tertiles. Out of top 20 proteins, IFGBP.2 level seems to be correlated with the incidents of developing dementia according to the Cox Proportional Hazard model. Specifically, patients in the fourth quratile of IGFBP.2 measurements are 7 times more likely to develop dementia compared to those in the lowest quartile. 

In addition, longitudinal motor function analysis suggested that NCAM.120 might be a potential biomaker for motor function over time. Patients who have lower NCAM 120 seemed to have a slower motor function progression (not very clear difference though). Also, since it looks like patients with different baseline NCAM 120 measurements have different baseline MoCA score as well, it might be useful for us to include baseline MoCA as a covariant in the LME model as well in the future.

The limit of this study is that this is an entirely analytic project, therefore, no causal relationship can be inferred. A quick screen at the top 20 proteins didn't identify any significant pQTL effect, which made the Mendelian Randomization (MR) analysis planned in the beginning impossible to conduct. Also, since Somalogic is a new proteomic platform, it remains unknown how reliable the protein measurements are. Therefore, it might be interesting to use ELISA essay to validate some of the proteomic measurements to see how valid they are.  
