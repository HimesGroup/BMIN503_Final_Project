## BMIN503/EPID600 Project: Structural Brain Imaging Biomarker for Traumatic Brain Injury
### by Elizabeth Mamourian

 
This project investigates the structural brain abnormality resulting from traumatic brain injury (TBI), 
specifically probing for a reliable measure to quantify the severity of TBI, which is agnostic to 
the type and location of the trauma. The aim is to quantify structural brain volumes, to identify 
regions with disease-related atrophy, and to compare the relative distribution of brain volume in 
TBI stubjects against normal controls.
 
The data used are volumetric measurements of brain regions of interest, based on a multi atlas 
segmentation method. All results are shown based on the absolute volumetric measure
and the volume normalized by intracranial volume. Z-scores for each ROI are calculated using
and age and sex matched normal control group, and applied to the case subjects, to see how
the disease affects cases in comparison to normal controls. 
    
In order to run the code, please download five files from the submodule at
`https://github.com/mamourie/BMIN503_Final_Project/Data/`
   
1 "df_z_503.csv"      
2 "df_z_icv_503.csv"      
3 "df_z_ctrl_503.csv"      
4 "df_z_ctrl_icv_503.csv"      
5 "doc_MUSE_ROI_Dictionary.csv"       

Set the variable `home` to your local directory where those data files are saved.

Additional Notes for Running `final_project_mamourian.Rmd`:
- the variable `fromBeginning` is set to FALSE.         
This will skip the data preparation, and run the code to visualize results, 
using the provided de-identified data files.



