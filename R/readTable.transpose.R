#' @rdname gfcmSTAR-internal
#'
#' @importFrom XLConnect readTable
#'
#' @export

## Read transposed table as a list
## rownames is passed to readTable()
## cols specifies how many columns to import

readTable.transpose <- function(..., rownames=1, cols=1)
{
  x <- readTable(..., rownames=rownames)
  x <- as.list(as.data.frame(t(x), stringsAsFactors=FALSE))
  names(x) <- gsub(" |/|#|\\(|\\)", "_", names(x))  # replace ' #/()' with _
  names(x) <- gsub("[_]+", "_", names(x))  # replace __ with _
  names(x) <- gsub("_$", "", names(x))  # remove trailing _
  x
}
