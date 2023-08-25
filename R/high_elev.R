#' Get base data required from bc data catalogue
#'
#' @param dem an tif with elevation data
#' @param elev_thresh default elevation at which moose would be unlikely to pass, default = 1500m
#'
#' @return a geopackage with single polygon that shows elevation above the given threshold
#' @importFrom magrittr "%>%"
#' @export
#'
#' @examples
#' \dontrun{
#' high_elev(dem, 1500)
#' }


high_elevl <- function(dem, elev_thresh = 1500) {


  high_elev <- terra::clamp(dem, lower= eval_threshold, upper=Inf, values=FALSE)
  high_elev_poly <- terra::as.polygons(high_elev)


  high_elev_sf <- st::st_as_sf(high_elev_poly) %>%
    st::st_transform(3005) %>%
    st::st_union(by_feature = FALSE) %>%
    st::st_cast("MULTIPOLYGON") %>%
    st::st_union


  return(high_elev_sf)


}
