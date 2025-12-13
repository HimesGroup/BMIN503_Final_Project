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
date: last-modified
bibliography: references.bib
csl: jama.csl
citation:
  container-title: BMIN5030
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

Opioid use disorder (OUD) represents a persistent public health crisis in the United States, contributing substantially to national mortality, morbidity, and healthcare expenditure.[@alexanderEpidemicMidstPandemic2020; @florenceEconomicBurdenPrescription2016; @theusburdenofdiseasecollaboratorsStateUSHealth2018] Recent estimates found a 289% increase in unintentional opioid-related mortality between 2011 and 2021, with particularly pronounced effects observed during the COVID-19 pandemic. During this period, years of life lost (YLL) from opioid-related causes increased by 62.9%, from 1.5 to 3.9 years per 1,000 individuals.[@gomesTrendsOpioidToxicity2023] Recent surveillance data suggest potential moderation in these trends, with the Centers for Disease Control and Prevention (CDC) reporting 94,758 drug overdose deaths in the 12-month period ending May 2024, representing a 12.7% reduction from the previous year.[@nationalcenterforhealthstatisticsnchsProductsVitalStatistics2024] However, sustainable reduction in opioid-related mortality requires continued expansion of prevention and treatment infrastructure, with modeling studies suggesting that a 30% increase in naloxone accessibility could prevent approximately 25% of opioid-related deaths.[@raoEffectivenessPoliciesAddressing2021]

Treatment approaches for OUD encompass both inpatient detoxification and outpatient services, including medications for OUD (MOUD) such as buprenorphine, naltrexone, and methadone.[@nationalacademiesofsciencesEffectivenessMedicationBasedTreatment2019; @nationalacademiesofsciencesengineeringandmedicineMedicationAssistedTreatmentOpioid2018] Despite demonstrated efficacy, significant treatment gaps persist. Only 27.8% of people needing OUD treatment received MOUD in the past year as of 2019, and approximately 40% of U.S. counties lacked authorized buprenorphine providers as of 2018.[@kapinosTrendsGeographicProximity2023; @cantorPatternsGeographicDistribution2022; @amiriDisparitiesAccessOpioid2021]

Establishment of new treatment facilities frequently encounters regulatory and community opposition, often centered on concerns regarding potential increases in neighborhood crime rates.[@rouhaniNIMBYismHarmReduction2022; @davidsonNIMBYismUnderstandingCommunity2014; @lofaroNarrativePoliticsPolicy2021] However, county-level analyses suggest inverse relationships between treatment facility presence and criminal activity, with each additional facility associated with reductions in drug-related mortality (0.5%), intentional homicide (0.24%), and overall crime  (0.14%) annually.@bondurantSubstanceAbuseTreatment Similar protective associations have been observed with emergency department utilization, where facility openings and closures correspond with 6.5% decreases and 7.4% increases in drug-related visits, respectively.[@corredor-waldronTacklingSubstanceUse2022] At the individual level, systematic reviews of the available trials (largely focusing on carceral programs) have demonstrated that treatment of incarcerated persons with OUD resulted in sustained reductions in recidivism by up to 15%.[@DrugCourtsEffects; @prendergastEffectivenessDrugAbuse2002]

Spatial analyses present a more complex relationship between facility location and neighborhood-level outcomes. Cross-sectional research in urban environments has identified modest increases in crime rates within immediate facility proximity (3.2-6.6% higher density per 100 feet closer), though these effects are comparable to or lower than those observed near other community establishments such as convenience stores.[@furr-holdenNotMyBack2016] However, significant gaps exist in understanding the temporal and spatial dynamics between facility operations and neighborhood-level outcomes, particularly regarding spillover effects and the influence of pre-existing community vulnerability factors.

This study examines the temporal and spatial associations between drug treatment center operations and neighborhood crime rates over a ``19``-year time period in ``9`` major U.S. cities across the country. Specifically, we investigate: 1) the relationship between facility opening/closure events and changes in immediate areal crime rates, 2) spatial spillover effects on adjacent areas, and 3) the modifying effects of community social vulnerability indicators on these relationships. 

We hypothesize that there is either a small negative or no spatiotemporal association between the incidence of violent crime in the geographic area surrounding a drug treatment center and the opening of such a center. Conversely, we expect a small positive or no relationship between center closures and areal crime density.

## Data & Methods {#sec-data-methods}

The analytic pipeline is summarized and visualized below:

::: {.cell}

```{.r .cell-code}
tar_visnetwork(physics = TRUE, reporter = "silent")
```

::: {.cell-output-display}

