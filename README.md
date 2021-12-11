# BMIN503/EPID600 Final Project - Jiayu Li
## Prediction of the Stock Price of Four Medical Device Company in COVID-19 Pandemic
## Overview
This project will examine the effect of COVID-19 cases and resulting mortality rate with the performance of four different leading medical device during this Global Pandemic. The performance of each individual company will be measured based on their stock price due to limited access to confidential sales data.  The companies selected are Medtronic, Boston Scientific, Stryker, and Zimmer Biomet. The stock price data for these four companies are obtained from Yahoo Finance and the COVID_19 cases in US are based on the data published by the Johns Hopkins University.  Linear regression and random forest have been used in the project. The models are trained and tested based on the stock prices and Covid – 19 cases in 2020 and the prediction of the four companies’ performance are made using COVID_19 cases and mortality rate in 2021. Comparisons of the predicted stock prices of the four companies with the actual stock prices have been conducted. Based on the analysis, it is clear that except for the Zimmer Biomet stock with the 2020 mortality rate shows limited significance, the COVID-19 cases and mortality rate are significant to the stock prices of all four companies in 2020 and all models have low RMSE. However, the prediction of 2021 is not as accurate as the reality and may indicate that people and business are more adept or more confident towards the pandemic since the vaccination rate is ramping up so their performance or stock price are more reluctant to change along with the cases and death mortality change in 2021.
## Contents of Repository
1. BMIN503_Final_Project.Rproj - R Project File
2. BSX.csv - Boston Scientific 2020 Stock Data
3. BSX2021.csv - Boston Scientific 2021 Stock Data
4. Country.csv - US COVID-19 Date (Johns Hopkins University)
5. MDT.csv - Medtronic 2020 Stock Data
6. MDT2021.csv - Medtronic 2021 Stock Data
7. MRNA.csv - Moderna 2020 Stock Data
8. SYK.csv - Stryker 2020 Stock Data
9. SYK2021.csv - Stryker 2021 Stock Data
10. ZBH.csv - Zimmer Biomet 2020 Stock Data
11. ZBH2021.csv - Zimmer Biomet 2021 Stock Data
12. final_project_JL.Rmd - Source Code
13. final_project_JL.html - knitted HTML file
14. README.md - this file
## Required Package
1. dplyr
2. ggplot2
3. randomForest
4. caret
