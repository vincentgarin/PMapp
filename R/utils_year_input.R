#' year_input
#'
#' @description Year input
#'
#' @return sliderInput to select years
#'
#' @noRd
year_input <- function(id, label = 'Select year range', min = 1998, max = 2017){

  sliderInput(inputId =id, label = label, min = min,
              max = max, value = c(min, max), step = 1, ticks = FALSE)

}