```{=html}
<div class="visNetwork html-widget html-fill-item" id="htmlwidget-92a2fc9d81e66693b5ec" style="width:100%;height:464px;"></div>
<script type="application/json" data-for="htmlwidget-92a2fc9d81e66693b5ec">{"x":{"nodes":{"name":["acs_data","acs_sample","all_clinics_merge","all_layer_map","assign_keys","att_buffer","att_buffer_city","att_dist","att_dist_city","bg_acs_sample","bg_cenpop","bg_poly","buffer_forest","buffer_forest_city","buffers","calc_nds","candidate_pairs","cb_palette","cenpop_sample","chunk_distances","cities","cities_sample","city_names","clin_proj","clinic_change_dfs","clinic_chunks","clinic_counties","clinic_pairs_linked","clinic_year_summary","clinic_years_summary","clinics_changepoint","clinics_changepoint_count","clinics_close","clinics_geo","clinics_grouped","clinics_keyed","clinics_linked","clinics_open","clinics_sample","combined_clinics_tagged","count_outcome_categories","counties_geo","counties_sample","county_sample_fips","county_sample_states","create_changepoint","create_search_poly","create_spatial_chunks","create_unit_points","crime_by_city","crime_geo","crime_geo_filter","crime_loaders","csv_clinics","csv_df","csv_pdf_merged","dist_forest","dist_forest_city","dist_outcome_categories","estimate_diff","extract_pdfs","fig_all_crime_density_prepost","fig_city_crime_density_prepost","fig_clinic_year_overall","filter_county","filter_merge_cities","group_clinics","import_keys","included_cities","ingested_crimes","keys","keys_crosswalk","leaflet_basemap","load_acs","load_atlanta_crime","load_austin_crime","load_baltimore_crime","load_boston_crime","load_chicago_crime","load_cincinnati_crime","load_city_names","load_dallas_crime","load_denver_crime","load_detroit_crime","load_los_angeles_crime","load_new_york_crime","load_philadelphia_crime","load_raleigh_crime","load_san_francisco_crime","load_seattle_crime","load_sf","load_washington_crime","merge_distance_changepoint","mode_coords_clinics","nibrs_crosswalk","pairs_geom","pdf_df","pdf_split","places","plot_city_clinic_avail_year","plot_city_clinic_by_year","presentation","prob_link_clean_addr","prob_link_pair_distance","prob_link_pair_gen","prob_link_pairs","process_clinic_distances","projcrs","read_clinic_geo","report","selected_buffer","split_pdf","tab_density_diff_open","tag_clinics","tbl_city_crime_density_prepost","unit_points","write_arc_geocode_df","years"],"type":["pattern","stem","function","pattern","function","pattern","pattern","pattern","pattern","stem","stem","pattern","stem","stem","stem","function","pattern","object","stem","pattern","stem","stem","stem","stem","stem","stem","stem","stem","stem","function","pattern","stem","stem","stem","stem","stem","stem","stem","stem","stem","stem","stem","stem","stem","stem","function","function","function","function","stem","pattern","function","object","function","stem","stem","stem","stem","stem","function","function","pattern","pattern","stem","function","function","function","function","stem","pattern","stem","stem","function","function","function","function","function","function","function","function","function","function","function","function","function","function","function","function","function","function","function","function","function","function","stem","stem","pattern","pattern","stem","function","function","stem","function","function","function","function","function","object","function","stem","stem","function","pattern","function","pattern","pattern","stem","stem"],"description":[null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null],"status":["uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","dispatched","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate"],"seconds":[81.961,19.882,null,53.728,null,184.969,326.787,13.529,27.122,0.841,1.384,42.222,0.019,0.035,0,null,19.8240000000002,null,0.513,2255.675,3.888,0.074,0.337,1.332,0,0.043,0.004,18.645,0.015,null,0.541,12.207,1.441,7.14,287.611,10.509,11.577,1.173,0.504,51.202,0,16.245,0.008999999999999999,0,0,null,null,null,null,0.074,6.416,null,null,null,0.708,1.922,0.026,0.018,0,null,null,9.407999999999999,0.718,0.032,null,null,null,null,0,650.7809999999999,0.225,0.011,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,0.001,4.43,102.697,648.8049999999999,4.889,null,null,60.549,null,null,null,null,null,null,null,111.116,0,null,42.069,null,15.026,0.006,0.412,0],"bytes":[4046239,4033144,null,46662676,null,39567,353677,3067,27469,6282251,7404690,4395678,168130,220083,151,null,3048837,null,816569,4948900,562,175173,111213,41600486,8852305,80425,11880,23322290,756,null,211868,8376009,4621483,40154111,12094154,27776478,22979609,4350461,2483301,41719043,115,3499380,167208,173,132,null,null,null,null,259309166,7217040,null,null,null,2942739,21018479,163318,166884,124,null,null,103066823,14767008,186240,null,null,null,null,177,829483007,1244,19625,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,1905,29951032,23342087,41977479,15417684,null,null,1270628714,null,null,null,null,null,null,null,9830699,190,null,364080,null,118563,2505,12494438,109],"branches":[31,null,null,16,null,78,702,6,54,null,null,31,null,null,null,null,1723,null,null,155,null,null,null,null,null,null,null,null,null,null,16,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,16,null,null,null,null,null,null,null,null,null,null,6,54,null,null,null,null,null,null,16,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,19,19,null,null,null,null,null,null,null,null,null,null,null,null,null,null,6,null,54,16,null,null],"label":["acs_data","acs_sample","all_clinics_merge","all_layer_map","assign_keys","att_buffer","att_buffer_city","att_dist","att_dist_city","bg_acs_sample","bg_cenpop","bg_poly","buffer_forest","buffer_forest_city","buffers","calc_nds","candidate_pairs","cb_palette","cenpop_sample","chunk_distances","cities","cities_sample","city_names","clin_proj","clinic_change_dfs","clinic_chunks","clinic_counties","clinic_pairs_linked","clinic_year_summary","clinic_years_summary","clinics_changepoint","clinics_changepoint_count","clinics_close","clinics_geo","clinics_grouped","clinics_keyed","clinics_linked","clinics_open","clinics_sample","combined_clinics_tagged","count_outcome_categories","counties_geo","counties_sample","county_sample_fips","county_sample_states","create_changepoint","create_search_poly","create_spatial_chunks","create_unit_points","crime_by_city","crime_geo","crime_geo_filter","crime_loaders","csv_clinics","csv_df","csv_pdf_merged","dist_forest","dist_forest_city","dist_outcome_categories","estimate_diff","extract_pdfs","fig_all_crime_density_prepost","fig_city_crime_density_prepost","fig_clinic_year_overall","filter_county","filter_merge_cities","group_clinics","import_keys","included_cities","ingested_crimes","keys","keys_crosswalk","leaflet_basemap","load_acs","load_atlanta_crime","load_austin_crime","load_baltimore_crime","load_boston_crime","load_chicago_crime","load_cincinnati_crime","load_city_names","load_dallas_crime","load_denver_crime","load_detroit_crime","load_los_angeles_crime","load_new_york_crime","load_philadelphia_crime","load_raleigh_crime","load_san_francisco_crime","load_seattle_crime","load_sf","load_washington_crime","merge_distance_changepoint","mode_coords_clinics","nibrs_crosswalk","pairs_geom","pdf_df","pdf_split","places","plot_city_clinic_avail_year","plot_city_clinic_by_year","presentation","prob_link_clean_addr","prob_link_pair_distance","prob_link_pair_gen","prob_link_pairs","process_clinic_distances","projcrs","read_clinic_geo","report","selected_buffer","split_pdf","tab_density_diff_open","tag_clinics","tbl_city_crime_density_prepost","unit_points","write_arc_geocode_df","years"],"color":["#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#DC863B","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823"],"id":["acs_data","acs_sample","all_clinics_merge","all_layer_map","assign_keys","att_buffer","att_buffer_city","att_dist","att_dist_city","bg_acs_sample","bg_cenpop","bg_poly","buffer_forest","buffer_forest_city","buffers","calc_nds","candidate_pairs","cb_palette","cenpop_sample","chunk_distances","cities","cities_sample","city_names","clin_proj","clinic_change_dfs","clinic_chunks","clinic_counties","clinic_pairs_linked","clinic_year_summary","clinic_years_summary","clinics_changepoint","clinics_changepoint_count","clinics_close","clinics_geo","clinics_grouped","clinics_keyed","clinics_linked","clinics_open","clinics_sample","combined_clinics_tagged","count_outcome_categories","counties_geo","counties_sample","county_sample_fips","county_sample_states","create_changepoint","create_search_poly","create_spatial_chunks","create_unit_points","crime_by_city","crime_geo","crime_geo_filter","crime_loaders","csv_clinics","csv_df","csv_pdf_merged","dist_forest","dist_forest_city","dist_outcome_categories","estimate_diff","extract_pdfs","fig_all_crime_density_prepost","fig_city_crime_density_prepost","fig_clinic_year_overall","filter_county","filter_merge_cities","group_clinics","import_keys","included_cities","ingested_crimes","keys","keys_crosswalk","leaflet_basemap","load_acs","load_atlanta_crime","load_austin_crime","load_baltimore_crime","load_boston_crime","load_chicago_crime","load_cincinnati_crime","load_city_names","load_dallas_crime","load_denver_crime","load_detroit_crime","load_los_angeles_crime","load_new_york_crime","load_philadelphia_crime","load_raleigh_crime","load_san_francisco_crime","load_seattle_crime","load_sf","load_washington_crime","merge_distance_changepoint","mode_coords_clinics","nibrs_crosswalk","pairs_geom","pdf_df","pdf_split","places","plot_city_clinic_avail_year","plot_city_clinic_by_year","presentation","prob_link_clean_addr","prob_link_pair_distance","prob_link_pair_gen","prob_link_pairs","process_clinic_distances","projcrs","read_clinic_geo","report","selected_buffer","split_pdf","tab_density_diff_open","tag_clinics","tbl_city_crime_density_prepost","unit_points","write_arc_geocode_df","years"],"level":[5,6,1,16,1,23,23,23,23,7,2,5,24,24,1,1,11,0,5,19,1,4,2,9,22,18,10,13,8,1,16,20,21,8,5,7,14,21,15,4,1,2,3,4,4,1,1,1,2,4,3,1,1,1,2,6,24,24,1,1,1,23,24,9,1,1,1,1,1,2,2,0,0,1,0,0,0,0,0,0,1,2,0,0,0,0,0,0,0,0,1,0,1,1,1,12,2,3,2,0,0,25,1,1,1,1,1,1,2,25,1,1,23,1,23,17,8,1],"shape":["square","dot","triangle","square","triangle","square","square","square","square","dot","dot","square","dot","dot","dot","triangle","square","triangleDown","dot","square","dot","dot","dot","dot","dot","dot","dot","dot","dot","triangle","square","dot","dot","dot","dot","dot","dot","dot","dot","dot","dot","dot","dot","dot","dot","triangle","triangle","triangle","triangle","dot","square","triangle","triangleDown","triangle","dot","dot","dot","dot","dot","triangle","triangle","square","square","dot","triangle","triangle","triangle","triangle","dot","square","dot","dot","triangle","triangle","triangle","triangle","triangle","triangle","triangle","triangle","triangle","triangle","triangle","triangle","triangle","triangle","triangle","triangle","triangle","triangle","triangle","triangle","triangle","triangle","dot","dot","square","square","dot","triangle","triangle","dot","triangle","triangle","triangle","triangle","triangle","triangleDown","triangle","dot","dot","triangle","square","triangle","square","square","dot","dot"]},"edges":{"from":["county_sample_states","county_sample_fips","load_acs","acs_data","calc_nds","crime_geo","clinics_sample","bg_poly","cities_sample","acs_sample","count_outcome_categories","clinic_change_dfs","buffers","included_cities","estimate_diff","estimate_diff","count_outcome_categories","included_cities","buffers","clinic_change_dfs","estimate_diff","included_cities","dist_outcome_categories","clinic_change_dfs","selected_buffer","estimate_diff","clinic_change_dfs","dist_outcome_categories","selected_buffer","included_cities","bg_poly","acs_sample","cities_sample","projcrs","load_sf","county_sample_fips","county_sample_states","projcrs","att_buffer","att_buffer_city","clin_proj","prob_link_pair_gen","clinic_counties","cities_sample","bg_cenpop","crime_by_city","create_search_poly","process_clinic_distances","buffers","clinic_chunks","cities","projcrs","filter_merge_cities","counties_sample","places","load_city_names","prob_link_clean_addr","clinics_geo","clinics_open","clinics_close","cities_sample","create_spatial_chunks","unit_points","clin_proj","clin_proj","candidate_pairs","pairs_geom","prob_link_pairs","clinics_keyed","clinic_years_summary","cities","create_changepoint","crime_geo","clinics_sample","clinics_sample","merge_distance_changepoint","clinics_changepoint","included_cities","chunk_distances","bg_acs_sample","clinics_changepoint_count","read_clinic_geo","clinics_keyed","combined_clinics_tagged","group_clinics","city_names","assign_keys","csv_pdf_merged","mode_coords_clinics","clinic_pairs_linked","projcrs","clinics_changepoint_count","clinics_linked","cities_sample","tag_clinics","pdf_split","city_names","keys","cities","projcrs","filter_county","counties_geo","counties_sample","counties_sample","projcrs","crime_geo","nibrs_crosswalk","projcrs","crime_geo_filter","ingested_crimes","csv_clinics","clinics_grouped","csv_df","all_clinics_merge","att_dist","att_dist_city","included_cities","clinic_change_dfs","dist_outcome_categories","tbl_city_crime_density_prepost","clinic_year_summary","crime_loaders","cities","nibrs_crosswalk","import_keys","projcrs","clin_proj","candidate_pairs","prob_link_pair_distance","years","extract_pdfs","split_pdf","pdf_df","cities","projcrs","acs_sample","att_dist","buffers","all_layer_map","clinics_open","dist_forest","att_dist_city","att_buffer","included_cities","clinic_year_summary","att_buffer_city","dist_forest_city","buffer_forest_city","clinics_close","cities","cities_sample","bg_poly","clinics_sample","buffer_forest","projcrs","att_buffer_city","clinics_open","selected_buffer","buffers","all_layer_map","dist_forest_city","dist_forest","att_dist_city","fig_clinic_year_overall","att_dist","cities","buffer_forest","included_cities","fig_all_crime_density_prepost","clinics_sample","clinic_year_summary","att_buffer","clinics_close","fig_city_crime_density_prepost","buffer_forest_city","clinic_change_dfs","included_cities","count_outcome_categories","clinic_change_dfs","included_cities","dist_outcome_categories","clinics_changepoint","create_unit_points","clinics_keyed"],"to":["acs_data","acs_data","acs_data","acs_sample","acs_sample","all_layer_map","all_layer_map","all_layer_map","all_layer_map","all_layer_map","att_buffer","att_buffer","att_buffer","att_buffer","att_buffer","att_buffer_city","att_buffer_city","att_buffer_city","att_buffer_city","att_buffer_city","att_dist","att_dist","att_dist","att_dist","att_dist","att_dist_city","att_dist_city","att_dist_city","att_dist_city","att_dist_city","bg_acs_sample","bg_acs_sample","bg_acs_sample","bg_cenpop","bg_cenpop","bg_poly","bg_poly","bg_poly","buffer_forest","buffer_forest_city","candidate_pairs","candidate_pairs","candidate_pairs","cenpop_sample","cenpop_sample","chunk_distances","chunk_distances","chunk_distances","chunk_distances","chunk_distances","cities_sample","cities_sample","cities_sample","cities_sample","cities_sample","city_names","clin_proj","clin_proj","clinic_change_dfs","clinic_change_dfs","clinic_chunks","clinic_chunks","clinic_chunks","clinic_counties","clinic_pairs_linked","clinic_pairs_linked","clinic_pairs_linked","clinic_pairs_linked","clinic_year_summary","clinic_year_summary","clinics_changepoint","clinics_changepoint","clinics_changepoint","clinics_changepoint","clinics_changepoint_count","clinics_changepoint_count","clinics_changepoint_count","clinics_changepoint_count","clinics_changepoint_count","clinics_changepoint_count","clinics_close","clinics_geo","clinics_geo","clinics_grouped","clinics_grouped","clinics_grouped","clinics_keyed","clinics_keyed","clinics_linked","clinics_linked","clinics_linked","clinics_open","clinics_sample","clinics_sample","combined_clinics_tagged","combined_clinics_tagged","combined_clinics_tagged","combined_clinics_tagged","counties_geo","counties_geo","counties_sample","counties_sample","county_sample_fips","county_sample_states","create_unit_points","crime_by_city","crime_geo","crime_geo","crime_geo","crime_geo","csv_df","csv_pdf_merged","csv_pdf_merged","csv_pdf_merged","dist_forest","dist_forest_city","fig_all_crime_density_prepost","fig_all_crime_density_prepost","fig_all_crime_density_prepost","fig_city_crime_density_prepost","fig_clinic_year_overall","ingested_crimes","ingested_crimes","ingested_crimes","keys","load_dallas_crime","pairs_geom","pairs_geom","pairs_geom","pdf_df","pdf_df","pdf_split","pdf_split","places","places","presentation","presentation","presentation","presentation","presentation","presentation","presentation","presentation","presentation","presentation","presentation","presentation","presentation","presentation","presentation","presentation","presentation","presentation","presentation","read_clinic_geo","report","report","report","report","report","report","report","report","report","report","report","report","report","report","report","report","report","report","report","report","tab_density_diff_open","tab_density_diff_open","tab_density_diff_open","tbl_city_crime_density_prepost","tbl_city_crime_density_prepost","tbl_city_crime_density_prepost","unit_points","unit_points","write_arc_geocode_df"],"color":["#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#DC863B","#DC863B","#DC863B","#DC863B","#DC863B","#DC863B","#DC863B","#DC863B","#DC863B","#DC863B","#DC863B","#DC863B","#DC863B","#DC863B","#DC863B","#DC863B","#DC863B","#DC863B","#DC863B","#DC863B","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823"],"arrows":["to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to"]},"nodesToDataframe":true,"edgesToDataframe":true,"options":{"width":"100%","height":"100%","nodes":{"shape":"dot","physics":true},"manipulation":{"enabled":false},"edges":{"smooth":{"type":"cubicBezier","forceDirection":"horizontal"}},"physics":{"stabilization":false},"interaction":{"zoomSpeed":1},"layout":{"hierarchical":{"enabled":true,"levelSeparation":222,"direction":"LR"}}},"groups":null,"width":null,"height":null,"idselection":{"enabled":false,"style":"width: 150px; height: 26px","useLabels":true,"main":"Select by id"},"byselection":{"enabled":false,"style":"width: 150px; height: 26px","multiple":false,"hideColor":"rgba(200,200,200,0.5)","highlight":false},"main":{"text":"","style":"font-family:Georgia, Times New Roman, Times, serif;font-weight:bold;font-size:20px;text-align:center;"},"submain":null,"footer":null,"background":"rgba(0, 0, 0, 0)","highlight":{"enabled":true,"hoverNearest":false,"degree":{"from":1,"to":1},"algorithm":"hierarchical","hideColor":"rgba(200,200,200,0.5)","labelOnly":true},"collapse":{"enabled":true,"fit":false,"resetHighlight":true,"clusterOptions":null,"keepCoord":true,"labelSuffix":"(cluster)"},"legend":{"width":0.2,"useGroups":false,"position":"right","ncol":1,"stepX":100,"stepY":100,"zoom":true,"nodes":{"label":["Up to date","Dispatched","Dynamic\nbranches","Regular\ntarget","Function","Object"],"color":["#354823","#DC863B","#899DA4","#899DA4","#899DA4","#899DA4"],"shape":["dot","dot","square","dot","triangle","triangleDown"]},"nodesToDataframe":true},"tooltipStay":300,"tooltipStyle":"position: fixed;visibility:hidden;padding: 5px;white-space: nowrap;font-family: verdana;font-size:14px;font-color:#000000;background-color: #f5f4ed;-moz-border-radius: 3px;-webkit-border-radius: 3px;border-radius: 3px;border: 1px solid #808074;box-shadow: 3px 3px 10px rgba(0, 0, 0, 0.2);"},"evals":[],"jsHooks":[]}</script>
```

