# BMIN5030 Final Project

This GitHub is used as the final project for BMIN 5030 class.

The COVID-19 pandemic dramatically reshaped daily life and public health systems, highlighting the need for better tools to anticipate and respond to infectious disease surges. Even as the pandemic has subsided, understanding the early signals that predict rising case numbers remains critical for future preparedness. This project focuses on using Google search trend data and other public features (weather, government policy, etc) from the Google COVID-19 Open Data Repository to visualize and forecast case and death patterns across U.S. regions. The core goal is to evaluate whether real-time search behavior—such as individuals looking up symptoms like loss of taste or breathing difficulties—can serve as an early indicator of community transmission before official reports catch up. By pairing search trends with supporting datasets on vaccination, mobility, and healthcare impact, we aim to develop a simple machine learning model that reveals which online behaviors most strongly track and predict shifts in the pandemic.

In this GitHub, we present the codes, data and figures for the COVID-19 predictions for Pennsylvania state. The code can be used to populate the predictions for other U.S. states. Since the major surge occurred in 2021 and early 2022, we use all data up to September 30, 2021 for training. The following months through December 31, 2021 serve as a validation period for tuning hyperparameters, while data from January to June 2022 is reserved for final testing to evaluate generalization performance during the peak (after June 2022, lots of features become NaN). Model performance is assessed using Root Mean Squared Error (RMSE) and Mean Absolute Error (MAE). We then evaluate the performance of four predictive models: LASSO Regression, Linear Regression, Random Forest, and XGBoost. The most important features selected by LASSO Regression model are used to train other models. For each model (except Linear Regression), we also perform hyperparameter tuning to optimize performance before evaluating them on the test dataset.

QMD file:

  COVID-19_ML_GoogleSearch.qmd: provides the full codes and documentations
  
HTML file: 

  COVID-19_ML_GoogleSearch.html: provides the full codes and documentations
  
CSV file:

  covid19_open_data_US_all.csv: subset of original COVID-19 Open Data Repository for the U.S. specifically.
  
Figures:

  covid_monthly_cumulative_cases.gif: the animation showing the COVID-19 cumulative cases over time across U.S. states and territories from 2020-01-01 to 2022-09-17.
  
  covid_monthly_cumulative_deaths.gif: the animation showing the COVID-19 cumulative deaths over time across U.S. states and territories from 2020-01-01 to 2022-09-17.
  
  covid_predictions_Pennsylvania.png: the plot showing predictions of LASSO Regression, Linear Regression, Random Forest, and XGBoost models on validation and test sets.
  
  search_trends_vs_cases.png: the plot showing some Google Search trends during COVID-19 pandemic along with the daily confirmed cases.

  other_features_vs_cases.png: the plot showing some general features during COVID-19 pandemic along with the daily confirmed cases.

Author: Quan Minh Nguyen

Ph.D. Candidate in Bioengineering, University of Pennsylvania

Email: qmn103@seas.upenn.edu

<!-- Links -->

[forking]: https://guides.github.com/activities/forking/

