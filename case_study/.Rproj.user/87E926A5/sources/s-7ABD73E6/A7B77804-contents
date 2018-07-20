# 04-report.R removes the functions to this external file
# checking date functions -------------------------------------------------
library(tidyverse)

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

# summarise functions -----------------------------------------------------

summarise_weekly <- function(data, date, var, group){
  date <- enquo(date)
  var <- enquo(var)
  group <- enquo(group)
  
  data %>%
    mutate(week = lubridate::week(!!date)) %>%
    group_by(!!group, week) %>%
    summarise(
      date = first(!!date),
      n = sum(!is.na(!!var)),
      mean = mean(!!var, na.rm = TRUE))  
}

# plotting functions ------------------------------------------------------

plot_ts <- function(data, x, y, group, title = ""){
  x <- enquo(x)
  y <- enquo(y)
  group <- enquo(group)
  
  data %>% 
    ggplot(aes(!!x, !!y, color =!!group)) + 
    geom_point(size = 3) +
    geom_line(alpha = 0.5) + 
    labs(title = title, 
      x = "Week starting",
      y = "Average number of sales per day") +
    theme_bw() +
    scale_color_brewer(type = "qual") 
}

ggsave_multiple <- function(filename, plot, exts, ...){
  paths <- paste0(filename, exts)
  
  walk(paths, ggsave, 
    plot = plot, ...)
}

