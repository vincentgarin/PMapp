#' plot_soil_maj
#'
#' @description Plot soil type
#'
#' @return Map with soil type
#'
#' @noRd
plot_soil_maj <- function(data, d_poly, sel_dist){

  d_poly <- mdf_map_polygon(d_poly)

  d_p <- data %>% filter(!is.na(env), dist_code %in% sel_dist) %>% group_by(dist_name2) %>%
    summarise(soil = unique(soil))

  soil_id <- unique(d_p$soil)
  soil_id <- c("VERTISOLS", "UDUPTS/UDALFS", "PSSAMENTS", "ORTHIDS", "USTALF/USTOLLS",
               "INCEPTISOLS")
  # soil_labs <- c('vert.', 'udup.', 'pssa.', 'orth.', 'usta.', 'incep.')
  n_soil <- length(soil_id)

  col_palette <- c("#FFFFFF", "#6B6100", "#9D964B", "#FDAE6B", "#FD8D3C", "#E6550D", "#A63603")

  c_id <- paste0('c', 1:n_soil)

  d_poly$soil <- rep('', nrow(d_poly))

  for(j in 1:n_soil){

    d_sel_j <- d_p %>% filter(soil == soil_id[j]) %>% select(dist_name2)
    d_poly$soil[d_poly$dist %in% unlist(d_sel_j[, 1])] <- c_id[j]

  }

  p_soil <- ggplot(d_poly, aes(x = long, y = lat, group = dist)) +
    geom_polygon(colour='black', aes(fill=soil, group = dist)) +
    scale_fill_manual(breaks = c("", c_id), values=col_palette,
                      name = "Soil", labels =  c('', soil_id)) +
    ggtitle('Soil type')

  return(p_soil)

}
