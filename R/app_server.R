#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @import dplyr
#' @import ggplot2
#' @import glue
#' @import htmltools
#' @import shinyWidgets
#' @importFrom stats coef dist lm
#' @noRd

app_server <- function(input, output, session) {

  # General area
  mod_par_gen_server("par_gen_area")

}
