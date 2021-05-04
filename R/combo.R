#' Combo String
#'
#' Create a string that combines Reference Year, Species Code, and GSA.
#'
#' @param star STAR object, a list containing \code{Metadata} and
#'        \code{TimeSeries}.
#' @param \dots optional strings to \code{\link{paste0}} after the combo. See
#'        examples below.
#'
#' @return
#' String in the format \code{"STAR_2019_HKE_5"} followed by optional strings
#' passed by user.
#'
#' @note
#' When a stock assessment covers multiple GSAs, they are combined in a compact
#' format. For example GSA \code{"8,9,10,11.1,11.2"} becomes \code{"891011"}.
#'
#' @seealso
#' \code{\link{lookup.species}} is a data frame containing species codes and
#' names.
#'
#' \code{\link{gsa.names}} converts comma-separated GSA codes to full GSA names.
#'
#' \code{\link{gfcmSTAR-package}} gives an overview of the package.
#'
#' @examples
#' \dontrun{
#'
#' combo(star)
#'
#' combo(star, ".xlsx")
#'
#' combo(star, "_", star$Metadata$Assessment_Method)
#' }
#'
#' @export

combo <- function(star, ...)
{
  ## 1  Extract Reference Year, Species, and GSA
  refyear <- star$Metadata$Reference_Year
  sciname <- star$Metadata$Scientific_Name
  gsa <- star$Metadata$GSA

  ## 2  Convert to Species Code and compact GSA format
  lookup <- gfcmSTAR::lookup.species
  species <- lookup$Alpha[lookup$Scientific == sciname]
  gsa <- unlist(strsplit(gsa, ","))       # split 8 9 10 11.1 11.2
  gsa <- gsa[order(as.numeric(gsa))]      # sort 8 < 9 < 10 < 11.1 < 11.2
  gsa <- paste(gsa, collapse="")          # paste 891011.111.2
  gsa <- gsub("11\\.111\\.2", "11", gsa)  # simplify 891011

  ## 3  Construct combo
  out <- paste("STAR", refyear, species, gsa, sep="_")
  out <- paste0(out, ...)

  out
}
