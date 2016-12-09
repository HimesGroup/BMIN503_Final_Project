TITLE: SEDENTARY BEHAVIOR AND 30-YEAR CVD RISK
AUTHOR:  Alexandra L. Hanlon, PhD
DATE:  December 9, 2016
RE:  EPID600 Final Project

Research Question and Key Variables: 
  Is sedentaray behavior associated with cardiovascular risk in the UK Biobank dataset? The outcome variable is a composite measure of cardiovascular risk; the predictors of interest are screen based and transport based sedentary behavior as defined by time spent watching TV and using the computer, as well as time spent driving, in hours. Covariates include physical activity, diet, tobacco use, alcohol use, sleep, BMI, and body composition variables. The analysis relies on data from the UK Biobank (https://www.ukbiobank.ac.uk/), a large study arried out in the UK investigating the respective contributions of genetic predisposition and environmental exposure (including nutrition, lifestyle, medications etc.) to the development of disease. The entire baseline dataset includes ~500,000 participants of age 40 to 69, who enrolled from 2006 to 2010, and will be prospectively followed for at least 25 years.

Project Overview:
  The current study examines the relationship between screen-based (hours of television and computer per day) and transport-based (hours of transporting as driver or passenger per day) sedentary behavior with a dichotomous indicator of high cardiovascular disease (CVD) risk based on the 30-year Framingham risk score. Covariates include physical activity, diet, alcohol use and sleep. Data for this investigation has been collected by the United Kingdom Biobank, a prospective cohort-study that is comprised of ~500,000 participants aged 40 to 69 years, who enrolled from 2006 to 2010, and will be prospectively followed for at least 25 years. 

Introduction (Problem, Significance, Background):
  One in three deaths are attributed to CVD, both nationally and globally. According to the American Heart Association (AHA), 95% of adult Americans do not satisfy the profile for ideal heart health, thus limiting the potential of reaching the AHA 2020 goal of improving the cardiovascular health of all Americans by 20% while reducing death from cardiovascular diseases and stroke by 20%. Reaching this goal requires novel, efficacious, achievable and sustainable CVD prevention measures. 
  Sedentary behavior is now recognized as a separate construct to physical activity, and is a demonstrated prognostic indicator of higher triglycerides-high-density lipoprotein cholesterol ratio, as well as higher body mass index, waist circumference, body fat percentage and death. Yet, sedentary behavior remains unrecognized as an independent risk factor for CVD as demonstrated by its omission from the most widely used and validated composite CVD risk scores (AHA's “Simple 7”, the Framingham Heart Score, and the European Heart Score). Sedentary behavior may be more amenable to long-term individual change than other CVD risk factors, such as physical activity. Limiting the development of effective interventions to reduce sedentary behavior is the absence of objective, empirically supported guidelines for adult sedentary behavior. 
  The current study addresses these empirical and theoretical gaps by examining the extent to which two different forms of sedentary behavior (screen-based and transport) predict cardiovascular risk and identify a threshold of sedentary time that is predictive of greater risk, independent of key covariates (including physical activity). This study will be one of the first to examine these questions at the population level using objective, verified data.  
 
An Interdisciplinary Project (why interdisciplinary, fields of contribution, collaborator contributions):
  The etiology of health behavior is interdisciplinary, drawing from the fields of epidemiology and biostatistics, medicine and physiology, psychology, public health and public policy. Convergent with this model, the current study poses interdisciplinary research questions that are presented by an interdisciplinary team of collaborators from the fields listed below. The range and depth of expertise presented by this team ensures a rigorous process with meaningful results.  
Collaborator, Area of Expertise:
Michael A. Grandner, PhD, Clinical Psychology, Sleep and Cardiovascular Health
Alexandra L. Hanlon, PhD, Biostatistics
Susan K. Malone, PhD., RN, Nursing, Sleep and Cardiometabolic Health
Freda Patterson, PhD, Public Health and Epidemiology, CVD Behaviors
Richard Suminiski, PhD, Exercise Physiology, Physical Activity, Built Environment

Methods:
  The current analysis is conducted on cross sectional, baseline data collected between 2006-2010 on a subsample of 302,889 (of 502,656) UK biobank participants. The United Kingdom (UK) BioBank, prospective cohort study relies on patient registers for the UK National Health Service (NHS), and includes adults aged 40-69 years who live within a 10-mile radius of one of the UK Biobank’s 35 assessment centers invited to participate. At their baseline visit, participants provide written informed consent and complete a touch screen questionnaire that assessed socio-demographic, lifestyle and health behavior variables.  
  The dependent variable is a measure of 30-year CVD risk as derived by Pencina et al [Pencina, D'Agostino, Larson, Massaro, Vasan. 'Predicting the 30-Year Risk of Cardiovascular Disease: The Framingham Heart Study', Circulation 2009]. The measure is based on 4,506 participants of the Framingham Offspring cohort, age 20 to 59 years, free of CVD and cancer at baseline exam in 1971-1974, who were followed for the development of "hard" CVD events: coronary death, myocardial infarction, stroke. The methodology behind the measure is a modified Cox model to accommodate the competing risk of non-cardiovascular death. Seven risk factors are included in the score:  male sex, age, systolic blood pressure, antihypertensive treatment, BMI, smoking, and diabetes mellitus. The outcome of interest in our current study is based on the dichotomized 30-year CVD risk, where high risk are those with a score >=40% [Pencina et al, 2009]. The independent variables include chronotype (4 levels), sleep duration (3 levels), physical activity (dichotomous based on meeting AHA recommendations), fruit and vegetable intake (dichotomous based on meeting AHA recommendations), alcohol intake (6 levels), body fat percentage (continuous).  The predictors of interest are sedentary behavior as measured on a continuum: TV hours per day, computer hours per day, and driving hours per day.
  Preliminary statistical analyses include a descriptive summarization (mean, SD, etc) of CVD risk component measures and independent variables. All independent variables are visually examined using bar charts and boxplots, and are compared by risk group using unadjusted p-values corresponding to chi-square statistics and two-sample t-tests. Inferential analysis includes the generation of univariable and multivariable logistic regression (LR) and random forest (RF) models for high CVD risk. Variables are compared in terms of p-values and gini importance scores; training and 10-fold cross-validation models are compared for predictive accuracy in terms of AUC estimates and ROC curves. Finally, a classification tree using rpart is used to identify the most important combinations of predictors of CVD risk, where the final tree balances size of tree with misclassification rate.
  
Results:
See the file cvd2_12092016.html for all analytic results. The file was generated from knitting cvd2_12092016.rmd. A mock dataset is included for those who wish to test out the sytax.

Conclusions and Next Steps:
  The AUC for the RF traingin model, RF CV model, LR training, and LR CV models are .8963, .6727, .6477, and .6476, respectively.  The classification tree identifed those at high CVD risk by: >=2.5 hours of TV per day; <2.5 hours of TV per day, low BF, and daily alcohol intake; low BF, non-daily alcohol intake, TV hours 1.5-2.5 hours per day; and <2.5 hours of TV per day, high BF. The overall tree accuracy was 62.98% [95% CI 62.71%, 63.24%], with sensitivity 40% and specificity 80%.  
  Key points: from the predictors included in the classification tree model of CVD risk, TV viewing >2.5 hr/day emerged as the strongest predictor (tier 1 of tree); among low TV watchers, low body fat and high alcohol consumption demonstrated a high CVD risk profile. 
  The next steps are to critically evaluate multicollinearity, create subgroups of patients with various profiles and generate similar supervised learning analyses, and to include socio-demographic variables in the modeling process exclusive of components of risk score. 


Helpful Links for managing this repository:
<!-- Links -->
[forking]: https://guides.github.com/activities/forking/
[ref-clone]: http://gitref.org/creating/#clone
[ref-commit]: http://gitref.org/basic/#commit
[ref-push]: http://gitref.org/remotes/#push
[pull-request]: https://help.github.com/articles/creating-a-pull-request


The instructions below show how to clone this repository, and then turn in the final project's code via a pull request to this repository.

1. To start, [**fork** this EPID600_Final_Project repository][forking].
2. [**Clone**][ref-clone] the forked repository to your computer.
3. Modify the files provided, add your own, and [**commit**][ref-commit] changes to complete your final project.
4. [**Push**][ref-push]/sync the changes up to your GitHub account.
5. [Create a **pull request**][pull-request] on this, the original EPID600_Final_Project, repository to turn in your final project.