#' plot_mgt_pract
#'
#' @description A fct function
#'
#' @return The return value, if any, from executing the function.
#'
#' @noRd
plot_mgt_pract <- function(data, d_poly, dist_sel, y_range, s_var = 'irrig',
                           var_nm = 'Irrig.', pb_dist = NULL,
                           col_high = 'darkblue', unit_nm = '%'){

  d_poly <- mdf_map_polygon(d_poly)

  d_s <- data %>% filter(!is.na(env), dist_code %in% dist_sel,
                         year %in% y_range[1]:y_range[2]) %>%
    group_by(dist_name2) %>% summarise(sate = unique(state_name),
                                       dist_name = unique(dist_name),
                                       av_s = mean((!!sym(s_var)), na.rm = TRUE),
                                       trend = tr_f_error(x = year, y = (!!sym(s_var))))

  p_caption <- paste(var_nm, c('average', 'trend'))
  f_title <- paste(var_nm, c(paste0('[', unit_nm, ']'), paste0('[', unit_nm,'/y]')))

  for(j in 1:2){

    p_lk <- unlist(d_s[, j+3])
    names(p_lk) <- d_s$dist_name2
    d_poly$param <- p_lk[as.character(d_poly$dist)]
    # d_poly$param[is.na(d_poly$param)] <- 0
    d_poly$param[!(d_poly$dist_code %in% dist_sel)] <- NA
    if(!is.null(pb_dist)){
      d_poly$param[d_poly$dist_name2 %in% pb_dist] <- NA
    }


    # plot
    if(j == 1){

      p <- ggplot(d_poly, aes(x = long, y = lat, group = dist)) +
        geom_polygon(colour='black', aes(fill=param, group = dist)) +
        scale_fill_gradient(low = "white", high = col_high, name = f_title[j]) +
        labs(title = p_caption[j], x = 'lon')

    } else if (j == 2){

      p <- ggplot(d_poly, aes(x = long, y = lat, group = dist)) +
        geom_polygon(colour='black', aes(fill=param, group = dist)) +
        scale_fill_gradient2(low = 'red', mid = 'white', high = 'blue',
                             name = f_title[j]) +
        labs(title = p_caption[j], x = 'lon')

    }

    assign(x = paste0('p', j), value = p)

  }

  # further process table of values
  d_s2 <- d_s[, 2:5]
  colnames(d_s2) <- c('state', 'district', paste(var_nm, c(paste0('av. ', '[', unit_nm, ']'),
                                                           paste0('trend [', unit_nm, '/y]'))))
  d_s2 <- d_s2 %>% arrange(state)

  return(list(p_av = p1, p_tr = p2, tab = d_s2))

}
