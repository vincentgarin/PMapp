#' share_trend
#'
#' @description Calculate share trend
#'
#' @return Share trend.
#'
#' @noRd
share_trend <- function(data, dist_sel, y_range){

  d <- data %>% filter(dist_code %in% dist_sel, year %in% y_range[1]:y_range[2]) %>%
    rowwise() %>% mutate(tot_s = sum(c_across(8:ncol(data)))) %>%
    mutate(sh = 100*(PearlMillet/tot_s)) %>%
    ungroup() %>% group_by(state_name, dist_code, dist_name) %>%
    summarise(av = m_f(sh), tr = tr_f(x = year, y = sh))

  return(d)

}
