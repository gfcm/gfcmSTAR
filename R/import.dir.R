#' Import Directory
#'
#' Import all Excel STAR templates from a directory to a list.
#'
#' @param dir directory name.
#' @param pattern regular expression to select filenames to include.
#' @param exclude filenames to exclude.
#' @param \dots passed to \code{read.template}.
#'
#' @details
#' The default \code{pattern} selects all filenames ending with \file{xls} or
#' \file{xlsx}.
#'
#' @return List of STAR objects.
#'
#' @note
#' A vignette demonstrates the use of \code{import.dir} to import STAR templates:
#' \preformatted{
#' vignette("import", "gfcmSTAR")
#' }
#'
#' @seealso
#' \code{\link{read.template}} reads an Excel STAR template into a STAR object.
#'
#' \code{\link{gfcmSTAR-package}} gives an overview of the package.
#'
#' @examples
#' \dontrun{
#' cluster <- import.dir("STAR")
#' }
#'
#' @export

import.dir <- function(dir, pattern="\\.xlsx?$", exclude=NULL, ...)
{
  files <- dir(dir, pattern=pattern, full.names=TRUE)
  files <- files[!(basename(files) %in% exclude)]

  out <- lapply(files, function(file) try(read.template(file=file, ...)))
  names(out) <- basename(files)

  out
}
