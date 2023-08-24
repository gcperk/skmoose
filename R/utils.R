
# helper function to get local file.path for test package dataset.

skmoose_example <- function(path = NULL) {
  if (is.null(path)) {
    dir(system.file("extdata", package = "skmoose"))
  } else {
    system.file("extdata", path, package = "skmoose", mustWork = TRUE)
  }
}
