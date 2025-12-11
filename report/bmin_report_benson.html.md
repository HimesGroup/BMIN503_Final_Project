---
title: The Impact of Drug Treatment Center Openings and Closures on Neighborhood Violent Crime
subtitle: "BMIN503/EPID600 Final Project"
author:
  - name: Jamie S. Benson
    degrees:
      - B.A.
    orcid: 0000-0002-0709-4711
    corresponding: true
    email: jamie.benson@pennmedicine.upenn.edu
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
    roles: []
    affiliation:
      - ref: ggeb
  - name: Elizabeth K. Nesoff
    degrees:
      - PhD
      - MPH
    orcid: 0000-0001-8562-8646
    corresponding: false
    roles: []
    affiliation:
      - ref: ggeb
affiliations:
  - id: ggeb
    name: University of Pennsylvania Perelman School of Medicine, Department of
      Biostatistics, Epidemiology, and Informatics; 423 Guardian Drive,
      Philadelphia, PA 19104
    isni: 123012088
keywords:
  - Opioid
  - Drug Treatment Center
  - Difference-in-Difference
  - GIS
  - Crime
abstract: |
  **Purpose** Drug treatment centers (DTCs) frequently encounter opposition because of fear of subsequent increases in neighborhood crime rates. This study examines temporal and spatial associations between DTC operation and neighborhood crime rates over a 20-year period in nine major U.S. cities.
  
  **Methods** We geocoded listings from the National Survey of Substance Abuse Treatment Services, linking DTCs probabilistically on name, location, and service offerings (2004-2024) (n=942). GPS coordinates for crimes classified as "violent" by the Uniform Crime Reporting Program (murder, non-negligent manslaughter, rape, robbery, or aggravated assault) were obtained from public records from nine U.S. cities for 2004-2024.
  
  We estimated the effect of DTC operation using a staggered difference-in-differences model, comparing crime activity around a DTC after opening, compared to areas where DTCs had not yet opened. We defined crime activity by determining the median distance to any violent crime within an 800m (0.5mi) catchment for each clinic-year. Effects are estimated using a 10-year window (5 years pre/post) around DTC opening. Sensitivity analyses included varying the time window around opening and exclusion of DTCs near a city boundary for spillover effects.

  **Results** We saw no statistically significant relationship between DTC opening and crime proximity within an 800m buffer. Trend analyses suggest a protective effect on opening, with a median annual increase of 16.5m to nearest violent crime (ATT= 16.46m, 95% CI=(-32.87m; 65.79m)), and an increase in violent crime on closure (ATT=-7.07m, 95% CI=(-11.06m; -3.08m)). There was variability in effect between cities.

  **Conclusions** We observed no significant relationship between DTC opening and neighborhood violent crime rates and a potential increase in crime following DTC closure.
plain-language-summary: |
  This study's findings support the safety of DTC operation for surrounding communities and may provide evidence for policymakers in reducing barriers to clinic placement in high-need areas.
key-points:
  - Point 1
  - Point 2
date: last-modified
bibliography: references.bib
csl: jama.csl
citation:
  container-title: Journal of the American Medical Association
number-sections: true
format:
  html:
    self-contained: true
---

# Environment Setup

::: {.cell}
::: {.cell-output .cell-output-stderr}

```
── Attaching core tidyverse packages ──────────────────────── tidyverse 2.0.0 ──
✔ dplyr     1.1.4     ✔ readr     2.1.5
✔ forcats   1.0.1     ✔ stringr   1.6.0
✔ ggplot2   4.0.0     ✔ tibble    3.3.0
✔ lubridate 1.9.4     ✔ tidyr     1.3.1
✔ purrr     1.2.0     
── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
✖ dplyr::filter() masks stats::filter()
✖ dplyr::lag()    masks stats::lag()
ℹ Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors

Attaching package: 'flextable'


The following object is masked from 'package:purrr':

    compose



Attaching package: 'kableExtra'


The following objects are masked from 'package:flextable':

    as_image, footnote


The following object is masked from 'package:dplyr':

    group_rows


## See bit.ly/panelview4r for more info.
## Report bugs -> yiqingxu@stanford.edu.


Loading required package: htmlwidgets

Linking to GEOS 3.13.0, GDAL 3.8.5, PROJ 9.5.1; sf_use_s2() is TRUE

udunits database from /Library/Frameworks/R.framework/Versions/4.5-arm64/Resources/library/units/share/udunits/udunits2.xml
```


:::

::: {.cell-output .cell-output-stderr}

```
Warning in check_dep_version(dep_pkg = "TMB"): package version mismatch: 
glmmTMB was built with TMB package version 1.9.17
Current TMB package version is 1.9.18
Please re-install glmmTMB from source or restore original 'TMB' package (see '?reinstalling' for more information)
```


:::
:::


## Introduction

Opioid use disorder (OUD) represents a persistent public health crisis in the United States, contributing substantially to national mortality, morbidity, and healthcare expenditure.1–3 Recent estimates found a 289% increase in unintentional opioid-related mortality between 2011 and 2021, with particularly pronounced effects observed during the COVID-19 pandemic. During this period, years of life lost (YLL) from opioid-related causes increased by 62.9%, from 1.5 to 3.9 years per 1,000 individuals.4 Recent surveillance data suggest potential moderation in these trends, with the Centers for Disease Control and Prevention (CDC) reporting 94,758 drug overdose deaths in the 12-month period ending May 2024, representing a 12.7% reduction from the previous year.5 However, sustainable reduction in opioid-related mortality requires continued expansion of prevention and treatment infrastructure, with modeling studies suggesting that a 30% increase in naloxone accessibility could prevent approximately 25% of opioid-related deaths.8

Treatment approaches for OUD encompass both inpatient detoxification and outpatient services, including medications for OUD (MOUD)  such as buprenorphine, naltrexone, and methadone.9,10 Despite demonstrated efficacy, significant treatment gaps persist. Only 27.8% of people needing OUD treatment received MOUD in the past year as of 2019, and approximately 40% of U.S. counties lacked authorized buprenorphine providers as of 2018. 

