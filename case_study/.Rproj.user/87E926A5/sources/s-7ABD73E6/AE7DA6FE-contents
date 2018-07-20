library(tidyverse)
library(fs)

# Oregon -----------------------------------------------------------------
# ------------------------------------------------------------------------
or_file <- "OR_2018-07-15"
or_file_path <- path("data", or_file, ext = "csv")

# ------------------------------------------------------------------------
or_file_date <- or_file_path  %>%
  str_extract("[0-9]{4}-[0-9]{2}-[0-9]{2}") %>%
  parse_date()

or_days_old <- difftime(lubridate::today(), or_file_date, units = "days")

or_days_old > 30

# -------------------------------------------------------------------------
or <- read_csv(or_file_path)

# -------------------------------------------------------------------------
or_weekly <- 
  or %>%
  mutate(week = lubridate::week(date)) %>%
  group_by(type, week) %>%
  summarise(
    date = first(date),
    n = sum(!is.na(n_sales)),
    mean = mean(n_sales, na.rm = TRUE))  

or_weekly %>% 
  ggplot(aes(date, mean, color = type)) + 
    geom_point(size = 3) +
    geom_line(alpha = 0.5) + 
    labs(title = "Oregon", 
      x = "Week starting",
      y = "Average number of sales per day") +
    theme_bw() +
  scale_color_brewer(type = "qual")

image_path <- path("images", paste(or_file, "n_sales", sep = "_"))

ggsave(paste0(image_path, ".pdf"), height = 3, width = 8)
ggsave(paste0(image_path, ".png"), height = 3, width = 8)


# British Columbia -------------------------------------------------------
# ------------------------------------------------------------------------
bc_file <- "BC_2018-07-14"
bc_file_path <- path("data", bc_file, ext = "csv")

# ------------------------------------------------------------------------
bc_file_date <- bc_file_path  %>%
  str_extract("[0-9]{4}-[0-9]{2}-[0-9]{2}") %>%
  parse_date()

bc_days_old <- difftime(lubridate::today(), bc_file_date, units = "days")

bc_days_old > 30

# -------------------------------------------------------------------------
bc <- read_csv(bc_file_path)

# -------------------------------------------------------------------------
bc_weekly <- 
  bc %>%
  mutate(week = lubridate::week(date)) %>%
  group_by(type, week) %>%
  summarise(
    date = first(date),
    n = sum(!is.na(n_sales)),
    mean = mean(n_sales, na.rm = TRUE))

bc_weekly %>% 
  ggplot(aes(date, mean, color = type)) + 
  geom_point(size = 3) +
  geom_line(alpha = 0.5) + 
  labs(title = "British Columbia", 
    x = "Week starting",
    y = "Average number of sales per day") +
  theme_bw() +
  scale_color_brewer(type = "qual")

image_path <- path("images", paste(bc_file, "n_sales", sep = "_"))

ggsave(paste0(image_path, ".pdf"), height = 3, width = 8)
ggsave(paste0(image_path, ".png"), height = 3, width = 8)

# Washington -------------------------------------------------------------
# ------------------------------------------------------------------------
wa_file <- "WA_2018-07-18"
wa_file_path <- path("data", wa_file, ext = "csv")

# ------------------------------------------------------------------------
wa_file_date <- wa_file_path  %>%
  str_extract("[0-9]{4}-[0-9]{2}-[0-9]{2}") %>%
  parse_date()

wa_days_old <- difftime(lubridate::today(), wa_file_date, units = "days")

wa_days_old > 30

# -------------------------------------------------------------------------
wa <- read_csv(wa_file_path)

# -------------------------------------------------------------------------
wa_weekly <- wa %>%
  mutate(week = lubridate::week(date)) %>%
  group_by(type, week) %>%
  summarise(
    date = first(date),
    n = sum(!is.na(n_sales)),
    mean = mean(n_sales, na.rm = TRUE)) 

wa_weekly %>% 
  ggplot(aes(date, mean, color = type)) + 
  geom_point(size = 3) +
  geom_line(alpha = 0.5) + 
  labs(title = "Washington", 
    x = "Week starting",
    y = "Average number of sales per day") +
  theme_bw() +
  scale_color_brewer(type = "qual")

image_path <- path("images", paste(wa_file, "n_sales", sep = "_"))

ggsave(paste0(image_path, ".pdf"), height = 3, width = 8)
ggsave(paste0(image_path, ".png"), height = 3, width = 8)
