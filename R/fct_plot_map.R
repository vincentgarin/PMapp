#' plot_map
#'
#' @description plot map
#'
#' @param d_poly map polygon data
#'
#' @param p_val vector of parameter values
#'
#' @param dist_code vector of districts codes
#'
#' @param col_low color of the lower parameter value
#'
#' @param col_mid color of the mid parameter value
#'
#' @param col_high color of the high parameter value
#'
#' @param main title of the plot
#'
#' @return plot.
#'
#' @noRd
plot_map <- function(d_poly, p_val, dist_code, col_low = 'white', col_mid = NULL,
                     col_high = 'blue', v_name, main){

  p_lk <- p_val
  names(p_lk) <- dist_code
  d_poly$param <- p_lk[as.character(d_poly$dist_code)]

  p <- ggplot(d_poly, aes(x = long, y = lat, group = dist)) +
    geom_polygon(colour='black', aes(fill=param, group = dist)) +
    labs(title = main, x = 'lon')

  if(is.null(col_mid)){

    p <- p + scale_fill_gradient(low = col_low, high = col_high, name = v_name)

  } else {

    p <- p + scale_fill_gradient2(low = col_low, mid = col_mid, high = col_high, name = v_name)

  }

  p

}