Establishment of new treatment facilities frequently encounters regulatory and community opposition, often centered on concerns regarding potential increases in neighborhood crime rates.14–16 However, county-level analyses suggest inverse relationships between treatment facility presence and criminal activity, with each additional facility associated with reductions in drug-related mortality (0.5%), intentional homicide (0.24%), and overall crime  (0.14%) annually.17 Similar protective associations have been observed with emergency department utilization, where facility openings and closures correspond with 6.5% decreases and 7.4% increases in drug-related visits, respectively.18 At the individual level, systematic reviews of the available trials (largely focusing on carceral programs) have demonstrated that treatment of incarcerated persons with OUD resulted in sustained reductions in recidivism by up to 15%.19,20 

Spatial analyses present a more complex relationship between facility location and neighborhood-level outcomes. Cross-sectional research in urban environments has identified modest increases in crime rates within immediate facility proximity (3.2-6.6% higher density per 100 feet closer), though these effects are comparable to or lower than those observed near other community establishments such as convenience stores.21 However, significant gaps exist in understanding the temporal and spatial dynamics between facility operations and neighborhood-level outcomes, particularly regarding spillover effects and the influence of pre-existing community vulnerability factors.

This study examines the temporal and spatial associations between drug treatment center operations and neighborhood crime rates over a 20-year time period in 15 major U.S. cities across the country. Specifically, we investigate: 1) the relationship between facility opening/closure events and changes in immediate areal crime rates, 2) spatial spillover effects on adjacent areas, and 3) the modifying effects of community social vulnerability indicators on these relationships. 

We hypothesize that there is either a small negative or no spatiotemporal association between the incidence of violent crime in the geographic area surrounding a drug treatment center and the opening of such a center. Conversely, we expect a small positive or no relationship between center closures and areal crime density.

## Data & Methods {#sec-data-methods}

The analytic pipeline is summarized and visualized below:

::: {.cell}

```{.r .cell-code}
tar_visnetwork()
```

::: {.cell-output .cell-output-stdout}

```
+ ingested_crimes declared [16 branches]
+ pdf_df declared [19 branches]
+ crime_geo declared [16 branches]
+ pdf_split declared [19 branches]
+ bg_poly declared [31 branches]
+ acs_data declared [31 branches]
+ candidate_pairs declared [1723 branches]
+ all_layer_map declared [16 branches]
+ clinics_changepoint declared [16 branches]
+ unit_points declared [16 branches]
+ chunk_distances declared [155 branches]
+ att_buffer declared [78 branches]
+ att_buffer_city declared [702 branches]
+ att_dist declared [6 branches]
+ att_dist_city declared [54 branches]
```


:::

::: {.cell-output-display}

