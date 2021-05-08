#' Import Many CSV Files
#'
#' Import many STAR CSV files from a directory tree into a cluster (list) of
#' STAR objects.
#'
#' @param dir directory name.
#'
#' @return A cluster (list) of STAR objects.
#'
#' @note
#' The top directory can have any name, but the directory tree must have the
#' following structure: \preformatted{
#' dirname/
#'     STAR_2019_HKE_4/
#'         metadata.csv
#'         timeseries.csv
#'     STAR_2019_HKE_5/
#'         metadata.csv
#'         timeseries.csv}
#'
#' @seealso
#' \code{\link{read.star.csv}} reads a pair of STAR CSV files into a STAR
#' object.
#'
#' \code{\link{write.star.csv}} writes a STAR object to CSV files.
#'
#' \code{\link{import.many.templates}} imports many Excel STAR templates from a
#' directory into a cluster (list).
#'
#' \code{\link{export.many.csv}} exports a cluster (list) of STAR objects to CSV
#' files.
#'
#' \code{\link{gfcmSTAR-package}} gives an overview of the package.
#'
#' @examples
#' \dontrun{
#' cluster <- import.many.csv("csv")
#' }
#'
#' @export

import.many.csv <- function(dir)
{
  stars <- dir(dir, full.name=TRUE)
  stars <- stars[dir.exists(stars)]  # only directories

  cluster <- lapply(stars, read.star.csv)
  names(cluster) <- basename(stars)

  cluster
}
