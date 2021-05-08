#' Import Many Templates
#'
#' Import many Excel STAR templates from a directory into a cluster (list) of
#' STAR objects.
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
#' @return A cluster (list) of STAR objects.
#'
#' @note
#' A vignette demonstrates the use of \code{import.many.templates} to import
#' STAR templates:
#' \preformatted{
#' vignette("import", "gfcmSTAR")
#' }
#'
#' @seealso
#' \code{\link{read.template}} reads an Excel STAR template into a STAR object.
#'
#' \code{\link{import.many.csv}} imports many STAR CSV files from a directory
#' tree into a cluster.
#'
#' \code{\link{peek}} examines a metadata field of STAR objects.
#'
#' \code{\link{gfcmSTAR-package}} gives an overview of the package.
#'
#' @examples
#' \dontrun{
#' cluster <- import.many.templates("STAR")
#' }
#'
#' @export

import.many.templates <- function(dir, pattern="\\.xlsx?$", exclude=NULL, ...)
{
  files <- dir(dir, pattern=pattern, full.names=TRUE)
  files <- files[!(basename(files) %in% exclude)]

  cluster <- lapply(files, function(file) try(read.template(file=file, ...)))
  names(cluster) <- basename(files)

  cluster
}
