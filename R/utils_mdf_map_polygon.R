#' mdf_map_polygon
#'
#' @description Function to resize polygon map
#'
#' @return resized map polygon
#'
#' @noRd
mdf_map_polygon <- function(map_poly, lat_min = 14, lat_max = 31, long_min = 68, long_max = 83){

  map_poly <- map_poly %>% filter(lat < lat_max, lat > lat_min, long > long_min, long < long_max)

}

# usage

# d_poly <- mdf_map_polygon(d_poly)
