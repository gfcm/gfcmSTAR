#' Peek
#'
#' Examine a metadata field of STAR objects.
#'
#' @param x STAR object or a cluster (list) of STAR objects.
#' @param field a metadata field, such as "Assessment_ID".
#'
#' @return Metadata field from STAR object(s).
#'
#' @note
#' This function is convenient to quickly examine a cluster (list) of STAR
#' objects after importing many STAR templates. See example below.
#'
#' @seealso
#' \code{\link{import.many.templates}} imports many Excel STAR templates from a
#' directory into a cluster (list).
#'
#' \code{\link{gfcmSTAR-package}} gives an overview of the package.
#'
#' @examples
#' \dontrun{
#'
#' peek(star, "Assessment_ID")
#'
#' peek(cluster, "Assessment_ID")
#' }
#'
#' @export

peek <- function(x, field)
{
  if(any(names(x) == "Metadata"))
    x$Metadata[[field]]
  else
    sapply(x, peek, field=field)
}
