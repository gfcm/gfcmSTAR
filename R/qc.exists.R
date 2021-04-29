#' File Exists
#'
#' Assert that a file exists.
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
#' qc.exists("STAR_2019_HKE_5.xlsx")
#' }
#'
#' @export

qc.exists <- function(file, stop=TRUE, quiet=FALSE)
{
  ## 1  Preamble
  if(!quiet)
    message("* checking '", file, "' with qc.exists ... ", appendLF=FALSE)

  ## 2  Test
  success <- is.character(file) && file.exists(file)

  ## 3  Result
  if(!success)
  {
    if(!quiet) message("ERROR")
    msg <- paste0("file '", file, "' does not exist")
    if(stop) stop(msg) else warning(msg)
  }
  else if(!quiet)
    message("OK")
  success
}
