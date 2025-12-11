---
title: "Drug Treatment Centers and Neighborhood Crime: Evidence from Nine U.S. Cities Over Two Decades"
subtitle: "BMIN5030/EPID6000 Final Project"
format:
  clean-revealjs:
    self-contained: true
author:
  - name: Jamie S. Benson
    degrees:
      - B.A.
    orcid: 0000-0002-0709-4711
    corresponding: true
   # email: jamie.benson@pennmedicine.upenn.edu
    roles:
      - investigation
      - data curation
    affiliation:
      - ref: ggeb
  - name: Nicholas J. Seewald
    degrees:
      - PhD
    orcid: 0000-0002-8367-0522
    corresponding: false
   # email: nicholas.seewald@pennmedicine.upenn.edu
    roles: []
    affiliation:
      - ref: ggeb
  - name: Elizabeth K. Nesoff
    degrees:
      - PhD
      - MPH
    orcid: 0000-0001-8562-8646
    corresponding: false
   # email: elizabeth.nesoff@pennmedicine.upenn.edu
    roles: []
    affiliation:
      - ref: ggeb
affiliations:
  - id: ggeb
    name: Perelman School of Medicine, Department of
      Biostatistics, Epidemiology, and Informatics
    isni: 123012088
date: last-modified
csl: jama.csl
bibliography: references.bib
---


::: {.cell}

:::


# Project Motivation {background-color="#40666e"}

## Motivation {#sec-background}
### Background
The opioid epidemic in the U.S. is an unceasing public health [crisis]{.alert}

:::{.fragment}
- Despite encouraging post-pandemic trends (13% annual decline in fatalities), it remains worse than pre-COVID[@alexanderEpidemicMidstPandemic2020; @florenceEconomicBurdenPrescription2016; @gomesTrendsOpioidToxicity2023]
:::
:::{.fragment}
- Improvements in overdose fatalities have mirrored decreases in violent crime rates across the country, dropping 13% over-all in 2024[@CrimeTrendsUS2024]
:::
:::{.fragment}
- Access to opioid use disorder (OUD) treatment services is essential, and has been shown to decrease deaths from overdose and crime recidivism, and improve quality of life[@cantorPatternsGeographicDistribution2022; @amiriDisparitiesAccessOpioid2021]
:::
:::{.fragment}
- Drug treatment centers (DTCs) take many forms, and provide much of this care in American communities
:::

## Motivation
### Background
Social, structural, and political barriers remain opposing expansion of these essential services

:::{.fragment}
- Often, "Not in My Backyard" (NIMBY) arguments are an impediment[@rouhaniNIMBYismHarmReduction2022]
:::
:::{.fragment}
- County-level analyses have shown an [inverse relationship]{.alert} to crime and all-cause mortality with facility openings[@bondurantSubstanceAbuseTreatment]
:::
:::{.fragment}
- Tract and bock-group level models in New Jersey have found a slight cross-sectional increase in crime in proximity to facilities[@furr-holdenNotMyBack2016]
    - This is hypothesized to be a function of population and activity density, and was a uniform effect across DTCs, grocery stores, and liquor outlets
:::

## Motivation
:::{.fragment}
- Evidence for, or indeed against, "NIMBY" arguments against DTC proliferation at the local level is lacking
:::
:::{.fragment .center}
### Project Aims
- This project aims to explore the [spatial and temporal]{.alert} relationship between Drug Treatment Center operation and neighborhood crime density over a [large timespan]{.alert} in major U.S. metropolitan areas
:::

# Methods {background-color="#40666e"}

## Methods
### Analytic Pipeline

::: {.cell warnings='false'}
::: {.cell-output-display}

