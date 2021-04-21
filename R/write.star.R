#' Write STAR Object to Files
#'
#' Write a STAR object to CSV files.
#'
#' @param star a STAR object, list containing \code{Metadata} and
#'        \code{TimeSeries}.
#' @param dir an optional directory name.
#' @param mfile a filename for the metadata.
#' @param tfile a filename for the time series.
#' @param quote whether to quote strings.
#' @param row.names whether to include row names.
#' @param fileEncoding character encoding for output file.
#' @param dos whether to ensure the resulting CSV files have Dos line endings.
#' @param \dots passed to \code{write.csv}.
#'
#' @return No return value, called for side effects.
#'
#' @seealso
#' \code{\link{write.csv}} is the underlying function used to write a table to a
#' file.
#'
#' \code{\link{read.star.v10}} reads from an Excel template into a STAR object.
#'
#' @importFrom utils write.csv
#'
#' @export

write.star <- function(star, dir=NULL, mfile="metadata.csv",
                       tfile="timeseries.csv", quote=TRUE, row.names=FALSE,
                       fileEncoding="UTF-8", dos=TRUE, ...)
{
  ## 1  Create and prepend directory
  dir <- if(is.null(dir)) "." else dir
  mkdir(dir)
  mfile <- file.path(dir, mfile)
  tfile <- file.path(dir, tfile)

  ## 2  Extract metadata and timeseries
  metadata <- as.data.frame(star$Metadata, stringsAsFactors=FALSE)
  timeseries <- star$TimeSeries

  ## 3  Write CSV files
  write.csv(metadata, file=mfile, quote=quote, row.names=row.names,
            fileEncoding=fileEncoding, ...)
  write.csv(timeseries, file=tfile, quote=quote, row.names=row.names,
            fileEncoding=fileEncoding, ...)

  ## 4  Ensure Dos line endings
  if(dos)
  {
    unix2dos(mfile)
    unix2dos(tfile)
  }
}