```{=html}
<div class="visNetwork html-widget html-fill-item" id="htmlwidget-ed6af32fac4a982dce3b" style="width:100%;height:464px;"></div>
<script type="application/json" data-for="htmlwidget-ed6af32fac4a982dce3b">{"x":{"nodes":{"name":["acs_data","acs_sample","all_clinics_merge","all_layer_map","assign_keys","att_buffer","att_buffer_city","att_dist","att_dist_city","bg_cenpop","bg_poly","buffer_forest","buffer_forest_city","buffers","calc_nds","candidate_pairs","cb_palette","cenpop_sample","chunk_distances","cities","cities_sample","city_names","clin_proj","clinic_change_dfs","clinic_chunks","clinic_counties","clinic_pairs_linked","clinic_year_summary","clinic_years_summary","clinics_changepoint","clinics_changepoint_count","clinics_close","clinics_geo","clinics_grouped","clinics_keyed","clinics_linked","clinics_open","clinics_sample","combined_clinics_tagged","count_outcome_categories","counties_geo","counties_sample","county_sample_fips","county_sample_states","create_changepoint","create_search_poly","create_spatial_chunks","create_unit_points","crime_by_city","crime_geo","crime_geo_filter","crime_loaders","csv_clinics","csv_df","csv_pdf_merged","dist_forest","dist_forest_city","dist_outcome_categories","estimate_diff","extract_pdfs","filter_county","filter_merge_cities","group_clinics","import_keys","included_cities","ingested_crimes","keys","keys_crosswalk","leaflet_basemap","leaflet_map_ods","load_acs","load_atlanta_crime","load_austin_crime","load_baltimore_crime","load_boston_crime","load_chicago_crime","load_cincinnati_crime","load_city_names","load_dallas_crime","load_denver_crime","load_detroit_crime","load_los_angeles_crime","load_new_york_crime","load_philadelphia_crime","load_raleigh_crime","load_san_francisco_crime","load_seattle_crime","load_sf","load_washington_crime","map_od_rate_bg","merge_distance_changepoint","mode_coords_clinics","nibrs_crosswalk","pairs_geom","pdf_df","pdf_split","places","plot_city_clinic_avail_year","plot_city_clinic_by_year","presentation","prob_link_clean_addr","prob_link_pair_distance","prob_link_pair_gen","prob_link_pairs","process_clinic_distances","projcrs","read_clinic_geo","report","selected_buffer","split_pdf","tag_clinics","unit_points","write_arc_geocode_df","years"],"type":["pattern","stem","function","pattern","function","pattern","pattern","pattern","pattern","stem","pattern","stem","stem","stem","function","pattern","object","stem","pattern","stem","stem","stem","stem","stem","stem","stem","stem","stem","function","pattern","stem","stem","stem","stem","stem","stem","stem","stem","stem","stem","stem","stem","stem","stem","function","function","function","function","stem","pattern","function","object","function","stem","stem","stem","stem","stem","function","function","function","function","function","function","stem","pattern","stem","stem","function","function","function","function","function","function","function","function","function","function","function","function","function","function","function","function","function","function","function","function","function","function","function","function","stem","stem","pattern","pattern","stem","function","function","stem","function","function","function","function","function","object","function","stem","stem","function","function","pattern","stem","stem"],"description":[null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null],"status":["uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","dispatched","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate"],"seconds":[81.961,19.882,null,54.065,null,170.307,307.295,12.004,23.265,1.384,42.222,0.028,0.035,0,null,19.8240000000002,null,0.513,2255.675,3.888,0.074,0.337,1.356,0,0.043,0.004,18.645,0.015,null,0.541,8.439,0.928,7.14,287.611,10.509,11.577,0.922,0.504,51.202,0,16.245,0.008999999999999999,0,0,null,null,null,null,0.074,6.416,null,null,null,0.708,1.922,0.018,0.018,0,null,null,null,null,null,null,0,650.7809999999999,0.225,0.011,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,0.001,4.43,102.697,648.8049999999999,4.889,null,null,63.156,null,null,null,null,null,null,null,61.557,0,null,null,0.006,0.412,0],"bytes":[4046239,4033144,null,46667152,null,39547,353649,3068,27458,7404690,4395678,168145,220493,151,null,3048837,null,816569,4948900,562,175173,111213,41600486,6947733,80425,11880,23322290,756,null,211868,6676132,3525076,40154111,12094154,27776478,22979609,3456157,2483301,41719043,115,3499380,167208,173,132,null,null,null,null,259309166,7217040,null,null,null,2942739,21018479,163525,166710,124,null,null,null,null,null,null,177,829483007,1244,19625,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,1905,29951032,23342087,41977479,15417684,null,null,1270720781,null,null,null,null,null,null,null,10095775,190,null,null,2505,12494438,109],"branches":[31,null,null,16,null,78,702,6,54,null,31,null,null,null,null,1723,null,null,155,null,null,null,null,null,null,null,null,null,null,16,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,16,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,16,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,19,19,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,16,null,null],"label":["acs_data","acs_sample","all_clinics_merge","all_layer_map","assign_keys","att_buffer","att_buffer_city","att_dist","att_dist_city","bg_cenpop","bg_poly","buffer_forest","buffer_forest_city","buffers","calc_nds","candidate_pairs","cb_palette","cenpop_sample","chunk_distances","cities","cities_sample","city_names","clin_proj","clinic_change_dfs","clinic_chunks","clinic_counties","clinic_pairs_linked","clinic_year_summary","clinic_years_summary","clinics_changepoint","clinics_changepoint_count","clinics_close","clinics_geo","clinics_grouped","clinics_keyed","clinics_linked","clinics_open","clinics_sample","combined_clinics_tagged","count_outcome_categories","counties_geo","counties_sample","county_sample_fips","county_sample_states","create_changepoint","create_search_poly","create_spatial_chunks","create_unit_points","crime_by_city","crime_geo","crime_geo_filter","crime_loaders","csv_clinics","csv_df","csv_pdf_merged","dist_forest","dist_forest_city","dist_outcome_categories","estimate_diff","extract_pdfs","filter_county","filter_merge_cities","group_clinics","import_keys","included_cities","ingested_crimes","keys","keys_crosswalk","leaflet_basemap","leaflet_map_ods","load_acs","load_atlanta_crime","load_austin_crime","load_baltimore_crime","load_boston_crime","load_chicago_crime","load_cincinnati_crime","load_city_names","load_dallas_crime","load_denver_crime","load_detroit_crime","load_los_angeles_crime","load_new_york_crime","load_philadelphia_crime","load_raleigh_crime","load_san_francisco_crime","load_seattle_crime","load_sf","load_washington_crime","map_od_rate_bg","merge_distance_changepoint","mode_coords_clinics","nibrs_crosswalk","pairs_geom","pdf_df","pdf_split","places","plot_city_clinic_avail_year","plot_city_clinic_by_year","presentation","prob_link_clean_addr","prob_link_pair_distance","prob_link_pair_gen","prob_link_pairs","process_clinic_distances","projcrs","read_clinic_geo","report","selected_buffer","split_pdf","tag_clinics","unit_points","write_arc_geocode_df","years"],"color":["#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#DC863B","#354823","#354823","#354823","#354823","#354823","#354823"],"id":["acs_data","acs_sample","all_clinics_merge","all_layer_map","assign_keys","att_buffer","att_buffer_city","att_dist","att_dist_city","bg_cenpop","bg_poly","buffer_forest","buffer_forest_city","buffers","calc_nds","candidate_pairs","cb_palette","cenpop_sample","chunk_distances","cities","cities_sample","city_names","clin_proj","clinic_change_dfs","clinic_chunks","clinic_counties","clinic_pairs_linked","clinic_year_summary","clinic_years_summary","clinics_changepoint","clinics_changepoint_count","clinics_close","clinics_geo","clinics_grouped","clinics_keyed","clinics_linked","clinics_open","clinics_sample","combined_clinics_tagged","count_outcome_categories","counties_geo","counties_sample","county_sample_fips","county_sample_states","create_changepoint","create_search_poly","create_spatial_chunks","create_unit_points","crime_by_city","crime_geo","crime_geo_filter","crime_loaders","csv_clinics","csv_df","csv_pdf_merged","dist_forest","dist_forest_city","dist_outcome_categories","estimate_diff","extract_pdfs","filter_county","filter_merge_cities","group_clinics","import_keys","included_cities","ingested_crimes","keys","keys_crosswalk","leaflet_basemap","leaflet_map_ods","load_acs","load_atlanta_crime","load_austin_crime","load_baltimore_crime","load_boston_crime","load_chicago_crime","load_cincinnati_crime","load_city_names","load_dallas_crime","load_denver_crime","load_detroit_crime","load_los_angeles_crime","load_new_york_crime","load_philadelphia_crime","load_raleigh_crime","load_san_francisco_crime","load_seattle_crime","load_sf","load_washington_crime","map_od_rate_bg","merge_distance_changepoint","mode_coords_clinics","nibrs_crosswalk","pairs_geom","pdf_df","pdf_split","places","plot_city_clinic_avail_year","plot_city_clinic_by_year","presentation","prob_link_clean_addr","prob_link_pair_distance","prob_link_pair_gen","prob_link_pairs","process_clinic_distances","projcrs","read_clinic_geo","report","selected_buffer","split_pdf","tag_clinics","unit_points","write_arc_geocode_df","years"],"level":[5,6,1,16,1,23,23,23,23,2,5,24,24,1,1,11,0,5,19,1,4,2,9,22,18,10,13,8,1,16,20,21,8,5,7,14,21,15,4,1,2,3,4,4,1,1,1,2,4,3,1,1,1,2,6,24,24,1,1,1,1,1,1,1,1,2,2,0,0,0,1,0,0,0,0,0,0,1,2,0,0,0,0,0,0,0,0,1,0,0,1,1,1,12,2,3,2,0,0,25,1,1,1,1,1,1,2,25,1,1,1,17,8,1],"shape":["square","dot","triangle","square","triangle","square","square","square","square","dot","square","dot","dot","dot","triangle","square","triangleDown","dot","square","dot","dot","dot","dot","dot","dot","dot","dot","dot","triangle","square","dot","dot","dot","dot","dot","dot","dot","dot","dot","dot","dot","dot","dot","dot","triangle","triangle","triangle","triangle","dot","square","triangle","triangleDown","triangle","dot","dot","dot","dot","dot","triangle","triangle","triangle","triangle","triangle","triangle","dot","square","dot","dot","triangle","triangle","triangle","triangle","triangle","triangle","triangle","triangle","triangle","triangle","triangle","triangle","triangle","triangle","triangle","triangle","triangle","triangle","triangle","triangle","triangle","triangle","triangle","triangle","dot","dot","square","square","dot","triangle","triangle","dot","triangle","triangle","triangle","triangle","triangle","triangleDown","triangle","dot","dot","triangle","triangle","square","dot","dot"]},"edges":{"from":["load_acs","county_sample_fips","county_sample_states","acs_data","calc_nds","clinics_sample","acs_sample","cities_sample","bg_poly","crime_geo","included_cities","count_outcome_categories","clinic_change_dfs","estimate_diff","buffers","buffers","estimate_diff","included_cities","clinic_change_dfs","count_outcome_categories","clinic_change_dfs","dist_outcome_categories","selected_buffer","estimate_diff","included_cities","included_cities","clinic_change_dfs","selected_buffer","dist_outcome_categories","estimate_diff","projcrs","load_sf","county_sample_states","county_sample_fips","projcrs","att_buffer","att_buffer_city","prob_link_pair_gen","clin_proj","clinic_counties","cities_sample","bg_cenpop","crime_by_city","clinic_chunks","buffers","process_clinic_distances","create_search_poly","counties_sample","cities","places","projcrs","filter_merge_cities","load_city_names","prob_link_clean_addr","clinics_geo","clinics_close","clinics_open","create_spatial_chunks","unit_points","cities_sample","clin_proj","candidate_pairs","prob_link_pairs","pairs_geom","clin_proj","clinic_years_summary","clinics_keyed","cities","clinics_sample","crime_geo","create_changepoint","chunk_distances","clinics_changepoint","merge_distance_changepoint","included_cities","clinics_sample","clinics_changepoint_count","clinics_keyed","read_clinic_geo","group_clinics","combined_clinics_tagged","city_names","assign_keys","csv_pdf_merged","mode_coords_clinics","projcrs","clinic_pairs_linked","clinics_changepoint_count","cities_sample","clinics_linked","keys","pdf_split","city_names","tag_clinics","projcrs","cities","filter_county","counties_geo","counties_sample","counties_sample","projcrs","crime_geo","ingested_crimes","nibrs_crosswalk","crime_geo_filter","projcrs","csv_clinics","all_clinics_merge","clinics_grouped","csv_df","att_dist","att_dist_city","nibrs_crosswalk","cities","crime_loaders","import_keys","projcrs","clin_proj","candidate_pairs","prob_link_pair_distance","years","extract_pdfs","pdf_df","split_pdf","projcrs","cities","acs_sample","clinics_sample","cities_sample","all_layer_map","included_cities","att_buffer_city","att_buffer","buffer_forest_city","clinic_year_summary","buffers","buffer_forest","att_dist_city","att_dist","bg_poly","dist_forest","cities","clinics_open","clinics_close","dist_forest_city","projcrs","att_buffer_city","buffer_forest_city","all_layer_map","att_dist_city","att_dist","buffer_forest","included_cities","dist_forest","buffers","acs_sample","clinics_open","clinics_close","att_buffer","dist_forest_city","clinics_sample","cities","clinic_year_summary","bg_poly","cities_sample","clinics_changepoint","create_unit_points","clinics_keyed"],"to":["acs_data","acs_data","acs_data","acs_sample","acs_sample","all_layer_map","all_layer_map","all_layer_map","all_layer_map","all_layer_map","att_buffer","att_buffer","att_buffer","att_buffer","att_buffer","att_buffer_city","att_buffer_city","att_buffer_city","att_buffer_city","att_buffer_city","att_dist","att_dist","att_dist","att_dist","att_dist","att_dist_city","att_dist_city","att_dist_city","att_dist_city","att_dist_city","bg_cenpop","bg_cenpop","bg_poly","bg_poly","bg_poly","buffer_forest","buffer_forest_city","candidate_pairs","candidate_pairs","candidate_pairs","cenpop_sample","cenpop_sample","chunk_distances","chunk_distances","chunk_distances","chunk_distances","chunk_distances","cities_sample","cities_sample","cities_sample","cities_sample","cities_sample","city_names","clin_proj","clin_proj","clinic_change_dfs","clinic_change_dfs","clinic_chunks","clinic_chunks","clinic_chunks","clinic_counties","clinic_pairs_linked","clinic_pairs_linked","clinic_pairs_linked","clinic_pairs_linked","clinic_year_summary","clinic_year_summary","clinics_changepoint","clinics_changepoint","clinics_changepoint","clinics_changepoint","clinics_changepoint_count","clinics_changepoint_count","clinics_changepoint_count","clinics_changepoint_count","clinics_changepoint_count","clinics_close","clinics_geo","clinics_geo","clinics_grouped","clinics_grouped","clinics_grouped","clinics_keyed","clinics_keyed","clinics_linked","clinics_linked","clinics_linked","clinics_open","clinics_sample","clinics_sample","combined_clinics_tagged","combined_clinics_tagged","combined_clinics_tagged","combined_clinics_tagged","counties_geo","counties_geo","counties_sample","counties_sample","county_sample_fips","county_sample_states","create_unit_points","crime_by_city","crime_geo","crime_geo","crime_geo","crime_geo","csv_df","csv_pdf_merged","csv_pdf_merged","csv_pdf_merged","dist_forest","dist_forest_city","ingested_crimes","ingested_crimes","ingested_crimes","keys","load_dallas_crime","pairs_geom","pairs_geom","pairs_geom","pdf_df","pdf_df","pdf_split","pdf_split","places","places","presentation","presentation","presentation","presentation","presentation","presentation","presentation","presentation","presentation","presentation","presentation","presentation","presentation","presentation","presentation","presentation","presentation","presentation","presentation","read_clinic_geo","report","report","report","report","report","report","report","report","report","report","report","report","report","report","report","report","report","report","report","unit_points","unit_points","write_arc_geocode_df"],"color":["#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#DC863B","#DC863B","#DC863B","#DC863B","#DC863B","#DC863B","#DC863B","#DC863B","#DC863B","#DC863B","#DC863B","#DC863B","#DC863B","#DC863B","#DC863B","#DC863B","#DC863B","#DC863B","#DC863B","#354823","#354823","#354823"],"arrows":["to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to"]},"nodesToDataframe":true,"edgesToDataframe":true,"options":{"width":"100%","height":"100%","nodes":{"shape":"dot","physics":false},"manipulation":{"enabled":false},"edges":{"smooth":{"type":"cubicBezier","forceDirection":"horizontal"}},"physics":{"stabilization":false},"interaction":{"zoomSpeed":1},"layout":{"hierarchical":{"enabled":true,"levelSeparation":222,"direction":"LR"}}},"groups":null,"width":null,"height":null,"idselection":{"enabled":false,"style":"width: 150px; height: 26px","useLabels":true,"main":"Select by id"},"byselection":{"enabled":false,"style":"width: 150px; height: 26px","multiple":false,"hideColor":"rgba(200,200,200,0.5)","highlight":false},"main":{"text":"","style":"font-family:Georgia, Times New Roman, Times, serif;font-weight:bold;font-size:20px;text-align:center;"},"submain":null,"footer":null,"background":"rgba(0, 0, 0, 0)","highlight":{"enabled":true,"hoverNearest":false,"degree":{"from":1,"to":1},"algorithm":"hierarchical","hideColor":"rgba(200,200,200,0.5)","labelOnly":true},"collapse":{"enabled":true,"fit":false,"resetHighlight":true,"clusterOptions":null,"keepCoord":true,"labelSuffix":"(cluster)"},"legend":{"width":0.2,"useGroups":false,"position":"right","ncol":1,"stepX":100,"stepY":100,"zoom":true,"nodes":{"label":["Up to date","Dispatched","Dynamic\nbranches","Regular\ntarget","Function","Object"],"color":["#354823","#DC863B","#899DA4","#899DA4","#899DA4","#899DA4"],"shape":["dot","dot","square","dot","triangle","triangleDown"]},"nodesToDataframe":true},"tooltipStay":300,"tooltipStyle":"position: fixed;visibility:hidden;padding: 5px;white-space: nowrap;font-family: verdana;font-size:14px;font-color:#000000;background-color: #f5f4ed;-moz-border-radius: 3px;-webkit-border-radius: 3px;border-radius: 3px;border: 1px solid #808074;box-shadow: 3px 3px 10px rgba(0, 0, 0, 0.2);"},"evals":[],"jsHooks":[]}</script>
```