```{=html}
<div class="visNetwork html-widget html-fill-item" id="htmlwidget-800940a45730c8aa516f" style="width:960px;height:480px;"></div>
<script type="application/json" data-for="htmlwidget-800940a45730c8aa516f">{"x":{"nodes":{"name":["acs_data","acs_sample","all_layer_map","att_buffer","att_buffer_city","att_dist","att_dist_city","bg_cenpop","bg_poly","buffer_forest","buffer_forest_city","buffers","candidate_pairs","cenpop_sample","chunk_distances","cities","cities_sample","city_names","clin_proj","clinic_change_dfs","clinic_chunks","clinic_counties","clinic_pairs_linked","clinic_year_summary","clinics_changepoint","clinics_changepoint_count","clinics_close","clinics_geo","clinics_grouped","clinics_keyed","clinics_linked","clinics_open","clinics_sample","combined_clinics_tagged","count_outcome_categories","counties_geo","counties_sample","county_sample_fips","county_sample_states","crime_by_city","crime_geo","csv_df","csv_pdf_merged","dist_forest","dist_forest_city","dist_outcome_categories","included_cities","ingested_crimes","keys","nibrs_crosswalk","pairs_geom","pdf_df","pdf_split","places","presentation","report","selected_buffer","unit_points","write_arc_geocode_df","years"],"type":["pattern","stem","pattern","pattern","pattern","pattern","pattern","stem","pattern","stem","stem","stem","pattern","stem","pattern","stem","stem","stem","stem","stem","stem","stem","stem","stem","pattern","stem","stem","stem","stem","stem","stem","stem","stem","stem","stem","stem","stem","stem","stem","stem","pattern","stem","stem","stem","stem","stem","stem","pattern","stem","stem","stem","pattern","pattern","stem","stem","stem","stem","pattern","stem","stem"],"description":[null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null],"status":["uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","dispatched","uptodate","uptodate","uptodate","uptodate","uptodate"],"seconds":[81.961,19.882,54.065,170.307,307.295,12.004,23.265,1.384,42.222,0.028,0.035,0,19.8240000000002,0.513,2255.675,3.888,0.074,0.337,1.356,0,0.043,0.004,18.645,0.015,0.541,8.439,0.928,7.14,287.611,10.509,11.577,0.922,0.504,51.202,0,16.245,0.008999999999999999,0,0,0.074,6.416,0.708,1.922,0.018,0.018,0,0,650.7809999999999,0.225,0.001,4.43,102.697,648.8049999999999,4.889,61.677,32.214,0,0.006,0.412,0],"bytes":[4046239,4033144,46667152,39547,353649,3068,27458,7404690,4395678,168145,220493,151,3048837,816569,4948900,562,175173,111213,41600486,6947733,80425,11880,23322290,756,211868,6676132,3525076,40154111,12094154,27776478,22979609,3456157,2483301,41719043,115,3499380,167208,173,132,259309166,7217040,2942739,21018479,163525,166710,124,177,829483007,1244,1905,29951032,23342087,41977479,15417684,1271215423,16631770,190,2505,12494438,109],"branches":[31,null,16,78,702,6,54,null,31,null,null,null,1723,null,155,null,null,null,null,null,null,null,null,null,16,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,16,null,null,null,null,null,null,16,null,null,null,19,19,null,null,null,null,16,null,null],"label":["acs_data","acs_sample","all_layer_map","att_buffer","att_buffer_city","att_dist","att_dist_city","bg_cenpop","bg_poly","buffer_forest","buffer_forest_city","buffers","candidate_pairs","cenpop_sample","chunk_distances","cities","cities_sample","city_names","clin_proj","clinic_change_dfs","clinic_chunks","clinic_counties","clinic_pairs_linked","clinic_year_summary","clinics_changepoint","clinics_changepoint_count","clinics_close","clinics_geo","clinics_grouped","clinics_keyed","clinics_linked","clinics_open","clinics_sample","combined_clinics_tagged","count_outcome_categories","counties_geo","counties_sample","county_sample_fips","county_sample_states","crime_by_city","crime_geo","csv_df","csv_pdf_merged","dist_forest","dist_forest_city","dist_outcome_categories","included_cities","ingested_crimes","keys","nibrs_crosswalk","pairs_geom","pdf_df","pdf_split","places","presentation","report","selected_buffer","unit_points","write_arc_geocode_df","years"],"color":["#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#DC863B","#354823","#354823","#354823","#354823","#354823"],"id":["acs_data","acs_sample","all_layer_map","att_buffer","att_buffer_city","att_dist","att_dist_city","bg_cenpop","bg_poly","buffer_forest","buffer_forest_city","buffers","candidate_pairs","cenpop_sample","chunk_distances","cities","cities_sample","city_names","clin_proj","clinic_change_dfs","clinic_chunks","clinic_counties","clinic_pairs_linked","clinic_year_summary","clinics_changepoint","clinics_changepoint_count","clinics_close","clinics_geo","clinics_grouped","clinics_keyed","clinics_linked","clinics_open","clinics_sample","combined_clinics_tagged","count_outcome_categories","counties_geo","counties_sample","county_sample_fips","county_sample_states","crime_by_city","crime_geo","csv_df","csv_pdf_merged","dist_forest","dist_forest_city","dist_outcome_categories","included_cities","ingested_crimes","keys","nibrs_crosswalk","pairs_geom","pdf_df","pdf_split","places","presentation","report","selected_buffer","unit_points","write_arc_geocode_df","years"],"level":[5,6,16,23,23,23,23,1,5,24,24,1,11,5,19,1,4,1,9,22,18,10,13,8,16,20,21,8,5,7,14,21,15,4,1,2,3,4,4,4,3,1,6,24,24,1,1,2,1,1,12,2,3,2,25,25,1,17,8,1],"shape":["square","dot","square","square","square","square","square","dot","square","dot","dot","dot","square","dot","square","dot","dot","dot","dot","dot","dot","dot","dot","dot","square","dot","dot","dot","dot","dot","dot","dot","dot","dot","dot","dot","dot","dot","dot","dot","square","dot","dot","dot","dot","dot","dot","square","dot","dot","dot","square","square","dot","dot","dot","dot","square","dot","dot"]},"edges":{"from":["county_sample_fips","county_sample_states","acs_data","acs_sample","crime_geo","bg_poly","clinics_sample","cities_sample","count_outcome_categories","buffers","included_cities","clinic_change_dfs","buffers","clinic_change_dfs","count_outcome_categories","included_cities","included_cities","selected_buffer","clinic_change_dfs","dist_outcome_categories","selected_buffer","clinic_change_dfs","included_cities","dist_outcome_categories","county_sample_states","county_sample_fips","att_buffer","att_buffer_city","clinic_counties","clin_proj","bg_cenpop","cities_sample","clinic_chunks","buffers","crime_by_city","counties_sample","cities","places","clinics_geo","clinics_close","clinics_open","unit_points","cities_sample","clin_proj","candidate_pairs","pairs_geom","clin_proj","clinics_keyed","cities","clinics_sample","crime_geo","clinics_changepoint","clinics_sample","chunk_distances","included_cities","clinics_changepoint_count","clinics_keyed","combined_clinics_tagged","city_names","csv_pdf_merged","clinic_pairs_linked","clinics_changepoint_count","cities_sample","clinics_linked","city_names","pdf_split","keys","cities","counties_geo","counties_sample","counties_sample","crime_geo","nibrs_crosswalk","ingested_crimes","csv_df","clinics_grouped","att_dist","att_dist_city","cities","nibrs_crosswalk","clin_proj","candidate_pairs","years","pdf_df","cities","acs_sample","dist_forest","all_layer_map","clinic_year_summary","att_buffer","cities","buffer_forest","att_buffer_city","buffer_forest_city","clinics_close","att_dist","dist_forest_city","cities_sample","att_dist_city","clinics_open","clinics_sample","included_cities","bg_poly","buffers","all_layer_map","att_dist","buffers","att_dist_city","dist_forest","att_buffer_city","att_buffer","buffer_forest_city","cities","included_cities","clinic_year_summary","buffer_forest","dist_forest_city","clinics_changepoint","clinics_keyed"],"to":["acs_data","acs_data","acs_sample","all_layer_map","all_layer_map","all_layer_map","all_layer_map","all_layer_map","att_buffer","att_buffer","att_buffer","att_buffer","att_buffer_city","att_buffer_city","att_buffer_city","att_buffer_city","att_dist","att_dist","att_dist","att_dist","att_dist_city","att_dist_city","att_dist_city","att_dist_city","bg_poly","bg_poly","buffer_forest","buffer_forest_city","candidate_pairs","candidate_pairs","cenpop_sample","cenpop_sample","chunk_distances","chunk_distances","chunk_distances","cities_sample","cities_sample","cities_sample","clin_proj","clinic_change_dfs","clinic_change_dfs","clinic_chunks","clinic_chunks","clinic_counties","clinic_pairs_linked","clinic_pairs_linked","clinic_pairs_linked","clinic_year_summary","clinics_changepoint","clinics_changepoint","clinics_changepoint","clinics_changepoint_count","clinics_changepoint_count","clinics_changepoint_count","clinics_changepoint_count","clinics_close","clinics_geo","clinics_grouped","clinics_grouped","clinics_keyed","clinics_linked","clinics_open","clinics_sample","clinics_sample","combined_clinics_tagged","combined_clinics_tagged","combined_clinics_tagged","counties_geo","counties_sample","county_sample_fips","county_sample_states","crime_by_city","crime_geo","crime_geo","csv_pdf_merged","csv_pdf_merged","dist_forest","dist_forest_city","ingested_crimes","ingested_crimes","pairs_geom","pairs_geom","pdf_df","pdf_split","places","presentation","presentation","presentation","presentation","presentation","presentation","presentation","presentation","presentation","presentation","presentation","presentation","presentation","presentation","presentation","presentation","presentation","presentation","presentation","report","report","report","report","report","report","report","report","report","report","report","report","report","unit_points","write_arc_geocode_df"],"color":["#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#DC863B","#DC863B","#DC863B","#DC863B","#DC863B","#DC863B","#DC863B","#DC863B","#DC863B","#DC863B","#DC863B","#DC863B","#DC863B","#DC863B","#DC863B","#DC863B","#DC863B","#DC863B","#DC863B","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823"],"arrows":["to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to"]},"nodesToDataframe":true,"edgesToDataframe":true,"options":{"width":"100%","height":"100%","nodes":{"shape":"dot","physics":true},"manipulation":{"enabled":false},"edges":{"smooth":{"type":"cubicBezier","forceDirection":"horizontal"}},"physics":{"stabilization":false},"interaction":{"zoomSpeed":0.75},"layout":{"hierarchical":{"enabled":true,"levelSeparation":150,"direction":"LR"}}},"groups":null,"width":null,"height":null,"idselection":{"enabled":false,"style":"width: 150px; height: 26px","useLabels":true,"main":"Select by id"},"byselection":{"enabled":false,"style":"width: 150px; height: 26px","multiple":false,"hideColor":"rgba(200,200,200,0.5)","highlight":false},"main":{"text":"","style":"font-family:Georgia, Times New Roman, Times, serif;font-weight:bold;font-size:20px;text-align:center;"},"submain":null,"footer":null,"background":"rgba(0, 0, 0, 0)","highlight":{"enabled":true,"hoverNearest":false,"degree":{"from":1,"to":1},"algorithm":"hierarchical","hideColor":"rgba(200,200,200,0.5)","labelOnly":true},"collapse":{"enabled":true,"fit":false,"resetHighlight":true,"clusterOptions":null,"keepCoord":true,"labelSuffix":"(cluster)"},"legend":{"width":0.2,"useGroups":false,"position":"right","ncol":1,"stepX":100,"stepY":100,"zoom":true,"nodes":{"label":["Up to date","Dispatched","Dynamic\nbranches","Regular\ntarget"],"color":["#354823","#DC863B","#899DA4","#899DA4"],"shape":["dot","dot","square","dot"]},"nodesToDataframe":true},"tooltipStay":300,"tooltipStyle":"position: fixed;visibility:hidden;padding: 5px;white-space: nowrap;font-family: verdana;font-size:14px;font-color:#000000;background-color: #f5f4ed;-moz-border-radius: 3px;-webkit-border-radius: 3px;border-radius: 3px;border: 1px solid #808074;box-shadow: 3px 3px 10px rgba(0, 0, 0, 0.2);"},"evals":[],"jsHooks":[]}</script>
```

:::
:::


