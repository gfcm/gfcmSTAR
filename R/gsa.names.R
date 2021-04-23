#' Convert GSA Names
#'
#' Convert comma-separated GSA codes to a series of full GSA names.
#'
#' @param gsa comma-separated GSA codes.
#'
#' @return
#' String with the format \code{"1 - Northern Alboran Sea, 2 - Alboran Island"}.
#'
#' @seealso
#' \code{\link{lookup.gsa}} is a data frame containing GSA codes and names.
#'
#' \code{\link{combo}} combines reference year, species, and GSA.
#'
#' \code{\link{gfcmSTAR-package}} gives an overview of the package.
#'
#' @examples
#' gsa.names("1,2")
#'
#' @export

gsa.names <- function(gsa)
{
  ## 1  Split GSA
  gsa <- gsub(" ", "", gsa)
  gsa <- unlist(strsplit(gsa, ","))

  ## 2  Check user input
  if(any(duplicated(gsa)))
    stop("GSA ", gsa[which(duplicated(gsa))[1]], " is duplicated")
  lookup <- gfcmSTAR::lookup.gsa
  ok <- gsa %in% lookup$Code
  if(any(!ok))
    stop("GSA ", gsa[which(!ok)[1]], " not defined")

  ## 3  Construct full GSA names
  full <- lookup[match(gsa, lookup$Code),]
  full <- apply(full, 1, paste, collapse=" - ")
  full <- paste(full, collapse=", ")

  full
}
