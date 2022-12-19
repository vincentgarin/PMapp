#' plot_rain
#'
#' @description A fct function
#'
#' @return The return value, if any, from executing the function.
#'
#' @noRd
plot_rain <- function(data, d_poly, dist_sel, y_range){

  d_poly <- mdf_map_polygon(d_poly)

  s_rain <- data %>% filter(!is.na(env), dist_code %in% dist_sel,
                            year %in% y_range[1]:y_range[2]) %>%
    group_by(dist_name2) %>% summarise(sate = unique(state_name),
                                       dist_name = unique(dist_name),
                                       av_s = mean(rain, na.rm = TRUE),
                                       v_d = var(rain, na.rm = TRUE),
                                       trend = tr_f(x = year, y = rain))

  p_caption <- c('Rain average', 'Rain variance', 'Rain trend')
  f_title <- c('rain [mm]', 'rain [mm]', 'rain [mm/y]')

  for(i in 1:3){

    p_lk <- unlist(s_rain[, i+3])
    names(p_lk) <- s_rain$dist_name2
    d_poly$param <- p_lk[as.character(d_poly$dist)]
    d_poly$param[is.na(d_poly$param)] <- 0
    d_poly$param[!(d_poly$dist_code %in% dist_sel)] <- NA

    # plot

    p <- ggplot(d_poly, aes(x = long, y = lat, group = dist)) +
      geom_polygon(colour='black', aes(fill=param, group = dist)) +
      scale_fill_gradient(low = "white", high = "darkblue", name = f_title[i]) +
      labs(title = p_caption[i], x = 'lon')

    assign(x = paste0('p', i), value = p)

    # further process table of values
    s_rain2 <- s_rain[, 2:6]
    colnames(s_rain2) <- c('state', 'district', 'rain av. [mm]', 'rain var. [mm]', 'rain trend [mm/y]')
    s_rain2 <- s_rain2 %>% arrange(state)

  }

  return(list(p_av = p1, p_var = p2, p_tr = p3, tab = s_rain2))

}