<!-- ## Data Sources ```{r, results = "asis", echo = FALSE}
  cat(c("```{mermaid}", targets::tar_mermaid(reporter = "silent"),  targets_only = TRUE, exclude = "keys_crosswalk", "```"), sep = "\n")
  ``` -->

## Methods
### Data Sources
#### Drug Treatment Centers (DTC) 

:::{.fragment}
- National Survey of Substance Abuse Treatment Services (N-SSATS) is conducted by the Substance Abuse and Mental Health Services Administration (SAMSHA) annually
:::
:::{.fragment}
- Facilities provide information on services, licensure, funding structure, address, and contact information
:::
:::{.fragment}
- We obtained N-SSATS directory listings in PDF format for the years 2005-2021, which were ingested using optical character recognition, and merged with CSV data covering 2022-2024
:::
:::{.fragment}
- Clinics were geocoded and linked across years using nearest neighbor and Jaro-Winkler/SOUNDEX similarity
:::

## Methods
### Data Sources
#### Violent Crime Data

:::{.fragment}
- Accessed open data portals with geolocated crime incident records for large US cities (populations >300,000)
:::
:::{.fragment}
- Included records with date of incident, latitude and longitude, and crime description data 
:::
:::{.fragment}
- As drug-related and petty crimes are subject to reporting biases, we focused on "Part I" violent crimes: murder, non-negligent manslaughter (homicide), rape, robbery, or aggravated assault
:::
:::{.fragment}
- Subset by Federal Bureau of Investigation (FBI) Uniform Crime Reporting (UCR) standards: against persons, and against property
:::

## Methods
### Data Sources
#### Neighborhood Data

:::{.fragment}
- Community demographics for each block group in each city were taken from five-year American Community Survey (ACS) estimates using TidyCensus
:::
:::{.fragment}
- Shapefiles and source tables were retrieved from the IPUMS National Historical Geographic Information System (NHGIS).
:::
:::{.fragment}
- Population-weighted geographic centroids representing each block group similarly obtained from NHGIS
:::
:::{.fragment}
- Variables including population totals and median household income in $10,000s, educational attainment, property values, race / ethnicity / sex distribution, and household composition
:::

## Methods
### Sample Definition

:::{.fragment}
- Clinics were included for analysis if they had at least 5 years of operation observed, provided addiction treatment services, and were geocoded with at least 95% street address match confidence
:::
:::{.fragment}
- In each year, crimes within a maximum of 0.5mi Euclidean distance were considered for buffered density and distance calculations, as this is widely considered the upper bound of *"walking distance"* in an urban environment
:::
:::{.fragment}
- For clinics which opened in a given year, the point-locations of future clinics (which had not yet opened) were used as control units
:::

## Methods
### Exposures

:::{.fragment}
- The unit of analysis is the point location of a DTC, which is tracked over time before it opens, during operation, and (if relevant) after it closes
:::
:::{.fragment}
- Clinics which responded to NSSATS for listing in a given year were considered open
:::
:::{.fragment}
- Clinics were considered closed after the final year in which they responded to NSSATS
:::
:::{.fragment}
- As DTCs may have multiple listed offices within the same block address, DTCs which geocoded to within 100ft of one another were considered as one "treatment" unit
:::

## Methods
### Outcome Measures

:::{.fragment}
- Primary outcome was the density of violent crime in the immediate area surrounding a DTC before, during, and after its operation in a neighborhood
:::
:::{.fragment}
- Crime density was measured as: 
  1) Count of violent crimes within concentric 200ft buffers, up to 0.5mi
  2) Median Euclidean distance from crime location to each DTC
:::
:::{.fragment}
- Separate estimands were included for each crime subtype (over-all, against persons, against property)
:::
:::{.fragment}
- SAMSHA updates the directory annually, temporal resolution is 1yr
:::
:::{.fragment}
- We allowed a 1-year wash-in period until effects were estimated
:::

## Methods
### Social Measures

:::{.fragment}
Social Deprivation
:::
:::{.fragment}
- Neighborhood deprivation operationalized using the *Neighborhood Deprivation Score*, calculated as: 
$$\text{NDS} = \frac{\left(\frac{c}{10} + \frac{d}{10}\right) - \left(\frac{a}{10} + \frac{b}{10}\right)}{4}$$
:::
:::{.fragment}
- Range -5:5, where: 
  (a) adults ≥25 years with a college degree
  (b) owner-occupied housing
  (c) households with incomes below the federal poverty threshold
  (d) female-headed households with children
:::

## Methods
### Social Measures

:::{.fragment}
Residential Segregation
:::
:::{.fragment}
- Assessed using *Index of Concentration at the Extremes* (ICE), calculated as: 

$$\text{ICE} = \frac{\text{Non-Hispanic White}-\text{Non-Hispanic Black}}{\text{Block Group Population}} $$
:::
:::{.fragment}
- Range: -1 is 100% Black | 0 is 50% Black, 50% White | 1 is 100% White
:::

## Methods
### Modeling Approach

:::{.fragment}
- Within each year, treated units (newly opened or closed DTCs) were compared to not-yet-treated units using an event-study model.
:::
:::{.fragment}
- Paired t-tests assessed crime density before and after openings and closures.
:::
:::{.fragment}
- Initial GLMMs predicted crime density and distance following opening and closure events.
:::
:::{.fragment}
- A difference-in-differences model with staggered treatment timing and robust standard errors clustered at the clinic and city levels was estimated using the **did** package.
:::
:::{.fragment}
- Group-time-averaged treatment effects are reported for clarity.
:::

# Results {background-color="#40666e"}

## Results
### Clinics Identified

:::{.fragment}
In total, we identified ``22943`` clinics in ``9`` cities, across ``19`` years:
:::
:::: {.columns}
::: {.column width="40%"}
:::{.fragment}
| City           | State                  |
|----------------|------------------------|
| Atlanta        | Georgia                |
| Baltimore      | Maryland               |
| Chicago        | Illinois               |
| Denver         | Colorado               |
| Los Angeles    | California             |
| New York       | New York               |
| Philadelphia   | Pennsylvania           |
| San Francisco  | California             |
| Seattle        | Washington             |
:::
:::
::: {.column width="60%"}
:::{.fragment}

::: {.cell}
::: {.cell-output-display}
![](bmin_final_slides_benson_files/figure-revealjs/unnamed-chunk-1-1.png){width=960}
:::
:::

:::
:::
::::

## Results
### DTC & Crime Distribution: Philadelphia & Seattle {.center}

:::: {.columns}

::: {.column width="60%"}
:::{.fragment}

::: {.cell}
::: {.cell-output-display}
![](bmin_final_slides_benson_files/figure-revealjs/philly-map-1.png){width=960}
:::
:::

:::
:::
::: {.column width="40%"}
:::{.fragment}

::: {.cell}
::: {.cell-output-display}
![](bmin_final_slides_benson_files/figure-revealjs/seattle-map-1.png){width=960}
:::
:::

:::
:::

::::

## Results {visibility="hidden"}
### Clinic Treatment Status

:::{.fragment}

::: {.cell}
::: {.cell-output-display}
![](bmin_final_slides_benson_files/figure-revealjs/panel-view-1.png){width=960}
:::
:::

:::

## Results
### Unadjusted Differences: Clinic Opening

::: {.panel-tabset}

#### Crimes Against Persons

::: {.cell}
::: {.cell-output-display}
![](bmin_final_slides_benson_files/figure-revealjs/unnamed-chunk-2-1.png){width=960}
:::
:::


#### Crimes Against Property

::: {.cell}
::: {.cell-output-display}
![](bmin_final_slides_benson_files/figure-revealjs/unnamed-chunk-3-1.png){width=960}
:::
:::


:::

## Results
### Unadjusted Differences: Clinic Closure
::: {.panel-tabset}

#### Crimes Against Persons

::: {.cell}
::: {.cell-output-display}
![](bmin_final_slides_benson_files/figure-revealjs/unnamed-chunk-4-1.png){width=960}
:::
:::


#### Crimes Against Property

::: {.cell}
::: {.cell-output-display}
![](bmin_final_slides_benson_files/figure-revealjs/unnamed-chunk-5-1.png){width=960}
:::
:::

:::

## Results
### Unadjusted Differences: T-Tests & Parallel Trends

::: {.panel-tabset}

#### Clinic Opening

::: {.cell}
::: {.cell-output-display}
![](bmin_final_slides_benson_files/figure-revealjs/unnamed-chunk-6-1.png){width=960}
:::
:::


#### Clinic Closure

::: {.cell}
::: {.cell-output-display}
![](bmin_final_slides_benson_files/figure-revealjs/unnamed-chunk-7-1.png){width=960}
:::
:::

:::

## Results {visibility="hidden" .scrollable}
### OLS Model Results - **Opening**

::: {.cell}

:::


::: {.panel-tabset}
#### Table: Density

::: {.cell}
::: {.cell-output-display}

```{=html}
<!-- preamble start -->

    <script src="https://cdn.jsdelivr.net/gh/vincentarelbundock/tinytable@main/inst/tinytable.js"></script>

    <script>
      // Create table-specific functions using external factory
      const tableFns_jvpkjabvol8k1sbf6u4p = TinyTable.createTableFunctions("tinytable_jvpkjabvol8k1sbf6u4p");
      // tinytable span after
      window.addEventListener('load', function () {
          var cellsToStyle = [
            // tinytable style arrays after
          { positions: [ { i: '18', j: 2 }, { i: '18', j: 3 } ], css_id: 'tinytable_css_oceh7zro667s8x0icc2e',}, 
          { positions: [ { i: '1', j: 2 }, { i: '2', j: 2 }, { i: '3', j: 2 }, { i: '4', j: 2 }, { i: '5', j: 2 }, { i: '6', j: 2 }, { i: '7', j: 2 }, { i: '8', j: 2 }, { i: '9', j: 2 }, { i: '10', j: 2 }, { i: '11', j: 2 }, { i: '12', j: 2 }, { i: '13', j: 2 }, { i: '14', j: 2 }, { i: '15', j: 2 }, { i: '16', j: 2 }, { i: '17', j: 2 }, { i: '1', j: 3 }, { i: '2', j: 3 }, { i: '3', j: 3 }, { i: '4', j: 3 }, { i: '5', j: 3 }, { i: '6', j: 3 }, { i: '7', j: 3 }, { i: '8', j: 3 }, { i: '9', j: 3 }, { i: '10', j: 3 }, { i: '11', j: 3 }, { i: '12', j: 3 }, { i: '13', j: 3 }, { i: '14', j: 3 }, { i: '15', j: 3 }, { i: '16', j: 3 }, { i: '17', j: 3 } ], css_id: 'tinytable_css_rdn8df37a5gf24ljdj50',}, 
          { positions: [ { i: '0', j: 2 }, { i: '0', j: 3 } ], css_id: 'tinytable_css_3booy679z8gye1pv1fmd',}, 
          { positions: [ { i: '18', j: 1 } ], css_id: 'tinytable_css_ujor0rorxtbooqkq8uft',}, 
          { positions: [ { i: '1', j: 1 }, { i: '2', j: 1 }, { i: '3', j: 1 }, { i: '4', j: 1 }, { i: '5', j: 1 }, { i: '6', j: 1 }, { i: '7', j: 1 }, { i: '8', j: 1 }, { i: '9', j: 1 }, { i: '10', j: 1 }, { i: '11', j: 1 }, { i: '12', j: 1 }, { i: '13', j: 1 }, { i: '14', j: 1 }, { i: '15', j: 1 }, { i: '16', j: 1 }, { i: '17', j: 1 } ], css_id: 'tinytable_css_9rzc3p07gte3zgzglr3j',}, 
          { positions: [ { i: '0', j: 1 } ], css_id: 'tinytable_css_horp007a01p93wtyt32l',}, 
          ];

          // Loop over the arrays to style the cells
          cellsToStyle.forEach(function (group) {
              group.positions.forEach(function (cell) {
                  tableFns_jvpkjabvol8k1sbf6u4p.styleCell(cell.i, cell.j, group.css_id);
              });
          });
      });
    </script>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/vincentarelbundock/tinytable@main/inst/tinytable.css">
    <style>
    /* tinytable css entries after */
    #tinytable_jvpkjabvol8k1sbf6u4p td.tinytable_css_oceh7zro667s8x0icc2e, #tinytable_jvpkjabvol8k1sbf6u4p th.tinytable_css_oceh7zro667s8x0icc2e {  position: relative; --border-bottom: 1; --border-left: 0; --border-right: 0; --border-top: 0; --line-color-bottom: black; --line-color-left: black; --line-color-right: black; --line-color-top: black; --line-width-bottom: 0.1em; --line-width-left: 0.1em; --line-width-right: 0.1em; --line-width-top: 0.1em; --trim-bottom-left: 0%; --trim-bottom-right: 0%; --trim-left-bottom: 0%; --trim-left-top: 0%; --trim-right-bottom: 0%; --trim-right-top: 0%; --trim-top-left: 0%; --trim-top-right: 0%; ; text-align: center }
    #tinytable_jvpkjabvol8k1sbf6u4p td.tinytable_css_rdn8df37a5gf24ljdj50, #tinytable_jvpkjabvol8k1sbf6u4p th.tinytable_css_rdn8df37a5gf24ljdj50 { text-align: center }
    #tinytable_jvpkjabvol8k1sbf6u4p td.tinytable_css_3booy679z8gye1pv1fmd, #tinytable_jvpkjabvol8k1sbf6u4p th.tinytable_css_3booy679z8gye1pv1fmd {  position: relative; --border-bottom: 1; --border-left: 0; --border-right: 0; --border-top: 1; --line-color-bottom: black; --line-color-left: black; --line-color-right: black; --line-color-top: black; --line-width-bottom: 0.05em; --line-width-left: 0.1em; --line-width-right: 0.1em; --line-width-top: 0.1em; --trim-bottom-left: 0%; --trim-bottom-right: 0%; --trim-left-bottom: 0%; --trim-left-top: 0%; --trim-right-bottom: 0%; --trim-right-top: 0%; --trim-top-left: 0%; --trim-top-right: 0%; ; text-align: center }
    #tinytable_jvpkjabvol8k1sbf6u4p td.tinytable_css_ujor0rorxtbooqkq8uft, #tinytable_jvpkjabvol8k1sbf6u4p th.tinytable_css_ujor0rorxtbooqkq8uft {  position: relative; --border-bottom: 1; --border-left: 0; --border-right: 0; --border-top: 0; --line-color-bottom: black; --line-color-left: black; --line-color-right: black; --line-color-top: black; --line-width-bottom: 0.1em; --line-width-left: 0.1em; --line-width-right: 0.1em; --line-width-top: 0.1em; --trim-bottom-left: 0%; --trim-bottom-right: 0%; --trim-left-bottom: 0%; --trim-left-top: 0%; --trim-right-bottom: 0%; --trim-right-top: 0%; --trim-top-left: 0%; --trim-top-right: 0%; ; text-align: left }
    #tinytable_jvpkjabvol8k1sbf6u4p td.tinytable_css_9rzc3p07gte3zgzglr3j, #tinytable_jvpkjabvol8k1sbf6u4p th.tinytable_css_9rzc3p07gte3zgzglr3j { text-align: left }
    #tinytable_jvpkjabvol8k1sbf6u4p td.tinytable_css_horp007a01p93wtyt32l, #tinytable_jvpkjabvol8k1sbf6u4p th.tinytable_css_horp007a01p93wtyt32l {  position: relative; --border-bottom: 1; --border-left: 0; --border-right: 0; --border-top: 1; --line-color-bottom: black; --line-color-left: black; --line-color-right: black; --line-color-top: black; --line-width-bottom: 0.05em; --line-width-left: 0.1em; --line-width-right: 0.1em; --line-width-top: 0.1em; --trim-bottom-left: 0%; --trim-bottom-right: 0%; --trim-left-bottom: 0%; --trim-left-top: 0%; --trim-right-bottom: 0%; --trim-right-top: 0%; --trim-top-left: 0%; --trim-top-right: 0%; ; text-align: left }
    </style>
    <div class="container">
      <table class="tinytable" id="tinytable_jvpkjabvol8k1sbf6u4p" style="width: auto; margin-left: auto; margin-right: auto;" data-quarto-disable-processing='true'>
        
        <thead>
              <tr>
                <th scope="col" data-row="0" data-col="1"> </th>
                <th scope="col" data-row="0" data-col="2">(1: Property)</th>
                <th scope="col" data-row="0" data-col="3">(2: Persons)</th>
              </tr>
        </thead>
        <tfoot><tr><td colspan='3'>+ p < 0.1, * p < 0.05, ** p < 0.01, *** p < 0.001</td></tr></tfoot>
        <tbody>
                <tr>
                  <td data-row="1" data-col="1">ICE</td>
                  <td data-row="1" data-col="2">-18.240***</td>
                  <td data-row="1" data-col="3">6.970***</td>
                </tr>
                <tr>
                  <td data-row="2" data-col="1"></td>
                  <td data-row="2" data-col="2">[-25.750, -10.730]</td>
                  <td data-row="2" data-col="3">[5.860, 8.080]</td>
                </tr>
                <tr>
                  <td data-row="3" data-col="1">NDS</td>
                  <td data-row="3" data-col="2">-6.384***</td>
                  <td data-row="3" data-col="3">1.656***</td>
                </tr>
                <tr>
                  <td data-row="4" data-col="1"></td>
                  <td data-row="4" data-col="2">[-8.294, -4.474]</td>
                  <td data-row="4" data-col="3">[1.373, 1.938]</td>
                </tr>
                <tr>
                  <td data-row="5" data-col="1">ICExNDS</td>
                  <td data-row="5" data-col="2">14.031***</td>
                  <td data-row="5" data-col="3">1.642***</td>
                </tr>
                <tr>
                  <td data-row="6" data-col="1"></td>
                  <td data-row="6" data-col="2">[9.332, 18.730]</td>
                  <td data-row="6" data-col="3">[0.947, 2.337]</td>
                </tr>
                <tr>
                  <td data-row="7" data-col="1">Open -3</td>
                  <td data-row="7" data-col="2">-2.499</td>
                  <td data-row="7" data-col="3">-0.480</td>
                </tr>
                <tr>
                  <td data-row="8" data-col="1"></td>
                  <td data-row="8" data-col="2">[-10.716, 5.717]</td>
                  <td data-row="8" data-col="3">[-1.695, 0.735]</td>
                </tr>
                <tr>
                  <td data-row="9" data-col="1">Open -2</td>
                  <td data-row="9" data-col="2">-1.457</td>
                  <td data-row="9" data-col="3">-0.467</td>
                </tr>
                <tr>
                  <td data-row="10" data-col="1"></td>
                  <td data-row="10" data-col="2">[-9.417, 6.503]</td>
                  <td data-row="10" data-col="3">[-1.644, 0.710]</td>
                </tr>
                <tr>
                  <td data-row="11" data-col="1">Open -1</td>
                  <td data-row="11" data-col="2">-0.037</td>
                  <td data-row="11" data-col="3">-0.489</td>
                </tr>
                <tr>
                  <td data-row="12" data-col="1"></td>
                  <td data-row="12" data-col="2">[-7.701, 7.628]</td>
                  <td data-row="12" data-col="3">[-1.622, 0.644]</td>
                </tr>
                <tr>
                  <td data-row="13" data-col="1">Open +1</td>
                  <td data-row="13" data-col="2">-0.670</td>
                  <td data-row="13" data-col="3">0.327</td>
                </tr>
                <tr>
                  <td data-row="14" data-col="1"></td>
                  <td data-row="14" data-col="2">[-6.752, 5.412]</td>
                  <td data-row="14" data-col="3">[-0.572, 1.226]</td>
                </tr>
                <tr>
                  <td data-row="15" data-col="1">Open +2</td>
                  <td data-row="15" data-col="2">-0.491</td>
                  <td data-row="15" data-col="3">0.183</td>
                </tr>
                <tr>
                  <td data-row="16" data-col="1"></td>
                  <td data-row="16" data-col="2">[-6.980, 5.998]</td>
                  <td data-row="16" data-col="3">[-0.777, 1.142]</td>
                </tr>
                <tr>
                  <td data-row="17" data-col="1">Open +3</td>
                  <td data-row="17" data-col="2">-2.559</td>
                  <td data-row="17" data-col="3">0.087</td>
                </tr>
                <tr>
                  <td data-row="18" data-col="1"></td>
                  <td data-row="18" data-col="2">[-9.482, 4.363]</td>
                  <td data-row="18" data-col="3">[-0.937, 1.111]</td>
                </tr>
        </tbody>
      </table>
    </div>
