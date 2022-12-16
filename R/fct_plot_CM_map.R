#' plot_CM_map
#'
#' @description Plot the crop model prediction map
#'
#' @return Crop model prediction map
#'
#' @noRd
plot_CM_map <- function(ptype, d_poly, dist_code,
                        p_val_yld_o1, p_val_yld_o2, p_val_yld_diff,
                        p_val_inc_o1, p_val_inc_o2, p_val_inc_diff){

  if(ptype == 'exp_yield'){

    # option 1
    p_o1 <- plot_map(d_poly = d_poly, p_val = p_val_yld_o1, dist_code = dist_code,
                     col_high = "chocolate4", v_name = 'yield',
                     main = 'Predicted yield option 1')

    # option 2
    p_o2 <- plot_map(d_poly = d_poly, p_val = p_val_yld_o2, dist_code = dist_code,
                     col_high = "chocolate4", v_name = 'yield',
                     main = 'Predicted yield option 2')

    # difference
    p_diff <- plot_map(d_poly = d_poly, p_val = p_val_yld_diff, dist_code = dist_code,
                       col_low = 'red', col_mid = 'white', col_high = "green",
                       v_name = 'yield',
                       main = 'Predicted yield difference option 2 - option 1')

  } else if(ptype == 'exp_income'){

    # option 1
    p_o1 <- plot_map(d_poly = d_poly, p_val = p_val_inc_o1, dist_code = dist_code,
                     col_high = "chocolate4", v_name = 'INR',
                     main = 'Expected income option 1')

    # option 2
    p_o2 <- plot_map(d_poly = d_poly, p_val = p_val_inc_o2, dist_code = dist_code,
                     col_high = "chocolate4", v_name = 'INR',
                     main = 'Expected income option 2')

    # difference
    p_diff <- plot_map(d_poly = d_poly, p_val = p_val_inc_diff, dist_code = dist_code,
                       col_low = 'red', col_mid = 'white', col_high = "green",
                       v_name = 'INR',
                       main = 'Income difference option 2 - option 1')

  }

  return(list(p_o1 = p_o1, p_o2 = p_o2, p_diff = p_diff))

}
