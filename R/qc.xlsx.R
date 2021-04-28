#' Excel File Extension
#'
#' Assert that a filename has a \file{xlsx} file extension.
#'
#' @param file filename of a STAR template.
#' @param stop whether to stop if test fails.
#'
#' @return
#' \code{TRUE} if file extension is \file{xlsx}, otherwise an error message (if
#' \code{stop = TRUE}) or FALSE and a warning message (if \code{stop = FALSE}).
#'
#' @seealso
#' \code{\link{qc}} runs all \code{qc.*} tests.
#'
#' \code{\link{gfcmSTAR-package}} gives an overview of the package.
#'
#' @examples
#' qc.xlsx("STAR_2019_HKE_5.xlsx")
#'
#' @importFrom tools file_ext
#'
#' @export

qc.xlsx <- function(file, stop=TRUE)
{
  success <- file_ext(file) == "xlsx"

  if(!success)
  {
    msg <- paste0("'", file, "' does not have file extension 'xlsx'")
    if(stop)
      stop(msg)
    else
      warning(msg)
  }

  success
}
