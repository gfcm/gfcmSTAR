#' File Exists
#'
#' Assert that a file exists.
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
#' qc.exists("STAR_2019_HKE_5.xlsx")
#' }
#'
#' @export

qc.exists <- function(file, short=TRUE, stop=TRUE, quiet=FALSE)
{
  ## 1  Preamble
  if(!is.character(file) || length(file)!=1)
    file <- as.character(substitute(file))
  filename <- if(short) basename(file) else file
  if(!quiet)
    message("* checking '", filename, "' with qc.exists ... ", appendLF=FALSE)

  ## 2  Test
  success <- is.character(file) && file.exists(file)

  ## 3  Result
  if(!success)
  {
    if(!quiet) message("ERROR")
    msg <- paste0("file '", filename, "' does not exist")
    if(stop) stop(msg) else warning(msg)
  }
  else if(!quiet)
    message("OK")
  success
}
