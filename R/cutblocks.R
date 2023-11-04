#' Select recent cutblocks for Moose habitat
#' @param cutblocks sf object with all cutblocks
#' @param cutblock_min_yr numeric minimum age since date, default = 5.
#' @param cutblock_max_yr numeric maximum age since harvest, default = 25
#'
#' @return sf object with filtered cutblocks
#' @export
#'
#' @examples
#' \dontrun{
#' cutblocks_recent(cutblocks, 5, 25 )
#' }
#'
cutblocks_recent <- function(cutblocks, cutblock_min_yr = 5, cutblock_max_yr = 25){

  cutblocks_yrs <- cutblocks %>%
    dplyr::mutate(yrs_since_harvest = (as.numeric(format(Sys.time(), "%Y")) - HARVEST_YEAR))%>%
    st_cast("MULTIPOLYGON")

  cutblocks_yrs <- cutblocks_yrs %>%
   dplyr::filter(yrs_since_harvest >=  cutblock_min_yr & yrs_since_harvest <= cutblock_max_yr)

return(cutblocks_yrs)

}