<!-- hack to avoid NA insertion in last line -->
```

:::
:::


#### Fig: Density

::: {.cell}
::: {.cell-output-display}
![](bmin_final_slides_benson_files/figure-revealjs/unnamed-chunk-10-1.png){width=960}
:::
:::

#### Table: Distance

::: {.cell}

:::



::: {.cell}
::: {.cell-output-display}

```{=html}
<!-- preamble start -->

    <script src="https://cdn.jsdelivr.net/gh/vincentarelbundock/tinytable@main/inst/tinytable.js"></script>

    <script>
      // Create table-specific functions using external factory
      const tableFns_tpx5ly9aolu4qawa5fht = TinyTable.createTableFunctions("tinytable_tpx5ly9aolu4qawa5fht");
      // tinytable span after
      window.addEventListener('load', function () {
          var cellsToStyle = [
            // tinytable style arrays after
          { positions: [ { i: '18', j: 2 }, { i: '18', j: 3 } ], css_id: 'tinytable_css_oigiqcgfyiqurrnqs75f',}, 
          { positions: [ { i: '1', j: 2 }, { i: '2', j: 2 }, { i: '3', j: 2 }, { i: '4', j: 2 }, { i: '5', j: 2 }, { i: '6', j: 2 }, { i: '7', j: 2 }, { i: '8', j: 2 }, { i: '9', j: 2 }, { i: '10', j: 2 }, { i: '11', j: 2 }, { i: '12', j: 2 }, { i: '13', j: 2 }, { i: '14', j: 2 }, { i: '15', j: 2 }, { i: '16', j: 2 }, { i: '17', j: 2 }, { i: '1', j: 3 }, { i: '2', j: 3 }, { i: '3', j: 3 }, { i: '4', j: 3 }, { i: '5', j: 3 }, { i: '6', j: 3 }, { i: '7', j: 3 }, { i: '8', j: 3 }, { i: '9', j: 3 }, { i: '10', j: 3 }, { i: '11', j: 3 }, { i: '12', j: 3 }, { i: '13', j: 3 }, { i: '14', j: 3 }, { i: '15', j: 3 }, { i: '16', j: 3 }, { i: '17', j: 3 } ], css_id: 'tinytable_css_es1d050e1oz8iztnrrop',}, 
          { positions: [ { i: '0', j: 2 }, { i: '0', j: 3 } ], css_id: 'tinytable_css_5hoh1qps1ay55bngvjrn',}, 
          { positions: [ { i: '18', j: 1 } ], css_id: 'tinytable_css_yxdpipv7nkym9q7rz6xt',}, 
          { positions: [ { i: '1', j: 1 }, { i: '2', j: 1 }, { i: '3', j: 1 }, { i: '4', j: 1 }, { i: '5', j: 1 }, { i: '6', j: 1 }, { i: '7', j: 1 }, { i: '8', j: 1 }, { i: '9', j: 1 }, { i: '10', j: 1 }, { i: '11', j: 1 }, { i: '12', j: 1 }, { i: '13', j: 1 }, { i: '14', j: 1 }, { i: '15', j: 1 }, { i: '16', j: 1 }, { i: '17', j: 1 } ], css_id: 'tinytable_css_hafaabxhncnab81mzw65',}, 
          { positions: [ { i: '0', j: 1 } ], css_id: 'tinytable_css_de4owpik7iqliu49q0h9',}, 
          ];

          // Loop over the arrays to style the cells
          cellsToStyle.forEach(function (group) {
              group.positions.forEach(function (cell) {
                  tableFns_tpx5ly9aolu4qawa5fht.styleCell(cell.i, cell.j, group.css_id);
              });
          });
      });
    </script>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/vincentarelbundock/tinytable@main/inst/tinytable.css">
    <style>
    /* tinytable css entries after */
    #tinytable_tpx5ly9aolu4qawa5fht td.tinytable_css_oigiqcgfyiqurrnqs75f, #tinytable_tpx5ly9aolu4qawa5fht th.tinytable_css_oigiqcgfyiqurrnqs75f {  position: relative; --border-bottom: 1; --border-left: 0; --border-right: 0; --border-top: 0; --line-color-bottom: black; --line-color-left: black; --line-color-right: black; --line-color-top: black; --line-width-bottom: 0.1em; --line-width-left: 0.1em; --line-width-right: 0.1em; --line-width-top: 0.1em; --trim-bottom-left: 0%; --trim-bottom-right: 0%; --trim-left-bottom: 0%; --trim-left-top: 0%; --trim-right-bottom: 0%; --trim-right-top: 0%; --trim-top-left: 0%; --trim-top-right: 0%; ; text-align: center }
    #tinytable_tpx5ly9aolu4qawa5fht td.tinytable_css_es1d050e1oz8iztnrrop, #tinytable_tpx5ly9aolu4qawa5fht th.tinytable_css_es1d050e1oz8iztnrrop { text-align: center }
    #tinytable_tpx5ly9aolu4qawa5fht td.tinytable_css_5hoh1qps1ay55bngvjrn, #tinytable_tpx5ly9aolu4qawa5fht th.tinytable_css_5hoh1qps1ay55bngvjrn {  position: relative; --border-bottom: 1; --border-left: 0; --border-right: 0; --border-top: 1; --line-color-bottom: black; --line-color-left: black; --line-color-right: black; --line-color-top: black; --line-width-bottom: 0.05em; --line-width-left: 0.1em; --line-width-right: 0.1em; --line-width-top: 0.1em; --trim-bottom-left: 0%; --trim-bottom-right: 0%; --trim-left-bottom: 0%; --trim-left-top: 0%; --trim-right-bottom: 0%; --trim-right-top: 0%; --trim-top-left: 0%; --trim-top-right: 0%; ; text-align: center }
    #tinytable_tpx5ly9aolu4qawa5fht td.tinytable_css_yxdpipv7nkym9q7rz6xt, #tinytable_tpx5ly9aolu4qawa5fht th.tinytable_css_yxdpipv7nkym9q7rz6xt {  position: relative; --border-bottom: 1; --border-left: 0; --border-right: 0; --border-top: 0; --line-color-bottom: black; --line-color-left: black; --line-color-right: black; --line-color-top: black; --line-width-bottom: 0.1em; --line-width-left: 0.1em; --line-width-right: 0.1em; --line-width-top: 0.1em; --trim-bottom-left: 0%; --trim-bottom-right: 0%; --trim-left-bottom: 0%; --trim-left-top: 0%; --trim-right-bottom: 0%; --trim-right-top: 0%; --trim-top-left: 0%; --trim-top-right: 0%; ; text-align: left }
    #tinytable_tpx5ly9aolu4qawa5fht td.tinytable_css_hafaabxhncnab81mzw65, #tinytable_tpx5ly9aolu4qawa5fht th.tinytable_css_hafaabxhncnab81mzw65 { text-align: left }
    #tinytable_tpx5ly9aolu4qawa5fht td.tinytable_css_de4owpik7iqliu49q0h9, #tinytable_tpx5ly9aolu4qawa5fht th.tinytable_css_de4owpik7iqliu49q0h9 {  position: relative; --border-bottom: 1; --border-left: 0; --border-right: 0; --border-top: 1; --line-color-bottom: black; --line-color-left: black; --line-color-right: black; --line-color-top: black; --line-width-bottom: 0.05em; --line-width-left: 0.1em; --line-width-right: 0.1em; --line-width-top: 0.1em; --trim-bottom-left: 0%; --trim-bottom-right: 0%; --trim-left-bottom: 0%; --trim-left-top: 0%; --trim-right-bottom: 0%; --trim-right-top: 0%; --trim-top-left: 0%; --trim-top-right: 0%; ; text-align: left }
    </style>
    <div class="container">
      <table class="tinytable" id="tinytable_tpx5ly9aolu4qawa5fht" style="width: auto; margin-left: auto; margin-right: auto;" data-quarto-disable-processing='true'>
        
        <thead>
              <tr>
                <th scope="col" data-row="0" data-col="1"> </th>
                <th scope="col" data-row="0" data-col="2">(1: Property)</th>
                <th scope="col" data-row="0" data-col="3">(2: Persons)</th>
              </tr>
        </thead>
        <tfoot><tr><td colspan='3'>+ p < 0.1, * p < 0.05, ** p < 0.01, *** p < 0.001</td></tr></tfoot>
        <tbody>
                <tr>
                  <td data-row="1" data-col="1">ICE</td>
                  <td data-row="1" data-col="2">15.007***</td>
                  <td data-row="1" data-col="3">16.106***</td>
                </tr>
                <tr>
                  <td data-row="2" data-col="1"></td>
                  <td data-row="2" data-col="2">[7.919, 22.096]</td>
                  <td data-row="2" data-col="3">[7.913, 24.298]</td>
                </tr>
                <tr>
                  <td data-row="3" data-col="1">NDS</td>
                  <td data-row="3" data-col="2">3.164***</td>
                  <td data-row="3" data-col="3">-0.133</td>
                </tr>
                <tr>
                  <td data-row="4" data-col="1"></td>
                  <td data-row="4" data-col="2">[1.354, 4.974]</td>
                  <td data-row="4" data-col="3">[-2.220, 1.954]</td>
                </tr>
                <tr>
                  <td data-row="5" data-col="1">ICExNDS</td>
                  <td data-row="5" data-col="2">6.045**</td>
                  <td data-row="5" data-col="3">2.914</td>
                </tr>
                <tr>
                  <td data-row="6" data-col="1"></td>
                  <td data-row="6" data-col="2">[1.588, 10.502]</td>
                  <td data-row="6" data-col="3">[-2.223, 8.051]</td>
                </tr>
                <tr>
                  <td data-row="7" data-col="1">Open -3</td>
                  <td data-row="7" data-col="2">5.203</td>
                  <td data-row="7" data-col="3">-3.882</td>
                </tr>
                <tr>
                  <td data-row="8" data-col="1"></td>
                  <td data-row="8" data-col="2">[-2.590, 12.996]</td>
                  <td data-row="8" data-col="3">[-12.864, 5.101]</td>
                </tr>
                <tr>
                  <td data-row="9" data-col="1">Open -2</td>
                  <td data-row="9" data-col="2">1.449</td>
                  <td data-row="9" data-col="3">-1.087</td>
                </tr>
                <tr>
                  <td data-row="10" data-col="1"></td>
                  <td data-row="10" data-col="2">[-6.101, 8.999]</td>
                  <td data-row="10" data-col="3">[-9.789, 7.615]</td>
                </tr>
                <tr>
                  <td data-row="11" data-col="1">Open -1</td>
                  <td data-row="11" data-col="2">0.111</td>
                  <td data-row="11" data-col="3">-6.070</td>
                </tr>
                <tr>
                  <td data-row="12" data-col="1"></td>
                  <td data-row="12" data-col="2">[-7.158, 7.380]</td>
                  <td data-row="12" data-col="3">[-14.448, 2.308]</td>
                </tr>
                <tr>
                  <td data-row="13" data-col="1">Open +1</td>
                  <td data-row="13" data-col="2">1.151</td>
                  <td data-row="13" data-col="3">-4.935</td>
                </tr>
                <tr>
                  <td data-row="14" data-col="1"></td>
                  <td data-row="14" data-col="2">[-4.618, 6.919]</td>
                  <td data-row="14" data-col="3">[-11.584, 1.714]</td>
                </tr>
                <tr>
                  <td data-row="15" data-col="1">Open +2</td>
                  <td data-row="15" data-col="2">-0.073</td>
                  <td data-row="15" data-col="3">-1.949</td>
                </tr>
                <tr>
                  <td data-row="16" data-col="1"></td>
                  <td data-row="16" data-col="2">[-6.227, 6.081]</td>
                  <td data-row="16" data-col="3">[-9.042, 5.145]</td>
                </tr>
                <tr>
                  <td data-row="17" data-col="1">Open +3</td>
                  <td data-row="17" data-col="2">1.116</td>
                  <td data-row="17" data-col="3">2.884</td>
                </tr>
                <tr>
                  <td data-row="18" data-col="1"></td>
                  <td data-row="18" data-col="2">[-5.449, 7.682]</td>
                  <td data-row="18" data-col="3">[-4.684, 10.451]</td>
                </tr>
        </tbody>
      </table>
    </div>
