#' Identical STARs
#'
#' Check whether two STAR objects are identical. This comparison excludes the
#' \code{Time_Imported} data field.
#'
#' @param a STAR object, a list containing \code{Metadata} and
#'        \code{TimeSeries}.
#' @param b another STAR object.
#'
#' @return
#' \code{TRUE} or \code{FALSE}, indicating whether the objects are identical,
#' disregarding the time when they were imported.
#'
#' @note
#' When importing many STAR templates submitted by stock assessors, it can
#' happen that two Excel files contain the same data. This function helps to
#' identify such cases.
#'
#' @seealso
#' \code{\link{identical}} is the underlying base function used to compare the
#' two objects.
#'
#' \code{\link{gfcmSTAR-package}} gives an overview of the package.
#'
#' @examples
#' \dontrun{
#' identical.star(star1, star2)
#' }
#'
#' @export

identical.stars <- function(a, b)
{
  a$Metadata$Time_Imported <- NULL
  b$Metadata$Time_Imported <- NULL
  identical(a, b)
}
