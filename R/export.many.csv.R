#' Export Many CSV Files
#'
#' Export a cluster (list) of STAR objects to CSV files \file{metadata.csv} and
#' \file{timeseries.csv}.
#'
#' @param cluster list of STAR objects.
#' @param topdir top directory that will contain STAR subdirectories.
#' @param force whether to overwrite existing files.
#' @param quiet whether to suppress messages.
#' @param \dots passed to \code{write.star.csv}.
#'
#' @return \code{TRUE} if CSV files were created, otherwise \code{FALSE}.
#'
#' @note
#' A generic script to export many CSV files is covered in the 'Script' section
#' of the \link{gfcmSTAR-package} help page.
#'
#' @seealso
#' \code{\link{write.star.csv}} writes a STAR object to CSV files.
#'
#' \code{\link{import.many.csv}} imports many STAR CSV files from a directory
#' tree into a cluster.
#'
#' \code{\link{gfcmSTAR-package}} gives an overview of the package.
#'
#' @examples
#' \dontrun{
#' export.many.csv(cluster, topdir="working_group")
#' }
#'
#' @export

export.many.csv <- function(cluster, topdir, force=FALSE, quiet=TRUE, ...)
{
  sapply(cluster, write.star.csv, topdir=topdir, force=force, quiet=quiet, ...)
}
