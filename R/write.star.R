#' Write STAR Object to Files
#'
#' Write a STAR object to CSV files.
#'
#' @param star STAR object, a list containing \code{Metadata} and
#'        \code{TimeSeries}.
#' @param dir an optional directory to write the CSV files into, or a logical
#'        value. See details below.
#' @param topdir an optional directory containing \code{dir}. See details below.
#' @param mfile a filename for the metadata.
#' @param tfile a filename for the time series.
#' @param quote whether to quote strings.
#' @param row.names whether to include row names.
#' @param fileEncoding character encoding for output file.
#' @param dos whether to ensure the resulting CSV files have Dos line endings
#'        (CRLF).
#' @param quiet whether to suppress messages.
#' @param \dots passed to \code{write.csv}.
#'
#' @details
#' The special value \code{dir = TRUE} can be used as shorthand for
#' \code{combo(star$Metadata)}, which can produce a suitable directory name.
#'
#' The special value \code{dir = FALSE} is equivalent to \code{dir = "."} which
#' will write the CSV files into the current directory.
#'
#' The \code{topdir} argument can be used to organize the output from multiple
#' STAR objects in one top directory. For example, \preformatted{
#' write.star(read.template("STAR_2019_HKE_4.xlsx"), topdir="csv")
#' write.star(read.template("STAR_2019_HKE_5.xlsx"), topdir="csv")} will produce
#' four files in the following directory structure: \preformatted{
#' csv/
#'     STAR_2019_HKE_4/
#'         metadata.csv
#'         timeseries.csv
#'     STAR_2019_HKE_5/
#'         metadata.csv
#'         timeseries.csv}
#'
#' @return No return value, called for side effects.
#'
#' @seealso
#' \code{\link{write.csv}} is the underlying function used to write a table to a
#' CSV file.
#'
#' \code{\link{read.template}} reads an Excel STAR template into a STAR object.
#'
#' \code{\link{gfcmSTAR-package}} gives an overview of the package.
#'
#' @examples
#' \dontrun{
#'
#' write.star(star)
#'
#' write.star(star, dir="hake_5")
#'
#' write.star(star, topdir="csv")
#' }
#'
#' @importFrom utils write.csv
#'
#' @export

write.star <- function(star, dir=TRUE, topdir=NULL, mfile="metadata.csv",
                       tfile="timeseries.csv", quote=TRUE, row.names=FALSE,
                       fileEncoding="UTF-8", dos=TRUE, quiet=FALSE, ...)
{
  ## 1  Construct path
  if(identical(dir, TRUE))
    dir <- combo(star$Metadata)
  if(identical(dir, FALSE) || is.null(dir) || is.na(dir) || dir == "")
    dir <- "."
  if(is.logical(topdir) || is.null(topdir) || is.na(topdir) || topdir == "")
    topdir <- "."
  path <- if(topdir == ".") dir
          else if(dir == ".") topdir
          else file.path(topdir, dir)

  ## 2  Create directory
  if(path != ".")
  {
    if(!dir.exists(path))
    {
      if(!quiet)
        message("Creating directory '", path, "'")
      dir.create(path, recursive=TRUE)
    }
    mfile <- file.path(path, mfile)
    tfile <- file.path(path, tfile)
  }

  ## 3  Extract metadata and timeseries
  metadata <- as.data.frame(star$Metadata, stringsAsFactors=FALSE)
  timeseries <- star$TimeSeries

  ## 4  Write CSV files
  eol <- if(dos && Sys.info()[["sysname"]] != "Windows") "\r\n" else "\n"
  if(!quiet)
    message("Writing '", mfile, "'")
  write.csv(metadata, file=mfile, quote=quote, eol=eol, row.names=row.names,
            fileEncoding=fileEncoding, ...)
  if(!quiet)
    message("Writing '", tfile, "'")
  write.csv(timeseries, file=tfile, quote=quote, eol=eol, row.names=row.names,
            fileEncoding=fileEncoding, ...)
}
