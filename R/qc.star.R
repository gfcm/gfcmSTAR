#' STAR Template
#'
#' Assert that a file is a STAR template and contains a \code{Metadata} sheet.
#'
#' @param file filename of an Excel STAR template.
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
#' qc.star("STAR_2019_HKE_5.xlsx")
#' }
#'
#' @importFrom XLConnect getSheets
#'
#' @export

qc.star <- function(file, stop=TRUE, quiet=FALSE)
{
  ## 1  Preamble
  if(!quiet)
    message("* checking '", file, "' with qc.star ... ", appendLF=FALSE)

  ## 2  Test
  w <- loadWorkbook(file)
  success <- "Metadata" %in% getSheets(w)

  ## 3  Show result
  if(!success)
  {
    if(!quiet) message("ERROR")
    msg <- paste0("'", file, "' does not have a sheet called 'Metadata'")
    if(stop) stop(msg) else warning(msg)
  }
  else if(!quiet)
    message("OK")
  success
}
