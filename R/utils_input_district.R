#' input_district
#'
#' @description District selection
#'
#' @return selectInput function to select districts
#'
#' @noRd
input_district <- function(id, label = 'Selected districts(s)',
                           choices = d_list_nm){

  selectInput(inputId = id, label = label, choices = choices, multiple = TRUE,
              selected = 'all')

}
