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
#' The checks are run in the following order:
#'
#' \code{\link{qc.xlsx}} checks if file has an \file{xlsx} extension.
#'
#' \code{\link{gfcmSTAR-package}} gives an overview of the package.
#'
#' @examples
#' \dontrun{
#' qc.all("STAR_2019_HKE_5.xlsx")
#' }
#'
#' @export

qc.all <- function(file, stop=TRUE)
{
  ## Start with success TRUE and later flip it to FALSE if any test fails
  x <- TRUE

  x <- x && qc.xlsx(file, stop=stop)
  success <- x

  success
}
