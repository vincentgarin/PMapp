#' d_share
#'
#' @description Data for share regression
#'
#' @return share data.
#'
#' @noRd
d_share <- function(data, dist_sel, y_range){

  d_i <- data %>% filter(dist_code %in% dist_sel, year %in% y_range[1]:y_range[2])
  d_i <- rowsum(x = d_i[, 8:ncol(d_i)], group = d_i$year)
  d_i <- d_i %>% rowwise() %>% mutate(tot_s = sum(c_across(everything()))) %>%
    mutate(sh = 100*(PearlMillet/tot_s))
  d_i <- data.frame(year = y_range[1]:y_range[2], y = d_i$sh)

  return(d_i)

}
