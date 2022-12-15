#' plot_map_av_sh_tr
#'
#' @description Plot different stat on map
#'
#' @return map plot.
#'
#' @noRd
plot_map_av_sh_tr <- function(ptype, d_poly,
                              p_val_av, dist_code_av, col_high_av, v_name_av, main_av,
                              p_val_tr, dist_code_tr, col_low_tr, col_mid_tr, v_name_tr, main_tr,
                              p_val_as, dist_code_as, col_high_as, v_name_as, main_as,
                              p_val_st, dist_code_st, col_low_st, col_mid_st, v_name_st, main_st){

  # reactive({

  if(ptype == 'av'){

    p <- plot_map(d_poly = d_poly, p_val = p_val_av, dist_code = dist_code_av,
                  col_high = col_high_av, v_name = v_name_av, main = main_av)

  } else if (ptype == 'tr') {

    p <- plot_map(d_poly = d_poly, p_val = p_val_tr, dist_code = dist_code_tr,
                  col_low = col_low_tr, col_mid = col_mid_tr, v_name = v_name_tr, main = main_tr)

  } else if(ptype == 'av_sh'){

    p <- plot_map(d_poly = d_poly, p_val = p_val_as, dist_code = dist_code_as,
                  col_high = col_high_as, v_name = v_name_as, main = main_as)

  } else if(ptype == 'sh_tr'){

    p <- plot_map(d_poly = d_poly, p_val = p_val_st, dist_code = dist_code_st,
                  col_low = col_low_st, col_mid = col_mid_st, v_name = v_name_st, main = main_st)

  }

  return(p)

}

