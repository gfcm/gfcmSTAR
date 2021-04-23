#' Combo String
#'
#' Create a string that combines Reference Year, Species Code, and GSA.
#'
#' @param metadata STAR Metadata object.
#' @param \dots optional strings to \code{\link{paste0}} after the combo, e.g. a
#'        file extension (including the period) or assessment method.
#'
#' @return
#' String with the format \code{"STAR_2019_HKE_5"} followed by optional strings
#' passed as \dots.
#'
#' @note
#' When a stock assessment covers multiple GSAs, they are separated by
#' underscores. An extreme example is \code{"STAR_2019_HKE_8_9_10_11.1_11.2"}.
#'
#' @seealso
#' \code{\link{lookup.species}} is a data frame containing species codes and names.
#'
#' \code{\link{gsa.names}} converts comma-separated GSA codes to full GSA names.
#'
#' \code{\link{gfcmSTAR-package}} gives an overview of the package.
#'
#' @examples
#' \dontrun{
#'
#' combo(star$Metadata)
#'
#' combo(star$Metadata, ".xlsx")
#'
#' combo(star$Metadata, "_", star$Metadata$Assessment_Method)
#' }
#'
#' @export

combo <- function(metadata, ...)
{
  ## 1  Extract Reference Year, Species, and GSA
  refyear <- metadata$Reference_Year
  sciname <- metadata$Scientific_Name
  gsa <- metadata$GSA

  ## 2  Convert to Species Code and underscore-separated GSA
  lookup <- gfcmSTAR::lookup.species
  species <- lookup$Alpha[lookup$Scientific == sciname]
  gsa <- gsub(",", "_", gsa)

  ## 3  Construct combo
  out <- paste("STAR", refyear, species, gsa, sep="_")
  out <- paste0(out, ...)

  out
}
