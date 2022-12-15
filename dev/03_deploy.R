# Building a Prod-Ready, Robust Shiny Application.
#
# README: each step of the dev files is optional, and you don't have to
# fill every dev scripts before getting started.
# 01_start.R should be filled at start.
# 02_dev.R should be used to keep track of your development during the project.
# 03_deploy.R should be used once you need to deploy your app.
#
#
######################################
#### CURRENT FILE: DEPLOY SCRIPT #####
######################################

# Test your app

## Run checks ----
## Check the package before sending to prod
devtools::check()

# possibility to run RCMD check on any of the R-hub architecture: Windows, macOS, Solaris, Linux
# rhub::check_for_cran()

# Deploy

## Local, CRAN or Package Manager ----
## This will build a tar.gz that can be installed locally,
## sent to CRAN, or to a package manager
devtools::build()

## RStudio ----
## If you want to deploy on RStudio related platforms
# golem::add_rstudioconnect_file()
golem::add_shinyappsio_file()
# golem::add_shinyserver_file()

# Deploy the app:

rsconnect::setAccountInfo(name='agrvis',
                          token='BA3556E744252F0AAE86C197FD59E4CD',
                          secret='QTzqAjE4m8IYyxBrHFeEXpeI64aItRbmjdwWBHo8')

rsconnect::deployApp()

# cycle is completed: from development to deployment

## Docker ----
## If you want to deploy via a generic Dockerfile
# golem::add_dockerfile_with_renv()

## If you want to deploy to ShinyProxy
# golem::add_dockerfile_with_renv_shinyproxy()

