<h3 align="left">

BMIN503 Final Project - A brief epidemiologic examination of selected communicable diseases in the state of California

</h3>


For my final project, I am looking at trends in the case counts and rates of selected [infectious diseases reported in California](https://catalog.data.gov/dataset/infectious-diseases-by-disease-county-year-and-sex-d8912) from 2001 to 2021. California regulations require cases of [selected communicable diseases](https://www.cdph.ca.gov/Programs/CID/DCDC/CDPH%20Document%20Library/ReportableDiseases.pdf) to be reported to the California Department of Public Health (CDPH); CDPH work with and local health departments to monitor cases and to identify, control, and prevent infections. Broadly, I want to see if there is a increase in the number of cases for the Top 3 communicable diseases in the past two decades and assess their longitudinal trends over the years as well as looking at how cases are distributed spatially to identify potential hotspots. I spoke with two DBEI faculties (Quy Cao and Haochang Shou), as well as my coworker who is a wonderful data analyst. They provided valuable feedback on what to include, data visualizations, and coding. As well as asking questions that helped me dive a bit deeper into the dataset (e.g., doing more background research on the diseases, identifying potential reasons for increasing cases, and how surveillance aids decision-making). Overall, I had fun working with this dataset and hope to continue the analysis in the future by including more socioeconomic factors and running predictive models. The final project was a great exercise to utilize and apply all the R knowledge I gained this semester, as well as allowing me to use actual surveillance dataset to see how data can be used to inform decision-making.

Using the data, I want to answer a few **key questions**:

1.  What are the most common reportale communicable diseases in California from 2001-2021?
2.  What are the longitudinal trends of those diseases?
3.  How are cases distributed geographically and how can we use that information to inform decision-making?


#### Repository organization 

-   **BMIN5030_FinalProject_FLiu.pptx**: Slide-deck for in-class presentation.

-   **final_project_FangLiu.qmd/html**:  R markdown for all analysis performed. 

-   **README.md/html**: Markdown for this readme file.

-   **/data**: sub-directory containing the dataset used for the project, as well as a data dictionary describing the variables. 

Unlike in the past where surveillance systems are fairly simple and only consists of filling out paper forms, surveillance nowadays can be very complex. We need to capture standardized data from health system, package the data in a structured format, transport the messages between systems, quality-check the data, unpack/transform the data, and use the data for visualization and analysis. The figure below shows the data flow for nationally notifiable diseases that are reported to CDC by state health agencies, note the various systems needed for surveillance. ![](surveillance.png)