:::
:::


This study was deemed not to be human subjects research by the University of Pennsylvania Institutional Review Board. Here we report our findings following the Strengthening the Reporting of Observational Studies in Epidemiology (STROBE) guidelines.

### Data Sources
#### Drug Treatment Centers (DTC) 

The National Survey of Substance Abuse Treatment Services (N-SSATS) is conducted by the Substance Abuse and Mental Health Services Administration (SAMSHA) on an annual basis. Facilities which voluntarily responded and agreed to be represented are included in the directory. For each facility, information on their service offerings, licensure, payment forms and funding structure, street address, and contact information are collected. 

We obtained N-SSATS directory listings in PDF format for the years 2005-2021, and CSV format for 2022-2023. Prior to 2005, text was not directly embedded in each PDF document, and was instead created through optical character recognition, introducing significant barriers to data cleaning. Data ingestion from each PDF was performed using the R package readPDF. Future work to ingest NSSATS files from 1980 through 2005 using modern OCR techniques is needed.

#### Crime Data

We identified and accessed open data portals with geolocated, up-to-date crime incident records for medium and large US cities with populations above 300,000 (Atlanta, Baltimore, Chicago, Denver, Los Angeles, New York, Philadelphia, San Francisco, Seattle). We included records which contained complete date of incident, latitude and longitude where the incident occurred, and crime description data fields. 

