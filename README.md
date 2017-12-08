# BMIN503/EPID600 Final Project

This repository contains templates for your final written report and GitHub repository. Follow the instructions below to clone this repository, and then turn in your final project's code via a pull request to this repository.

1. To start, [**fork** this BMIN503_Final_Project repository][forking].
1. [**Clone**][ref-clone] the forked repository to your computer.
1. Modify the files provided, add your own, and [**commit**][ref-commit] changes to complete your final project.
1. [**Push**][ref-push]/sync the changes up to your GitHub account.
1. [Create a **pull request**][pull-request] on this, the original BMIN503_Final_Project, repository to turn in your final project.

S Pierson Repository 
Using data obtained from ACCELERATE, the first-ever Castleman disease natural history registry and from the siltuximab clinical trial, this project aims to characterize Castleman disease patients and to identify the characteristics of siltuximab responders vs. non-responders. 

Resposity contains:
1. README.md file to list the datafiles and RMD program files used in this project
2. final_project_template.Rmd contains code for cleaning data, reporting results, and reporting conclusions 
3. Due to inability to share data on github, datafiles will be emailed separately. Datafiles include the following:
-Datasets from the ACCELERATE Registry: 
Name: Description
1. reg_elig: Includes the relevant eligibility data, e.g. diagnosis, date of diagnosis
2. reg_dem: Includes relevant demographic data captured through registry
3. reg_clin: Clinical data collected to date
4. reg_path: Diagnostic pathology data collected to date
5. reg_lab: Lab data collected to date
6. reg_med: Lists all medications used for Castleman treatment and associates each medication with its respective regimen as created during data entry. Each medication has a regimen_id which links the medication to the response dataset 
7. reg_response: This dataset reports the regimen response and is linked to the reg_med dataset through a regimen ID (allowing regimen response to be linked to drugs used in a regimen)
8. lab_type: Listing of all lab test types collected in the registry to associate the lab test types in the with their name

-Datasets from the Siltuximab Trial: 
name: Description
1. screening: This dataset includes the screening data, including the treatment arm and patient-level characteristics (e.g. age, race, sex) 
2. efficacy: Includes the parameters of response and response. The parameter used for analysis was "Durable tumor and symptomatic response during blinded treatment period by independent review"  
3. clinical: Includes clinical data collected during the clinical trial 
4. labs: Includes laboratory data collected during the clinical trial 

DUE DATE FOR FINAL VERSION: 12/8/17 11:59PM. This is a hard deadline. Turn in whatever you have by this date.


<!-- Links -->
[forking]: https://guides.github.com/activities/forking/
[ref-clone]: http://gitref.org/creating/#clone
[ref-commit]: http://gitref.org/basic/#commit
[ref-push]: http://gitref.org/remotes/#push
[pull-request]: https://help.github.com/articles/creating-a-pull-request



