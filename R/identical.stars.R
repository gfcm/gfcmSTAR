#' Identical STARs
#'
#' Check whether two STAR objects are identical. This comparison excludes the
#' SharePoint and Excel properties \code{SharePoint_Folder},
#' \code{Excel_Filename}, \code{Person_Modified}, \code{Time_Modified}, and
#' \code{Time_Imported}.
#'
#' @param x STAR object, a list containing \code{Metadata} and
#'        \code{TimeSeries}.
#' @param y another STAR object to compare.
#'
#' @return
#' \code{TRUE} or \code{FALSE}, indicating whether the objects are identical,
#' disregarding the SharePoint and Excel properties.
#'
#' @note
#' When importing many STAR templates submitted by stock assessors, it can
#' happen that two Excel files contain the same stock assessment results. This
#' function helps to identify such cases.
#'
#' @seealso
#' \code{\link{diff.stars}} shows differences between STAR objects.
#'
#' \code{\link{identical}} is the underlying function used to compare the two
#' objects.
#'
#' \code{\link{gfcmSTAR-package}} gives an overview of the package.
#'
#' @examples
#' \dontrun{
#'
#' # Are the R objects completely identical?
#' identical(star1, star2)
#'
#' # Do the STAR objects contain the same data,
#' # disregarding SharePoint and Excel properties?
#' identical.stars(star1, star2)
#' }
#'
#' @export

identical.stars <- function(x, y)
{
  delete <- c("SharePoint_Folder", "Excel_Filename", "Person_Modified",
              "Time_Modified", "Time_Imported")
  x$Metadata[delete] <- NULL
  y$Metadata[delete] <- NULL

  identical(x, y)
}
