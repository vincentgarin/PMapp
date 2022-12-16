#' tab_av_sh
#'
#' @description table for average and share statistics
#'
#' @return Table
#'
#' @noRd

tab_av_sh <- function(d1, d2, v_nm = 'Kha'){

  d <- left_join(d1, d2, "dist_code") %>% ungroup() %>%
    select(state_name.x, dist_name.x, av.x, tr.x, av.y, tr.y)

  c_nm <-  c('state', 'district','average [XXX]', 'trend [XXX/y]', 'av. share [%]',
             'share trend [%/y]')
  c_nm <- gsub(pattern = 'XXX', replacement = v_nm, x = c_nm)

  colnames(d) <- c_nm

  return(d)

}