<!-- hack to avoid NA insertion in last line -->
```

:::
:::

#### Fig: Distance

::: {.cell}
::: {.cell-output-display}
![](bmin_final_slides_benson_files/figure-revealjs/unnamed-chunk-13-1.png){width=960}
:::
:::

:::

## Results {visibility="hidden" .scrollable}
### OLS Model Results - **Closure**

::: {.cell}

:::


::: {.panel-tabset}
#### Table: Density

::: {.cell}
::: {.cell-output-display}

```{=html}
<!-- preamble start -->

    <script src="https://cdn.jsdelivr.net/gh/vincentarelbundock/tinytable@main/inst/tinytable.js"></script>

    <script>
      // Create table-specific functions using external factory
      const tableFns_vpzbe37wxxal777ubgfz = TinyTable.createTableFunctions("tinytable_vpzbe37wxxal777ubgfz");
      // tinytable span after
      window.addEventListener('load', function () {
          var cellsToStyle = [
            // tinytable style arrays after
          { positions: [ { i: '18', j: 2 }, { i: '18', j: 3 } ], css_id: 'tinytable_css_05d3pf9prypktpsmz8kl',}, 
          { positions: [ { i: '1', j: 2 }, { i: '2', j: 2 }, { i: '3', j: 2 }, { i: '4', j: 2 }, { i: '5', j: 2 }, { i: '6', j: 2 }, { i: '7', j: 2 }, { i: '8', j: 2 }, { i: '9', j: 2 }, { i: '10', j: 2 }, { i: '11', j: 2 }, { i: '12', j: 2 }, { i: '13', j: 2 }, { i: '14', j: 2 }, { i: '15', j: 2 }, { i: '16', j: 2 }, { i: '17', j: 2 }, { i: '1', j: 3 }, { i: '2', j: 3 }, { i: '3', j: 3 }, { i: '4', j: 3 }, { i: '5', j: 3 }, { i: '6', j: 3 }, { i: '7', j: 3 }, { i: '8', j: 3 }, { i: '9', j: 3 }, { i: '10', j: 3 }, { i: '11', j: 3 }, { i: '12', j: 3 }, { i: '13', j: 3 }, { i: '14', j: 3 }, { i: '15', j: 3 }, { i: '16', j: 3 }, { i: '17', j: 3 } ], css_id: 'tinytable_css_lpcks6z0vh27hxujpkcw',}, 
          { positions: [ { i: '0', j: 2 }, { i: '0', j: 3 } ], css_id: 'tinytable_css_pysrzu56r1p5uk5zrt44',}, 
          { positions: [ { i: '18', j: 1 } ], css_id: 'tinytable_css_31pgvo4z2nlfqy0xpny1',}, 
          { positions: [ { i: '1', j: 1 }, { i: '2', j: 1 }, { i: '3', j: 1 }, { i: '4', j: 1 }, { i: '5', j: 1 }, { i: '6', j: 1 }, { i: '7', j: 1 }, { i: '8', j: 1 }, { i: '9', j: 1 }, { i: '10', j: 1 }, { i: '11', j: 1 }, { i: '12', j: 1 }, { i: '13', j: 1 }, { i: '14', j: 1 }, { i: '15', j: 1 }, { i: '16', j: 1 }, { i: '17', j: 1 } ], css_id: 'tinytable_css_66u9rgrz027aaa093cwb',}, 
          { positions: [ { i: '0', j: 1 } ], css_id: 'tinytable_css_p75xrn51wbwosmja4bzn',}, 
          ];

          // Loop over the arrays to style the cells
          cellsToStyle.forEach(function (group) {
              group.positions.forEach(function (cell) {
                  tableFns_vpzbe37wxxal777ubgfz.styleCell(cell.i, cell.j, group.css_id);
              });
          });
      });
    </script>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/vincentarelbundock/tinytable@main/inst/tinytable.css">
    <style>
    /* tinytable css entries after */
    #tinytable_vpzbe37wxxal777ubgfz td.tinytable_css_05d3pf9prypktpsmz8kl, #tinytable_vpzbe37wxxal777ubgfz th.tinytable_css_05d3pf9prypktpsmz8kl {  position: relative; --border-bottom: 1; --border-left: 0; --border-right: 0; --border-top: 0; --line-color-bottom: black; --line-color-left: black; --line-color-right: black; --line-color-top: black; --line-width-bottom: 0.1em; --line-width-left: 0.1em; --line-width-right: 0.1em; --line-width-top: 0.1em; --trim-bottom-left: 0%; --trim-bottom-right: 0%; --trim-left-bottom: 0%; --trim-left-top: 0%; --trim-right-bottom: 0%; --trim-right-top: 0%; --trim-top-left: 0%; --trim-top-right: 0%; ; text-align: center }
    #tinytable_vpzbe37wxxal777ubgfz td.tinytable_css_lpcks6z0vh27hxujpkcw, #tinytable_vpzbe37wxxal777ubgfz th.tinytable_css_lpcks6z0vh27hxujpkcw { text-align: center }
    #tinytable_vpzbe37wxxal777ubgfz td.tinytable_css_pysrzu56r1p5uk5zrt44, #tinytable_vpzbe37wxxal777ubgfz th.tinytable_css_pysrzu56r1p5uk5zrt44 {  position: relative; --border-bottom: 1; --border-left: 0; --border-right: 0; --border-top: 1; --line-color-bottom: black; --line-color-left: black; --line-color-right: black; --line-color-top: black; --line-width-bottom: 0.05em; --line-width-left: 0.1em; --line-width-right: 0.1em; --line-width-top: 0.1em; --trim-bottom-left: 0%; --trim-bottom-right: 0%; --trim-left-bottom: 0%; --trim-left-top: 0%; --trim-right-bottom: 0%; --trim-right-top: 0%; --trim-top-left: 0%; --trim-top-right: 0%; ; text-align: center }
    #tinytable_vpzbe37wxxal777ubgfz td.tinytable_css_31pgvo4z2nlfqy0xpny1, #tinytable_vpzbe37wxxal777ubgfz th.tinytable_css_31pgvo4z2nlfqy0xpny1 {  position: relative; --border-bottom: 1; --border-left: 0; --border-right: 0; --border-top: 0; --line-color-bottom: black; --line-color-left: black; --line-color-right: black; --line-color-top: black; --line-width-bottom: 0.1em; --line-width-left: 0.1em; --line-width-right: 0.1em; --line-width-top: 0.1em; --trim-bottom-left: 0%; --trim-bottom-right: 0%; --trim-left-bottom: 0%; --trim-left-top: 0%; --trim-right-bottom: 0%; --trim-right-top: 0%; --trim-top-left: 0%; --trim-top-right: 0%; ; text-align: left }
    #tinytable_vpzbe37wxxal777ubgfz td.tinytable_css_66u9rgrz027aaa093cwb, #tinytable_vpzbe37wxxal777ubgfz th.tinytable_css_66u9rgrz027aaa093cwb { text-align: left }
    #tinytable_vpzbe37wxxal777ubgfz td.tinytable_css_p75xrn51wbwosmja4bzn, #tinytable_vpzbe37wxxal777ubgfz th.tinytable_css_p75xrn51wbwosmja4bzn {  position: relative; --border-bottom: 1; --border-left: 0; --border-right: 0; --border-top: 1; --line-color-bottom: black; --line-color-left: black; --line-color-right: black; --line-color-top: black; --line-width-bottom: 0.05em; --line-width-left: 0.1em; --line-width-right: 0.1em; --line-width-top: 0.1em; --trim-bottom-left: 0%; --trim-bottom-right: 0%; --trim-left-bottom: 0%; --trim-left-top: 0%; --trim-right-bottom: 0%; --trim-right-top: 0%; --trim-top-left: 0%; --trim-top-right: 0%; ; text-align: left }
    </style>
    <div class="container">
      <table class="tinytable" id="tinytable_vpzbe37wxxal777ubgfz" style="width: auto; margin-left: auto; margin-right: auto;" data-quarto-disable-processing='true'>
        
        <thead>
              <tr>
                <th scope="col" data-row="0" data-col="1"> </th>
                <th scope="col" data-row="0" data-col="2">(1: Property)</th>
                <th scope="col" data-row="0" data-col="3">(2: Persons)</th>
              </tr>
        </thead>
        <tfoot><tr><td colspan='3'>+ p < 0.1, * p < 0.05, ** p < 0.01, *** p < 0.001</td></tr></tfoot>
        <tbody>
                <tr>
                  <td data-row="1" data-col="1">ICE</td>
                  <td data-row="1" data-col="2">-25.010***</td>
                  <td data-row="1" data-col="3">5.298***</td>
                </tr>
                <tr>
                  <td data-row="2" data-col="1"></td>
                  <td data-row="2" data-col="2">[-33.551, -16.469]</td>
                  <td data-row="2" data-col="3">[4.128, 6.467]</td>
                </tr>
                <tr>
                  <td data-row="3" data-col="1">NDS</td>
                  <td data-row="3" data-col="2">-7.164***</td>
                  <td data-row="3" data-col="3">1.590***</td>
                </tr>
                <tr>
                  <td data-row="4" data-col="1"></td>
                  <td data-row="4" data-col="2">[-9.261, -5.066]</td>
                  <td data-row="4" data-col="3">[1.303, 1.877]</td>
                </tr>
                <tr>
                  <td data-row="5" data-col="1">ICExNDS</td>
                  <td data-row="5" data-col="2">10.548***</td>
                  <td data-row="5" data-col="3">1.424***</td>
                </tr>
                <tr>
                  <td data-row="6" data-col="1"></td>
                  <td data-row="6" data-col="2">[5.135, 15.960]</td>
                  <td data-row="6" data-col="3">[0.683, 2.165]</td>
                </tr>
                <tr>
                  <td data-row="7" data-col="1">Close -3</td>
                  <td data-row="7" data-col="2">-6.971+</td>
                  <td data-row="7" data-col="3">-0.818</td>
                </tr>
                <tr>
                  <td data-row="8" data-col="1"></td>
                  <td data-row="8" data-col="2">[-14.576, 0.633]</td>
                  <td data-row="8" data-col="3">[-1.860, 0.224]</td>
                </tr>
                <tr>
                  <td data-row="9" data-col="1">Close -2</td>
                  <td data-row="9" data-col="2">-5.896</td>
                  <td data-row="9" data-col="3">-0.249</td>
                </tr>
                <tr>
                  <td data-row="10" data-col="1"></td>
                  <td data-row="10" data-col="2">[-13.036, 1.244]</td>
                  <td data-row="10" data-col="3">[-1.227, 0.729]</td>
                </tr>
                <tr>
                  <td data-row="11" data-col="1">Close -1</td>
                  <td data-row="11" data-col="2">-1.179</td>
                  <td data-row="11" data-col="3">-0.034</td>
                </tr>
                <tr>
                  <td data-row="12" data-col="1"></td>
                  <td data-row="12" data-col="2">[-7.834, 5.476]</td>
                  <td data-row="12" data-col="3">[-0.946, 0.877]</td>
                </tr>
                <tr>
                  <td data-row="13" data-col="1">Close +1</td>
                  <td data-row="13" data-col="2">1.666</td>
                  <td data-row="13" data-col="3">-0.244</td>
                </tr>
                <tr>
                  <td data-row="14" data-col="1"></td>
                  <td data-row="14" data-col="2">[-6.060, 9.391]</td>
                  <td data-row="14" data-col="3">[-1.302, 0.814]</td>
                </tr>
                <tr>
                  <td data-row="15" data-col="1">Close +2</td>
                  <td data-row="15" data-col="2">1.707</td>
                  <td data-row="15" data-col="3">-0.643</td>
                </tr>
                <tr>
                  <td data-row="16" data-col="1"></td>
                  <td data-row="16" data-col="2">[-6.532, 9.946]</td>
                  <td data-row="16" data-col="3">[-1.771, 0.486]</td>
                </tr>
                <tr>
                  <td data-row="17" data-col="1">Close +3</td>
                  <td data-row="17" data-col="2">1.678</td>
                  <td data-row="17" data-col="3">-0.703</td>
                </tr>
                <tr>
                  <td data-row="18" data-col="1"></td>
                  <td data-row="18" data-col="2">[-6.940, 10.296]</td>
                  <td data-row="18" data-col="3">[-1.883, 0.477]</td>
                </tr>
        </tbody>
      </table>
    </div>
