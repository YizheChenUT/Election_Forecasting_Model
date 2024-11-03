#### Preamble ####
# Purpose: Downloads and saves the data from FiveThirtyEight Presidential Polls.
# Author: Yizhe Chen
# Date: 22 OCT 2024
# Contact: yz.chen@mail.utoronto.ca
# License: MIT
# Pre-requisites: Must have access to the internet.
# Any other information needed? No


#### Workspace setup ####
library(httr) # For downloading data
library(tidyverse)

#### Download data ####
# Specify the URL for the data
url <- "https://projects.fivethirtyeight.com/polls/data/president_polls.csv"

# Use the GET function from the httr package to download the data
response <- GET(url)

# Check if the download is successful (status code 200 means success)
if (status_code(response) == 200) {
  # Parse the content as text and convert it to a data frame
  the_raw_data <- read_csv(content(response, as = "text"))

  #### Save data ####
  write_csv(the_raw_data, "data/01-raw_data/raw_data.csv")

  print("Data downloaded and saved successfully.")
} else {
  print(paste("Failed to download data. Status code:", status_code(response)))
}
