#### Preamble ####
# Purpose: Tests the structure and validity of the simulated body fat dataset
# Author: Wendy Yuan
# Date: 29 November 2024
# Contact: w.yuan@mail.utoronto.ca 
# Pre-requisites: 
  # - 00-simulate_data.R must have been run

#### Workspace setup ####
library(tidyverse)

sim_data <- read_csv("data/00-simulated_data/simulated_bodyfat.csv")

# Test if the dataset was successfully loaded
if (exists("sim_data")) {
  message("Test Passed: The dataset was successfully loaded.")
} else {
  stop("Test Failed: The dataset could not be loaded.")
}

# Test if the dataset has 150 rows (based on your simulation)
if (nrow(sim_data) == 150) {
  message("Test Passed: The dataset has 150 rows.")
} else {
  stop("Test Failed: The dataset does not have 150 rows.")
}

# Test if the data has 6 columns (Pct.BF, Neck, Chest, Abdomen, Wrist, Weight)
if (ncol(sim_data) == 6) {
  message("Test Passed: The dataset has 6 columns.")
} else {
  stop("Test Failed: The dataset does not have 6 columns.")
}

# Test if all columns contain numeric values
if (all(sapply(sim_data, is.numeric))) {
  message("Test Passed: All columns contain numeric values.")
} else {
  stop("Test Failed: Some columns do not contain numeric values.")
}

# Test if there are no missing values in the dataset
if (all(!is.na(sim_data))) {
  message("Test Passed: The dataset contains no missing values.")
} else {
  stop("Test Failed: The dataset contains missing values.")
}

# Test if there are no duplicate rows
if (nrow(sim_data) == nrow(distinct(sim_data))) {
  message("Test Passed: There are no duplicate rows in the dataset.")
} else {
  stop("Test Failed: The dataset contains duplicate rows.")
}

# Test if all values in 'Pct.BF' are within a realistic range (5% to 40%)
if (all(sim_data$Pct.BF >= 5 & sim_data$Pct.BF <= 40)) {
  message("Test Passed: All values in 'Pct.BF' are within the range (5%-40%).")
} else {
  stop("Test Failed: Some values in 'Pct.BF' are outside the range.")
}

# Test if all values in body measurement columns are positive
body_columns <- c("Neck", "Chest", "Abdomen", "Wrist", "Weight")
if (all(sim_data %>% select(all_of(body_columns)) > 0)) {
  message("Test Passed: All body measurements are positive.")
} else {
  stop("Test Failed: Some body measurement values are not positive.")
}

# Test if all columns have variance (not constant)
if (all(sapply(sim_data, var, na.rm = TRUE) > 0)) {
  message("Test Passed: All columns have variance.")
} else {
  stop("Test Failed: Some columns do not have variance.")
}