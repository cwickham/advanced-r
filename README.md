Advanced R
================
Charlotte Wickham
July 2018

This repo currently reflects a version delivered at the JSM July 2018, Vancouver, BC.

Older versions include:

-   [July 2018 at BC Stats, Victoria, BC](https://github.com/cwickham/advanced-r/tree/v1.0)

Overview
--------

Move from using other peoples' functions to writing your own! This course focuses on some of the key programming techniques in R that will move you to the next level.

You'll get the most from this course if you have some R programming experience already: you've written a few R functions and are comfortable with R's basic data structures (vectors, lists and data frames).

We'll start with a review of some R fundamentals before jumping into writing functions in R. You'll learn some strategies for getting started, and making your functions easy for others to use.

Once you've mastered writing functions, you'll learn about the ways functions can be used in R, like functions that write other functions and functions as arguments to functions - key elements of functional programming. You'll also learn about `purrr`, a package that enhances R's functional programming toolkit.

Finally, you'll learn about tidy evaluation: a framework for creating domain specific languages. Tidy evaluation makes it easy for you to program with functions that use it (e.g. functions in the tidyverse like `dplyr::filter()` and `tidyr::spread()`).

Learning Objectives
-------------------

By the end of the workshop you'll be able to:

> Remove repetition in your code so that is more clearly expresses what you did, not the details of how you did it.

We'll work towards this goal with three modules: functions, functional programming and tidy evaluation.

-   **Functions**: reduce repetitive code by extracting a common action into a function:

    -   Identify when to write a function, and use a strategy for how to write a function
    -   Apply good design principles to make your functions easy for you and others to use

-   **Functional Programming**: reduce repetitive code by having functions write for loops for you:

    -   Describe what it means that functions in R are first class citizens
    -   Solve iteration problems using `purrr::map()` and friends
    -   Avoid a single error stopping iteration with `purrr::safely()`

-   **Tidy evaluation**: write functions that wrap tidyverse functions:

    -   Identify arguments in functions that are automatically quoted
    -   Refer to a saved variable in the quoted arguments of a tidyverse function
    -   Wrap a tidyverse function inside your own function by combining `quo()` and `!!`

Recommended reading
-------------------

I'll assume you are comfortable with R's basic data structures. If you are feeling rusty, skim "Vectors" <http://r4ds.had.co.nz/vectors.html> in R for Data Science.

The final part of the day will cover tidy evaluation: an approach to programming with tidyverse functions. As such, I'll assume you are familiar with ggplot2 and dplyr. If you aren't, I'd suggest reading the following chapters of "R for Data Science" before you come:

-   Data Visualization, <http://r4ds.had.co.nz/data-visualisation.html>
-   Data Transformation, <http://r4ds.had.co.nz/transform.html>

On the day of the course, I'll share an electronic copy of the slides, code and data with you via dropbox.

R setup
-------

The course is hands on, so you'll need **a laptop with a recent version of R**. Run the following code to get the necessary packages:

``` r
install.packages(c(
  "usethis", "rlang", "devtools",
  "tidyverse", "fs"
))

devtools::install_github("r-lib/lobstr")
```

If you've installed the tidyverse before, re-installing it may not update all the component packages, in which case run,

``` r
tidyverse::tidyverse_update()
```

to identify any out-of-date packages, and follow the instructions to update them.

If you use RStudio, please make sure you have RStudio 1.1, which you can download from <https://www.rstudio.com/products/rstudio/download/#download>

If you often work on a network drive, it is worth verifying you can load the above packages when you are not connected to the internet, just in case there are wifi problems on the day.

If you have any problems with the setup, please come a little early and we'll help you get configured.

Getting the materials
---------------------

To download the materials, open RStudio and on the Console run:

``` r
usethis::use_course("bit.ly/advr-jul18")
```

After a pause, you'll be asked a few questions about the download process. The materials will be downloaded, unzipped to your Desktop, and a new RStudio session will open.

You only need to do this once. If you close RStudio, and want to pick it up again later (i.e. on the day of the training):

1.  Navigate to where the folder was downloaded (this should be a folder called `advanced-r-master` on your **Desktop**)
2.  Double-click the file `advanced-r.Rproj` to open up RStudio

Instructor Details
------------------

Charlotte Wickham
<cwickham@gmail.com>
@cvwickham
<http://cwick.co.nz>
