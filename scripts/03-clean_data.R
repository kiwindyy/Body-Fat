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
cleaned_data <- data %>%
  drop_na()

# Remove duplicates
cleaned_data <- cleaned_data %>%
  distinct()

#### Save data ####
write_parquet(cleaned_data, "data/02-analysis_data/bodyfat.parquet")
