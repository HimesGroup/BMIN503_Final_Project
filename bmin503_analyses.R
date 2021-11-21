############################################################
############################################################
# Analyses for final project
#  - descriptive
#  - logistic regression
#  - 10-fold cross validation
############################################################
############################################################

library(tidyverse)
library(ggplot2)
library(GGally)
library(tibble)
library(pROC)
library(car)


# import final dataset
covid <- read_csv("bmin503_final_data_20211121.csv") %>%
  mutate(next_week_increase = factor(next_week_increase,
                                     levels = c(0, 1),
                                     labels = c("no increase", "increase")))

########################################################
########################################################
               # Descriptive Analysis
########################################################
########################################################

# view data
glimpse(covid)

# check that each county has 86 rows
table(covid$county)

# check min and max year_week
min(covid$year_week) # 2020-07
max(covid$year_week) # 2021-39

#################################
# outcome variable x vaccination 
#################################

# next week increase or no increase 
table(covid$next_week_increase) # split is close to 50/50

# view summary stats of vaccine vars - overall
summary_df <- covid %>%
  select(mean_per_pop_fully_vacc, vacc_prevalence_per100thou,
         vacc_incidence_per100thou) %>%
  psych::describe(quant=c(.25,.75)) %>%
  as_tibble(rownames="rowname")  %>%
  select(-vars, -trimmed, -mad) %>%
  print()

# observations with increase
summary_inc <- covid %>% filter(next_week_increase == "increase") %>%
  select(mean_per_pop_fully_vacc, vacc_prevalence_per100thou,
         vacc_incidence_per100thou) %>%
  psych::describe(quant=c(.25,.75)) %>%
  as_tibble(rownames="rowname")  %>%
  select(-vars, -trimmed, -mad) %>%
  print()

# observations with no increase
summary_noinc <- covid %>% filter(next_week_increase == "no increase") %>%
  select(mean_per_pop_fully_vacc, vacc_prevalence_per100thou,
         vacc_incidence_per100thou) %>%
  psych::describe(quant=c(.25,.75)) %>%
  as_tibble(rownames="rowname")  %>%
  select(-vars, -trimmed, -mad) %>%
  print()

### The mean for mean_per_pop_fully_vacc and vacc_prevalence_per100thou
#  in the "increase" group is higher than for the "no increase" group. 
#  We expected the "no increase" group to have higher means for these variables.

### The mean for vacc_incidence_per100thou is higher in "no increase" group.

# boxplot for mean percentage of population fully vaccinated by outcome
ggplot(data = covid, aes(x = next_week_increase, y = mean_per_pop_fully_vacc)) +
  geom_boxplot(color = "darkorchid4", fill = "mediumpurple2")

# boxplot for mean vaccine prevalence by outcome
ggplot(data = covid, aes(x = next_week_increase, y = vacc_prevalence_per100thou)) +
  geom_boxplot(color = "magenta4", fill = "thistle")

# boxplot for mean vaccine incidence by outcome
ggplot(data = covid, aes(x = next_week_increase, y = vacc_incidence_per100thou)) +
  geom_boxplot(color = "darkblue", fill = "plum3")



########################
# plot with ggpairs
########################
df_clean <- covid %>% filter(complete.cases(.))

# limit dataframe to focus on specific predictor variables  
df_clean2 <- df_clean %>% 
  select(-county, -year_week, -case_mean, -case_mean_per100thou,
         -next_week_mean, -next_week_per100thou, -vacc_incidence_n,
         -vacc_incidence_per100thou, -mean_fully_vacc_n,
         -vacc_prevalence_per100thou) %>%
  rename(case_incr = next_week_increase,
         vacc = mean_per_pop_fully_vacc,
         retail = mean_retail_rec,
         grocery = mean_grocery_pharm,
         parks = mean_parks,
         transit = mean_transit_stations,
         workplace = mean_workplaces,
         residential = mean_residential)

# compare outcome and mean_per_pop_fully_vacc only
ggpairs(df_clean, mapping = aes(col = next_week_increase),
        columns = c("mean_per_pop_fully_vacc"),
        axisLabels = "show")