<!-- hack to avoid NA insertion in last line -->
```

:::
:::


#### Fig: Density

::: {.cell}
::: {.cell-output-display}
![](bmin_final_slides_benson_files/figure-revealjs/unnamed-chunk-16-1.png){width=960}
:::
:::

#### Table: Distance

::: {.cell}

:::



::: {.cell}
::: {.cell-output-display}

```{=html}
<!-- preamble start -->

    <script src="https://cdn.jsdelivr.net/gh/vincentarelbundock/tinytable@main/inst/tinytable.js"></script>

    <script>
      // Create table-specific functions using external factory
      const tableFns_vui1v1n801jkjytg3bra = TinyTable.createTableFunctions("tinytable_vui1v1n801jkjytg3bra");
      // tinytable span after
      window.addEventListener('load', function () {
          var cellsToStyle = [
            // tinytable style arrays after
          { positions: [ { i: '18', j: 2 }, { i: '18', j: 3 } ], css_id: 'tinytable_css_di69m40hf16ozos4un78',}, 
          { positions: [ { i: '1', j: 2 }, { i: '2', j: 2 }, { i: '3', j: 2 }, { i: '4', j: 2 }, { i: '5', j: 2 }, { i: '6', j: 2 }, { i: '7', j: 2 }, { i: '8', j: 2 }, { i: '9', j: 2 }, { i: '10', j: 2 }, { i: '11', j: 2 }, { i: '12', j: 2 }, { i: '13', j: 2 }, { i: '14', j: 2 }, { i: '15', j: 2 }, { i: '16', j: 2 }, { i: '17', j: 2 }, { i: '1', j: 3 }, { i: '2', j: 3 }, { i: '3', j: 3 }, { i: '4', j: 3 }, { i: '5', j: 3 }, { i: '6', j: 3 }, { i: '7', j: 3 }, { i: '8', j: 3 }, { i: '9', j: 3 }, { i: '10', j: 3 }, { i: '11', j: 3 }, { i: '12', j: 3 }, { i: '13', j: 3 }, { i: '14', j: 3 }, { i: '15', j: 3 }, { i: '16', j: 3 }, { i: '17', j: 3 } ], css_id: 'tinytable_css_04m3std4atml6u53hthg',}, 
          { positions: [ { i: '0', j: 2 }, { i: '0', j: 3 } ], css_id: 'tinytable_css_bfifsr4pliqa20bzvnbi',}, 
          { positions: [ { i: '18', j: 1 } ], css_id: 'tinytable_css_7ie80hitocm5y4bvxnh9',}, 
          { positions: [ { i: '1', j: 1 }, { i: '2', j: 1 }, { i: '3', j: 1 }, { i: '4', j: 1 }, { i: '5', j: 1 }, { i: '6', j: 1 }, { i: '7', j: 1 }, { i: '8', j: 1 }, { i: '9', j: 1 }, { i: '10', j: 1 }, { i: '11', j: 1 }, { i: '12', j: 1 }, { i: '13', j: 1 }, { i: '14', j: 1 }, { i: '15', j: 1 }, { i: '16', j: 1 }, { i: '17', j: 1 } ], css_id: 'tinytable_css_197qin96qi3jhz9woaxg',}, 
          { positions: [ { i: '0', j: 1 } ], css_id: 'tinytable_css_lwkdgtzrweey3j4ih0gx',}, 
          ];

          // Loop over the arrays to style the cells
          cellsToStyle.forEach(function (group) {
              group.positions.forEach(function (cell) {
                  tableFns_vui1v1n801jkjytg3bra.styleCell(cell.i, cell.j, group.css_id);
              });
          });
      });
    </script>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/vincentarelbundock/tinytable@main/inst/tinytable.css">
    <style>
    /* tinytable css entries after */
    #tinytable_vui1v1n801jkjytg3bra td.tinytable_css_di69m40hf16ozos4un78, #tinytable_vui1v1n801jkjytg3bra th.tinytable_css_di69m40hf16ozos4un78 {  position: relative; --border-bottom: 1; --border-left: 0; --border-right: 0; --border-top: 0; --line-color-bottom: black; --line-color-left: black; --line-color-right: black; --line-color-top: black; --line-width-bottom: 0.1em; --line-width-left: 0.1em; --line-width-right: 0.1em; --line-width-top: 0.1em; --trim-bottom-left: 0%; --trim-bottom-right: 0%; --trim-left-bottom: 0%; --trim-left-top: 0%; --trim-right-bottom: 0%; --trim-right-top: 0%; --trim-top-left: 0%; --trim-top-right: 0%; ; text-align: center }
    #tinytable_vui1v1n801jkjytg3bra td.tinytable_css_04m3std4atml6u53hthg, #tinytable_vui1v1n801jkjytg3bra th.tinytable_css_04m3std4atml6u53hthg { text-align: center }
    #tinytable_vui1v1n801jkjytg3bra td.tinytable_css_bfifsr4pliqa20bzvnbi, #tinytable_vui1v1n801jkjytg3bra th.tinytable_css_bfifsr4pliqa20bzvnbi {  position: relative; --border-bottom: 1; --border-left: 0; --border-right: 0; --border-top: 1; --line-color-bottom: black; --line-color-left: black; --line-color-right: black; --line-color-top: black; --line-width-bottom: 0.05em; --line-width-left: 0.1em; --line-width-right: 0.1em; --line-width-top: 0.1em; --trim-bottom-left: 0%; --trim-bottom-right: 0%; --trim-left-bottom: 0%; --trim-left-top: 0%; --trim-right-bottom: 0%; --trim-right-top: 0%; --trim-top-left: 0%; --trim-top-right: 0%; ; text-align: center }
    #tinytable_vui1v1n801jkjytg3bra td.tinytable_css_7ie80hitocm5y4bvxnh9, #tinytable_vui1v1n801jkjytg3bra th.tinytable_css_7ie80hitocm5y4bvxnh9 {  position: relative; --border-bottom: 1; --border-left: 0; --border-right: 0; --border-top: 0; --line-color-bottom: black; --line-color-left: black; --line-color-right: black; --line-color-top: black; --line-width-bottom: 0.1em; --line-width-left: 0.1em; --line-width-right: 0.1em; --line-width-top: 0.1em; --trim-bottom-left: 0%; --trim-bottom-right: 0%; --trim-left-bottom: 0%; --trim-left-top: 0%; --trim-right-bottom: 0%; --trim-right-top: 0%; --trim-top-left: 0%; --trim-top-right: 0%; ; text-align: left }
    #tinytable_vui1v1n801jkjytg3bra td.tinytable_css_197qin96qi3jhz9woaxg, #tinytable_vui1v1n801jkjytg3bra th.tinytable_css_197qin96qi3jhz9woaxg { text-align: left }
    #tinytable_vui1v1n801jkjytg3bra td.tinytable_css_lwkdgtzrweey3j4ih0gx, #tinytable_vui1v1n801jkjytg3bra th.tinytable_css_lwkdgtzrweey3j4ih0gx {  position: relative; --border-bottom: 1; --border-left: 0; --border-right: 0; --border-top: 1; --line-color-bottom: black; --line-color-left: black; --line-color-right: black; --line-color-top: black; --line-width-bottom: 0.05em; --line-width-left: 0.1em; --line-width-right: 0.1em; --line-width-top: 0.1em; --trim-bottom-left: 0%; --trim-bottom-right: 0%; --trim-left-bottom: 0%; --trim-left-top: 0%; --trim-right-bottom: 0%; --trim-right-top: 0%; --trim-top-left: 0%; --trim-top-right: 0%; ; text-align: left }
    </style>
    <div class="container">
      <table class="tinytable" id="tinytable_vui1v1n801jkjytg3bra" style="width: auto; margin-left: auto; margin-right: auto;" data-quarto-disable-processing='true'>
        
        <thead>
              <tr>
                <th scope="col" data-row="0" data-col="1"> </th>
                <th scope="col" data-row="0" data-col="2">(1: Property)</th>
                <th scope="col" data-row="0" data-col="3">(2: Persons)</th>
              </tr>
        </thead>
        <tfoot><tr><td colspan='3'>+ p < 0.1, * p < 0.05, ** p < 0.01, *** p < 0.001</td></tr></tfoot>
        <tbody>
                <tr>
                  <td data-row="1" data-col="1">ICE</td>
                  <td data-row="1" data-col="2">16.265***</td>
                  <td data-row="1" data-col="3">7.311+</td>
                </tr>
                <tr>
                  <td data-row="2" data-col="1"></td>
                  <td data-row="2" data-col="2">[8.761, 23.770]</td>
                  <td data-row="2" data-col="3">[-1.281, 15.903]</td>
                </tr>
                <tr>
                  <td data-row="3" data-col="1">NDS</td>
                  <td data-row="3" data-col="2">5.642***</td>
                  <td data-row="3" data-col="3">3.350**</td>
                </tr>
                <tr>
                  <td data-row="4" data-col="1"></td>
                  <td data-row="4" data-col="2">[3.787, 7.497]</td>
                  <td data-row="4" data-col="3">[1.235, 5.466]</td>
                </tr>
                <tr>
                  <td data-row="5" data-col="1">ICExNDS</td>
                  <td data-row="5" data-col="2">2.313</td>
                  <td data-row="5" data-col="3">-0.950</td>
                </tr>
                <tr>
                  <td data-row="6" data-col="1"></td>
                  <td data-row="6" data-col="2">[-2.479, 7.104]</td>
                  <td data-row="6" data-col="3">[-6.411, 4.510]</td>
                </tr>
                <tr>
                  <td data-row="7" data-col="1">Close -3</td>
                  <td data-row="7" data-col="2">2.473</td>
                  <td data-row="7" data-col="3">5.712</td>
                </tr>
                <tr>
                  <td data-row="8" data-col="1"></td>
                  <td data-row="8" data-col="2">[-4.259, 9.205]</td>
                  <td data-row="8" data-col="3">[-1.961, 13.385]</td>
                </tr>
                <tr>
                  <td data-row="9" data-col="1">Close -2</td>
                  <td data-row="9" data-col="2">-1.298</td>
                  <td data-row="9" data-col="3">5.848</td>
                </tr>
                <tr>
                  <td data-row="10" data-col="1"></td>
                  <td data-row="10" data-col="2">[-7.619, 5.022]</td>
                  <td data-row="10" data-col="3">[-1.357, 13.052]</td>
                </tr>
                <tr>
                  <td data-row="11" data-col="1">Close -1</td>
                  <td data-row="11" data-col="2">2.385</td>
                  <td data-row="11" data-col="3">3.432</td>
                </tr>
                <tr>
                  <td data-row="12" data-col="1"></td>
                  <td data-row="12" data-col="2">[-3.507, 8.276]</td>
                  <td data-row="12" data-col="3">[-3.283, 10.147]</td>
                </tr>
                <tr>
                  <td data-row="13" data-col="1">Close +1</td>
                  <td data-row="13" data-col="2">-1.045</td>
                  <td data-row="13" data-col="3">0.747</td>
                </tr>
                <tr>
                  <td data-row="14" data-col="1"></td>
                  <td data-row="14" data-col="2">[-7.884, 5.794]</td>
                  <td data-row="14" data-col="3">[-7.048, 8.542]</td>
                </tr>
                <tr>
                  <td data-row="15" data-col="1">Close +2</td>
                  <td data-row="15" data-col="2">-0.831</td>
                  <td data-row="15" data-col="3">3.953</td>
                </tr>
                <tr>
                  <td data-row="16" data-col="1"></td>
                  <td data-row="16" data-col="2">[-8.125, 6.462]</td>
                  <td data-row="16" data-col="3">[-4.361, 12.266]</td>
                </tr>
                <tr>
                  <td data-row="17" data-col="1">Close +3</td>
                  <td data-row="17" data-col="2">0.306</td>
                  <td data-row="17" data-col="3">2.373</td>
                </tr>
                <tr>
                  <td data-row="18" data-col="1"></td>
                  <td data-row="18" data-col="2">[-7.324, 7.935]</td>
                  <td data-row="18" data-col="3">[-6.323, 11.069]</td>
                </tr>
        </tbody>
      </table>
    </div>
