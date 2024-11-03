#### Preamble ####
# Purpose: Tests the structure and validity of the simulated U.S. presidential election polling dataset.
# Author: Yizhe Chen
# Date: 3 Nov 2024
# Contact: yz.chen@mail.utoronto.ca
# License: MIT
# Pre-requisites:
# - The `tidyverse` package must be installed and loaded
# - 00-simulate_data.R must have been run
# Any other information needed? No


#### Workspace setup ####
library(tidyverse)
library(arrow)

# Load the simulated dataset
simulated_data <- read_parquet("data/00-simulated_data/simulated_data.parquet")

# Test if the data was successfully loaded
if (exists("simulated_data")) {
  message("Test Passed: The dataset was successfully loaded.")
} else {
  stop("Test Failed: The dataset could not be loaded.")
}


#### Test data ####

# Check if the dataset has 200 rows
if (nrow(simulated_data) == 200) {
  message("Test Passed: The dataset has 200 rows.")
} else {
  stop("Test Failed: The dataset does not have 200 rows.")
}

# Check if the dataset has 6 columns
if (ncol(simulated_data) == 6) {
  message("Test Passed: The dataset has 6 columns.")
} else {
  stop("Test Failed: The dataset does not have 6 columns.")
}

# Check if the 'poll_id' column values are unique
if (n_distinct(simulated_data$poll_id) == nrow(simulated_data)) {
  message("Test Passed: All values in 'poll_id' are unique.")
} else {
  stop("Test Failed: The 'poll_id' column contains duplicate values.")
}

# Check if the 'party' column contains only valid U.S. party names
valid_parties <- c("Democrat", "Republican", "Independent", "Green")

if (all(simulated_data$party %in% valid_parties)) {
  message("Test Passed: The 'party' column contains only valid U.S. party names.")
} else {
  stop("Test Failed: The 'party' column contains invalid party names.")
}

# Check if the 'sample_size' column has realistic values (between 500 and 3000)
if (all(simulated_data$sample_size >= 500 & simulated_data$sample_size <= 3000)) {
  message("Test Passed: The 'sample_size' column values are within the realistic range.")
} else {
  stop("Test Failed: The 'sample_size' column has values outside the realistic range.")
}

# Check if 'end_date' values are within 6 months prior to 2024-11-05
min_date <- as.Date("2024-05-05")
max_date <- as.Date("2024-11-05")

if (all(simulated_data$end_date >= min_date & simulated_data$end_date <= max_date)) {
  message("Test Passed: The 'end_date' column values are within the expected date range.")
} else {
  stop("Test Failed: The 'end_date' column contains dates outside the expected range.")
}

# Check if 'pct' column has values between 25% and 75%
if (all(simulated_data$pct >= 25 & simulated_data$pct <= 75)) {
  message("Test Passed: The 'pct' column values are within the realistic range of 25-75%.")
} else {
  stop("Test Failed: The 'pct' column has values outside the realistic range.")
}

# Check if there are no missing values in the dataset
if (all(!is.na(simulated_data))) {
  message("Test Passed: The dataset contains no missing values.")
} else {
  stop("Test Failed: The dataset contains missing values.")
}

# Check if 'party' column has at least two unique values (to confirm variability)
if (n_distinct(simulated_data$party) >= 2) {
  message("Test Passed: The 'party' column contains at least two unique values.")
} else {
  stop("Test Failed: The 'party' column contains less than two unique values.")
}