Incidents were subset into two groups: all crimes, and violent crimes. Per the U.S. Federal Bureau of Investigation (FBI) Uniform Crime Reporting (UCR) Program, any crime which was recorded as murder, non-negligent manslaughter (homicide), rape, robbery, or aggravated assault was considered to be “violent crime.”

#### Neighborhood Data

Community demographics for each block group in each city were taken from five-year American Community Survey (ACS) estimates. Shapefiles and source tables were retrieved from the IPUMS National Historical Geographic Information System (NHGIS). Variables including population totals and median household income in $10,000s,

### Measures

We operationalized neighborhood deprivation using the *Neighborhood Deprivation Score*, calculated as: 
$$\text{NDS} = \frac{\left(\frac{c}{10} + \frac{d}{10}\right) - \left(\frac{a}{10} + \frac{b}{10}\right)}{4}$$

This score is constructed using census tract-level items from the ACS, where: 
  (a) adults ≥25 years with a college degree
  (b) owner-occupied housing
  (c) households with incomes below the federal poverty threshold
  (d) female-headed households with children
The NDS score ranges from -5 (very low/little deprivation) to +5 (very severe deprivation). 

- Assessed using *Index of Concentration at the Extremes* (ICE), calculated as: 

- Range: -1 is 100% Black | 0 is 50% Black, 50% White | 1 is 100% White

We assessed segregation using Index of Concentration at the Extremes (ICE), which is calculated by subtracting the number of non-Latino Blacks from the number of non-Latino Whites in a census tract and dividing by census tract population:
$$\text{ICE} = \frac{\text{Non-Hispanic White}-\text{Non-Hispanic Black}}{\text{Block Group Population}} $$
 
The score ranges from -1 (100% Black), to 0 (50% Black, 50% White), to 1 (100% White) continuously.

### Outcome Measures

Similar to other studies, we linked facilities longitudinally across years using geolocation (ArcGIS Pro, V.10.8.2; Esri) and probabilistic linkage.[@cantorPatternsGeographicDistribution2022] We conducted this "fuzzy" linkage by generating Jaro-Winkler string similarity scores for each field of each clinic-year observation, and through geographic clustering. Pairwise comparisons were blocked within postal codes for computational efficiency. The sub-scores for geocoded X/Y coordinates, street address, and clinic name were weighted equally, and summed into a total score. Pairwise comparisons with similarity scores above the 90th percentile, and which were geogoded to within 200ft of one another, were considered the same clinic for analysis purposes. Matching was conducted using the reclin2 package in R.

DTCs were occasionally listed under two different entities providing different services, on different floors of the same street address. As our unit of analysis is the point location of each DTC, centers meeting these criteria were represented as a single site. We used spatial joining to identify the census block group containing each DTC and assigned the corresponding cross-sectional block group measures to it.

Our primary outcome of interest was the incidence of violent crime in the geographic area surrounding DTCs, as measured via density and distance. Density calculations were performed using concentric rings centered around the point location of each DTC, with the density determined by dividing the count of crimes within each ring by the total area of the ring, for each year. Ring sizes were selected at even Euclidean 200ft radius increments, up to 0.5mi, generally considered walking distance in urban centers. 

We additionally determined the median distance from each DTC to any given crime within the 0.5mi catchment for a given year. This allows more flexible estimation of proximity effects, though it trades off granularity on the absolute volume of crime for specificity on its distance.

[Currently approaching using difference in difference, filtering to the clinics with 5 years of data at a minimum, using the pre-treatment clinics at a given year as the control. All p-values reported are presented as raw, and Holm-Bonferroni corrected for multiple comparisons.]

### Statistical Models

In univariate analyses, variables were compared using t-tests (continuous) and chi-square / ANOVA as appropriate. For multivariate analyses, a generalized linear mixed model was first fit to predict crime density and median crime distance for each subtype (against persons, against property, over-all), estimating separate terms for the three years pre- and post-opening, adjusting for NDS and ICE scores. Standard errors were clustered within cities. 

The primary analysis was a difference-in-difference model with hetergeneous treatment timing, as described by Callaway & Sant'Anna.[@callawayDifferenceinDifferencesMultipleTime2021] This model uses a doubly robust estimator, and clusters standard errors within both individual DTCs across time, and within cities across time. For a given cohort (e.g. clinics which opened in 2010), the clinics which had not yet been treated (would open at a future date) served as control units. Parallel trends were assessed visually, to ensure models had face validity. 

We report the group-time-averaged treatment effects across all opening cohorts and cities, as well as per-city estimates for each crime subtype, and for each outcome measure (crime density and crime distance). 

