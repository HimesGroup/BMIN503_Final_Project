## Project Files Description
- final_project_LingyunShi.html: final project report in HTML format
- environment.yml: list required package for this project
- Bidirectional_LSTM_Multivariate_Model.h5: model file
- Bidirectional_LSTM_Multivariate_Model.data-00000-of-00001: model file
- Bidirectional_LSTM_Multivariate_Model.index: model file
- bilstm.data-00000-of-00001: model file
- bilstm.index: model file
- GRU.data-00000-of-00001: model file
- GRU.index: model file
- CNN.index: model file
- CNN.data-00000-of-00001: model file
- bilstm-single.data-00000-of-00001: model file
- bilstm-single.index: model file
- GRU-single.data-00000-of-00001: model file
- GRU-single.index: model file
- checkpoint: model file
- CNN-single.index: model file
- CNN-single.data-00000-of-00001: model file
- GRU-singletest_result.csv: test prediction of single-style GRU model
- bilstm-singletest_result.csv: test prediction of single-style Bi-LSTM model
- CNN-singletest_result.csv: test prediction of single-style CNN model

### Overview
My project is to explore the performance of predicting ventilator pressure using machine learning. The data I am using are shared through a Kaggle competition that hosted by Google brain and Prinston University (https://www.kaggle.com/c/ventilator-pressure-prediction/overview).

The three faculty/staff advisors for my projects are: Tsui Rich, Ruiz Victor, Russel Richie. During our discussion, they gave me suggestions on model selection, recurrent model techniques, and time-seires feature engineering.

The final project GitHub repository:https://github.com/helenshi-chop/BMIN503_Final_Project


### Introduction 
Clinicians use mechanical ventilator to help patients who have trouble breathing.But it is a labor intensive treatment. Especially in the early stage of COVID-pandemic, this caused a lot loss due to a shortage of clinicians. Develop automatic ventilator could relieve the burden but that requires precise pressure control and adaption to different lung attributes. I will explore using Deep Learning and time-seines data analysis to predict inspiration pressure of each breath. This is cross-disciplinarian problem as it requires knowledge in mechanics, machine learning, time-series modeling, and deep learning. In the meeting the faculty, we brain-stormed that recurrent neural network may potentially catch the time-series subtle changes during breath.


### Methods
#### Machine Learning

The whole dataset was randomly split as training+development (70%) and testing (30%). The training and development datasets were used to develop traditional machine learning (regression-based) and deep learning models and tune hyperparameters for the developed models. The testing dataset was hold out for evaluating and reporting the model performance. 

#### Evaluation 

The study reported the following 5 evaluation metrics:
MSE: mean squared error
MAE: mean absolute error
RMSE: root mean squared error
MAPE: mean absolute percentage error
R2: coefficient of determination

### Results
- Single-style deep Learning models with outperformed traditional statistic-based approach in this time-series prediction task
- Horizontal-style deep learning model do not perform well
- Single-style GRU model gives the best test results for all metrics, it can catch the multi-variate time-series signals during breath and make accurate predictions of airway pressure
- AI-algorithm has the potential to be adopted in developing automatic ventilator which can reduce human workload

# BMIN503/EPID600 Final Project

This repository contains templates for your final written report and GitHub repository. Follow the instructions below to clone this repository, and then turn in your final project's code via a pull request to this repository.


1. To start, **fork** this BMIN503_Final_Project repository.
1. **Clone** the forked repository to your computer.
1. Modify the files provided, add your own, and **commit** changes to complete your final project.
1. **Push**/sync the changes up to your GitHub account.
1. Create a **pull request** on this, the original BMIN503_Final_Project, repository to turn in your final project.


Follow the instructions [here][forking] if you are unsure what the above steps mean.

DUE DATE FOR FINAL VERSION: 12/10/21 11:59PM. This is a hard deadline. Turn in whatever you have by this date.
