#### Preamble ####
# Purpose: Exploratory data analysis on variables
# Author: Wendy Yuan
# Date: 29 November 2024
# Contact: w.yuan@mail.utoronto.ca
# Pre-requisites:
# - 03-clean_data.R must have been run


#### Workspace setup ####
library(tidyverse)
library(arrow)
library(MASS)
library(knitr)

#### Read data ####
data <- read_parquet("data/02-analysis_data/bodyfat.parquet")
data <- data[, !(names(data) %in% c("Density"))]

# Full model using all variables except Density
full_model <- lm(Pct.BF ~ ., data = data)

# Perform backward selection
backward_model <- stepAIC(full_model, direction = "backward", trace = 0)

# Extract the final 4-variable model
final_variables <- names(coef(backward_model))[-1] # Exclude intercept
while (length(final_variables) > 4) {
  current_model <- lm(as.formula(paste("Pct.BF ~", paste(final_variables,
                                                         collapse = "+"))),
                      data = data)
  current_aic <- AIC(current_model)
  
  # Drop one variable at a time and calculate AIC
  aic_values <- sapply(final_variables, function(var) {
    temp_model <- lm(as.formula(paste("Pct.BF ~", paste(setdiff(final_variables,
                                                                var),
                                                        collapse = "+"))),
                     data = data)
    return(AIC(temp_model))
  })
  
  # Remove the variable leading to the lowest AIC improvement
  final_variables <- setdiff(final_variables, names(which.min(aic_values)))
}

# Print the AIC value and final variables
kable(final_variables)