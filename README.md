# EPID600 Final Project: Wearable Heart Rate Monitors by Avantika Diwadkar

This repository is dedicated to my project on wrist worn heart rate monitors for the final project of EPID 600: Data Science for Biomedical Informatics at University of Pennsylvania.The main focus of this project is to investigate the use of commercial wearables as possible patient monitoring devices by testing the precision of heart rate measurement by a wrist worn heart rate monitor (FitBit) against a portable ECG-based heart rate computer (Bitalino). The project work flow involves device setup, data acquisition, data extraction, data cleaning and conversion followed by a statistical analysis involving one sample t-test, pearson correlation, accuracy percentage and quantification of data points by Histograms, boxplots and Bland Altman plots. The softwares used are OpenSignals for acquiring data from Bitalino device and Kubios software to convert ECG in volts to RR interval. 

The repository consist of the following files -

1) heart_rate_monitors.Rmd : This is the main project file with description and all the R code.

2) heart_rate_monitors.html: This is the html version of the same file.

3) sample1.txt - The ECG output from the Bitalino OpenSignals software for the Sample1.

4) sample2.txt - The ECG output from the Bitalino OpenSignals software for the Sample2.

5) ecgdata1.txt - The ECG raw output converted to Volts using transfer function for Sample 1. This was the input file for Kubios software.

6) ecgdata2.txt - The ECG raw output converted to Volts using transfer function for Sample 2. This was the input file for Kubios software.

7) ecgdata2.csv - The ecgdata2.txt file in csv format to be used for visualization by signal processing in the code given in the Rmd file.

8) ecghrv1.csv - This is the output file from Kubios for Sample 1 with the RR intervals. This was used to calculate beats per minute.

9) ecghrv2.csv - This is the output file from Kubios for Sample 2 with the RR intervals. This was used to calculate beats per minute.

Collaborators:
Jeff Pennington, Department of Biomedical and Health Informatics, Children's Hospital of Philadelphia

<!-- Links -->
[forking]: https://guides.github.com/activities/forking/
[ref-clone]: http://gitref.org/creating/#clone
[ref-commit]: http://gitref.org/basic/#commit
[ref-push]: http://gitref.org/remotes/#push
[pull-request]: https://help.github.com/articles/creating-a-pull-request
