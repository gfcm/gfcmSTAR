#' Diff STARs
#'
#' Show the differences between two STAR templates/objects.
#'
#' @param x STAR template filename or STAR object, a list containing
#'        \code{Metadata} and \code{TimeSeries}.
#' @param y another STAR template/object to compare.
#' @param full whether to also show the parts that are similar in both.
#' @param width maximum column width in output.
#' @param \dots passed to \code{identical}.
#'
#' @return
#' A list of data frames showing the differences, or \code{NULL} if the STAR
#' objects are identical.
#'
#' @seealso
#' \code{\link{identical.stars}} checks if STAR templates/objects are identical.
#'
#' \code{\link{identical}} is the underlying function used to compare each data
#' element.
#'
#' \code{\link{gfcmSTAR-package}} gives an overview of the package.
#'
#' @examples
#' \dontrun{
#' diff.stars(star1, star2)
#' diff.stars("STAR_1.xlsx", "STAR_2.xlsx")
#' }
#'
#' @export
#' @export diff.stars

## Implementation note:
##
## The function name diff.stars() is good for describing its purpose and
## behavior, although it confuses both 'R CMD check' and roxygen2. Like the
## 'diff' shell command, diff.stars() returns nothing if the objects are the
## same.
##
## We export as S3 method to get a clean R CMD check. It is more important to
## suppress unnecessary noise from R CMD check than to be right about whether
## diff.stars() is an S3 method or not.

diff.stars <- function(x, y, full=FALSE, width=20, ...)
{
  ## Handle possible filenames, create a short column label
  if(is.character(x))
  {
    x.name <- basename(x)
    x <- read.template(x)
  }
  else
  {
    x.name <- tail(as.character(substitute(x)), 1)
  }
  if(is.character(y))
  {
    y.name <- basename(y)
    y <- read.template(y)
  }
  else
  {
    y.name <- tail(as.character(substitute(y)), 1)
  }

  ## Functions
  same <- function(element, part)  # check if two list elements are identical
  {
    identical(x[[part]][[element]], y[[part]][[element]], ...)
  }
  fmt <- function(x, width)   # format anything as string with max width
  {
    y <- if(length(x) > 1)
           format(x[1])
         else if(is.na(x))
           "NA"
         else if(class(x)[1] == "POSIXct")
           format(x, format="%Y-%m-%d %H:%M:%S")
         else if(is.numeric(x))
           format(x)
         else
           x
    if(nchar(y) > width)
      paste0(substring(y, 1, width-3), "...")
    else
      y
  }

  ## Compare elements of Metadata and TimeSeries
  metadata.names <- union(names(x$Metadata), names(y$Metadata))
  Metadata <- data.frame(
    Same=sapply(metadata.names, same, part="Metadata"),
    x=sapply(x$Metadata, fmt, width=width),
    y=sapply(y$Metadata, fmt, width=width),
    stringsAsFactors=FALSE)
  timeseries.names <- union(names(x$TimeSeries), names(y$TimeSeries))
  TimeSeries <- data.frame(
    Same=sapply(timeseries.names, same, part="TimeSeries"),
    x=sapply(x$TimeSeries, fmt, width=width),
    y=sapply(y$TimeSeries, fmt, width=width),
    stringsAsFactors=FALSE)
  names(Metadata)[2:3] <- c(x.name, y.name)
  names(TimeSeries)[2:3] <- c(x.name, y.name)

  ## Prepare output
  if(full)
  {
    out <- list(Metadata=Metadata, TimeSeries=TimeSeries)
  }
  else
  {
    out <- list()
    if(!all(Metadata$Same))
      out$Metadata <- Metadata[!Metadata$Same,]
    if(!all(TimeSeries$Same))
      out$TimeSeries <- TimeSeries[!TimeSeries$Same,]
    if(length(out) == 0)
      out <- NULL
  }
  out
}
