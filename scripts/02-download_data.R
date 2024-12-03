#### Preamble ####
# Purpose: Downloads and saves the data from DASL
# Author: Wendy Yuan
# Date: 29 November 2024
# Contact: w.yuan@mail.utoronto.ca

#### Workspace setup ####
library(tidyverse)
library(dplyr)
library(readr)

# Dataset page : https://dasl.datadescription.com/datafile/bodyfat/
url <- "https://dasl.datadescription.com/download/data/3079"
saved_file <- "data/01-raw_data/bodyfat.txt"

#### Download data ####
text_content <- readLines(url)

#### Save data ####
writeLines(text_content, saved_file)
