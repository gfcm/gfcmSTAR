#' @rdname gfcmSTAR-internal
#'
#' @export

## Convert time to POSIXct that is truncated to seconds and has no time zone

basic.time <- function(x)
{
  x <- as.POSIXct(as.character(x))
  attr(x, "tzone") <- NULL
  x
}
