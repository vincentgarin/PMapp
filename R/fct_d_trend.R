#' d_trend
#'
#' @description Process data trend
#'
#' @return Trend data.
#'
#' @noRd
d_trend <- function(data, dist_sel, y_range, s_var = 'area'){

  d <- data %>% filter(dist_code %in% dist_sel, year %in% y_range[1]:y_range[2]) %>%
    group_by(year) %>% summarise(y = sum((!!sym(s_var)), na.rm = TRUE))

  return(d)

}
