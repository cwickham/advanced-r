# Exactly the same as 04-report.R, but store things in a tibble
library(tidyverse)
library(fs)

source("functions.R")

sales <- tibble(
  files = dir("data") %>% path_ext_remove(),
  file_paths = path("data", files, ext = "csv"), 
  states = str_sub(files, 1, 2),
  states_long_names = c(
    "OR" = "Oregon", 
    "BC" = "British Columbia", 
    "WA" = "Washington")[states]
)

sales 

# Check data isn't too old ------------------------------------------------
sales <- sales %>% 
  mutate(ages = check_not_outdated(file_paths))

# Import data -------------------------------------------------------------
sales <- sales %>% 
  mutate(data = map(file_paths, read_csv))

# Summarise by week -------------------------------------------------------
sales <- sales %>% 
  mutate(weekly_n_sales = map(data, summarise_weekly,
   date = date, var = n_sales, group = type))

# Plot weekly summary -----------------------------------------------------
sales <- sales %>% 
  mutate(n_sales_weekly_plot = map2(weekly_n_sales, states_long_names, plot_ts,
    x = date, y = mean, group = type))

# Output plots ------------------------------------------------------------
sales <- sales %>% 
  mutate(image_paths = path("images", paste(files, "n_sales", sep = "_")))

with(sales, walk2(image_paths, n_sales_weekly_plot, ggsave_multiple,
  exts = c(".pdf", ".png"), height = 3, width = 8))

sales
