####################
## Author: Stephanie Teeple
## Date: 11 December 2018
## Summary:  
####################

# libraries
library(lme4)
library(stargazer)


# 1. Fixed effects model 
# NOTE: very poor fit
# NOTE: running a full fixed effects model with a PI_IDS term exceeded memory allocation. 
# NOTE: Highly significant coefficients in fixed effects models likely due to gigantic 
# sample size; very little variance is explained (R^2), but this does not necessarily 
# mean the estimators are biased. 
# NOTE: the output of these two models should be roughly the same - and they are, 
# except for the coefficient on pubs_to_date, which changes direction. Unclear why. 
fixed1 <- lm(TOTAL_COST_log ~ pubs_to_date + max_impact_factor + count_grants,
            data = data)
summary(fixed1)
stargazer(fixed1, type = "text", title = "Fixed effects log-transformed/OLS model",
          summary = FALSE, out = "figures/fixed_ols_effects.txt")
pdf(file = "figures/fixed_ols_fit_plots.pdf", onefile = TRUE)
plot(fixed1)
dev.off()
fixed2 <- glm(TOTAL_COST ~ pubs_to_date + max_impact_factor + count_grants,
             family = gaussian(link = "log"), data = data)
summary(fixed2)
stargazer(fixed2, type = "text", title = "Fixed effects GLM/gaussian model",
          summary = FALSE, out = "figures/fixed_glm_effects.txt")
pdf(file = "figures/fixed_glm_gaussian_fit_plots.pdf", onefile = TRUE)
plot(fixed2)
dev.off()

# 2. Mixed effects w/ random intercepts
# NOTE: For one fit value, there is wide variation in actual TOTAL_COST_log. 
# This could be due noisiness in the data OR due to something within groups 
# that I'm not measuring - likely a combination of the two. 
mixed_intercepts <- lmer(TOTAL_COST_log ~ pubs_to_date + max_impact_factor + 
                           count_grants + (1 | STUDY_SECTION_NAME) + 
                           (1 | ORG_NAME) + (1 | PI_IDS), data = data)
summary(mixed_intercepts)
stargazer(mixed_intercepts, type = "text", title = "Mixed effects random intercept model",
          out = "figures/mixed_intercept_effects.txt")
pdf(file = "figures/mixed_intercept_fit_plots.pdf", onefile = TRUE)
plot(mixed_intercepts)
dev.off()

dt <- as.data.table(data)
dt[, fit := predict(mixed_intercepts, data, allow.new.levels=T)]
pdf(file = "figures/mixed_intercept_fit_actual_scatter.pdf")
d <- ggplot(data=dt, aes(x=TOTAL_COST_log,y=fit)) +
  geom_point()
plot(d)

# 3. Mixed effects w/ random intercepts and slopes
# NOTE: Beyond level changes within each person that I can't quantify or observe, 
# there are also trajectory changes within each PI that I can't quantify or observe. 
# Random slopes are used in growth curve modelling - this is a very stringent 
# test of your covariates. 
# NOTE: if you want your covariate to explain difference in trajectory, you can't 
# include random slopes!
# mixed_slopes <- lmer(TOTAL_COST ~ pubs_to_date + max_impact_factor + count_grants +
                       # (1 | ORG_NAME) + (1 + pubs_to_date | STUDY_SECTION_NAME) + 
                       # (1 + pubs_to_date | PI_IDS) + (1 + max_impact_factor | PI_IDS) +
                       # (1 + count_grants | PI_IDS), data = data)

