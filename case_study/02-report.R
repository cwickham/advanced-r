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
or_file <- "OR_2018-07-15"
or_file_path <- path("data", or_file, ext = "csv")

wa_file <- "WA_2018-07-18"
wa_file_path <- path("data", wa_file, ext = "csv")

bc_file <- "BC_2018-07-14"
bc_file_path <- path("data", bc_file, ext = "csv")

or <- read_csv(or_file_path)
bc <- read_csv(bc_file_path)
wa <- read_csv(wa_file_path)

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

or_weekly <- summarise_weekly(or)
bc_weekly <- summarise_weekly(bc)
wa_weekly <- summarise_weekly(wa)


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

or_plot <- plot_weekly(or_weekly, "Oregon")
bc_plot <- plot_weekly(bc_weekly, "British Columbia")
wa_plot <- plot_weekly(wa_weekly, "Washington")

# Output plots ------------------------------------------------------------

or_image_path <- path("images", paste(or_file, "n_sales", sep = "_"))
bc_image_path <- path("images", paste(bc_file, "n_sales", sep = "_"))
wa_image_path <- path("images", paste(wa_file, "n_sales", sep = "_"))

ggsave(paste0(or_image_path, ".pdf"), or_plot, height = 3, width = 8)
ggsave(paste0(or_image_path, ".png"), or_plot, height = 3, width = 8)

ggsave(paste0(bc_image_path, ".pdf"), bc_plot, height = 3, width = 8)
ggsave(paste0(bc_image_path, ".png"), bc_plot, height = 3, width = 8)

ggsave(paste0(wa_image_path, ".pdf"), wa_plot, height = 3, width = 8)
ggsave(paste0(wa_image_path, ".png"), wa_plot, height = 3, width = 8)
