#### Preamble ####
# Purpose: Simulates the body fat data
# Author: Wendy Yuan
# Date: 29 November 2024
# Contact: w.yuan@mail.utoronto.ca

#### Workspace setup ####
library(tidyverse)
set.seed(1009122423)

#### Simulate Data ####
# Mean and SD values are from the National Health and Nutrition Examination
# Survey and Anthropometric Data for U.S. Adults

#variable, Mean(Approx.), Standard Deviation (Approx.)

#Human Density (g/cm³)  1.05, 0.01
#Pct.BF (%)             25,   10
#Age                    40,   15
#Weight (kg)            70,   15
#Height (cm)            170,  10
#Neck (cm)              37,   3
#Chest (cm)             95,   10
#Abdomen (cm)           85,   15
#Waist (cm)             90,   12
#Hip (cm)               95,   10
#Thigh (cm)             55,   5
#Knee (cm)              38,   3
#Ankle (cm)             23,   2
#Bicep (cm)             30,   5
#Forearm (cm)           27,   3
#Wrist (cm)             16,   1

# Number of rows to simulate
n <- 150

# Simulate data for each column
simulated_data <- NULL

repeat {
  simulated_data <- tibble(
    Density = rnorm(n, mean = 1.05, sd = 0.01),
    Pct.BF = runif(n, min = 5, max = 40),
    Age = rnorm(n, mean = 40, sd = 15),
    Weight = rnorm(n, mean = 70, sd = 15),
    Height = rnorm(n, mean = 170, sd = 10),
    Neck = rnorm(n, mean = 37, sd = 3),
    Chest = rnorm(n, mean = 95, sd = 10),
    Abdomen = rnorm(n, mean = 85, sd = 15),
    Waist = rnorm(n, mean = 90, sd = 12),
    Hip = rnorm(n, mean = 95, sd = 10),
    Thigh = rnorm(n, mean = 55, sd = 5),
    Knee = rnorm(n, mean = 38, sd = 3),
    Ankle = rnorm(n, mean = 23, sd = 2),
    Bicep = rnorm(n, mean = 30, sd = 5),
    Forearm = rnorm(n, mean = 27, sd = 3),
    Wrist = rnorm(n, mean = 18, sd = 2)
  )
  
  if (all(simulated_data > 0)) {
    break
  }
}

# Truncate simulated values to the same number of digits of the original
simulated_data$Density <- round(simulated_data$Density, digits = 4)
simulated_data$Pct.BF <- round(simulated_data$Pct.BF, digits = 1)
simulated_data$Age <- round(simulated_data$Age, digits = 0)
simulated_data$Weight <- round(simulated_data$Weight, digits = 2)
simulated_data$Height <- round(simulated_data$Height, digits = 2)
simulated_data$Neck <- round(simulated_data$Neck, digits = 1)
simulated_data$Chest <- round(simulated_data$Chest, digits = 1)
simulated_data$Abdomen <- round(simulated_data$Abdomen, digits = 1)
simulated_data$Waist <- round(simulated_data$Waist, digits = 5)
simulated_data$Hip <- round(simulated_data$Hip, digits = 1)
simulated_data$Thigh <- round(simulated_data$Thigh, digits = 1)
simulated_data$Knee <- round(simulated_data$Knee, digits = 1)
simulated_data$Ankle <- round(simulated_data$Ankle, digits = 1)
simulated_data$Bicep <- round(simulated_data$Bicep, digits = 1)
simulated_data$Forearm <- round(simulated_data$Forearm, digits = 1)
simulated_data$Wrist <- round(simulated_data$Wrist, digits = 1)

# Remove duplicates
simulated_data <- simulated_data %>% distinct()

# Save simulated data as CSV for easy viewing
write_csv(simulated_data, "data/00-simulated_data/simulated_bodyfat.csv")