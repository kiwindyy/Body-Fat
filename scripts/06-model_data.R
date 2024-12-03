#### Preamble ####
# Purpose: Build final model
# Author: Wendy Yuan
# Date: 29 November 2024
# Contact: w.yuan@mail.utoronto.ca
# Pre-requisites:
# - 05-exploratory-data_analysis.R must have been run

library(arrow)

# Final variables learned from 05-exploratory-data_analysis.R
final_variables <- c("Age", "Height", "Abdomen", "Wrist")

data <- read_parquet("data/02-analysis_data/bodyfat.parquet")

# Final 4-variable model
final_model <- lm(as.formula(paste("Pct.BF ~", paste(final_variables,
                                                     collapse = "+"))),
                  data = data)
summary(final_model)

#### Save model ####
saveRDS(final_model, file = "model/final_model.rds")
