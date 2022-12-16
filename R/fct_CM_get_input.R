#' CM_get_input
#'
#' @description Get the crop model parameter input
#'
#' @return Crop model parameter input
#'
#' @noRd
CM_get_input <- function(data_CM, PM_prod, s_text_inp, s_depth_inp, irrig_inp,
                         variety_inp, fert_inp, sow_d_inp, dens_inp, sel_dist,
                         year_range, last_year){

  # get the input
  s_text_s <- unlist(list(`0.6 (~sandy)` = 'sand',
                          `0.9 (~loam)` = 'loam',
                          `1.3 (~clay)` = 'clay')[s_text_inp])

  s_depth_s <- unlist(list(`60 cm (shallow)` = 'shallow',
                           `120 cm (medium)` = 'medium',
                           `180 cm (deep)` = 'deep')[s_depth_inp])

  irrig_s <- unlist(list(`no irrigation` = 'off', `partial irrigation` = 'int',
                         `full irrigation` = 'on')[irrig_inp])

  variety_s <- variety_inp

  fert_s <- unlist(list(`no fertilisation` = 'f_0', `30/30 kg N` = 'f_30',
                        `50/50 kg N` = 'f_50')[fert_inp])

  sow_d_s <- unlist(list(`early (16-30 June)` = 'early',
                         `average (1-15 July)` = 'average',
                         `late (16-30 July)` = 'late')[sow_d_inp])

  dens_s <- unlist(list(`12` = 12,
                        `18` = 18,
                        `24` = 24)[dens_inp])

  d <- data_CM %>% filter(dist_code %in% sel_dist, year %in% year_range[1]:year_range[2],
                          s_text == s_text_s, s_depth == s_depth_s,
                          irrig == irrig_s, variety == variety_s,
                          fert == fert_s, sow_d == sow_d_s, dens == dens_s) %>%
    group_by(dist_code, dist) %>% summarise(av_yld = mean(y_est, na.rm = TRUE))

  av_price <- PM_prod %>% filter(dist_code %in% sel_dist, year %in% last_year) %>%
    group_by(dist_code, dist_name) %>% summarise(av_price = mean(price, na.rm = TRUE))

  d <- left_join(x = d, y = av_price, "dist_code") %>%
    mutate(exp_inc = av_yld * av_price/100) %>%
    select(dist_code, dist_name, av_yld, exp_inc) %>% rename(exp_yld = av_yld)

  # d <- d %>% select(dist_code, dist_name, exp_yld, exp_inc)

  return(d)

}
