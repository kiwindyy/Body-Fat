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
library(arrow)
library(dplyr)

# Load the cleaned dataset
cleaned_data <- read_parquet("data/02-analysis_data/bodyfat.parquet")

#### Test cleaned data ####

# Test that the dataset has rows - there should be some rows after cleaning
test_that("dataset has rows", {
  expect_gt(nrow(cleaned_data), 0)  # Ensure at least 1 row exists
})

# Test that all columns in the dataset exist
test_that("all columns exist", {
  expect_true(all(colnames(cleaned_data) %in% colnames(cleaned_data)))
})

# Test that all columns are numeric
test_that("all columns are numeric", {
  expect_true(all(sapply(cleaned_data, is.numeric)))
})

# Test that there are no missing values in the dataset
test_that("no missing values in dataset", {
  expect_true(all(!is.na(cleaned_data)))
})

# Test that there are no duplicate rows
test_that("no duplicate rows in dataset", {
  expect_equal(nrow(cleaned_data), nrow(distinct(cleaned_data)))
})