#' comp_trend_plot
#'
#' @description A fct function
#'
#' @return The return value, if any, from executing the function.
#'
#' @noRd
comp_trend_plot <- function(data, dist_sel, y_range, N_crop = 6,
                            unit = "1000 ha", main = 'Param trend'){

  y_r <- y_range[1]:y_range[2]
  n_year <- length(y_r)

  data_i <- data %>% filter(dist_code %in% dist_sel, year %in% y_r)
  cr_av <- colMeans(data_i[, 8:ncol(data_i)])
  data_i <- data_i[, c(rep(T, 7), cr_av > 1)]

  data_s_y <- c()
  tot_crop <- dim(data_i)[2] - 7

  for(j in 1:tot_crop){

    tr_i_av <- tapply(data_i[, j+7], data_i$year, m_f)
    data_s_y <- cbind(data_s_y, tr_i_av)

  }

  colnames(data_s_y) <- colnames(data_i[8:dim(data_i)[2]])

  # determine most important crop
  sc <- cr_av[cr_av > 1]
  sc_nm <- unlist(lapply(strsplit(x = colnames(data_s_y), split =  '_'), `[[`, 1))
  dt <- data.frame(Group = factor(sc_nm), sc = sc)

  data_s_cr <- data_s_y
  colnames(data_s_cr) <- sc_nm

  dt2 <- dt[order(dt$sc, decreasing = T), ]
  data_s_cr <- data_s_cr[, as.character(dt2$Group)[1:N_crop]]
  data_s_cr <- data.frame(data_s_cr) %>% select(PearlMillet, everything())
  data_s_cr <- as.matrix(data_s_cr)

  cr_lab <- factor(rep(colnames(data_s_cr), each = n_year),
                   levels = colnames(data_s_cr))

  dt <- data.frame(crop = cr_lab,
                   year = rep(y_r, N_crop),
                   sc = c(data_s_cr))

  facet_AC <- ggplot(data = dt, aes(x = year, y = sc)) + geom_line(size = 1) +
    facet_wrap(~crop, ncol = 3) + ylab(unit) + ggtitle(main)

  return(facet_AC)

}
