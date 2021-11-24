# BMIN503/EPID600 Final Project

This repository contains templates for your final written report and GitHub repository. Follow the instructions below to clone this repository, and then turn in your final project's code via a pull request to this repository.


1. To start, **fork** this BMIN503_Final_Project repository.
1. **Clone** the forked repository to your computer.
1. Modify the files provided, add your own, and **commit** changes to complete your final project.
1. **Push**/sync the changes up to your GitHub account.
1. Create a **pull request** on this, the original BMIN503_Final_Project, repository to turn in your final project.


Follow the instructions [here][forking] if you are unsure what the above steps mean.

DUE DATE FOR FINAL VERSION: 12/10/21 11:59PM. This is a hard deadline. Turn in whatever you have by this date.


### Overview
My project is to explore the performance of predicting ventilator pressure using machine learning. The data I am using are shared through a Kaggle competition that hosted by Google brain and Prinston University (https://www.kaggle.com/c/ventilator-pressure-prediction/overview).

The three faculty/staff advisors for my projects are: Tsui Rich, Ruiz Victor, Russel Richie. During our discussion, they gave me suggestions on model selection, recurrent model techniques, and time-seires feature engineering.

The final project GitHub repository:https://github.com/helenshi-chop/BMIN503_Final_Project


### Introduction 
Clinicians use mechanical ventilator to help patients who have trouble breathing.But it is a labor intensive treatment. Especially in the early stage of COVID-pandemic, this caused a lot loss due to a shortage of clinicians. Develop automatic ventilator could relieve the burden but that requires precise pressure control and adaption to different lung attributes. I will explore using Deep Learning and time-seines data analysis to predict inspiration pressure of each breath. This is cross-disciplinarian problem as it requires knowledge in mechanics, machine learning, time-series modeling, and deep learning. In the meeting the faculty, we brain-stormed that recurrent neural network may potentially catch the time-series subtle changes during breath.


### Methods
Data:
The data are time-series records that catches the pressure censor readings during each breath (the output to be predicted).The input features (data used to predict) are two control inputs and two lung-specific features. The two cnotrol inputs are (1) inspiratoory valve (0-100), indicating the percentage of valve that let air in, and (2) the expiratoory valve (0 or 1), indicating whether the exploratooory valve is open. The lung-specific attribute features are R-indicating how restricted the airway is, and C-indicating how compiant the lung is.  

Modeling strategies:
LSTM
LSTM+CNN
LSTM+Manual feature engineering
LSTM+CNN+Manual feature engineering

### Results
Describe your results and include relevant tables, plots, and code/comments used to obtain them. End with a brief conclusion of your findings related to the question you set out to address. You can include references if you'd like, but this is not required.

