#' Buffer streams by stream order
#'
#' @param streams sf object with all streams
#' @param stream_order vector of numeric values with stream order, default =  c(3,4,5,6,7,8)
#' @param buffer_dist numeric buffer distance, default = 150
#' @importFrom magrittr '%>%'
#'
#' @return sf object with dissolved and buffered stream network
#' @export
#'
#' @examples
#' \dontrun{
#' buffer_streams(streams, stream_order = c(3,4,5,6,7,8), buffer_dist = 150 )
#' }

buffer_streams <- function(streams, stream_order = c(3,4,5,6,7,8), buffer_dist = 150){

  stbuf <- streams %>%
      dplyr::filter(STREAM_ORDER %in% stream_order)%>%
      sf::st_buffer(buffer_dist) %>%
      sf::st_union()

  return(stbuf)
}
