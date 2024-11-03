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
library(arrow) # For saving data in Parquet format

#### Clean data ####
raw_data <- read_csv("data/01-raw_data/raw_data.csv")

# Select relevant columns and clean names
cleaned_data <-
  raw_data |>
  janitor::clean_names() |> # Clean column names to snake_case
  filter(pollster == "YouGov") |> # Pick one pollster
  select(poll_id, pollster, candidate_name, pct, party, start_date, end_date, sample_size) |>
  filter(!is.na(pct)) |> # Filter out rows where percentage (pct) is missing
  mutate(
    party = case_when(
      party == "DEM" ~ "Democratic",
      party == "REP" ~ "Republican",
      TRUE ~ party # Keep other parties unchanged
    ),
    candidate_name = as.factor(candidate_name),
    start_date = as.Date(start_date), # Assuming start_date is in standard format
    end_date = mdy(end_date) # If end_date is in "mm/dd/yyyy" format, adjust based on your data
  ) |>
  arrange(start_date) # Arrange data by the 'start_date'

#### Save data ####
write_parquet(cleaned_data, "data/02-analysis_data/analysis_data.parquet")

print("Data cleaned and saved as a Parquet file successfully.")
