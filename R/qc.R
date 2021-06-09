#' Quality Check
#'
#' Run all quality checks on one or more Excel STAR templates.
#'
#' @param x filename of an Excel STAR template or a directory containing Excel
#'        STAR templates.
#' @param stop whether to stop if test fails.
#' @param quiet whether to suppress messages.
#'
#' @return
#' Logical \code{TRUE} or \code{FALSE} indicating whether all tests succeeded,
#' or a logical vector if \code{x} is a directory.
#'
#' @seealso
#' The checks are run in the following order:
#'
#' \code{\link{qc.exists}} checks if file exists.
#'
#' \code{\link{qc.xlsx}} checks if file extension is \file{xlsx}.
#'
#' \code{\link{qc.star}} checks if file is a STAR template.
#'
#' \code{\link{qc.vpa}} checks if \code{VPA_Model} is \code{Yes} or \code{No}.
#'
#' \code{\link{gfcmSTAR-package}} gives an overview of the package.
#'
#' @examples
#' \dontrun{
#'
#' # Filename
#' qc("STAR_2019_HKE_5.xlsx")
#'
#' # Directory
#' ok <- qc("working_group")
#' ok[!ok]
#' }
#'
#' @export

qc <- function(x, stop=TRUE, quiet=FALSE)
{
  if(dir.exists(x))
  {
    files <- dir(x, pattern="\\.xlsx?$", full.names=TRUE)
    s <- suppressWarnings(sapply(files, qc, stop=FALSE, quiet=FALSE))
    names(s) <- basename(names(s))
  }
  else if(file.exists(x))
  {
    ## Start with success TRUE and later flip it to FALSE if any test fails
    s <- TRUE

    s <- s && qc.exists(x, stop=stop, quiet=quiet)
    s <- s && qc.xlsx(x, stop=stop, quiet=quiet)
    s <- s && qc.star(x, stop=stop, quiet=quiet)
    s <- s && qc.vpa(x, stop=stop, quiet=quiet)
  }
  else
  {
    stop("'x' must be an existing filename or directory")
  }

  invisible(s)
}
