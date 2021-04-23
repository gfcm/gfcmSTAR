#' Combo String
#'
#' Create a string that combines the Reference Year, Species, and GSA.
#'
#' @param metadata STAR Metadata object.
#' @param suffix an optional string to paste after the combo, e.g. a file
#'        extension (including the period).
#'
#' @return
#' String with the format \code{"STAR_2019_HKE_5"} followed by an optional
#' \code{suffix}.
#'
#' @note
#' When a stock assessment covers multiple GSAs, they are separated by
#' underscores. An extreme example is \code{"STAR_2019_HKE_8_9_10_11.1_11.2"}.
#'
#' @seealso
#' \code{\link{gsa.names}} converts comma-separated GSA codes to full GSA names.
#'
#' \code{\link{lookup.species}} is a data frame containing GSA codes and names.
#'
#' \code{\link{gfcmSTAR-package}} gives an overview of the package.
#'
#' @examples
#' \dontrun{
#'
#' combo(star$Metadata)
#'
#' combo(star$Metadata, ".xlsx")
#' }
#'
#' @export

combo <- function(metadata, suffix=NULL)
{
  refyear <- metadata$Reference_Year
  sciname <- metadata$Scientific_Name
  gsa <- metadata$GSA

  species <- lookup.species$Alpha[lookup.species$Scientific == sciname]
  gsa <- gsub(",", "_", gsa)

  out <- paste("STAR", refyear, species, gsa, sep="_")
  out <- paste0(out, suffix)
  out
}
