# BMIN503/EPID600 Final Project: Using Childhood and Adulthood Stress Factors as Predictors for Nicotine Use

Katie Cardone

## Respository Organization

This repository contains QMD, HTML, and README files for my final project for Data Science For Biomedical Informatics or BMIN 503 at the University of Pennsylvania. The course director is Dr. Blanca Himes.

The repository is organized as follows:
* QMD File: [BMIN503_Final_Project_Cardone_2023.qmd](https://github.com/katiecardone26/BMIN503_Final_Project/blob/master/BMIN503_Final_Project_Cardone_2023.qmd)
* HTML File: [BMIN503_Final_Project_Cardone_2023.html](https://github.com/katiecardone26/BMIN503_Final_Project/blob/master/BMIN503_Final_Project_Cardone_2023.html)

## Project Overview

Cigarette smoking is a major health problem in the United States, as it is the leading cause of preventable death. Many family-related problems/stress have been associated with smoking individually, but this study considers whether the combination of these risk factors in a machine learning approach can improve prediction. This study leverages data from the Behavioral Risk Factor Surveillance System 2022 survey, as this provides data on both family risk factors and nicotine use. This study integrates childhood and adulthood stress factor predictors in a random forest model and evaluates the model's effectiveness in predicting nicotine use status with models with and without 10-fold cross validation. This study also investigates the individual relationships between the predictors and nicotine use status as well as correlations between the predictors to understand the mechanisms in which these predictors interact with each other or contribute to nicotine use. 

The model modestly predicts non-nicotine use status, as the area under the curve with 10-fold cross validation is 0.64. The most important predictors in the model are days of lived with an illicit substance user or prescription drug abuser in childhood, annual household income less than $25,000, days of bad mental health in the past month, lived with an incarcerated adult in childhood, sexual abuse as a child, lived with an alcoholic or problem drug user in childhood, sex, and whether basic needs were met as a child. All of the predictors were significantly associated with nicotine use status in the univariate logistic regressions except for caregiver status, replicating previous studies. Having lived with someone who was incarcerated as a child has the highest odds ratio, such that individuals who experienced this are 2.6x more likely to use nicotine as an adult. Additionally, most of the predictors are not strongly correlated, except for sexual abuse variables, which are all strongly positively correlated. Thus, it is likely that these predictors are interacting in the random forest model.

In summary, combining child and adult home stress factors in a random forest model modestly predicted non-nicotine use status. Given that all of the predictors were significantly associated with nicotine use status in the univariate regressions, it is probable that these variables better predict nicotine use individually rather than in combination. The weak correlations between most of the variables further supports that.

