#' Get high elevation areas
#'
#' @param dem an tif with elevation data
#' @param elev_thresh default elevation at which moose would be unlikely to pass, default = 1300m
#'
#' @return a geopackage with single polygon that shows elevation above the given threshold
#' @importFrom magrittr "%>%"
#' @export
#'
#' @examples
#' \dontrun{
#' high_elev(dem, 1500)
#' }


high_elev <- function(dem, elev_thresh = 1300) {


  high_e <- terra::clamp(dem, lower = elev_thresh, upper=Inf, values=FALSE)
  high_elev_poly <- terra::as.polygons(high_e)


  high_elev_sf <- sf::st_as_sf(high_elev_poly) %>%
    sf::st_transform(3005) %>%
    sf::st_union(by_feature = FALSE) %>%
    sf::st_cast("MULTIPOLYGON") %>%
    sf::st_union()


  return(high_elev_sf)


}
