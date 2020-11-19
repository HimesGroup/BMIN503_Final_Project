# BMIN503/EPID600 Final Project_Oppenheimer

## About the Data

### Data Sources
Three different data sources have been linked to generate this data set:

1. Virtual Driving Test (VDT) data from Diagnostic Driving, Inc.
- Before the drivers license applicants take their On-Road Exam (ORE), they are encouraged to take a VDT, available on a computer at the testing center (see Figures 1 & 2), which assesses their driving skills on a virtual course.

![Figure 1: VDT workstation](G:\My Drive\BMIN 503\Workstation.jpg)
![Figure 2: VDT in Action](G:\My Drive\BMIN 503\VDT Setup.png)


2. Licensing data from the Ohio Bureau of Motor Vehicles (OBMV)
The OBMV Business Application Services System (BASS) utilizes two systems to collect data about applicants and drivers in Ohio
* the DX system, 35 tables that house all information about Ohioans *before* they receive a full drivers license.
* the DL system, 102 tables that house all information about Ohioans *starting at* the time of licensure.

3. Police-reported crash data from the Ohio Department of Public Safety (ODPS) which is organized by year into three tables
* Crash event, which houses all variables related to crash-level information
* Vehicle, which houses all variables related to each vehicle involved in the crash
* Person, which houses all variables related to each individual involved in the crash

### Data Linkage
1. From VDT: users are required to input a unique “ID number” which they receive from the BMV. 
2. From BASS: the VDT "ID Number" lives in the OBMV BASS as variable "CustomerID". BASS also houses each customers unique drivers license number. By linking VDT "ID number" and BASS "CustomerID", we joined information about customers including demographics, VDT results, and ORE results.
3. From ODPS: crash data was linked to unique Customer IDs by drivers license number in the BASS through an honest brokering process.

**Note:** Crash data was only joined for drivers who had been issued a full drivers license.

**Note:** The data from the state of Ohio was shared under an extremely limiting MOU between the Ohio Traffic Safety Office (OTSO) and CHOP and cannot be shared outside of the organization. My team is working on some "dummy data" to make this code runnable without violating our data use agreement.







Ignore:

Instructions (for reference)

This repository contains templates for your final written report and GitHub repository. Follow the instructions below to clone this repository, and then turn in your final project's code via a pull request to this repository.

1. Modify the files provided, add your own, and **commit** changes to complete your final project.
1. **Push**/sync the changes up to your GitHub account.
1. Create a **pull request** on this, the original BMIN503_Final_Project, repository to turn in your final project.