<!-- hack to avoid NA insertion in last line -->
```

:::
:::

#### Fig: Distance

::: {.cell}
::: {.cell-output-display}
![](bmin_final_slides_benson_files/figure-revealjs/unnamed-chunk-19-1.png){width=960}
:::
:::

:::

## Results
### Difference-in-Difference
::: {.panel-tabset}
#### Distance

::: {.cell}
::: {.cell-output-display}
![](bmin_final_slides_benson_files/figure-revealjs/unnamed-chunk-20-1.png){width=960}
:::
:::


#### Distance - By City

::: {.cell}
::: {.cell-output-display}
![](bmin_final_slides_benson_files/figure-revealjs/unnamed-chunk-21-1.png){width=960}
:::
:::


#### Density

::: {.cell}
::: {.cell-output-display}
![](bmin_final_slides_benson_files/figure-revealjs/unnamed-chunk-22-1.png){width=960}
:::
:::


#### Density - By City

::: {.cell}
::: {.cell-output-display}
![](bmin_final_slides_benson_files/figure-revealjs/unnamed-chunk-23-1.png){width=960}
:::
:::

:::

# Conclusions {background-color="#40666e"}

## Conclusions
### Primary Findings

:::{.fragment}
- Substantial growth in DTC availability in U.S. cities from 2004 to 2024
:::
:::{.fragment}
- Neighborhoods with greater social disadvantage had higher levels of violent crime
:::
:::{.fragment}
- In aggregate, across all cities and years, we found **no significant relationship** between DTC operation and violent crime, crimes against persons, or crimes against property
:::

## Conclusions
### Primary Findings

:::{.fragment}
City-level estimates are more varied: 
:::
:::{.fragment}
- Most cities have no significant relationship by either measure
:::
:::{.fragment}
- NYC and Atlanta showed protective associations with DTC opening
:::
:::{.fragment}
- Denver and Philadelphia showed potential positive associations when measured via Euclidean distance, and negative to null associations when measured with buffered-density
:::

## Conclusions
### Limitations, Future Directions

:::{.fragment}
- Causal inference is dependent upon assumed parallel trends
:::
:::{.fragment}
- Correction for multiple comparisons in confidence interval selection is needed
:::
:::{.fragment}
- Social covariates treated as uniform across time (2005 starting estimates)
:::
:::{.fragment}
- Euclidean distance measurements do not reflect street-network based travel times
:::
:::{.fragment}
- Spatial autocorrelation should be addressed using k-means clustered nearest neighbor crime values
:::

## References
::: {#refs}
:::

<!-- [[Back to top]{.button}](#sec-background) -->
