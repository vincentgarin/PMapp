#' scatplot_reg
#'
#' @description Scatterplot with linear regression
#'
#' @return plot.
#'
#' @noRd
scatplot_reg <- function(d, ylab, main) {

  p <- ggplot(d, aes(x = year, y = y)) + geom_point() +
    geom_smooth(method='lm', formula= y~x) +
    labs(y = ylab, title = main)
  p

}
