#' Write STAR Object to Files
#'
#' Write a STAR object to files.
#'
#' @param x a STAR object, list containing \code{Metadata} and
#'        \code{TimeSeries}.
#' @param mfile a filename for the metadata.
#' @param tfile a filename for the time series.
#' @param \dots passed to \code{write.csv}.
#'
#' @importFrom utils write.csv
#'
#' @export

## Write

write.star <- function(x, mfile="metadata.csv", tfile="timeseries.csv", ...)
{
  metadata <- as.data.frame(x$Metadata, stringsAsFactors=FALSE)
  timeseries <- x$TimeSeries
  write.csv(metadata, file=mfile, ...)
  write.csv(timeseries, file=tfile, ...)
}
