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
#' @param dos whether to ensure resulting CSV files have Dos line endings.
#' @param \dots passed to \code{write.csv}.
#'
#' @return No return value, called for side effects.
#'
#' @note
#' The resulting CSV file has Dos line endings, as specified in the RFC 4180
#' standard (IETF 2005).
#'
#' @references
#' IETF (2005).
#' Common format and Mime type for Comma-Separated Values (CSV) files.
#' \href{https://tools.ietf.org/html/rfc4180}{\emph{IETF RFC} 4180}.
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
  dir <- if(is.null(dir)) "." else dir

  metadata <- as.data.frame(star$Metadata, stringsAsFactors=FALSE)
  timeseries <- star$TimeSeries

  write.csv(metadata, file=mfile, quote=quote, row.names=row.names,
            fileEncoding=fileEncoding, ...)
  write.csv(timeseries, file=tfile, quote=quote, row.names=row.names,
            fileEncoding=fileEncoding, ...)

  if(dos)
  {
    unix2dos(mfile)
    unix2dos(tfile)
  }
}
