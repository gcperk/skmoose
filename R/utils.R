#' helper function to get local file.path for test package dataset.
#'
#' @param path default location as NULL
#'
#' @return TRUE
#' @export
#'
#' @examples
#' \dontrun{
#' skmoose_example()
#' }
skmoose_example <- function(path = NULL) {
  if (is.null(path)) {
    dir(system.file("extdata", package = "skmoose"))
  } else {
    system.file("extdata", path, package = "skmoose", mustWork = TRUE)
  }
}

