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

# Handle missing values
cleaned_data <- data %>% drop_na()

# Remove duplicates
cleaned_data <- cleaned_data %>% distinct()

# define percentile curoff
lower_cutoff = 0.25
upper_cutoff = 0.75

# Function to remove outlines
remove_outliers <- function(data, column) {
  Q1 <- quantile(data[[column]], lower_cutoff, na.rm = TRUE)
  Q3 <- quantile(data[[column]], upper_cutoff, na.rm = TRUE)
  IQR <- Q3 - Q1
  lower_bound <- Q1 - 1.5 * IQR
  upper_bound <- Q3 + 1.5 * IQR
  data %>%
    filter(data[[column]] >= lower_bound & data[[column]] <= upper_bound)
}

#Remove outliners by checking all columns
for (column_name in colnames(cleaned_data)) {
  if (is.numeric(cleaned_data[[column_name]])) {
    cleaned_data <- remove_outliers(cleaned_data, column_name)
  }
}

#### Save data ####
write_parquet(cleaned_data, "data/02-analysis_data/bodyfat.parquet")