:::
:::


This study was deemed not to be human subjects research by the University of Pennsylvania Institutional Review Board. Here we report our findings following the Strengthening the Reporting of Observational Studies in Epidemiology (STROBE) guidelines.

### Data Sources
#### Drug Treatment Centers (DTC) 

The National Survey of Substance Abuse Treatment Services (N-SSATS) is conducted by the Substance Abuse and Mental Health Services Administration (SAMSHA) on an annual basis. Facilities which voluntarily responded and agreed to be represented are included in the directory. For each facility, information on their service offerings, licensure, payment forms and funding structure, street address, and contact information are collected. 

We obtained N-SSATS directory listings in PDF format for the years 2005-2021, and CSV format for 2022-2023. Prior to 2005, the text was not directly embedded in each PDF document, and was instead created through optical character recognition, introducing significant barriers to data cleaning. Data ingestion from each PDF was performed using the R package readPDF.

#### Crime Data

We identified and accessed open data portals with geolocated, up-to-date crime incident records for medium and large US cities with populations above 300,000 (Atlanta, Austin, Baltimore, Chicago, Cincinnati, Dallas, Denver, Detroit, Los Angeles, New York City, Philadelphia, San Francisco, Seattle). We included records which contained complete date of incident, latitude and longitude where the incident occurred, and crime description data fields. 

