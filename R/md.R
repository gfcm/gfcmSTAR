#' @rdname gfcmSTAR-internal
#'
#' @export

## Create directory, including parent dirs if necessary, without generating a
## warning if dir already exists.

md <- function(path)
{
  out <- sapply(path, dir.create, showWarnings=FALSE, recursive=TRUE)
  invisible(out)
}
