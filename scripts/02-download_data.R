#### Preamble ####
# Purpose: Downloads and saves the data from DASL
# Author: Wendy Yuan
# Date: 29 November 2024
# Contact: w.yuan@mail.utoronto.ca 

#### Workspace setup ####
library(opendatatoronto)
library(tidyverse)

#### Download data ####



#### Save data ####
write_csv(the_raw_data, "inputs/data/raw_data.csv")