# compare all variables at once
ggpairs(df_clean2)



########################################################
########################################################
          # Logistic Regression Models
########################################################
########################################################

###############################################
# fit bivariate statistical models to find out 
# which variables are individually associated 
# with next_week_increase at a 
# nominally significant level.
###############################################

# scale vaccine variables
covid$vacc_inc_per100thou_sc <- scale(covid$vacc_incidence_per100thou)[, 1]
covidvacc_prev_per100thou_sc <- scale(covid$vacc_prevalence_per100thou)[, 1]

covid_clean <- covid %>% select(-county, -year_week,
                                -case_mean_per100thou, -case_mean,
                                -next_week_mean, -next_week_per100thou,
                                -vacc_incidence_n, -mean_fully_vacc_n) 


# generate multiple models and save output to df
glm_output <- covid_clean %>%
  select(-next_week_increase, -vacc_incidence_per100thou,
         -vacc_prevalence_per100thou) %>%
  names() %>%
  paste("next_week_increase ~", .) %>%
  map_df(~tidy(glm(as.formula(.x), 
                   data = covid_clean, 
                   family = "binomial"), 
               estimate = TRUE,
               conf.int = TRUE, 
               exponentiate = TRUE)) %>%
  filter(term != "(Intercept)") %>%
  rename(or = estimate) %>%
  arrange(p.value)
glm_output

# vacc_inc_per100thou_sc  and mean_retail_rec are significant at p < 0.05 
# we hypothesized that vacc_prevalence_per100thou would be a significant predictor


#####################################
# model using significant predictors
#####################################

# fit model
mod_vacc <- glm(next_week_increase ~ vacc_inc_per100thou_sc + mean_retail_rec,
                data = covid, family = "binomial")

# check model output
tidy(mod_main, conf.int = TRUE, exponentiate = TRUE)

# check for multicollinearity
car::vif(mod_main) # variance inflation factors are low, so no issues 

# store predicted values of training data
vacc_pred <- predict(mod_vacc, covid, type = "response") 
head(vacc_pred)

########################################################
########################################################
#           10-fold cross validation
########################################################
########################################################

# use 10-fold cross validation to train and test model
N = nrow(covid)
K = 10
set.seed(1234)
s = sample(1:K, size = N, replace = T)
pred_outputs <- vector(mode = "numeric", length = N)
obs_outputs <- vector(mode = "numeric", length = N)
offset <- 0
for (i in 1:K) {
  train <- filter(covid, s != i)
  test <- filter(covid, s == i)
  obs_outputs[1:length(s[s == i]) + offset] <- test$next_week_increase
  
  # GLM train/test
  glm <- glm(next_week_increase ~ vacc_inc_per100thou_sc + mean_retail_rec, 
             data = train, family = "binomial")
  glm_pred_curr <- predict(glm, test, type = "response")
  pred_outputs[1:length(s[s == i]) + offset] <- glm_pred_curr
  
  offset <- offset + length(s[s == i])
}
head(cbind(pred_outputs, obs_outputs))

#############################################
# evaluate model using ROC curve analysis
#############################################

# calculate area under the ROC curve
roc(covid$next_week_increase, vacc_pred, ci = TRUE) # training data
roc(obs_outputs, pred_outputs, ci = TRUE) # test data

# plot ROC curves for training and test data
plot.roc(covid$next_week_increase, vacc_pred, ci = TRUE, col = "darkblue", lwd = 3)
plot.roc(obs_outputs, pred_outputs, ci = TRUE, col = "mediumorchid2", add = TRUE, lwd = 3) #CV of glm
legend("bottomright", legend = c("GLM Logistic", "GLM Logistic Cross-Validation"), 
       col = c("darkblue", "mediumorchid2"), lwd = 3)

# the AUCs for both training and test data are not very high, so
# predictive accuracy is not very good. Model does not distinguish well
# between no increase and increase.
# Not much better than a coin flip.