### Sensitivity Analysis 

We included only the three years pre- and post- clinic opening and closure in models of direct effect estimates, as it is implausible that parallel trends would hold for a given community for 17 years, or that the effect we observe would be discernible on that time scale. Additional models were run with varying effect windows from 1-5 years, and with varying inclusion requirements from 1-5 years of observation in the dataset, and effect estimates were consistent across these specifications.

Additionally, given the COVID-19 pandemic, and changes to SAMSHA's classification and reporting of clinics in NSSATS in 2021, we ran separate models which limited the dataset to pre-2020 data. These estimates were grossly similar to the estimates obtained on the entire dataset.

Lastly, as we lack information on crimes occurring outside of the borders of the city, where additional DTCs may still be located in proximity to them, we conducted subgroup analyses containing only the DTCs which were outside of a 0.5mi buffer from the city's municipal border, which similarly had no measurable effect on our estimates. Given the number of additional models this represents, these results are not presented here for brevity.

## Results {#sec-results}

### Clinics Identified

In total, we identified ``22943`` clinics in ``9`` cities, across ``19`` years:


::: {.cell}

```{.r .cell-code}
cities[cities$city %in% included_cities,1:2] %>% rename(City=city,State=state) %>% flextable() # Shows the city data for those which we included in the analysis
```

::: {.cell-output-display}

```{=html}
<div class="tabwid"><style>.cl-6cc45992{}.cl-6cc1abf2{font-family:'Helvetica';font-size:11pt;font-weight:normal;font-style:normal;text-decoration:none;color:rgba(0, 0, 0, 1.00);background-color:transparent;}.cl-6cc2d5d6{margin:0;text-align:left;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-6cc2e1a2{width:0.75in;background-color:transparent;vertical-align: middle;border-bottom: 1.5pt solid rgba(102, 102, 102, 1.00);border-top: 1.5pt solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-6cc2e1de{width:0.75in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-6cc2e1e8{width:0.75in;background-color:transparent;vertical-align: middle;border-bottom: 1.5pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}</style><table data-quarto-disable-processing='true' class='cl-6cc45992'><thead><tr style="overflow-wrap:break-word;"><th class="cl-6cc2e1a2"><p class="cl-6cc2d5d6"><span class="cl-6cc1abf2">City</span></p></th><th class="cl-6cc2e1a2"><p class="cl-6cc2d5d6"><span class="cl-6cc1abf2">State</span></p></th></tr></thead><tbody><tr style="overflow-wrap:break-word;"><td class="cl-6cc2e1de"><p class="cl-6cc2d5d6"><span class="cl-6cc1abf2">Atlanta</span></p></td><td class="cl-6cc2e1de"><p class="cl-6cc2d5d6"><span class="cl-6cc1abf2">Georgia</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-6cc2e1de"><p class="cl-6cc2d5d6"><span class="cl-6cc1abf2">Baltimore</span></p></td><td class="cl-6cc2e1de"><p class="cl-6cc2d5d6"><span class="cl-6cc1abf2">Maryland</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-6cc2e1de"><p class="cl-6cc2d5d6"><span class="cl-6cc1abf2">Chicago</span></p></td><td class="cl-6cc2e1de"><p class="cl-6cc2d5d6"><span class="cl-6cc1abf2">Illinois</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-6cc2e1de"><p class="cl-6cc2d5d6"><span class="cl-6cc1abf2">Denver</span></p></td><td class="cl-6cc2e1de"><p class="cl-6cc2d5d6"><span class="cl-6cc1abf2">Colorado</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-6cc2e1de"><p class="cl-6cc2d5d6"><span class="cl-6cc1abf2">Los Angeles</span></p></td><td class="cl-6cc2e1de"><p class="cl-6cc2d5d6"><span class="cl-6cc1abf2">California</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-6cc2e1de"><p class="cl-6cc2d5d6"><span class="cl-6cc1abf2">New York</span></p></td><td class="cl-6cc2e1de"><p class="cl-6cc2d5d6"><span class="cl-6cc1abf2">New York</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-6cc2e1de"><p class="cl-6cc2d5d6"><span class="cl-6cc1abf2">Philadelphia</span></p></td><td class="cl-6cc2e1de"><p class="cl-6cc2d5d6"><span class="cl-6cc1abf2">Pennsylvania</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-6cc2e1de"><p class="cl-6cc2d5d6"><span class="cl-6cc1abf2">San Francisco</span></p></td><td class="cl-6cc2e1de"><p class="cl-6cc2d5d6"><span class="cl-6cc1abf2">California</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-6cc2e1e8"><p class="cl-6cc2d5d6"><span class="cl-6cc1abf2">Seattle</span></p></td><td class="cl-6cc2e1e8"><p class="cl-6cc2d5d6"><span class="cl-6cc1abf2">Washington</span></p></td></tr></tbody></table></div>
```

:::
:::



::: {.cell}

```{.r .cell-code}
fig_clinic_year_overall
```

::: {.cell-output-display}
![](bmin_report_benson_files/figure-html/unnamed-chunk-2-1.png){width=672}
:::
:::


The gap in our measured clinic counts from SAMSHA's official counts is due to a 15-20% non-response rate from DTCs in a given year. Additionally, in 2021, SAMSHA altered the reporting standards and classification of DTCs in the NSSATS survey-- sudden shifts in the number of clinics in the dataset thereafter are seen in the figure above.

### DTC & Crime Distribution: Philadelphia & Seattle

The below example maps show the distribution of violent crimes and DTCs in Philadelphia and Seattle, as well as the variation in residential segregation (measured by the ICE variable). 

::: {.cell}

```{.r .cell-code}
all_layer_map[[12]]
```

::: {.cell-output-display}
![](bmin_report_benson_files/figure-html/philly-map-1.png){width=672}
:::
:::


::: {.cell}

```{.r .cell-code}
all_layer_map[[15]]
```

::: {.cell-output-display}
![](bmin_report_benson_files/figure-html/seattle-map-1.png){width=672}
:::
:::


### Clinic Treatment Status

The below graph shows a sample of n=500 clinics, arranged by treatment status across the years. Clinics in light blue were serving as control units for those becoming treated in a given year (treatment is either opening or closing, depending upon the direction of the model). Dark blue clinics are those which are now post-treatment. White areas are those were the clinic was not in the dataset, due to non-response or post-closure. 

::: {.cell}

```{.r .cell-code}
panelview(violent_count ~ open, # Using the treatment var which allows treatment switching after initial assignment
          data = clinics_open %>% 
            filter(buffer==min(set_units(buffers,"m"))) %>% st_drop_geometry(), 
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

For models assessing opening status, we right-censored clinics once they closed, so that "empty" lots were not contributing data to a treated unit, and similarly for closure models we left-censored clinics before they opened, so that a non-existant clinic was not contributing time to an untreated (still open) clinic.

### Unadjusted Differences: Density within Buffers - Opening

The below figure shows boxplots of the density of violent crimes post- clinic openings, by crime subtype. Given the wide variation and significant skew to the density data, it is presented on the log scale.


::: {.cell}

```{.r .cell-code}
clinics_open %>%
  mutate(period = ifelse(period==0,"Pre-Opening","Post-Opening")) %>%
  filter(time_point %in% seq(-3,3)) %>% # Keep only the 3 years pre and post event
  st_drop_geometry() %>%
  ggplot(aes(x=buffer, y=log(units::drop_units(violent_count/area)), group = buffer, color = buffer)) +
  geom_boxplot() +
  facet_wrap(~period) +
  theme_minimal() +
  labs(
    x = "Buffer",
    y = "log(Crime Density)",
    title = "Crime Density Post-Open\nAll Crimes"
  )
