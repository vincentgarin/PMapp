#' tr_f
#'
#' @description trend function
#'
#' @return trend (slope) value.
#'
#' @noRd

tr_f <- function(x, y){ m <- lm(y ~ x); coef(m)[2]}
