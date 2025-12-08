# Follow-Up of Elevated Blood Lead Levels in CHOP Primary Care

**Author:** Peter Zhang  
**Course:** BMIN5030 Final Project  

## Project Overview
This project analyzes adherence to venous follow-up testing guidelines for children with elevated blood lead levels (EBLLs) within the CHOP Primary Care Network. Following the CDC's lowering of the reference value to $\ge 3.5 \mu g/dL$ and CHOP's shift toward universal screening, this study establishes baseline data on follow-up rates and identifies socioeconomic and operational disparities in care.

The analysis uses a retrospective cohort of 5,688 patients to examine the influence of demographic, geographic, and insurance factors on the timeliness of follow-up.

## Objectives
* Assess the baseline adherence to venous follow-up testing for elevated capillary or venous lead levels.
* Identify barriers to care using survival analysis  through Kaplan-Meier & Cox Proportional Hazards.
* Evaluate the predictive power of demographic variables using ML (Random Forest).

## Methods
* **Study Period:** October 28, 2021 – November 25, 2025[cite: 23].
* **Population:** Children with an elevated lead result >3.5 ug/dL extracted from Epic Clarity.
* **Outcomes:** Time-to-venous follow-up (primary) and categorical status (Appropriate, Overdue, Pending).

## Analytical Approach
1.  **Descriptive Statistics:** Summary of demographics and "Overdue" rates by department/county.
2.  **Survival Analysis:** Kaplan-Meier curves and Cox Proportional Hazards models to estimate time-to-event probabilities.
3.  **Machine Learning:** Random Forest classifier to predict "Never Follow-up" status.

##️ Key Findings
* **Overall Adherence:** 60% of patients were overdue for follow-up at the time of analysis.
* **Disparities:** Patients with Commercial insurance and those residing in suburban counties followed up significantly faster than those with Medicaid or those living in Philadelphia.
* **Digital Engagement:** Activation of MyCHOP and text notifications were strong, independent predictors of better follow-up adherence.
* **Predictive Modeling:** A Random Forest model yielded an AUC of 0.6, suggesting that demographic data alone are insufficient to predict non-adherence.