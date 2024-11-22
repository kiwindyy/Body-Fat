#### Preamble ####
# Purpose: Simulates the body fat data with columns: Pct.BF, Neck, Chest,
  #Abdomen, Wrist, Weight
# Author: Wendy Yuan
# Date: 29 November 2024
# Contact: w.yuan@mail.utoronto.ca 

#### Workspace setup ####
library(tidyverse)
set.seed(304)

#### Simulate Data ####

# Number of rows to simulate
n <- 150

# Simulate data for each column
simulated_data <- tibble(
  Pct.BF = runif(n, min = 5, max = 40),
  Neck = rnorm(n, mean = 35, sd = 5),
  Chest = rnorm(n, mean = 100, sd = 10),
  Abdomen = rnorm(n, mean = 90, sd = 10),
  Wrist = rnorm(n, mean = 18, sd = 2),
  Weight = rnorm(n, mean = 70, sd = 15)
)

# Ensure no negative values
simulated_data <- simulated_data %>%
  mutate(
    Neck = ifelse(Neck < 0, abs(Neck), Neck),
    Chest = ifelse(Chest < 0, abs(Chest), Chest),
    Abdomen = ifelse(Abdomen < 0, abs(Abdomen), Abdomen),
    Wrist = ifelse(Wrist < 0, abs(Wrist), Wrist),
    Weight = ifelse(Weight < 0, abs(Weight), Weight)
  )

# Save simulated data as CSV for easy viewing
write_csv(simulated_data, "data/00-simulated_data/simulated_bodyfat.csv")