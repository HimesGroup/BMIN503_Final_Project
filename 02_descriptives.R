####################
## Author: Stephanie Teeple
## Date: 9 December 2018
## Summary: This file generates univariate
## and bivariate descriptive statistics to 
## prep for analysis. 
####################

# Directory 
setwd("C:/Users/steeple/Dropbox/EPID_600/BMIN503_Final_Project")

# Libraries
library(stargazer)
library(ggplot2)

data <- as.data.frame(data)

# 1. Univariate

  # Numeric vars
  numerics <- c("PI_IDS", "TOTAL_COST", "pubs_to_date", "max_impact_factor", 
                "count_grants")
  for (i in numerics) {
    print(paste0("histogram for ", i))
    title <- i
    hist(data[[i]], breaks = "Scott", freq = TRUE, main = title)
    filename <- paste0("figures/histogram_", i, ".pdf")
    pdf(filename)
    dev.off()
  }
  dev.off()

  # Dates
  hist(data$BUDGET_START, breaks = "years", freq = TRUE, main = "BUDGET_START")
  pdf("figures/histogram_BUDGET_START.pdf")

  # Categorical
  categoricals <- c("ORG_NAME","STUDY_SECTION_NAME", "FULL_PROJECT_NUM")
  levels <- as.data.frame(lapply(data[categoricals], function(x) length(unique(x))))
  stargazer(levels, type = "text", title = "Number of unique categories/variable",
            summary = FALSE, out = "figures/category_counts.txt")
  
  stargazer(data[1:10, 1:6], type = "text", 
            title = "Example responses for categorical variables", 
            summary = FALSE, out = "figures/category_responses.txt" ) 
  
    # Count of observations by level 
    # This didn't work for some reason 
    # for (i in seq_along(categoricals)) {
    #    counts_by_level[[i]] <- data %>%
    #     group_by(!!categoricals[[i]]) %>%
    #     summarize(counts = n()) %>%
    #     print() %>%
    #     ungroup(!!categoricals[[i]])
    # }

    # for (i in seq_along(categoricals)) {
    #   counts_by_level[[i]] <- data %>%
    #     count(!!categoricals[[i]])
    # }
    
    counts_by_level[[1]] <- data %>%
      count(ORG_NAME) %>%
      print()
    counts_by_level[[2]] <- data %>%
      count(STUDY_SECTION_NAME) %>%
      print()
    for (i in 1:2) {
      title <- paste0("Distribution of counts by level of ", categoricals[i])
      hist(as.numeric(unlist(counts_by_level[[i]][2])), breaks = "Scott", freq = TRUE, main = title)
      filename <- paste0("figures/histogram_counts_of_", categoricals[i], ".pdf")
      pdf(filename)
      dev.off()
    }
  
    # NOTE: ~150000 observations are coded as STUDY_SECTION_NAME = "Special 
    # Emphasis Panel" which is essentially 'Misc.'
    # NOTE: Hundreds of flagship institutions have >1000 projects. Ex: Albert
    # Einstein College of Medicine, baylor, Brigham and Women's. Only Johns Hopkins
    # has >10000. 
  
# 2. Bivariate
  
  # Predictors vs. outcome 
  # Numerics 
  numerics <- c("TOTAL_COST", "pubs_to_date", "max_impact_factor", 
                "count_grants")
  numeric_data <- data[numerics]
  correlations <- cor(numeric_data)
  stargazer(correlations, type = "text", title = "Number of unique categories/variable",
            summary = FALSE, out = "figures/correlations.txt")
  
  # Similarly, this doesn't work not sure why
  # for (i in 2:4) {
  #   print(paste0("Plot for ", numerics[i]))
  #   d <- ggplot(data, aes(!!numerics[i], TOTAL_COST)) + 
  #     geom_point()
  #   plot(d)
  #   ggsave(filename = paste0("figures/scatter_", numerics[i], ".png"))
  # }
  
  d <- ggplot(data, aes(pubs_to_date, TOTAL_COST)) + 
    geom_point()
  plot(d)
  ggsave(filename = "figures/scatter_pubs_to_date.png")
  
  d <- ggplot(data, aes(max_impact_factor, TOTAL_COST)) + 
    geom_point()
  plot(d)
  ggsave(filename = "figures/scatter_max_impact_factor.png")
  
  d <- ggplot(data, aes(count_grants, TOTAL_COST)) + 
    geom_point()
  plot(d)
  ggsave(filename = "figures/scatter_count_grants.png")
    
  
  # Categoricals
  not_missing <- data %>%
    filter(!is.na(STUDY_SECTION_NAME)) %>%
    arrange(STUDY_SECTION_NAME)
  pdf(file = "figures/boxplots_STUDY_SECTION_NAME.pdf", onefile = TRUE)
  for (i in unique(not_missing$STUDY_SECTION_NAME)) {
    print(paste0("Printing plot ", i))
    d <- ggplot(not_missing[not_missing$STUDY_SECTION_NAME == i,], aes(x = STUDY_SECTION_NAME, y = TOTAL_COST)) + 
      geom_boxplot()
    plot(d)
    print(d)
  }
  dev.off()
  
  data <- arrange(data, ORG_NAME)
  pdf(file = "figures/boxplots_ORG_NAME.pdf", onefile = TRUE)
  for (i in unique(data$ORG_NAME)) {
    print(paste0("Printing plot ", i))
    d <- ggplot(data[data$ORG_NAME == i,], aes(x = ORG_NAME, y = TOTAL_COST)) + 
      geom_boxplot()
    plot(d)
    print(d)
  }
  dev.off()
 
  
  