Incidents were subset into two groups: all crimes, and violent crimes. Per the U.S. Federal Bureau of Investigation (FBI) Uniform Crime Reporting (UCR) Program, any crime which was recorded as murder, non-negligent manslaughter (homicide), rape, robbery, or aggravated assault was considered to be “violent crime.”

#### Neighborhood Data

Community demographics for each block group in each city were taken from five-year American Community Survey (ACS) estimates. Shapefiles and source tables were retrieved from the IPUMS National Historical Geographic Information System (NHGIS). Variables including population totals and median household income in $10,000s,

### Measures

We calculated neighborhood deprivation with the formula {((c/10+d/10)-(a/10+b/10))/4} using census tract-level items from ACS: (a) adults ≥25 years with a college degree, (b) owner-occupied housing, (c) households with incomes below the federal poverty threshold, and (d) female-headed households with children (percentages are entered as whole numbers, not decimals); range=[-5 is very low/little deprivation, +5 is very severe deprivation]. 

We assessed segregation using Index of Concentration at the Extremes (ICE) by subtracting the number of non-Latino Blacks from the number of non-Latino Whites in a census tract and dividing by census tract population; range=[-1 is 100% Black; 0 is 50% Black, 50% White; 1 is 100% White].

### Analytic Approach

Similar to other studies (Cantor 2022), we linked facilities longitudinally across years using geolocation (ArcGIS Pro, V.10.8.2; Esri) and probabilistic linkage. We conducted this "fuzzy" linkage by generating Jaro-Winkler string similarity scores for each field of each clinic-year observation (CITE). Pairwise comparisons were blocked within postal codes for computational efficiency. The sub-scores for geocoded X/Y coordinates, street address, and clinic name were weighted at 4,3, and 1 respectively, then summed into a total score. Pairwise comparisons with similarity scores above the 85th percentile were considered true matches. Matching was conducted using the reclin2 package in R. 

