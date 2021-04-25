#' @rdname gfcmSTAR-internal
#'
#' @importFrom XLConnect readTable
#'
#' @export

## Read yes/no flag and return TRUE/FALSE

readTable.logical <- function(...)
{
  readTable(...)[[1]] == "Yes"
}
