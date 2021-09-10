#' Import Many Templates
#'
#' Import many Excel STAR templates from a directory into a cluster (list) of
#' STAR objects.
#'
#' @param dir directory name.
#' @param pattern regular expression to select filenames to include.
#' @param exclude filenames to exclude.
#' @param short whether to show the filename in a short \code{\link{basename}}
#'        format.
#' @param qc whether to call \code{\link{qc}} on each filename.
#' @param quiet whether to suppress messages.
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

import.many.templates <- function(dir, pattern="\\.xlsx?$", exclude=NULL,
                                  short=TRUE, qc=FALSE, quiet=FALSE, ...)
{
  owarn <- options(warn=1); on.exit(options(owarn))
  files <- file.path(dir, dir(dir, pattern=pattern))
  files <- files[!(basename(files) %in% exclude)]
  filenames <- if(short) basename(files) else files

  cluster <- list()
  for(i in seq_along(files))
  {
    if(!quiet) cat("[", i, "] ", filenames[i], "\n", sep="")
    if(qc)
      qc(files[i], short=short, stop=FALSE, quiet=quiet)
    cluster[[i]] <- try(read.template(file=files[i], ...))
    names(cluster)[i] <- basename(files[i])
  }

  cluster
}
