#' Read STAR CSV
#'
#' Read STAR CSV files \file{metadata.csv} and \file{timeseries.csv} into a STAR
#' object.
#'
#' @param dir directory name.
#'
#' @return
#' STAR object, a list containing \code{Metadata} (simple list) and
#' \code{TimeSeries} (data frame).
#'
#' @seealso
#' \code{\link{import.many.csv}} imports many STAR CSV files from a directory
#' tree into a cluster (list).
#'
#' \code{\link{read.template}} reads an Excel STAR template into a STAR object.
#'
#' \code{\link{write.star.csv}} writes a STAR object to CSV files.
#'
#' \code{\link{gfcmSTAR-package}} gives an overview of the package.
#'
#' @examples
#' \dontrun{
#' read.star.csv("STAR_2019_HKE_5")
#' }
#'
#' @importFrom utils read.csv
#'
#' @export

read.star.csv <- function(dir)
{
  ## 1  Read CSV files
  Metadata <- as.list(read.csv(file.path(dir, "metadata.csv"),
                               stringsAsFactors=FALSE))
  class(Metadata) <- c("simple.list", "list")
  TimeSeries <- read.csv(file.path(dir, "timeseries.csv"),
                         stringsAsFactors=FALSE)

  ## 2  Set classes
  star <- list(Metadata=Metadata, TimeSeries=TimeSeries)
  star <- set.classes(star)

  star
}