```

::: {.cell-output-display}
![](bmin_report_benson_files/figure-html/unnamed-chunk-3-1.png){width=576}
:::

```{.r .cell-code}
clinics_open %>%
  mutate(period = ifelse(period==0,"Pre-Opening","Post-Opening")) %>%
  filter(time_point %in% seq(-3,3)) %>%
  st_drop_geometry() %>%
  ggplot(aes(x=buffer, y=log(units::drop_units(property_count/area)), group = buffer, color = buffer)) +
  geom_boxplot() +
  facet_wrap(~period) +
  theme_minimal() +
  labs(
    x = "Buffer",
    y = "log(Crime Density)",
    title = "Crime Density Post-Open\nProperty Crimes"
  )
```

::: {.cell-output-display}
![](bmin_report_benson_files/figure-html/unnamed-chunk-3-2.png){width=576}
:::

```{.r .cell-code}
  clinics_open %>%
  mutate(period = ifelse(period==0,"Pre-Opening","Post-Opening")) %>%
  filter(time_point %in% seq(-3,3)) %>%
  st_drop_geometry() %>%
  ggplot(aes(x=buffer, y=log(units::drop_units(person_count/area)), group = buffer, color = buffer)) +
  geom_boxplot() +
  facet_wrap(~period) +
  theme_minimal() +
  labs(
    x = "Buffer",
    y = "log(Crime Density)",
    title = "Crime Density Post-Open\nPersons Crimes"
  )
```

::: {.cell-output-display}
![](bmin_report_benson_files/figure-html/unnamed-chunk-3-3.png){width=576}
:::
:::


### Unadjusted Differences: Density within Buffers - Closures

The below figure shows boxplots of the density of violent crimes post- clinic closures, by crime subtype. Given the wide variation and significant skew to the density data, it is presented on the log scale.


::: {.cell}

```{.r .cell-code}
clinics_close %>%
  mutate(period = ifelse(period==0,"Pre-Closure","Post-Closure")) %>%
  filter(time_point %in% seq(-3,3)) %>%
  st_drop_geometry() %>%
  ggplot(aes(x=buffer, y=log(units::drop_units(violent_count/area)), group = buffer, color = buffer)) +
  geom_boxplot() +
  facet_wrap(~period) +
  theme_minimal() +
  labs(
    x = "Buffer",
    y = "log(Crime Density)",
    title = "Crime Density Post-Closure\nAll Crimes"
  )
```

::: {.cell-output-display}
![](bmin_report_benson_files/figure-html/unnamed-chunk-4-1.png){width=576}
:::

```{.r .cell-code}
clinics_close %>%
  mutate(period = ifelse(period==0,"Pre-Closure","Post-Closure")) %>%
  filter(time_point %in% seq(-3,3)) %>%
  st_drop_geometry() %>%
  ggplot(aes(x=buffer, y=log(units::drop_units(property_count/area)), group = buffer, color = buffer)) +
  geom_boxplot() +
  facet_wrap(~period) +
  theme_minimal() +
  labs(
    x = "Buffer",
    y = "log(Crime Density)",
    title = "Crime Density Post-Closure\nProperty Crimes"
  )
```

::: {.cell-output-display}
![](bmin_report_benson_files/figure-html/unnamed-chunk-4-2.png){width=576}
:::

```{.r .cell-code}
  clinics_close %>%
  mutate(period = ifelse(period==0,"Pre-Closure","Post-Closure")) %>%
  filter(time_point %in% seq(-3,3)) %>%
  st_drop_geometry() %>%
  ggplot(aes(x=buffer, y=log(units::drop_units(person_count/area)), group = buffer, color = buffer)) +
  geom_boxplot() +
  facet_wrap(~period) +
  theme_minimal() +
  labs(
    x = "Buffer",
    y = "log(Crime Density)",
    title = "Crime Density Post-Closure\nPersons Crimes"
  )
```

::: {.cell-output-display}
![](bmin_report_benson_files/figure-html/unnamed-chunk-4-3.png){width=576}
:::
:::


### Unadjusted Differences: Distance to Crime - Clinic Opening

The below graphs show the raw relationships for our other outcome of interest: crime distance by subtype, pre- vs post- opening and closure. While there may be minor differences in absolute volume of crime within each sub-type, the general distribution of crime proximity remains consistent across periods.


::: {.cell}

```{.r .cell-code}
fig_all_crime_density_prepost
```

::: {.cell-output .cell-output-stdout}

```
$fig_all_crime_density_prepost_b393043348047dc7
```


:::

::: {.cell-output-display}
![](bmin_report_benson_files/figure-html/unnamed-chunk-5-1.png){width=672}
:::

::: {.cell-output .cell-output-stdout}

```

$fig_all_crime_density_prepost_7363b6aac40752db
```


:::

::: {.cell-output-display}
![](bmin_report_benson_files/figure-html/unnamed-chunk-5-2.png){width=672}
:::

::: {.cell-output .cell-output-stdout}

```

$fig_all_crime_density_prepost_2cb4e622a276fff9
```


:::

::: {.cell-output-display}
![](bmin_report_benson_files/figure-html/unnamed-chunk-5-3.png){width=672}
:::

::: {.cell-output .cell-output-stdout}

```

$fig_all_crime_density_prepost_fc394cb2c474b151
```


:::

::: {.cell-output-display}
![](bmin_report_benson_files/figure-html/unnamed-chunk-5-4.png){width=672}
:::

::: {.cell-output .cell-output-stdout}

```

$fig_all_crime_density_prepost_f5bc21a1f7849842
```


:::

::: {.cell-output-display}
![](bmin_report_benson_files/figure-html/unnamed-chunk-5-5.png){width=672}
:::

::: {.cell-output .cell-output-stdout}

```

$fig_all_crime_density_prepost_2c9a1e663e68f9a5
```


:::

::: {.cell-output-display}
![](bmin_report_benson_files/figure-html/unnamed-chunk-5-6.png){width=672}
:::
:::


### Unadjusted Differences: T-Tests & Parallel Trends

Below are results from t-tests within each buffered area, comparing the count of violent crimes pre- and post-closure. Consistent differences are not observed at any level, though the confidence interval for the buffer at 548m following clinic opening does suggest an unadjusted increase in crime density further from the clinic. 

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

### Parallel Trends Assessment - Crime Density

The below charts show the assessment of the trend in violent crime density, pre- and post- clinic opening and closure, by city and over-all. In the majority of cases, trends are reasonably flat pre-change, though this does not universally hold within cities. This could present an obstacle to properly identifying the per-city models.

#### Opening, Over-all

::: {.cell}

```{.r .cell-code}
ggplot(data = clinics_open %>%
  filter(time_point %in% seq(-3,3)) %>%
         st_drop_geometry() %>%
         filter(buffer == selected_buffer) %>%
         filter(first_open > 2004), # Excluding those with no pre-open data
       aes(x=time_point,y=violent_count)) +
  stat_summary(geom="ribbon", fun.data=mean_cl_normal, fill=cb_palette[1], alpha = 0.3) +
  stat_summary(geom="line", fun=mean, linetype="dashed") + 
  stat_summary(geom="point",fun=mean, color=cb_palette[1]) +
  geom_vline(xintercept = 0, linetype = "dashed") +
  ylab("Violent Crime Count") +
  xlab("Years Pre/Post Clinic Opening") +
  labs(
    title = "Unadjusted Violent Crime Counts - Pre/Post Opening, 1/4mi Buffer",
    subtitle = "2004-2024, Offers Treatment, Geolocation Score >95%, 5+ Years of Clinic Operation",
    caption = "Data: U.S. Census Bureau, NHGIS, OpenStreetMap, SAMSHA"
  ) +
  theme_clean()
