#### Preamble ####
# Purpose: Simulates a dataset of U.S. presidential election polling data,  including candidate, party, sample size, and predicted vote percentage.
# Author: Yizhe Chen
# Date: 3 Nov 2024
# Contact: Yizhe Chen
# License: MIT
# Pre-requisites: The `tidyverse` package must be installed
# Any other information needed? No


#### Workspace setup ####
library(tidyverse)
library(arrow) # For saving data in Parquet format
set.seed(853)


#### Simulate data ####
# Candidate names
candidates <- c(
  "Joe Biden", "Donald Trump", "Kamala Harris", "Ron DeSantis",
  "Bernie Sanders", "Nikki Haley", "Elizabeth Warren", "Vivek Ramaswamy"
)

# Political parties
parties <- c("Democrat", "Republican", "Independent", "Green")

# Simulate the dataset with sample size and vote percentage
simulated_data <- tibble(
  poll_id = 1:200,
  candidate_name = sample(candidates, size = 200, replace = TRUE),
  party = sample(parties, size = 200, replace = TRUE, prob = c(0.45, 0.45, 0.05, 0.05)),
  sample_size = sample(500:3000, size = 200, replace = TRUE),
  end_date = as.Date("2024-11-05") - sample(1:180, size = 200, replace = TRUE), # random dates within 6 months
  pct = round(runif(200, min = 25, max = 75), 1) # random vote percentage between 25% and 75%
)


#### Save data ####
write_parquet(simulated_data, "data/00-simulated_data/simulated_data.parquet")