DTCs were occasionally listed under two different entities providing different services, on different floors of the same street address. As our unit of analysis is the point location of each DTC, centers meeting these criteria were represented as a single site. We used ArcGIS’ spatial join tool to identify the census block group containing each DTC and assigned the corresponding block group measures.

Our primary outcome of interest was the incidence of violent crime in the geographic area surrounding DTCs. Density calculations were performed using concentric rings centered around the point location of each DTC, with the density determined by dividing the count of crimes within each ring by the total area of the ring, for each year. Ring sizes were selected at even Euclidean 100ft radius increments, up to 0.25mi (0.4 km), generally considered walking distance in urban centers. Additionally, a larger catchment of 0.5mi (0.8 km) radius was assessed to capture larger neighborhood-level effects as most non-recreational urban walking trips are ≤0.5 miles. To explore XXX, we next calculated median Euclidean distance to a violent crime from each DTC. 

[Currently approaching using difference in difference, filtering to the clinics with 5 years of data at a minimum, using the pre-treatment clinics at a given year as the control. All p-values reported are presented as raw, and Holm-Bonferroni corrected for multiple comparisons.]

### Sensitivity Analysis 

[We compare the discriminatory ability of these two measures in the sensitivity analysis.]
[Debating adding in a knox test as sensitivity analysis]

## Results {#sec-results}

### Clinics Identified

In total, we identified ``22943`` clinics in ``9`` cities, across ``19`` years:

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


::: {.cell}

```{.r .cell-code}
clinic_year_summary[1] %>%
  as.data.frame() %>%
  pivot_longer(cols=c(counts_compare.n,counts_compare.official_count), names_to = "Count",values_to = "value") %>%
  mutate(Count = factor(Count, levels = c("counts_compare.n","counts_compare.official_count"), labels = c("Respondent Facilities","Official Count"))) %>%
  rename(Year = counts_compare.year) %>%
  ggplot(aes(x=Year, y = value, group = Count, color = Count)) +
    geom_point() +
    geom_line() +
    annotate("rect", xmin = 2021, xmax = 2025, ymin = 0, ymax = 19000, 
           alpha = .2) +
    ylim(0,19000) +
    theme_minimal() +
    scale_color_brewer(palette = "Dark2") +
    labs(
      x = "Year",
      y = "Clinics (n)",
      title = "Count of Clinics by Year\nSAMSHA Certified vs NSSATS Respondents"
    )
```

::: {.cell-output-display}
![](bmin_report_benson_files/figure-html/unnamed-chunk-1-1.png){width=672}
:::
:::


### DTC & Crime Distribution: Philadelphia & Seattle


::: {.cell}

```{.r .cell-code}
all_layer_map[[12]]
```

::: {.cell-output .cell-output-stderr}

```
Variable(s) "fill" contains positive and negative values, so midpoint is set to 0. Set midpoint = NA to show the full range of visual values.
```


:::

::: {.cell-output-display}
![](bmin_report_benson_files/figure-html/philly-map-1.png){width=672}
:::
:::


::: {.cell}

```{.r .cell-code}
all_layer_map[[15]]
```

::: {.cell-output .cell-output-stderr}

```
Variable(s) "fill" contains positive and negative values, so midpoint is set to 0. Set midpoint = NA to show the full range of visual values.
```


:::

::: {.cell-output-display}
![](bmin_report_benson_files/figure-html/seattle-map-1.png){width=672}
:::
:::


### Clinic Treatment Status


::: {.cell}

```{.r .cell-code}
panelview(violent_count ~ open, # Using the treatment var which allows treatment switching after initial assignment
          data = clinics_open %>% 
            filter(buffer==min(set_units(buffers,"m"))), 
          index = c("group","year"), 
          by.timing = TRUE,
          main = "Treatment Status - Clinic Opening\nAll Clinics",
          xlab = "Year", ylab = "Clinic ID")
```

::: {.cell-output .cell-output-stderr}

```
If the number of units is more than 300, we set "gridOff = TRUE".
```


:::

::: {.cell-output .cell-output-stderr}

```
If the number of units is more than 500, we randomly select 500 units to present.
        You can set "display.all = TRUE" to show all units.
```


:::

::: {.cell-output .cell-output-stderr}

```
Warning in fortify(data, ...): Arguments in `...` must be used.
✖ Problematic argument:
• position = "identity"
ℹ Did you misspell an argument name?
```


:::

::: {.cell-output .cell-output-stderr}

```
Warning: In `margin()`, the argument `t` should have length 1, not length 4.
ℹ Argument get(s) truncated to length 1.
```


:::

::: {.cell-output .cell-output-stderr}

```
Warning: The `size` argument of `element_rect()` is deprecated as of ggplot2 3.4.0.
ℹ Please use the `linewidth` argument instead.
ℹ The deprecated feature was likely used in the panelView package.
  Please report the issue to the authors.
```


:::

::: {.cell-output-display}
![](bmin_report_benson_files/figure-html/panel-view-1.png){width=672}
:::
:::


### Unadjusted Differences: Clinic Opening

::: {.panel-tabset}

#### Crimes Against Persons

::: {.cell}

```{.r .cell-code}
clinics_open %>%
  st_drop_geometry() %>%
  filter(city == "Philadelphia") %>%
  mutate(period = factor(period, levels = c(0,1), labels = c("Pre-Opening", "Post-Opening"))) %>%
  ggplot(aes(x=person_median_distance, group = period, fill = period)) +
  geom_density(alpha=.8) +
  scale_fill_brewer(palette = 10) +
  theme_minimal() +
  labs(
    x = "Median Distance to Crime",
    y = "Density",
    title = "Median Distance: DTC to Crimes Against Persons"
  )
```

::: {.cell-output .cell-output-stderr}

```
Warning: Removed 39 rows containing non-finite outside the scale range
(`stat_density()`).
```