```

::: {.cell-output-display}
![](bmin_report_benson_files/figure-html/unnamed-chunk-8-1.png){width=672}
:::
:::


#### Opening, By City

::: {.cell}

```{.r .cell-code}
# By City
ggplot(data = clinics_open %>%
  filter(time_point %in% seq(-3,3)) %>%
         filter(buffer == selected_buffer) %>%
         filter(first_open > 2004),
       aes(x=time_point,y=violent_count)) +
  stat_summary(geom="ribbon", fun.data=mean_cl_normal, fill=cb_palette[1], alpha = 0.3) +
  stat_summary(geom="line", fun=mean, linetype="dashed") + 
  stat_summary(geom="point",fun=mean, color=cb_palette[1]) +
  geom_vline(xintercept = 0, linetype = "dashed") +
  facet_wrap(~city, scales = "free_y") +
  ylab("Violent Crime Count") +
  xlab("Years Pre/Post Clinic Opening") +
  labs(
    title = "Unadjusted Violent Crime Counts - Pre/Post Opening, 1/4mi Buffer",
    subtitle = "2004-2024, Offers Treatment, Geolocation Score >95%, 5+ Years of Clinic Operation",
    caption = "Data: U.S. Census Bureau, NHGIS, OpenStreetMap, SAMSHA"
  ) +
  theme_clean()
```

::: {.cell-output-display}
![](bmin_report_benson_files/figure-html/unnamed-chunk-9-1.png){width=672}
:::
:::


#### Closure, Over-all

::: {.cell}

```{.r .cell-code}
# Count of crimes by year pre/post clinic closure, 1/4mi buffer
# Over-all
ggplot(data = clinics_close %>%
    filter(time_point_closure %in% seq(-3,3)) %>%
         filter( buffer == selected_buffer),
       aes(x=time_point_closure,y=violent_count)) +
  stat_summary(geom="ribbon", fun.data=mean_cl_normal, fill=cb_palette[1], alpha = 0.3) +
  stat_summary(geom="line", fun=mean, linetype="dashed") + 
  stat_summary(geom="point",fun=mean, color=cb_palette[1]) +
  geom_vline(xintercept = 0, linetype = "dashed") +
  ylab("Violent Crime Count") +
  xlab("Years Pre/Post Clinic Closure") +
  labs(
    title = "Unadjusted Violent Crime Counts - Pre/Post Closure, 1/4mi Buffer",
    subtitle = "2004-2024, Offers Treatment, Geolocation Score >95%, 5+ Years of Clinic Operation",
    caption = "Data: U.S. Census Bureau, NHGIS, OpenStreetMap, SAMSHA"
  ) +
  theme_clean()
```

::: {.cell-output-display}
![](bmin_report_benson_files/figure-html/unnamed-chunk-10-1.png){width=672}
:::
:::


#### Closure, By City

::: {.cell}

```{.r .cell-code}
# By City
ggplot(data = clinics_close %>%
    filter(time_point_closure %in% seq(-3,3)) %>%
         filter( buffer == selected_buffer),
       aes(x=time_point_closure,y=violent_count)) +
  stat_summary(geom="ribbon", fun.data=mean_cl_normal, fill=cb_palette[1], alpha = 0.3) +
  stat_summary(geom="line", fun=mean, linetype="dashed") + 
  stat_summary(geom="point",fun=mean, color=cb_palette[1]) +
  geom_vline(xintercept = 0, linetype = "dashed") +
  facet_wrap(~city, scales = "free_y") +
  ylab("Violent Crime Count") +
  xlab("Years Pre/Post Clinic Closure") +
  labs(
    title = "Unadjusted Violent Crime Counts - Pre/Post Closure, 1/4mi Buffer",
    subtitle = "2004-2024, Offers Treatment, Geolocation Score >95%, 5+ Years of Clinic Operation",
    caption = "Data: U.S. Census Bureau, NHGIS, OpenStreetMap, SAMSHA"
  ) +
  theme_clean()
```

::: {.cell-output-display}
![](bmin_report_benson_files/figure-html/unnamed-chunk-11-1.png){width=672}
:::
:::


### Parallel Trends Assessment - Median Distance from DTC

The below charts show the assessment of the trend in violent crime distance from each DTC, pre- and post- clinic opening and closure, by city and over-all. In the majority of cases, trends are also reasonably flat pre-change, though this does not universally hold within cities, similare to density models.

#### Opening, Over-all

::: {.cell}

```{.r .cell-code}
ggplot(data = clinics_open %>%
  filter(time_point %in% seq(-3,3)) %>%
         st_drop_geometry() %>%
         filter(buffer == selected_buffer) %>%
         filter(first_open > 2004), # Excluding those with no pre-open data
       aes(x=time_point,y=violent_median_distance)) +
  stat_summary(geom="ribbon", fun.data=mean_cl_normal, fill=cb_palette[1], alpha = 0.3) +
  stat_summary(geom="line", fun=mean, linetype="dashed") + 
  stat_summary(geom="point",fun=mean, color=cb_palette[1]) +
  geom_vline(xintercept = 0, linetype = "dashed") +
  ylab("Violent Crime Distance") +
  xlab("Years Pre/Post Clinic Opening") +
  labs(
    title = "Unadjusted Violent Crime Distance - Pre/Post Opening, 1/4mi Buffer",
    subtitle = "2004-2024, Offers Treatment, Geolocation Score >95%, 5+ Years of Clinic Operation",
    caption = "Data: U.S. Census Bureau, NHGIS, OpenStreetMap, SAMSHA"
  ) +
  theme_clean()
```

::: {.cell-output-display}
![](bmin_report_benson_files/figure-html/unnamed-chunk-12-1.png){width=672}
:::
:::


#### Opening, By City

::: {.cell}

```{.r .cell-code}
# By City
ggplot(data = clinics_open %>%
  filter(time_point %in% seq(-3,3)) %>%
         filter(buffer == selected_buffer) %>%
         filter(first_open > 2004),
       aes(x=time_point,y=violent_median_distance)) +
  stat_summary(geom="ribbon", fun.data=mean_cl_normal, fill=cb_palette[1], alpha = 0.3) +
  stat_summary(geom="line", fun=mean, linetype="dashed") + 
  stat_summary(geom="point",fun=mean, color=cb_palette[1]) +
  geom_vline(xintercept = 0, linetype = "dashed") +
  facet_wrap(~city, scales = "free_y") +
  ylab("Violent Crime Distance") +
  xlab("Years Pre/Post Clinic Opening") +
  labs(
    title = "Unadjusted Violent Crime Distance - Pre/Post Opening, 1/4mi Buffer",
    subtitle = "2004-2024, Offers Treatment, Geolocation Score >95%, 5+ Years of Clinic Operation",
    caption = "Data: U.S. Census Bureau, NHGIS, OpenStreetMap, SAMSHA"
  ) +
  theme_clean()
```

::: {.cell-output .cell-output-stderr}

```
Warning: Removed 1260 rows containing non-finite outside the scale range
(`stat_summary()`).
Removed 1260 rows containing non-finite outside the scale range
(`stat_summary()`).
Removed 1260 rows containing non-finite outside the scale range
(`stat_summary()`).
```


:::

::: {.cell-output-display}
![](bmin_report_benson_files/figure-html/unnamed-chunk-13-1.png){width=672}
:::
:::


#### Closure, Over-all

::: {.cell}

```{.r .cell-code}
# Count of crimes by year pre/post clinic closure, 1/4mi buffer
# Over-all
ggplot(data = clinics_close %>%
    filter(time_point_closure %in% seq(-3,3)) %>%
         filter( buffer == selected_buffer),
       aes(x=time_point_closure,y=violent_median_distance)) +
  stat_summary(geom="ribbon", fun.data=mean_cl_normal, fill=cb_palette[1], alpha = 0.3) +
  stat_summary(geom="line", fun=mean, linetype="dashed") + 
  stat_summary(geom="point",fun=mean, color=cb_palette[1]) +
  geom_vline(xintercept = 0, linetype = "dashed") +
  ylab("Violent Crime Distance") +
  xlab("Years Pre/Post Clinic Closure") +
  labs(
    title = "Unadjusted Violent Crime Distance - Pre/Post Closure, 1/4mi Buffer",
    subtitle = "2004-2024, Offers Treatment, Geolocation Score >95%, 5+ Years of Clinic Operation",
    caption = "Data: U.S. Census Bureau, NHGIS, OpenStreetMap, SAMSHA"
  ) +
  theme_clean()
