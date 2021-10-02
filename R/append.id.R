#' Append Suffix to Assessment_ID
#'
#' Modify the \code{Assessment_ID} of an existing STAR object, in both the
#' \code{Metadata} and \code{TimeSeries} components.
#'
#' @param star STAR object, a list containing \code{Metadata} and
#'        \code{TimeSeries}.
#' @param suffix string appended to the existing \code{Assessment_ID} to create
#'        a unique identifier.
#'
#' @return \code{star} with the new \code{Assessment_ID}.
#'
#' @note
#' This function is an administrative tool, convenient when two (or more) STAR
#' objects imported into R have the same \code{Assessment_ID}. Before importing
#' into the STAR database, the \code{Assessment_ID} of these STAR objects should
#' be modified by appending different \code{suffix} strings. See example below.
#'
#' @seealso
#' \code{\link{combo}} is the general method to construct the
#' \code{Assessment_ID}.
#'
#' \code{\link{read.template}} reads an Excel STAR template into a STAR object,
#' offering the user to append a \code{suffix} at the time of initial import.
#'
#' \code{\link{gfcmSTAR-package}} gives an overview of the package.
#'
#' @examples
#' \dontrun{
#'
#' # Two STAR objects have the same Assessment_ID ... let's fix that
#' s1 <- append.id(s1, "a4a")
#' s2 <- append.id(s2, "spict")
#' }
#'
#' @export

append.id <- function(star, suffix)
{
  id <- paste0(star$Metadata$Assessment_ID, "_", suffix)
  star$Metadata$Assessment_ID <- id
  star$TimeSeries$Assessment_ID <- id
  star
}
