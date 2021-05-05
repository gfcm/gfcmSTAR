#' @rdname gfcmSTAR-internal
#'
#' @export

## Convert Column_name to Column_Name

Start_Case <- function(x)
{
  gsub("_([a-z])", "_\\U\\1", x, perl=TRUE)
}
