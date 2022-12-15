# Building a Prod-Ready, Robust Shiny Application.
#
# README: each step of the dev files is optional, and you don't have to
# fill every dev scripts before getting started.
# 01_start.R should be filled at start.
# 02_dev.R should be used to keep track of your development during the project.
# 03_deploy.R should be used once you need to deploy your app.
#
#
###################################
#### CURRENT FILE: DEV SCRIPT #####
###################################

setwd('C:/Users/vince/OneDrive/Documents/WD/Programming/Shiny/test/PMapp')
library(here)
here()

# Engineering

## Dependencies ----
## Amend DESCRIPTION with dependencies read from package code parsing
## install.package('attachment') # if needed.
attachment::att_amend_desc()

## Add some extra dependency
usethis::use_package("ggplot2")
usethis::use_package("shinyWidgets")
usethis::use_package("dplyr")

## Add modules ----
## Create a module infrastructure in R/
golem::add_module(name = "name_of_module1", with_test = TRUE) # Name of the module
golem::add_module(name = "name_of_module2", with_test = TRUE) # Name of the module

# list of modules added:

# General parameter. can be used for area, prod, yield ...
golem::add_module(name = "par_gen", with_test = TRUE)

## Add helper functions: smaller functions
## Creates fct_* and utils_*
golem::add_fct("helpers", with_test = TRUE)
golem::add_utils("helpers", with_test = TRUE)

golem::add_utils("m_f", with_test = TRUE)
golem::add_utils("tr_f", with_test = TRUE)

# add generic functions for input
golem::add_utils("input_district", with_test = FALSE)
golem::add_utils("year_input", with_test = FALSE)
golem::add_utils("map_stat_input", with_test = FALSE)

# functions required by the first module (par_gen - area)
golem::add_fct("average_trend", with_test = FALSE)
golem::add_fct("share_trend", with_test = FALSE)
golem::add_fct("d_trend", with_test = FALSE)
golem::add_fct("d_share", with_test = FALSE)
golem::add_fct("scatplot_reg", with_test = FALSE)
golem::add_fct("plot_map_av_sh_tr", with_test = FALSE)
golem::add_fct("plot_map", with_test = FALSE)


## External resources
## Creates .js and .css files at inst/app/www
golem::add_js_file("script")
golem::add_js_handler("handlers")
golem::add_css_file("custom")
golem::add_sass_file("custom")

## Add internal datasets ----
## If you have data in your package
usethis::use_data_raw(name = "my_dataset", open = FALSE)

setwd('C:/Users/vince/OneDrive/Documents/WD/Programming/Shiny/data/PM')
load('PM_prod.RData')
load('d_cr_area.RData')
load('d_cr_prod.RData')
load('d_poly.RData')
load('dist_list.RData')
load('dist_list_name.RData')
load('data_CM.RData')

setwd(here())

# store data as interal data that are available to all function
# from R folder

# need to load everything in one go. No append...

usethis::use_data(PM_prod, d_cr_area, d_cr_prod, d_poly, dist_list, d_list_nm,
                  data_CM, compress = 'xz', overwrite = TRUE, internal = TRUE)

# usethis::use_data(PM_prod, compress = 'xz', overwrite = TRUE, internal = TRUE)
# usethis::use_data(d_cr_area, compress = 'xz', overwrite = TRUE, internal = TRUE)
# usethis::use_data(d_cr_prod, compress = 'xz', overwrite = TRUE, internal = TRUE)
# usethis::use_data(d_poly, compress = 'xz', overwrite = TRUE, internal = TRUE)
# usethis::use_data(dist_list, compress = 'xz', overwrite = TRUE, internal = TRUE)
# usethis::use_data(d_list_nm, compress = 'xz', overwrite = TRUE, internal = TRUE)
# usethis::use_data(data_CM, compress = 'xz', overwrite = TRUE, internal = TRUE)

# Document the datasets
# use_r('data_PM_prod')

# add the standard information to the data documentation

#' data ...
#'
#' Data description
#'
#' @format A data frame
#'
#' @examples
#' data(my_data)
"my_data"

## Tests ----
## Add one line by test you want to create
usethis::use_test("app")

# Documentation

## Vignette ----
usethis::use_vignette("PMapp")
devtools::build_vignettes()

## Code Coverage----
## Set the code coverage service ("codecov" or "coveralls")
usethis::use_coverage()

# Create a summary readme for the testthat subdirectory
covrpage::covrpage()

## CI ----
## Use this part of the script if you need to set up a CI
## service for your application
##
## (You'll need GitHub there)
usethis::use_github()

# GitHub Actions
usethis::use_github_action()
# Chose one of the three
# See https://usethis.r-lib.org/reference/use_github_action.html
usethis::use_github_action_check_release()
usethis::use_github_action_check_standard()
usethis::use_github_action_check_full()
# Add action for PR
usethis::use_github_action_pr_commands()

# Travis CI
usethis::use_travis()
usethis::use_travis_badge()

# AppVeyor
usethis::use_appveyor()
usethis::use_appveyor_badge()

# Circle CI
usethis::use_circleci()
usethis::use_circleci_badge()

# Jenkins
usethis::use_jenkins()

# GitLab CI
usethis::use_gitlab_ci()

# You're now set! ----
# go to dev/03_deploy.R
rstudioapi::navigateToFile("dev/03_deploy.R")

# test that the app functions

library(PMapp)
PMapp::run_app()
