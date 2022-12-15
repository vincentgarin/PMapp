#' average_trend
#'
#' @description function to calculate average and trend
#'
#' @return average and trend.
#'
#' @noRd
average_trend <- function(data, dist_sel, y_range, s_var = 'area'){

  d <- data %>% filter(dist_code %in% dist_sel, year %in% y_range[1]:y_range[2]) %>%
    group_by(state_name, dist_code, dist_name) %>%
    summarise(av = m_f((!!sym(s_var))), tr = tr_f(x = year, y = (!!sym(s_var))))

  return(d)

}
