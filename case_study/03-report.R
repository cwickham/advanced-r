library(tidyverse)
library(fs)

# Get file names and paths to data
files <- dir("data") %>% path_ext_remove()
file_paths <- path("data", files, ext = "csv") 
states <- str_sub(files, 1, 2)
states_long_names <- c(
  "OR" = "Oregon", 
  "BC" = "British Columbia", 
  "WA" = "Washington")[states]

# Check data isn't too old -----------------------------------------------

file_date <- function(path){
  path %>%
    str_extract("[0-9]{4}-[0-9]{2}-[0-9]{2}") %>%
    parse_date()
}

file_age <- function(path){
  difftime(lubridate::today(), file_date(path), units = "days")
}

check_not_outdated <- function(path, threshold_days = 30){
  age <- file_age(path)
  old <- age > threshold_days
  
  if(any(old)){
    old_files <- paste(path[old], "is", age[old], "days old", collapse = ", \n* ")
    stop(paste("Some files are outdated: \n*", old_files), call. = FALSE)
  }
  message("No files are outdated")
  invisible(age)
}

ages <- check_not_outdated(file_paths)

# Import data -------------------------------------------------------------

all_states <- map(file_paths, read_csv)

# Summarise by week -------------------------------------------------------

summarise_weekly <- function(data){
  data %>%
    mutate(week = lubridate::week(date)) %>%
    group_by(type, week) %>%
    summarise(
      date = first(date),
      n = sum(!is.na(n_sales)),
      mean = mean(n_sales, na.rm = TRUE))  
}

all_states_weekly <- map(all_states, summarise_weekly)

# Plot weekly summary -----------------------------------------------------

plot_weekly <- function(data, title){
  data %>% 
    ggplot(aes(date, mean, color = type)) + 
    geom_point(size = 3) +
    geom_line(alpha = 0.5) + 
    labs(title = title, 
      x = "Week starting",
      y = "Average number of sales per day") +
    theme_bw() +
    scale_color_brewer(type = "qual") 
}

all_states_plots <- map2(all_states_weekly, states_long_names, plot_weekly)

# Output plots ------------------------------------------------------------

ggsave_multiple <- function(filename, plot, exts, ...){
  paths <- paste0(filename, exts)
  
  walk(paths, ggsave, 
    plot = plot, ...)
}

image_paths <- path("images", 
  paste(files, "n_sales", sep = "_"))

walk2(image_paths, all_states_plots, ggsave_multiple,
  exts = c(".pdf", ".png"), height = 3, width = 8)
