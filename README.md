# BMIN503/EPID600 Final Project
## Student Alcohol Consumption Project

This repository contains a R script used to solve the student alcohol consumption problem provided in [https://www.kaggle.com/uciml/student-alcohol-consumption](https://www.kaggle.com/uciml/student-alcohol-consumption)

## Introduction
Despite laws banning teenagers from drinking alcohol until they are adults, teenage binge drinking is still a common problem. This study was designed to see if drinking alcohol among teenagers had any adverse effects on them.

The data were obtained in a survey of students math and Portuguese language courses in secondary school. It contains a lot of interesting social, gender and study information about students, especially their alcohol consumption. I would like to use it for finding out the most important factor that related to the students final grade. To see if teen binge drinking has a negative impact on their learning performance. And create a prediction model to predict the student's final score. This problem is related to education, statistic and computer science. Solving it needs a clear and thorough understanding about semantics, regression model as well as solid programming skills. I will apply multiple regression models that we learned in this course and rigorous data pre-processing, multifaceted validation to get a persuasive result.

## Required Packages
- ggplot2
- RColorBrewer

## Files Explanation
- student-mat.csv ：raw data in math course.
- student-por.csv ：raw data in portuguese course.
- data_description.txt ：features description file.

## Important Variables Explanation
- school : student's school (binary: 'GP' - Gabriel Pereira or 'MS' - Mousinho da Silveira)
- sex : student's sex (binary: 'F' - female or 'M' - male)
- age : student's age (numeric: from 15 to 22)
- address : student's home address type (binary: 'U' - urban or 'R' - rural)
- famsize : family size (binary: 'LE3' - less or equal to 3 or 'GT3' - greater than 3)
- Pstatus : parent's cohabitation status (binary: 'T' - living together or 'A' - apart)
- Medu : mother's education (numeric: 0 - none, 1 - primary education (4th grade), 2 – 5th to 9th grade, 3 – secondary education or 4 – higher education)
- Fedu : father's education (numeric: 0 - none, 1 - primary education (4th grade), 2 – 5th to 9th grade, 3 – secondary education or 4 – higher education)
- Mjob : mother's job (nominal: 'teacher', 'health' care related, civil 'services' (e.g. administrative or police), 'at_home' or 'other')
- Fjob : father's job (nominal: 'teacher', 'health' care related, civil 'services' (e.g. administrative or police), 'at_home' or 'other')
- reason : reason to choose this school (nominal: close to 'home', school 'reputation', 'course' preference or 'other')
- guardian : student's guardian (nominal: 'mother', 'father' or 'other')
- traveltime : home to school travel time (numeric: 1 - <15 min., 2 - 15 to 30 min., 3 - 30 min. to 1 hour, or 4 - >1 hour)
- studytime : weekly study time (numeric: 1 - <2 hours, 2 - 2 to 5 hours, 3 - 5 to 10 hours, or 4 - >10 hours)
- failures : number of past class failures (numeric: n if 1<=n<3, else 4)
- schoolsup : extra educational support (binary: yes or no)
- famsup : family educational support (binary: yes or no)
- paid : extra paid classes within the course subject (Math or Portuguese) (binary: yes or no)
- activities : extra-curricular activities (binary: yes or no)
- nursery : attended nursery school (binary: yes or no)
- higher : wants to take higher education (binary: yes or no)
- internet : Internet access at home (binary: yes or no)
- romantic : with a romantic relationship (binary: yes or no)
- famrel : quality of family relationships (numeric: from 1 - very bad to 5 - excellent)
- freetime : free time after school (numeric: from 1 - very low to 5 - very high)
- goout : going out with friends (numeric: from 1 - very low to 5 - very high)
- Dalc : workday alcohol consumption (numeric: from 1 - very low to 5 - very high)
- Walc : weekend alcohol consumption (numeric: from 1 - very low to 5 - very high)
- health : current health status (numeric: from 1 - very bad to 5 - very good)
- absences : number of school absences (numeric: from 0 to 93)

These grades are related with the course subject, Math or Portuguese:
- G1 : first period grade (numeric: from 0 to 20)
- G2 : second period grade (numeric: from 0 to 20)
- G3 : final grade (numeric: from 0 to 20, output target)

Additional note: there are several (382) students that belong to both datasets . 
These students can be identified by searching for identical attributes
that characterize each student, as shown in the annexed R file.


## Source Information

P. Cortez and A. Silva. Using Data Mining to Predict Secondary School Student Performance. In A. Brito and J. Teixeira Eds., Proceedings of 5th FUture BUsiness TEChnology Conference (FUBUTEC 2008) pp. 5-12, Porto, Portugal, April, 2008, EUROSIS, ISBN 978-9077381-39-7.

Fabio Pagnotta, Hossain Mohammad Amran. 
Email:fabio.pagnotta@studenti.unicam.it, mohammadamra.hossain '@' studenti.unicam.it 
University Of Camerino

[https://archive.ics.uci.edu/ml/datasets/STUDENT+ALCOHOL+CONSUMPTION](https://archive.ics.uci.edu/ml/datasets/STUDENT+ALCOHOL+CONSUMPTION)
