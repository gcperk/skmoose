#' Create steep slope exclusion layer
#'
#' @param dem elevation rast
#' @param slope_thresh a numeric threshold above which moose are unlikley to occur (degrees), default is 55.
#'
#' @return sf object with polygon rrepresenting higher than threshold area
#' @export
#'
#' @examples
#' \dontrun{
#' steep_slope(dem, 55)
#' }
steep_slope <- function(dem, slope_thresh = 55){

  # filter by steep slope
  rslope <- terra::terrain(dem, v = "slope", neighbors = 8, unit = "degrees")

  steep <- terra::clamp(rslope, lower= slope_thresh, upper=Inf, values=FALSE)
  steep_poly <- terra::as.polygons(steep)

  # conver to sf and output
  steep_sf <- sf::st_as_sf(steep_poly)%>%
    sf::st_transform(3005) %>%
    sf::st_union() %>%
    sf::st_cast("MULTIPOLYGON")

  return(steep_sf)

  # st_write(steep_sf, file.path(out_dir, "steep.gpkg"))

}
