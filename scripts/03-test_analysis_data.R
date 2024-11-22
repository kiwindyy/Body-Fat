#### Preamble ####
# Purpose: Tests cleaned data
# Author: Wendy Yuan
# Date: 29 November 2024
# Contact: w.yuan@mail.utoronto.ca
# Pre-requisites: 
# - 02-clean_data.R must have been run

#### Workspace setup ####
library(tidyverse)
library(testthat)
library(dplyr)

# Load the cleaned dataset
cleaned_data <- read_parquet("data/02-analysis_data/bodyfat.parquet")

#### Test cleaned data ####

# Test that the dataset has rows - there should be some rows after cleaning
test_that("dataset has rows", {
  expect_gt(nrow(cleaned_data), 0)  # Ensure at least 1 row exists
})

# Test that the dataset has 6 columns
test_that("dataset has 6 columns", {
  expect_equal(ncol(cleaned_data), 6)
})

# Test that all selected columns exist
test_that("required columns exist", {
  expect_true(all(c("Pct.BF", "Neck", "Chest", "Abdomen", "Wrist", "Weight")
                  %in% colnames(cleaned_data)))
})

# Test that all columns are numeric
test_that("all columns are numeric", {
  expect_true(all(sapply(cleaned_data, is.numeric)))
})

# Test that individual columns are numeric (optional redundancy)
columns_to_check <- c("Pct.BF", "Neck", "Chest", "Abdomen", "Wrist")
for (col in columns_to_check) {
  test_that(paste0(col, " is numeric"), {
    expect_type(cleaned_data[[col]], "double")  # "double" for numeric values
  })
}

# Test that there are no missing values in the dataset
test_that("no missing values in dataset", {
  expect_true(all(!is.na(cleaned_data)))
})

# Test that there are no duplicate rows
test_that("no duplicate rows in dataset", {
  expect_equal(nrow(cleaned_data), nrow(distinct(cleaned_data)))
})

# Test that outliers were removed based on IQR (values within bounds)
for (col in columns_to_check) {
  test_that(paste0(col, " does not contain outliers"), {
    Q1 <- quantile(cleaned_data[[col]], 0.25, na.rm = TRUE)
    Q3 <- quantile(cleaned_data[[col]], 0.75, na.rm = TRUE)
    IQR <- Q3 - Q1
    lower_bound <- Q1 - 1.5 * IQR
    upper_bound <- Q3 + 1.5 * IQR
    expect_true(all(cleaned_data[[col]] >= lower_bound &
                      cleaned_data[[col]] <= upper_bound))
  })
}