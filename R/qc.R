#' Quality Check
#'
#' Run all quality checks on one or more Excel STAR templates.
#'
#' @param x filename of an Excel STAR template or a directory containing Excel
#'        STAR templates.
#' @param short whether to show filenames in a short \code{\link{basename}}
#'        format.
#' @param stop whether to stop if any test fails.
#' @param quiet whether to suppress messages.
#'
#' @details
#' If \code{x} is a directory, \code{stop} is set to \code{FALSE} unless the
#' user passes an explicit \code{stop = TRUE}.
#'
#' @return
#' String indicating which test did not succeed, or a vector of strings if
#' \code{x} is a directory. A value of \code{""} means all tests succeeded for
#' that file.
#'
#' @note
#' A generic script to quality check many STAR templates is covered in the
#' 'Script' section of the \link{gfcmSTAR-package} help page.
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
#' \code{\link{qc.ts.names}} checks if time series column names are intact.
#'
#' \code{\link{qc.ts.numbers}} checks if time series are numbers and not
#' strings.
#'
#' \code{\link{report}} reports which files were successfully imported.
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

qc <- function(x, short=TRUE, stop=TRUE, quiet=FALSE)
{
  ## Print warnings as they occur, rather than all at the end
  owarn <- options(warn=1); on.exit(options(owarn))

  if(dir.exists(x))
  {
    stop <- if(missing(stop)) FALSE else stop
    files <- dir(x, pattern="\\.xlsx?$", full.names=TRUE)
    filenames <- if(short) basename(files) else files
    s <- rep(NA_character_, length(filenames))
    for(i in seq_along(filenames))
    {
      if(!quiet) cat("[", i, "] ", filenames[i], "\n", sep="")
      s[i] <- qc(files[i], short=short, stop=stop, quiet=quiet)
    }
    names(s) <- basename(files)
  }
  else if(file.exists(x))
  {
    s <- ""
    if(s == "" && !qc.exists(x, short=short, stop=stop, quiet=quiet))
      s <- "exists"
    if(s == "" && !qc.xlsx(x, short=short, stop=stop, quiet=quiet))
      s <- "xlsx"
    if(s == "" && !qc.star(x, short=short, stop=stop, quiet=quiet))
      s <- "star"
    if(s == "" && !qc.vpa(x, short=short, stop=stop, quiet=quiet))
      s <- "vpa"
    if(s == "" && !qc.ts.names(x, short=short, stop=stop, quiet=quiet))
      s <- "ts.names"
    if(s == "" && !qc.ts.numbers(x, short=short, stop=stop, quiet=quiet))
      s <- "ts.numbers"
  }
  else
  {
    stop("'x' must be an existing filename or directory")
  }

  invisible(s)
}
