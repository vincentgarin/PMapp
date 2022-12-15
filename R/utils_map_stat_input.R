#' map_stat_input
#'
#' @description Function to get the input for map
#'
#' @return map input values
#'
#' @noRd
map_stat_input <- function(id){

  selectInput(inputId = id, label = '',
              choices = list(average = 'av', `average share` = 'av_sh',
                             trend = 'tr', `share trend` = 'sh_tr'), selected = 'av_sh')

}
