#' Diff STARs
#'
#' Show the differences between two STAR objects.
#'
#' @param x STAR object, a list containing \code{Metadata} and
#'        \code{TimeSeries}.
#' @param y another STAR object to compare.
#' @param full whether to also show the parts that are similar in both.
#' @param width maximum column width in output.
#' @param \dots passed to \code{identical}.
#'
#' @return
#' A list of data frames showing the differences, or \code{NULL} if the STAR
#' objects are identical.
#'
#' @seealso
#' \code{\link{identical.stars}} checks if STAR objects are identical.
#'
#' \code{\link{identical}} is the underlying function used to compare each data
#' element.
#'
#' \code{\link{gfcmSTAR-package}} gives an overview of the package.
#'
#' @examples
#' \dontrun{
#' diff.stars(star1, star2)
#' }
#'
#' @export
#' @export diff.stars

diff.stars <- function(x, y, full=FALSE, width=20, ...)
{
  ## 1  Functions
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

  ## 2  Compare elements of Metadata and TimeSeries
  metadata.names <- union(names(x$Metadata), names(y$Metadata))
  Metadata <- data.frame(
    Same=sapply(metadata.names, same, part="Metadata"),
    x=sapply(x$Metadata, fmt, width=width),
    y=sapply(y$Metadata, fmt, width=width))
  timeseries.names <- union(names(x$TimeSeries), names(y$TimeSeries))
  TimeSeries <- data.frame(
    Same=sapply(timeseries.names, same, part="TimeSeries"),
    x=sapply(x$TimeSeries, fmt, width=width),
    y=sapply(y$TimeSeries, fmt, width=width))
  x.name <- tail(as.character(substitute(x)), 1)
  y.name <- tail(as.character(substitute(y)), 1)
  names(Metadata)[2:3] <- c(x.name, y.name)
  names(TimeSeries)[2:3] <- c(x.name, y.name)

  ## 3  Prepare output
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
