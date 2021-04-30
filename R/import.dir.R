#' Import Directory
#'
#' Import all Excel STAR templates from a directory to a list.
#'
#' @param dir directory name.
#' @param exclude filenames to exclude.
#' @param \dots passed to \code{read.template}.
#'
#' @return List of STAR objects.
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

import.dir <- function(dir, exclude=NULL, ...)
{
  files <- dir(dir, full.names=TRUE)
  files <- files[!(basename(files) %in% exclude)]

  out <- lapply(files, function(file) try(read.template(file=file, ...)))
  names(out) <- basename(files)

  out
}
