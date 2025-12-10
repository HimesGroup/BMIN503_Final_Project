# BMIN503/EPID600 Final Project

## Overview

This project evaluates whether dosing pediatric platelet transfusions based on absolute platelet count (platelets/kg) predicts post-transfusion increments better than the current standard of weight-based volume (mL/kg).

**Hypothesis:** Accounting for the variability in platelet count per bag (2.5–4.5 x10\^11) will improve dosing accuracy compared to volume alone.

## Methods

1.  **Data Extraction (SQL):** Queried CHOP’s clinical data warehouse (Helix/Snowflake) for pediatric transfusions (July–Dec 2023), including CBC results and patient weights.

2.  **Data Processing (R):**

    -   Merged digital records with digitized hand-written absolute platelet counts.

    -   Calculated dosing metrics (`Dose_ml_kg` vs `Dose_plt_kg`) and outcomes (`Delta_Plt`).

    -   Removed outliers using the IQR method (15% cut-off).

3.  **Analysis:** Linear regression comparing $R^2$ values of both dosing strategies.

## Key Findings

Both models demonstrated low predictive power, suggesting clinical acuity (sepsis, bleeding) outweighs dosing strategy in this pilot cohort.

-   **Weight-Based Model** ($R^2$): 0.015

-   **Absolute Count Model** ($R^2$): 0.020

**Conclusion:** The absolute count model performed marginally better but remains a poor predictor without controlling for consumption factors.

## Next Steps

-   **Narrow Scope:** Filter for patients receiving weight-based aliquots only.

-   **Tighten Window:** Reduce post-transfusion CBC window from 7 days to 24–72 hours.

-   **Add Covariates:** Control for diagnosis, severity of illness, active bleeding, surgical cases, etc.
