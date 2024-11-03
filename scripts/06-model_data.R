#### Preamble ####
# Purpose: Models polling data for a single pollster (YouGov) officially.
# Author: Yizhe Chen
# Date: 22 OCT 2024
# Contact: yz.chen@mail.utoronto.ca
# License: MIT
# Pre-requisites: Must have cleaned polling data.
# Any other information needed? No


#### Workspace setup ####
library(tidyverse)
library(rstanarm)
library(arrow)

#### Read data ####
analysis_data <- read_parquet("data/02-analysis_data/analysis_data.parquet")


### Model data ####
# Model with multiple predictors
first_model <-
  stan_glm(
    formula = pct ~ party + candidate_name + sample_size + end_date,
    data = analysis_data,
    family = gaussian(),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_aux = exponential(rate = 1, autoscale = TRUE),
    seed = 853
  )


#### Save model ####
saveRDS(
  first_model,
  file = "models/final_model.rds"
)
