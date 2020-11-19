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
    
In order to run the code, please download five files from the `https://github.com/mamourie/BMIN503_Final_Project/Data/`submodule 
   
1 "df_z_503.csv"      
2 "df_z_icv_503.csv"      
3 "df_z_ctrl_503.csv"      
4 "df_z_ctrl_icv_503.csv"      
5 "doc_MUSE_ROI_Dictionary.csv"       

Set the variable `home` to your local directory where those data files are saved.

At the beginning of the Rmd chunk in `final_project_template.Rmd` called `data_prep`, the variable called `fromBeginning` is set to FALSE.       
This allows you to view the code for data preparation, and also to run the code to visualize results, using the provided data files.




___________________________________________________________________________________________________________

> Modify the files provided, add your own, and **commit** changes to complete your final project.
> **Push**/sync the changes up to your GitHub account.
> Create a **pull request** on this, the original BMIN503_Final_Project, repository to turn in your final project.

DUE DATE FOR FINAL VERSION: 12/11/20 11:59PM. This is a hard deadline. Turn in whatever you have by this date.


<!-- Links -->
[forking]: https://guides.github.com/activities/forking/