:::

::: {.cell-output-display}
![](bmin_report_benson_files/figure-html/unnamed-chunk-2-1.png){width=672}
:::
:::


#### Crimes Against Property

::: {.cell}

```{.r .cell-code}
clinics_open %>%
  st_drop_geometry() %>%
  filter(city == "Philadelphia") %>%
  mutate(period = factor(period, levels = c(0,1), labels = c("Pre-Opening", "Post-Opening"))) %>%
  ggplot(aes(x=property_median_distance, group = period, fill = period)) +
  geom_density(alpha=.8) +
  scale_fill_brewer(palette = 10) +
  theme_minimal() +
  labs(
    x = "Median Distance to Crime",
    y = "Density",
    title = "Median Distance: DTC to Crime Against Property"
  )
```

::: {.cell-output-display}
![](bmin_report_benson_files/figure-html/unnamed-chunk-3-1.png){width=672}
:::
:::


:::

### Unadjusted Differences: Clinic Closure
::: {.panel-tabset}

#### Crimes Against Persons

::: {.cell}

```{.r .cell-code}
clinics_close %>%
  st_drop_geometry() %>%
  filter(city == "Philadelphia") %>%
  mutate(period = factor(period_closure, levels = c(0,1), labels = c("Pre-Closure", "Post-Closure"))) %>%
  ggplot(aes(x=person_median_distance, group = period, fill = period)) +
  geom_density(alpha=.8) +
  scale_fill_brewer(palette = 10) +
  theme_minimal() +
  labs(
    x = "Median Distance to Crime",
    y = "Density",
    title = "Median Distance: DTC to Crimes Against Persons"
  )
```

::: {.cell-output .cell-output-stderr}

```
Warning: Removed 52 rows containing non-finite outside the scale range
(`stat_density()`).
```


:::

::: {.cell-output-display}
![](bmin_report_benson_files/figure-html/unnamed-chunk-4-1.png){width=672}
:::
:::


#### Crimes Against Property

::: {.cell}

```{.r .cell-code}
clinics_close %>%
  st_drop_geometry() %>%
  filter(city == "Philadelphia") %>%
  mutate(period = factor(period_closure, levels = c(0,1), labels = c("Pre-Closure", "Post-Closure"))) %>%
  ggplot(aes(x=property_median_distance, group = period, fill = period)) +
  geom_density(alpha=.8) +
  scale_fill_brewer(palette = 10) +
  theme_minimal() +
  labs(
    x = "Median Distance to Crime",
    y = "Density",
    title = "Median Distance: DTC to Crime Against Property"
  )
```

::: {.cell-output-display}
![](bmin_report_benson_files/figure-html/unnamed-chunk-5-1.png){width=672}
:::
:::

:::

### Unadjusted Differences: T-Tests & Parallel Trends

::: {.panel-tabset}

#### Clinic Opening

::: {.cell}

```{.r .cell-code}
clinics_open %>%
  filter(time_point %in% seq(-3,3)) %>%
  st_drop_geometry() %>%
  group_by(buffer) %>%
  do(tidy(t.test(units::drop_units(violent_count/area) ~ period, data = .))) %>%
  ggplot() +
  geom_line(aes(x=buffer,y=estimate*-1), color=cb_palette[1]) +
  geom_ribbon(aes(x=buffer,ymin=conf.low*-1,ymax=conf.high*-1), alpha = 0.3, fill=cb_palette[1]) +
  geom_hline(aes(yintercept = 0), linetype = "dashed") +
  ylab("Violent Crime Count Change (t-test)") +
  xlab("Buffer Size") +
  labs(
    title = "T-test: Unadjusted Violent Crime Counts - Opening",
    subtitle = "2004-2024, Offers Treatment, Geolocation Score >95%, 5+ Years of Clinic Operation",
    caption = "Data: U.S. Census Bureau, NHGIS, OpenStreetMap, SAMSHA"
  ) +
  theme_clean()
```

::: {.cell-output .cell-output-stderr}

```
Warning: The `size` argument of `element_line()` is deprecated as of ggplot2 3.4.0.
ℹ Please use the `linewidth` argument instead.
ℹ The deprecated feature was likely used in the ggthemes package.
  Please report the issue at <https://github.com/jrnold/ggthemes/issues>.
```


:::

::: {.cell-output-display}
![](bmin_report_benson_files/figure-html/unnamed-chunk-6-1.png){width=672}
:::
:::


#### Clinic Closure

::: {.cell}

```{.r .cell-code}
clinics_close %>%
  filter(time_point_closure %in% seq(-3,3)) %>%
  st_drop_geometry() %>%
  group_by(buffer) %>%
  do(tidy(t.test(units::drop_units(violent_count/area) ~ period_closure, data = .))) %>%
  ggplot() +
  geom_line(aes(x=buffer,y=estimate*-1), color=cb_palette[1]) +
  geom_ribbon(aes(x=buffer,ymin=conf.low*-1,ymax=conf.high*-1), alpha = 0.3, fill=cb_palette[1]) +
  geom_hline(aes(yintercept = 0), linetype = "dashed") +
  ylab("Violent Crime Count Change (t-test)") +
  xlab("Buffer Size") +
  labs(
    title = "T-test: Unadjusted Violent Crime Counts - Closure",
    subtitle = "2004-2024, Offers Treatment, Geolocation Score >95%, 5+ Years of Clinic Operation",
    caption = "Data: U.S. Census Bureau, NHGIS, OpenStreetMap, SAMSHA"
  ) +
  theme_clean()
```

::: {.cell-output-display}
![](bmin_report_benson_files/figure-html/unnamed-chunk-7-1.png){width=672}
:::
:::

:::

### OLS Model Results - **Opening**

::: {.cell}

:::


::: {.panel-tabset}
#### Table: Density

::: {.cell}

```{.r .cell-code}
modelsummary(
    setNames(models, c("(1: Property)", "(2: Persons)")),
  coef_map = dict, stars = TRUE, statistic = 'conf.int',
  gof_map = NA
  )
```

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

