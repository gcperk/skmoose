#' Select recent fire years for Moose habitat
#' @param fires sf object with all fires
#' @param fire_min_yr numeric minimum age since fire, default = 5.
#' @param fire_max_yr numeric maximum age since fire, default = 40
#'
#' @return sf object with filtered fires
#' @export
#'
#' @examples
#' \dontrun{
#' fires_recent(fires, 5, 40 )
#' }
#'
fires_recent <- function(fires, fire_min_yr = 5, fire_max_yr = 40){

  # filter for recent fires
  fires_filt <- fires %>%
    dplyr::select(id, FIRE_YEAR) %>%
    dplyr::filter(as.numeric(format(Sys.time(), "%Y")) - FIRE_YEAR <= fire_max_yr) %>%
    dplyr::filter(as.numeric(format(Sys.time(), "%Y")) - FIRE_YEAR >= fire_min_yr) %>%
    st_union()

  return(fires_filt)

}

