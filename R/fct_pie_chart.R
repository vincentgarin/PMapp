#' pie_chart
#'
#' @description A fct function
#'
#' @return The return value, if any, from executing the function.
#'
#' @noRd
pie_chart <- function(data, dist_sel, y_range, min, main = 'param share'){

  sh_d <- data %>% filter(dist_code %in% dist_sel, year %in% y_range[1]:y_range[2]) %>%
    summarise(across(.cols = 8:ncol(data), ~ sum(., is.na(.), 0)))

  sh_d <- data.frame(crop = colnames(sh_d), tot = unlist(sh_d[1, ])) %>%
    arrange(desc(tot)) %>% mutate(c_per = round(tot/sum(tot)*100, 1)) %>%
    filter(c_per > min) %>% select(crop, c_per)

  res_info <- data.frame('Others', round(100 - sum(sh_d$c_per), 1))
  names(res_info) <- colnames(sh_d)
  sh_d <- rbind(sh_d, res_info)
  sh_d$crop <- paste0(sh_d$crop, ' (', sh_d$c_per, '%)')
  sh_d$crop <- factor(sh_d$crop, levels = sh_d$crop)

  # Pie chart
  bp <- ggplot(sh_d, aes(x="", y=c_per, fill=crop)) +
    geom_bar(width = 1, stat = "identity")

  pie <- bp + coord_polar("y", start=0) + ggtitle(main) +
    theme(axis.text.x=element_blank()) + labs(x = '', y = '') +
    theme(title = element_text(size = 14),
          legend.title = element_text(size = 12),
          legend.text = element_text(size = 12))

  return(pie)

}