```{.r .cell-code}
modelplot(setNames(models, c("(1: Property)", "(2: Persons)")),
  coef_map = dict) +
    labs(x = 'Coef: Crime Density', 
         y = 'Term',
         title = 'Negative Binomial GLMM\nPre/Post Opening vs Crime Density') + 
          geom_vline(xintercept = 0, color = 'orange', alpha = 0.6) +
    scale_color_brewer(palette = "Dark2")
```

::: {.cell-output-display}
![](bmin_report_benson_files/figure-html/unnamed-chunk-10-1.png){width=672}
:::
:::

#### Table: Distance

::: {.cell}

:::



::: {.cell}

```{.r .cell-code}
modelsummary(
    setNames(models, c("(1: Property)", "(2: Persons)")),
  coef_map = dict, stars = TRUE, statistic = 'conf.int',
  gof_map = NA
  )
```

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

```{.r .cell-code}
modelplot(setNames(models, c("(1: Property)", "(2: Persons)")),
  coef_map = dict) +
    labs(x = 'Coef: Crime Distance', 
         y = 'Term',
         title = 'Negative Binomial GLMM\nPre/Post Opening vs Crime Distance') + 
          geom_vline(xintercept = 0, color = 'orange', alpha = 0.6) +
    scale_color_brewer(palette = "Dark2")
```

::: {.cell-output-display}
![](bmin_report_benson_files/figure-html/unnamed-chunk-13-1.png){width=672}
:::
:::

:::

### OLS Model Results - **Closure**

::: {.cell}

:::


::: {.panel-tabset}
#### Table: Density

::: {.cell}

```{.r .cell-code}
modelsummary(
    setNames(models, c("(1: Property)", "(2: Persons)")),
  coef_map = dict, stars = TRUE, statistic = 'conf.int',
  gof_map = NA
  )
```

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

```{.r .cell-code}
modelplot(setNames(models, c("(1: Property)", "(2: Persons)")),
  coef_map = dict) +
    labs(x = 'Coef: Crime Density', 
         y = 'Term',
         title = 'Negative Binomial GLMM\nPre/Post Closure vs Crime Density') + 
          geom_vline(xintercept = 0, color = 'orange', alpha = 0.6) +
    scale_color_brewer(palette = "Dark2")
```

::: {.cell-output-display}
![](bmin_report_benson_files/figure-html/unnamed-chunk-16-1.png){width=672}
:::
:::

#### Table: Distance

::: {.cell}

:::



::: {.cell}

```{.r .cell-code}
modelsummary(
    setNames(models, c("(1: Property)", "(2: Persons)")),
  coef_map = dict, stars = TRUE, statistic = 'conf.int',
  gof_map = NA
  )
```

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

```{.r .cell-code}
modelplot(setNames(models, c("(1: Property)", "(2: Persons)")),
  coef_map = dict) +
    labs(x = 'Coef: Crime Distance', 
         y = 'Term',
         title = 'Negative Binomial GLMM\nPre/Post Closure vs Crime Distance') + 
          geom_vline(xintercept = 0, color = 'orange', alpha = 0.6) +
    scale_color_brewer(palette = "Dark2")
```

::: {.cell-output-display}
![](bmin_report_benson_files/figure-html/unnamed-chunk-19-1.png){width=672}
:::
:::

:::

### Difference-in-Difference
::: {.panel-tabset}
#### Distance

::: {.cell}

```{.r .cell-code}
dist_forest
```

::: {.cell-output-display}
![](bmin_report_benson_files/figure-html/unnamed-chunk-20-1.png){width=672}
:::
:::


#### Distance - By City

::: {.cell}

```{.r .cell-code}
dist_forest_city
```

::: {.cell-output-display}
![](bmin_report_benson_files/figure-html/unnamed-chunk-21-1.png){width=672}
:::
:::


#### Density

::: {.cell}

```{.r .cell-code}
buffer_forest
```

::: {.cell-output-display}
![](bmin_report_benson_files/figure-html/unnamed-chunk-22-1.png){width=672}
:::
:::


#### Density - By City

::: {.cell}

```{.r .cell-code}
buffer_forest_city
```

::: {.cell-output .cell-output-stderr}

```
Warning: `position_dodge()` requires non-overlapping x intervals.
`position_dodge()` requires non-overlapping x intervals.
`position_dodge()` requires non-overlapping x intervals.
`position_dodge()` requires non-overlapping x intervals.
`position_dodge()` requires non-overlapping x intervals.
`position_dodge()` requires non-overlapping x intervals.
`position_dodge()` requires non-overlapping x intervals.
`position_dodge()` requires non-overlapping x intervals.
`position_dodge()` requires non-overlapping x intervals.
`position_dodge()` requires non-overlapping x intervals.
`position_dodge()` requires non-overlapping x intervals.
`position_dodge()` requires non-overlapping x intervals.
`position_dodge()` requires non-overlapping x intervals.
`position_dodge()` requires non-overlapping x intervals.
`position_dodge()` requires non-overlapping x intervals.
`position_dodge()` requires non-overlapping x intervals.
`position_dodge()` requires non-overlapping x intervals.
`position_dodge()` requires non-overlapping x intervals.
```


:::

::: {.cell-output-display}
![](bmin_report_benson_files/figure-html/unnamed-chunk-23-1.png){width=672}
:::
:::

:::

## Conclusions
### Primary Findings

- Substantial growth in DTC availability in U.S. cities from 2004 to 2024
- Neighborhoods with greater social disadvantage had higher levels of violent crime
- In aggregate, across all cities and years, we found **no significant relationship** between DTC operation and violent crime, crimes against persons, or crimes against property

City-level estimates are more varied: 

- Most cities have no significant relationship by either measure
- NYC and Atlanta showed protective associations with DTC opening
- Denver and Philadelphia showed potential positive associations when measured via Euclidean distance, and negative to null associations when measured with buffered-density

## Limitations, Future Directions

- Causal inference is dependent upon assumed parallel trends
- Correction for multiple comparisons in confidence interval selection is needed
- Social covariates treated as uniform across time (2005 starting estimates)
- Euclidean distance measurements do not reflect street-network based travel times
- Spatial autocorrelation should be addressed using k-means clustered nearest neighbor crime values

## References

::: {#refs}
:::