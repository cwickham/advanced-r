# A polite helper for installing packages ---------------------------------

please_install <- function(pkgs, install_fun = install.packages) {
  if (length(pkgs) == 0) {
    return(invisible())
  }
  if (!interactive()) {
    stop("Please run in interactive session", call. = FALSE)
  }

  title <- paste0(
    "Ok to install these packges?\n",
    paste("* ", pkgs, collapse = "\n")
  )
  ok <- menu(c("Yes", "No"), title = title) == 1

  if (!ok) {
    return(invisible())
  }

  install_fun(pkgs)
}

# Do you have all the needed packages? ------------------------------------

tidytools <- c(
  "usethis", "rlang", "devtools", "tidyverse", "fs",
  "rstudioapi"
  )

have <- rownames(installed.packages())
needed <- setdiff(tidytools, have)

please_install(needed)


# lobstr ------------------------------------------------------------------

if (!"lobstr" %in% have) {
  please_install("hadley/lobstr", devtools::install_github)
}

# Do you have the latest ggplot2 ? ----------------------------------------
# It was updated recently so if you've used it before you might
# have an old version

if (packageVersion("ggplot2") < "3.0.0") {
  please_install("ggplot2")
}

# Do you have the latest RStudio? ---------------------------------------

if (rstudioapi::getVersion() < "1.1.419") {
  cat("Please install RStudio from http://rstd.io/download-ide\n")
}
