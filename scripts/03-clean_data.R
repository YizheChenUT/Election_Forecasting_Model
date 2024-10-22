#### Preamble ####
# Purpose: Cleans the raw presidential polling data from FiveThirtyEight.
# Author: Yizhe Chen
# Date: 22 OCT 2024
# Contact: yz.chen@mail.utoronto.ca
# License: MIT
# Pre-requisites: Must have downloaded the raw data.
# Any other information needed? No

#### Workspace setup ####
library(tidyverse)
library(janitor)

#### Clean data ####
raw_data <- read_csv("data/01-raw_data/raw_data.csv")

# Select relevant columns and clean names
cleaned_data <-
  raw_data |>
  janitor::clean_names() |>  # Clean column names to snake_case
  select(poll_id, pollster, pollster_rating_name, pollster_rating_id, candidate_name, pct, party, start_date, end_date) |> 
  filter(!is.na(pct)) |>      # Filter out rows where percentage (pct) is missing
  mutate(
    party = case_when(
      party == "DEM" ~ "Democratic",
      party == "REP" ~ "Republican",
      TRUE ~ party    # Keep other parties unchanged
    )
  ) |> 
  arrange(start_date)           # Arrange data by poll date

#### Save data ####
write_csv(cleaned_data, "data/02-analysis_data/analysis_data.csv")

print("Data cleaned and saved successfully.")