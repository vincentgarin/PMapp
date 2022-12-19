#' plot_site
#'
#' @description Plot of testing site
#'
#' @return Map with the testing sites plotted
#'
#' @noRd
plot_site <- function(d_poly, d_clu, d_site, s_site, n_env = 5, text.size = 16){

  d_poly <- d_poly %>% filter(lat > 10, lat < 32, long < 85)

  env_lk <- d_clu[, n_env - 1]
  names(env_lk) <- d_clu$dist

  # col_palette <- c("#FFFFFF", "#A63603", "goldenrod3", "#FDAE6B", "#E6550D", "#6B6100")
  col_palette <- c('white', 'wheat1', 'orchid1', 'grey', 'olivedrab1', 'khaki1')

  d_poly$Env <- env_lk[d_poly$dist]
  d_poly$Env <- as.character(d_poly$Env)
  d_poly$Env[is.na(d_poly$Env)] <- ''

  p_map <- ggplot(d_poly, aes(x = long, y = lat, group = dist)) +
    geom_polygon(colour='black', aes(fill=Env, group = dist)) +
    scale_fill_manual(values=col_palette) +
    geom_point(data=d_site[s_site, ], aes(long, lat), inherit.aes = FALSE, alpha = 1, size = 3,
               col = 'black', shape = 18) +
    coord_equal() + ggtitle('Testing sites') + theme(axis.title.x = element_text(size=text.size),
                                                     axis.title.y = element_text(size=text.size),
                                                     axis.text.x  = element_text(size=text.size),
                                                     axis.text.y = element_text(size = text.size),
                                                     strip.text.x =  element_text(size=text.size),
                                                     legend.title = element_text(size=(text.size)),
                                                     legend.text = element_text(size=(text.size)))


  p_map

}
