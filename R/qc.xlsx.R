#' Excel File Extension
#'
#' Assert that a file has an \file{xlsx} file extension.
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
#' qc.xlsx("STAR_2019_HKE_5.xlsx")
#' }
#'
#' @importFrom tools file_ext
#'
#' @export

qc.xlsx <- function(file, stop=TRUE, quiet=FALSE)
{
  ## 1  Preamble
  if(!quiet)
    message("* checking '", file, "' with qc.xlsx ... ", appendLF=FALSE)

  ## 2  Test
  success <- file_ext(file) == "xlsx"

  ## 3  Result
  if(!success)
  {
    if(!quiet) message("ERROR")
    msg <- paste0("'", file, "' does not have file extension 'xlsx'")
    if(stop) stop(msg) else warning(msg)
  }
  if(!quiet)
    message("OK")
  success
}
