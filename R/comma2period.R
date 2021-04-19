#' @rdname gfcmSTAR-internal
#'
#' @export

## Ensure Advice_Export has . decimal separator

comma2period <- function(x)
{
  gsub(",([0-9])", ".\\1", x)
}
