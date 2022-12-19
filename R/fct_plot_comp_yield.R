#' plot_comp_yield
#'
#' @description A fct function
#'
#' @return The return value, if any, from executing the function.
#'
#' @noRd
plot_comp_yield <- function(data_yld, data_area, data_prod, N_crop = 6,
                            dist_sel = NULL, y_range = NULL,
                            comp_criteria = 'area', text.size = 16){

  y_r <- y_range[1]:y_range[2]

  # determine the competitors
  if(comp_criteria == 'area') {

    d_crit <- data_area %>% filter(dist_code %in% dist_sel, year %in% y_r)
    cr_sum <- colSums(d_crit [, 8:ncol(d_crit)], na.rm = TRUE)
    cr_sel <- names(sort(cr_sum, decreasing = TRUE)[1:N_crop])


  } else {

    d_crit <- data_prod %>% filter(dist_code %in% dist_sel, year %in% y_r)
    cr_sum <- colSums(d_crit [, 8:ncol(d_crit)], na.rm = TRUE)
    cr_sel <- names(sort(cr_sum, decreasing = TRUE)[1:N_crop])

  }

  d_yld <- data_yld %>% filter(dist_code %in% dist_sel, year %in% y_r)
  yld_av <- colMeans(d_yld[, 8:ncol(d_crit)], na.rm = TRUE)
  yld_av <- sort(yld_av[cr_sel], decreasing = TRUE)

  d <- data.frame(crop = names(yld_av), yield = yld_av)
  d$crop <- factor(d$crop, levels = rev(d$crop))

  # Plot
  p <- ggplot(d, aes(x=yield, y=crop)) +
    geom_bar(stat = "identity") + labs(x = '[kg/ha]') +
    theme(axis.title.x = element_text(size=text.size),
          axis.title.y = element_text(size=text.size),
          axis.text.x  = element_text(size=text.size),
          axis.text.y = element_text(size = text.size))

  colnames(d)[2] <- 'yield [kg/ha]'

  list(p = p, d = d)

}
