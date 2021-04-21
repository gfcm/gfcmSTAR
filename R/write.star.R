#' Write STAR Object to Files
#'
#' Write a STAR object to CSV files.
#'
#' @param star a STAR object, list containing \code{Metadata} and
#'        \code{TimeSeries}.
#' @param dir an optional directory name to write the CSV files into, or a
#'        logical value. See details.
#' @param mfile a filename for the metadata.
#' @param tfile a filename for the time series.
#' @param quote whether to quote strings.
#' @param row.names whether to include row names.
#' @param fileEncoding character encoding for output file.
#' @param dos whether to ensure the resulting CSV files have Dos line endings.
#' @param quiet whether to suppress messages.
#' @param \dots passed to \code{write.csv}.
#'
#' @details
#' The special value \code{dir = TRUE} can be used as shorthand for the prefix
#' of the original Excel template filename. For example, if
#' \code{star$Metadata$Excel_Filename} is \code{"STAR_2019_HKE_5.xlsx"}, then a
#' directory called \file{STAR_2019_HKE_5} will be created and used.
#'
#' The special value \code{dir = FALSE} can be used as shorthand for the current
#' directory, the same as \code{dir = "."}.
#'
#' @return No return value, called for side effects.
#'
#' @seealso
#' \code{\link{write.csv}} is the underlying function used to write a table to a
#' file.
#'
#' \code{\link{read.template.v10}} reads from an Excel template into a STAR
#' object.
#'
#' @importFrom tools file_path_sans_ext
#' @importFrom utils write.csv
#'
#' @export

write.star <- function(star, dir=TRUE, mfile="metadata.csv",
                       tfile="timeseries.csv", quote=TRUE, row.names=FALSE,
                       fileEncoding="UTF-8", dos=TRUE, quiet=FALSE, ...)
{
  ## 1  Create and prepend directory
  if(identical(dir, TRUE))
    dir <- file_path_sans_ext(star$Metadata$Excel_Filename)
  if(identical(dir, FALSE))
    dir <- "."
  if(dir != ".")
  {
    if(!dir.exists(dir))
    {
      message("Creating directory '", dir, "'")
      dir.create(dir, recursive=TRUE)
    }
    mfile <- file.path(dir, mfile)
    tfile <- file.path(dir, tfile)
  }

  ## 2  Extract metadata and timeseries
  metadata <- as.data.frame(star$Metadata, stringsAsFactors=FALSE)
  timeseries <- star$TimeSeries

  ## 3  Write CSV files
  if(!quiet)
    message("Writing ", mfile)
  write.csv(metadata, file=mfile, quote=quote, row.names=row.names,
            fileEncoding=fileEncoding, ...)
  if(!quiet)
    message("Writing ", tfile)
  write.csv(timeseries, file=tfile, quote=quote, row.names=row.names,
            fileEncoding=fileEncoding, ...)

  ## 4  Ensure Dos line endings
  if(dos)
  {
    u2d(mfile)
    u2d(tfile)
  }
}
