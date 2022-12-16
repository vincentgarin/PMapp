#' form_CM_res_tab
#'
#' @description format the results of the CM predictions
#'
#' @return Table with CM predictions
#'
#' @noRd
form_CM_res_tab <- function(data, d1, d2){

  r_tab <- inner_join(x = d1, y = d2, "dist_code")

  # combine and calculate the difference in yield and expected income
  r_tab <- r_tab %>%
    select(dist_code, dist_name.x, exp_yld.x, exp_yld.y, exp_inc.x, exp_inc.y) %>%
    mutate(yld_diff = exp_yld.y - exp_yld.x, inc_diff = exp_inc.y - exp_inc.x) %>%
    relocate(yld_diff, .after = exp_yld.y) %>% relocate(inc_diff, .after = exp_inc.y)

  state <- data %>% filter(dist_code %in% r_tab$dist_code) %>%
    group_by(dist_code) %>% summarise(state = unique(state_name))
  res_tab <- left_join(x = r_tab, y = state, "dist_code") %>% arrange(state) %>%
    relocate(state, .before = dist_name.x)
  res_tab <- res_tab[, -1]
  colnames(res_tab) <- c('state', 'district', 'exp. yield opt1 [kg/ha]',
                         'exp. yield opt2 [kg/ha]', 'yield diff (o2-o1) [kg/ha]',
                         'exp. inc. opt1 [INR]', 'exp. inc. opt2 [INR]',
                         'inc. diff (o2-o1) [INR]')

  return(list(r_tab = r_tab, res_tab = res_tab))

}
