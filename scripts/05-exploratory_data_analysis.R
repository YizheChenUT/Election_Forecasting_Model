#### Preamble ####
# Purpose: Models polling data for YouGov
# Author: Yizhe Chen
# Date: 22 OCT 2024
# Contact: yz.chen@mail.utoronto.ca
# License: MIT
# Pre-requisites: Must have cleaned polling data.
# Any other information needed? No


#### Workspace setup ####
library(tidyverse)
library(rstanarm)

#### Read data ####
analysis_data <- read_csv("data/02-analysis_data/analysis_data.csv")

#### Filter YouGov data ####
yougov_data <- analysis_data %>%
  filter(pollster == "YouGov")

### Model data ####
# Predict candidate percentage ('pct') based on pollster rating and party
yougov_model <-
  stan_glm(
    formula = pct ~ party,
    data = yougov_data,
    family = gaussian(),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_aux = exponential(rate = 1, autoscale = TRUE),
    seed = 853
  )


#### Save model ####
saveRDS(
  yougov_model,
  file = "models/yougov_model.rds"
)

#### Model summary ####
print(summary(yougov_model))
