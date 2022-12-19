#' tr_f_error
#'
#' @description A utils function
#'
#' @return The return value, if any, from executing the utility.
#'
#' @noRd
tr_f_error <- function(x, y){
  m <- tryCatch( lm(y ~ x), error = function(e) NULL)
  if(!is.null(m)){res <- coef(m)[2]} else {res <- NA }
  return(res)}
