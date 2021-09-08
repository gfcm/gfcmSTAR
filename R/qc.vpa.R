#' VPA Model Type
#'
#' Assert that a STAR template's table object \code{VPA_Model} is either
#' \code{"Yes"} or \code{"No"}.
#'
#' @param file filename of an Excel STAR template.
#' @param short whether to show the filename in a short \code{\link{basename}}
#'        format.
#' @param stop whether to stop if test fails.
#' @param quiet whether to suppress messages.
#'
#' @return
#' \code{TRUE} if test succeeds, otherwise an error message
#' (if \code{stop = TRUE}) or \code{FALSE} and a warning message
#' (if \code{stop = FALSE}).
#'
#' @seealso
#' \code{\link{qc}} runs all \code{qc.*} tests.
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

qc.vpa <- function(file, short=TRUE, stop=TRUE, quiet=FALSE)
{
  ## 1  Preamble
  filename <- if(short) basename(file) else file
  if(!quiet)
    message("* checking '", filename, "' with qc.vpa ... ", appendLF=FALSE)

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
  else if(!quiet)
    message("OK")
  success
}
