This project aims to clean and access protein crystal 
structure data that comes from deposited structures in 
the Protein Data Bank. The analysis goal is to identify
disulfide bonds formed in the protein structure based
on the proximity of cysteine residues in the protein. 
When 2 cysteines are close enough together, they form a
very strong bond (disulfide bond), and these are interesting
bonds because they increase the stability of proteins. 
From the Protein Data Bank, files can be downloaded as 
.pdb files and opened as .txt files, which is the preferred
format for this project code's input.

This project contains the following files:

1. README.txt
This file.

2. 1igt_clean.txt
This is the protein crystal structure file containing 
all of the coordinate data required for analysis. This
is the crystal structure for the IgG2a monoclonal antibody.
The link to this structure in the database is given here:
https://www.rcsb.org/structure/1igt

3. PDB Analysis.Rmd
This is the main RMD file that does the data cleanup and
analysis. Currently there is mostly just data cleaning
and organizing into structures that will be useful for 
the analysis portion of the project. I expect the cleaning
portion to be more extensive than the analysis portion, although
it is possible to keep optimizing the analysis. 

4. PDB Analysis.html
The knitted version of PDB Analysis.Rmd.