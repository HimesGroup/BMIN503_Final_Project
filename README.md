# BMIN503/EPID600 Final Project\

# Project setup
The project aims to design protein circuits that can sense clusters of diseased proteins to cause targeted cell death. The data analyzed here are collected based on cell apoptosis after cells being transfected with different apoplectic constructs at various time points. The goal of this project is to determine the optimal protein circuit design to engineer cell death in cancerous cells. 


Source data: Split TEV Cry2.csv
Variables: 
- Time: time point when the cells were imaged 
  t = 0/2/6/8/12 hrs 

- Plasmid: 
  split TEV-PC3
  TEV trunc
  TEV trunc TEVcsQ
  TEV trunc TEVcsL
  TEV trunc TEVcsM
  Cry2-GFP
  
- Fluorescent Channels: 
  mCherry
  mCherry+DAPI
  mCherry+FITC
  mCherry+FITC+DAPI
  
- Treatments: 
  base 
  stimulated (stimulated with FITC)
  
- Experiment setup: 
  -Cells stimulated with FITC are hypothesized to express the transfected constructs which would lead to cell apoptosis. 
  -mCherry - apoptosis circuit is activated 
  -DAPI: cell nuclei
  -FITC: cry2 - to stimulate the death circuit to start 


DUE DATE FOR FINAL VERSION: 12/10/21 11:59PM. This is a hard deadline. Turn in whatever you have by this date.


<!-- Links -->
[forking]: https://guides.github.com/activities/forking/

