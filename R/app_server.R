#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @import dplyr
#' @import ggplot2
#' @import glue
#' @import htmltools
#' @import pkgload
#' @import shinyWidgets
#' @importFrom stats coef dist lm
#' @noRd

app_server <- function(input, output, session) {

  # General area
  mod_par_gen_server("par_gen_area")

  # General production
  mod_par_gen_server("par_gen_prod", data = d_cr_prod, s_var = 'prod', par_nm = 'production',
                     unit_nm = 'tons', col_plot = 'brown', v_nm = 'Ktons')

  # General yield
  mod_par_yield_server("par_yield")

  # Area share
  mod_par_share_server("par_share_area")

  # Production share
  mod_par_share_server("par_share_prod", data = d_cr_prod, par_nm = 'production')

  # comparison competitors yield
  mod_comp_yield_server("comp_yield")

  # Area share
  mod_par_comp_server("par_comp_area")

  # Area share
  mod_par_comp_server("par_comp_prod", data = d_cr_prod, par_nm = 'production')

  # Soil type
  mod_soil_type_server("soil_type")

  # rain pattern
  mod_rain_pattern_server("rain_pattern")

  # mgt practice - irrigation
  mod_mgt_param_server("mgt_param_irrig")

  # mgt practice - irrigation
  mod_mgt_param_server("mgt_param_fert", s_var = 'fert', var_nm = 'N Fert.',
                       pb_dist = "SAMBHAL",
                       col_high = 'violet', unit_nm = 'kg/ha')

  # economics - price
  mod_mgt_param_server("mgt_param_price", s_var = 'price', var_nm = 'Price',
                       pb_dist = c("SAMBHAL", "Kasganj"),
                       col_high = 'springgreen3', unit_nm = 'INR/100kg')

  # plot testing sites
  mod_test_site_server("test_site")

  # Crop model prediction
  mod_CM_prediction_server("CM_prediction")

}
