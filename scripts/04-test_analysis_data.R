#### Preamble ####
# Purpose: Tests the structure and validity of the cleaned presidential polling dataset.
# Author: Yizhe Chen
# Date: 3 Nov 2024
# Contact: yz.chen@mail.utoronto.ca
# License: MIT
# Pre-requisites: The `tidyverse` and `testthat` packages must be installed and loaded
# Any other information needed? No

#### Workspace setup ####
library(tidyverse)
library(testthat)
library(arrow)

# Read data from Parquet file
data <- read_parquet("data/02-analysis_data/analysis_data.parquet")


#### Test data ####

# Test that the dataset has more than 100 rows (adjust as needed for expected data size)
test_that("dataset has more than 100 rows", {
  expect_gt(nrow(data), 100)
})

# Test that the dataset has 8 columns (poll_id, pollster, candidate_name, pct, party, start_date, end_date, sample_size)
test_that("dataset has 8 columns", {
  expect_equal(ncol(data), 8)
})

# Test that columns are of the expected types
test_that("columns have correct data types", {
  expect_type(data$poll_id, "double")
  expect_type(data$pollster, "character")
  expect_type(data$candidate_name, "integer")
  expect_type(data$pct, "double")
  expect_type(data$party, "character")
  expect_type(data$sample_size, "double")
})

# Test that 'pct' column values are within the range of 0 to 100
test_that("pct values are between 0 and 100", {
  expect_true(all(data$pct >= 0 & data$pct <= 100))
})


# Test that 'sample_size' has realistic values (not more than 5000)
test_that("'sample_size' column values are within a realistic range", {
  expect_true(all(data$data$sample_size <= 5000))
})


# Test that 'party' column has at least 2 unique values to ensure variability
test_that("'party' column contains at least 2 unique values", {
  expect_true(length(unique(data$party)) >= 2)
})


# Test that 'pollster' column only contains "YouGov" since we filtered for this in cleaning
test_that("pollster column contains only 'YouGov'", {
  expect_true(all(data$pollster == "YouGov"))
})


# Test that 'pct' column has no negative values
test_that("'pct' column has no negative values", {
  expect_true(all(data$pct >= 0))
})


# Test that 'candidate_name' column has at least 3 unique names (to ensure variability)
test_that("'candidate_name' column has at least 3 unique values", {
  expect_true(length(unique(data$candidate_name)) >= 3)
})
