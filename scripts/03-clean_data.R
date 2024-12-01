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

# Remove all missing values
cleaned_data <- data %>% drop_na()

# Remove duplicates
cleaned_data <- cleaned_data %>% distinct()

# define percentile curoff
lower_cutoff = 0.25
upper_cutoff = 0.75

# Function to remove outlines, ensure all values are greater than 0
epsilon = 1e-10
remove_outliers <- function(data, column) {
  Q1 <- quantile(data[[column]], lower_cutoff, na.rm = TRUE)
  Q3 <- quantile(data[[column]], upper_cutoff, na.rm = TRUE)
  IQR <- Q3 - Q1
  lower_bound <- max(Q1 - 1.5 * IQR, epsilon)
  message(paste(column, ":", lower_bound))
  upper_bound <- Q3 + 1.5 * IQR
  
  data %>% filter(data[[column]] >= lower_bound & data[[column]] <= upper_bound)
}

#Remove outliners by checking all columns
for (column_name in colnames(cleaned_data)) {
  if (is.numeric(cleaned_data[[column_name]])) {
    message(paste(column_name, " filtered"))
    cleaned_data <- remove_outliers(cleaned_data, column_name)
  }
}

# The original dataset includes weight in pounds, height and waist in inches, 
# and body fat in g/m³. The remaining measurements are in centimeters. 
# Normalize the units for the following columns:

#lbs to kg (Keep two decimal places)
cleaned_data$Weight <- cleaned_data$Weight * 0.453592
cleaned_data$Weight <- floor(cleaned_data$Weight * 100) / 100

#inch to cm (Keep two decimal places)
cleaned_data$Height <- cleaned_data$Height * 2.54
cleaned_data$Height <- floor(cleaned_data$Height * 100) / 100

#inch to cm 
cleaned_data$Waist <- cleaned_data$Waist * 2.54

#### Save data ####
write_parquet(cleaned_data, "data/02-analysis_data/bodyfat.parquet")