#' VPA Model Type
#'
#' Assert that a STAR template's table object \code{VPA_Model} is either
#' \code{"Yes"} or \code{"No"}.
#'
#' @param file filename of a STAR template.
#' @param stop whether to stop if test fails.
#' @param quiet whether to suppress messages.
#'
#' @return
#' \code{TRUE} if test succeeds, otherwise an error message
#' (if \code{stop = TRUE}) or \code{FALSE} and a warning message
#' (if \code{stop = FALSE}).
#'
#' @seealso
#' \code{\link{qc.all}} runs all \code{qc.*} tests.
#'
#' \code{\link{gfcmSTAR-package}} gives an overview of the package.
#'
#' @examples
#' \dontrun{
#' qc.vpa("STAR_2019_HKE_5.xlsx")
#' }
#'
#' @importFrom XLConnect readTable
#'
#' @export

qc.vpa <- function(file, stop=TRUE, quiet=FALSE)
{
  ## 1  Preamble
  if(!quiet)
    message("* checking '", file, "' with qc.vpa ... ", appendLF=FALSE)

  ## 2  Test
  w <- loadWorkbook(file)
  success <- readTable(w, "Metadata", "VPA_Model")[[1]] %in% c("Yes", "No")

  ## 3  Show result
  if(!success)
  {
    if(!quiet) message("ERROR")
    msg <- "VPA_Model must be either \"Yes\" or \"No\""
    if(stop) stop(msg) else warning(msg)
  }
  if(!quiet)
    message("OK")
  success
}
