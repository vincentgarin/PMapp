#' plot_sel_dist
#'
#' @description A fct function
#'
#' @return The return value, if any, from executing the function.
#'
#' @noRd
plot_sel_dist <- function(d_poly, sel_dist){

  d_poly <- mdf_map_polygon(d_poly)

  d_poly$param[d_poly$dist_code %in% sel_dist] <- 'sel.'

  p <- ggplot(d_poly, aes(x = long, y = lat, group = dist)) +
    geom_polygon(colour='black', aes(fill=param, group = dist)) +
    labs(x = 'lon') + ggtitle('Selected districts') +
    theme(legend.position = 'none')

  return(p)

}
