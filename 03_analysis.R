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

fixed1 <- lm(TOTAL_COST_log ~ pubs_to_date + max_impact_factor+ count_grants,
            data = data)
summary(fixed1)
stargazer(fixed1, type = "text", title = "Fixed effects log-transformed/OLS model",
          summary = FALSE, out = "figures/fixed_ols_effects.txt")
pdf(file = "figures/fixed_ols_fit_plots.pdf", onefile = TRUE)
plot(fixed1)
dev.off()
fixed2 <- glm(TOTAL_COST ~ pubs_to_date + max_impact_factor + count_grants,
             family = poisson(link = "log"), data = data)
summary(fixed2)
stargazer(fixed2, type = "text", title = "Fixed effects GLM/poisson model",
          summary = FALSE, out = "figures/fixed_glm_effects.txt")
pdf(file = "figures/fixed_glm_poisson_fit_plots.pdf", onefile = TRUE)
plot(fixed2)
dev.off()

# 2. Mixed effects w/ random intercepts
mixed_intercepts <- lmer(TOTAL_COST ~ pubs_to_date + max_impact_factor + 
                           count_grants + (1 | STUDY_SECTION_NAME) + 
                           (1 | ORG_NAME) + (1 | PI_IDS), data = data)
summary(mixed_intercepts)
stargazer(mixed_intercepts, type = "text", title = "Mixed effects random intercept model",
          out = "figures/mixed_intercept_effects.txt")
pdf(file = "figures/mixed_intercept_fit_plots.pdf", onefile = TRUE)
plot(mixed_intercepts)
dev.off()

# 3. Mixed effects w/ random intercepts and slopes
mixed_slopes <- lmer(TOTAL_COST ~ pubs_to_date + max_impact_factor + count_grants +
                       (1 | ORG_NAME) + (1 + pubs_to_date | STUDY_SECTION_NAME) + 
                       (1 + pubs_to_date | PI_IDS) + (1 + max_impact_factor | PI_IDS) +
                       (1 + count_grants | PI_IDS), data = data)