```

::: {.cell-output-display}
![](bmin_report_benson_files/figure-html/unnamed-chunk-14-1.png){width=672}
:::
:::


#### Closure, By City

::: {.cell}

```{.r .cell-code}
# By City
ggplot(data = clinics_close %>%
    filter(time_point_closure %in% seq(-3,3)) %>%
         filter( buffer == selected_buffer),
       aes(x=time_point_closure,y=violent_median_distance)) +
  stat_summary(geom="ribbon", fun.data=mean_cl_normal, fill=cb_palette[1], alpha = 0.3) +
  stat_summary(geom="line", fun=mean, linetype="dashed") + 
  stat_summary(geom="point",fun=mean, color=cb_palette[1]) +
  geom_vline(xintercept = 0, linetype = "dashed") +
  facet_wrap(~city, scales = "free_y") +
  ylab("Violent Crime Distance") +
  xlab("Years Pre/Post Clinic Closure") +
  labs(
    title = "Unadjusted Violent Crime Distance - Pre/Post Closure, 1/4mi Buffer",
    subtitle = "2004-2024, Offers Treatment, Geolocation Score >95%, 5+ Years of Clinic Operation",
    caption = "Data: U.S. Census Bureau, NHGIS, OpenStreetMap, SAMSHA"
  ) +
  theme_clean()
```

::: {.cell-output-display}
![](bmin_report_benson_files/figure-html/unnamed-chunk-15-1.png){width=672}
:::
:::


### GLMM Model Results - **Opening**

::: {.cell}

:::


Below are summary results from the exploratory GLMM models for opening and closure, adjusting for neighborhood social disadvantage and residential segregation. Models predicting density directly predicted crime counts, with a log-offset for the area of the buffer in which the crimes were counted.

In models predicting crime density, neighborhood characteristics were strongly associated with crime, with ICE and NDS having opposite individual effects, where in distance-based models these variable had similar effect directions and scales. 

Across all preliminary models, none of the time-varying effects pre- or post- clinic operation showed a significant relationship with crime density or distance.

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
         title = 'GLMM\nPre/Post Opening vs Crime Density') + 
          geom_vline(xintercept = 0, color = 'orange', alpha = 0.6) +
    scale_color_brewer(palette = "Dark2")
```

::: {.cell-output-display}
![](bmin_report_benson_files/figure-html/unnamed-chunk-18-1.png){width=672}
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
         title = 'GLMM\nPre/Post Opening vs Crime Distance') + 
          geom_vline(xintercept = 0, color = 'orange', alpha = 0.6) +
    scale_color_brewer(palette = "Dark2")
```

::: {.cell-output-display}
![](bmin_report_benson_files/figure-html/unnamed-chunk-21-1.png){width=672}
:::
:::

:::

### GLMM Model Results - **Closure**

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
         title = 'GLMM\nPre/Post Closure vs Crime Density') + 
          geom_vline(xintercept = 0, color = 'orange', alpha = 0.6) +
    scale_color_brewer(palette = "Dark2")
```

::: {.cell-output-display}
![](bmin_report_benson_files/figure-html/unnamed-chunk-24-1.png){width=672}
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
         title = 'GLMM\nPre/Post Closure vs Crime Distance') + 
          geom_vline(xintercept = 0, color = 'orange', alpha = 0.6) +
    scale_color_brewer(palette = "Dark2")
```

::: {.cell-output-display}
![](bmin_report_benson_files/figure-html/unnamed-chunk-27-1.png){width=672}
:::
:::

:::

### Difference-in-Difference

Below I present the main findings from the difference-in-difference analysis, comparing not-yet-treated units to newly opened or closed DTCs in a given year, and evaluating group time averaged treatment effects within 3 years of the change point.

#### Distance

::: {.cell}

```{.r .cell-code}
dist_forest
```

::: {.cell-output-display}
![](bmin_report_benson_files/figure-html/unnamed-chunk-28-1.png){width=672}
:::
:::


In distance-based models, in aggregate, there is no significant relationship observed between DTC operation and violent crime, by any subtype.

#### Distance - By City

::: {.cell}

```{.r .cell-code}
dist_forest_city
```

::: {.cell-output-display}
![](bmin_report_benson_files/figure-html/unnamed-chunk-29-1.png){width=672}
:::
:::


Within cities, there is variation in effect. NYC and Atlanta, for exmaple, suggest protective associations with DTC opening for crimes against persons and property, while Denver and Philadelphia suggest increases in crimes against persons (as measured by a decrease in proximity to the DTC).

#### Density

::: {.cell}

```{.r .cell-code}
buffer_forest
```

::: {.cell-output-display}
![](bmin_report_benson_files/figure-html/unnamed-chunk-30-1.png){width=672}
:::
:::


For density-based models, only one model resulted in a "significant" effect-- there was an increase in crime density against persons further from drug treatment centers following an opening event, approximately 740m away.

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
![](bmin_report_benson_files/figure-html/unnamed-chunk-31-1.png){width=672}
:::
:::


City-based density models show more variation in effect, with the majority of "significant" (e.g. non-overlapping confidence intervals) differences appearing further from DTCs, and suggesting a protective association (decreases in density following an opening event, and increases following a closure event), though the marked intra-city variation between buffers (often entirely reversing the sign of the effect) raises suspicion over the reliability of the results at this granular level. 

## Conclusions
### Primary Findings

We identified substantial growth in DTC availability in U.S. cities from 2004 to 2024, reflecting previously identified trends towards increased accessibility to these services. Neighborhoods with greater social disadvantage had higher levels of violent crime, with strong associations identified between the Index of Concentration at the Extremes, and the Neighborhood Disadvantage Score.

In aggregate, across all cities and years, we found **no consistent significant relationship** between DTC operation and violent crime, crimes against persons, or crimes against property.

City-level estimates are more varied, but generally were in agreement with pooled models. Most cities had no significant relationship by either measure, though NYC and Atlanta showed mixed protective associations with DTC opening, while Denver and Philadelphia showed potential positive associations when measured via Euclidean distance, and negative to null associations when measured with buffered-density.

## Limitations, Future Directions

As these data were all collected for administrative purposes, it is possible that inferences drawn from them may not be accurate. Causal inference especially is dependent upon assumed parallel trends in a difference in differences model, which, while it appeared to hold in this case, is an important implicit assumption. Correction for multiple comparisons in confidence interval selection is needed for future modeling, as there were nearly 700 models fit across the varied comparisons presented.

Social covariates were treated as uniform across time (2005 starting estimates)-- incorporating additional years of ACS data would allow for more accurate incorporation of time-varying community covariates in the GLMM models. 

For our outcome measures, Euclidean distance measurements may not accurately reflect street-network based travel times due to non-residential blocks, geographic restrictions, and other unobserved sources of error. Incorporation of street network distance using a system like Openroutingservice or OpenSourceRoutingMachine would aid in this.

Lastly, spatial autocorrelation should be addressed using k-means clustered nearest neighbor crime values in order to reduce the spillover effects from nearby DTCs in our models, which are currently treated as operating in a vacuum, presenting the possibility for crime observations to be "double counted" in densely populated areas.

## References

::: {#refs}
:::