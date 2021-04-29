#' Excel File Extension
#'
#' Assert that a filename has a \file{xlsx} file extension.
#'
#' @param file filename of a STAR template.
#' @param stop whether to stop if test fails.
#' @param quiet whether to suppress messages.
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
#' \dontrun{
#' qc.xlsx("STAR_2019_HKE_5.xlsx")
#' }
#'
#' @importFrom tools file_ext
#'
#' @export

qc.xlsx <- function(file, stop=TRUE, quiet=FALSE)
{
  if(!is.character(file))
    stop("'file' argument must be a filename")
  if(!file.exists(file))
    stop("file '", file, "' does not exist")

  if(!quiet)
    message("Checking '", file, "' with qc.xlsx ... ", appendLF=FALSE)
  success <- file_ext(file) == "xlsx"

  if(!success)
  {
    msg <- paste0("'", file, "' does not have file extension 'xlsx'")
    if(stop)
      stop(msg)
    else
      warning(msg)
  }

  if(!quiet)
    message("OK")

  success
}
