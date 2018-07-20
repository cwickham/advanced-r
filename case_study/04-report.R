library(tidyverse)
library(fs)

source("functions.R")

# Get file names and paths to data
files <- dir("data") %>% path_ext_remove()
file_paths <- path("data", files, ext = "csv") 
states <- str_sub(files, 1, 2)
states_long_names <- c(
  "OR" = "Oregon", 
  "BC" = "British Columbia", 
  "WA" = "Washington")[states]

# Check data isn't too old ------------------------------------------------
ages <- check_not_outdated(file_paths)

# Import data -------------------------------------------------------------
all_states <- map(file_paths, read_csv)

# Summarise by week -------------------------------------------------------
all_states_weekly <- map(all_states, summarise_weekly,
  date = date, var = n_sales, group = type)

# Plot weekly summary -----------------------------------------------------
all_states_plots <- map2(all_states_weekly, states_long_names, plot_ts,
  x = date, y = mean, group = type)

# Output plots ------------------------------------------------------------
image_paths <- path("images", 
  paste(files, "n_sales", sep = "_"))

walk2(image_paths, all_states_plots, ggsave_multiple,
  exts = c(".pdf", ".png"), height = 3, width = 8)
