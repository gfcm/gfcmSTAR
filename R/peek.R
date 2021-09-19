#' Peek
#'
#' Examine a metadata field of STAR objects.
#'
#' @param x STAR object or a cluster (list) of STAR objects. Alternatively,
#'          \code{x} can be an Excel STAR template filename or directory name.
#' @param field a metadata field, by default "Assessment_ID".
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
#' peek(star)
#' peek(star, "Scientific_Name")
#' peek(star, "Status_Fref")
#'
#' peek(star)         # object
#' peek(cluster)      # cluster
#' peek("STAR.xlsx")  # file
#' peek("folder")     # dir
#' }
#'
#' @export

peek <- function(x, field="Assessment_ID")
{
  ## Read directory or file
  if(is.character(x) && dir.exists(x))
    x <- import.many.templates(x, quiet=TRUE)
  if(is.character(x) && file.exists(x))
    x <- read.template(x)

  ## Handle cluster or star
  if(is.list(x) && any(names(x[[1]])=="Metadata"))  # cluster
    sapply(x, peek, field=field)
  else if(is.list(x) && any(names(x)=="Metadata"))  # star
    x$Metadata[[field]]
  else  # x was not a directory, file, cluster, or star
    NA
}
