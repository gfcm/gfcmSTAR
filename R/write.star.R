#' @rdname gfcmSTAR-internal
#'
#' @importFrom utils write.csv
#'
#' @export

## Write

write.star <- function(star, mfile="metadata.csv", tfile="timeseries.csv", ...)
{
  metadata <- as.data.frame(star$Metadata, stringsAsFactors=FALSE)
  timeseries <- star$TimeSeries
  write.csv(metadata, file=mfile, ...)
  write.csv(timeseries, file=tfile, ...)
}
