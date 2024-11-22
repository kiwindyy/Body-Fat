#### Preamble ####
# Purpose: Downloads and saves the data from DASL
# Author: Wendy Yuan
# Date: 29 November 2024
# Contact: w.yuan@mail.utoronto.ca 

#### Workspace setup ####
library(tidyverse)
library(arrow)
library(readr)
library(dplyr)
library(tidyr)

#### Clean data ####
data <- read.table("data/01-raw_data/bodyfat.txt", header = TRUE, sep = "\t")

# Select relevant columns
selected_data <- data %>%
  select(Pct.BF, Neck, Chest, Abdomen, Wrist, Weight)

# Handle missing values
cleaned_data <- selected_data %>%
  drop_na()

# Remove duplicates
cleaned_data <- cleaned_data %>%
  distinct()

# Function to remove outliers
remove_outliers <- function(data, column) {
  Q1 <- quantile(data[[column]], 0.25, na.rm = TRUE)
  Q3 <- quantile(data[[column]], 0.75, na.rm = TRUE)
  IQR <- Q3 - Q1
  lower_bound <- Q1 - 1.5 * IQR
  upper_bound <- Q3 + 1.5 * IQR
  data %>%
    filter(data[[column]] >= lower_bound & data[[column]] <= upper_bound)
}

# Apply outlier removal to each column
columns_to_check <- c("Pct.BF", "Neck", "Chest", "Abdomen", "Wrist")
for (col in columns_to_check) {
  cleaned_data <- remove_outliers(cleaned_data, col)
}

#### Save data ####
write_parquet(cleaned_data, "data/02-analysis_data/bodyfat.parquet")