#' Select recent fire years for Moose habitat
#' @param fires sf object with all fires
#' @param fire_min_yr numeric minimum age since fire, default = 10.
#' @param fire_max_yr numeric maximum age since fire, default = 25
#'
#' @return sf object with filtered fires
#' @export
#'
#' @examples
#' \dontrun{
#' fires_recent(fires, 10, 25 )
#' }
#'
fires_recent <- function(fires, fire_min_yr = 10, fire_max_yr = 25){

  # filter for recent fires
  fires_filt <- fires %>%
    dplyr::select(id, FIRE_YEAR) %>%
    dplyr::filter(as.numeric(format(Sys.time(), "%Y")) - FIRE_YEAR <= fire_max_yr) %>%
    dplyr::filter(as.numeric(format(Sys.time(), "%Y")) - FIRE_YEAR >= fire_min_yr) %>%
    st_union()

  return(fires_filt)

}

# fire severity
#https://catalogue.data.gov.bc.ca/dataset/04c5ad28-d8eb-4c49-90c5-48b9b98fdfe9

