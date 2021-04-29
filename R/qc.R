#' Quality Check
#'
#' Run all quality checks on a STAR template.
#'
#' @param file filename of a STAR template.
#' @param stop whether to stop if test fails.
#'
#' @return
#' \code{TRUE} if all tests succeed, otherwise an error message (if
#' \code{stop = TRUE}) or FALSE and a warning message (if \code{stop = FALSE}).
#'
#' @seealso
#' \code{\link{qc.xlsx}} checks if a filename has a \file{xlsx} extension.
#'
#' \code{\link{gfcmSTAR-package}} gives an overview of the package.
#'
#' @examples
#' \dontrun{
#' qc("STAR_2019_HKE_5.xlsx")
#' }
#'
#' @export

qc <- function(file, stop=TRUE)
{
  ## Start with success TRUE and later flip it to FALSE if any test fails
  success <- TRUE

  success <- success && qc.xlsx(file, stop=stop)

  success
}
