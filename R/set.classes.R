#' Set Classes
#'
#' Convert metadata and time series in a STAR object to match the data types in
#' the STAR database.
#'
#' @param star STAR object, a list containing \code{Metadata} and
#'        \code{TimeSeries}.
#'
#' @return STAR object with correct data types.
#'
#' @seealso
#' \code{\link{class}} is the underlying base function used to set the data type
#' of an R object.
#'
#' \code{\link{read.template}} uses \code{set.classes} to convert data types.
#'
#' \code{\link{gfcmSTAR-package}} gives an overview of the package.
#'
#' @examples
#' \dontrun{
#' star <- set.classes(star)
#' }
#'
#' @export

set.classes <- function(star)
{
  ## 1  Get objects
  Metadata <- star$Metadata
  TimeSeries <- star$TimeSeries

  ## 2  Handle Metadata
  class(Metadata$Assessment_ID) <- "character"
  class(Metadata$Assessment) <- "character"
  class(Metadata$Scientific_Name) <- "character"
  class(Metadata$GSA) <- "character"

  class(Metadata$Assessment_Type) <- "character"
  class(Metadata$Reference_Year) <- "integer"
  class(Metadata$Reporting_Year) <- "integer"
  class(Metadata$Validation_Status) <- "character"
  class(Metadata$Year_Benchmarked) <- "integer"
  class(Metadata$Assessment_Method) <- "character"
  class(Metadata$Expert_Group) <- "character"
  class(Metadata$Contact_Person) <- "character"
  class(Metadata$Status_Fref) <- "numeric"
  class(Metadata$Status_Btarget) <- "numeric"
  class(Metadata$Status_Bthreshold) <- "numeric"
  class(Metadata$Status_Blimit) <- "numeric"
  class(Metadata$Status_Text_F) <- "character"
  class(Metadata$Status_Text_B) <- "character"
  class(Metadata$Scientific_Advice) <- "character"
  class(Metadata$WG_Comments) <- "character"
  class(Metadata$VPA_Model) <- "logical"
  class(Metadata$Forecast_Included) <- "logical"
  class(Metadata$Fmsy) <- "numeric"
  class(Metadata$F0.1) <- "numeric"
  class(Metadata$E0.4) <- "numeric"
  class(Metadata$Bmsy) <- "numeric"
  class(Metadata$Bpa) <-  "numeric"
  class(Metadata$Blim) <- "numeric"
  class(Metadata$Fref_Basis) <- "character"
  class(Metadata$Fref_Value) <- "numeric"
  class(Metadata$Current_F) <- "numeric"
  class(Metadata$Current_B) <- "numeric"
  class(Metadata$B0.33) <- "numeric"
  class(Metadata$B0.66) <- "numeric"

  class(Metadata$Type_Confint) <- "character"
  class(Metadata$Recruitment_Unit) <- "character"
  class(Metadata$Recruitment_Age) <- "integer"
  class(Metadata$Recruitment_Length) <- "numeric"
  class(Metadata$Stock1_Indicator) <- "character"
  class(Metadata$Stock1_Unit) <- "character"
  class(Metadata$Stock2_Indicator) <- "character"
  class(Metadata$Stock2_Unit) <- "character"
  class(Metadata$Catches_Unit) <- "character"
  class(Metadata$Exploitation_Unit) <- "character"
  class(Metadata$Effort_Unit) <- "character"
  class(Metadata$Fbar_First_Age) <- "integer"
  class(Metadata$Fbar_Last_Age) <- "integer"
  class(Metadata$Fbar_First_Length) <- "numeric"
  class(Metadata$Fbar_Last_Length) <- "numeric"

  class(Metadata$Advice_Levels) <- "character"
  class(Metadata$Advice_Refpts) <- "character"
  class(Metadata$Advice_Quant_Status) <- "character"
  class(Metadata$Advice_Stock_Status) <- "character"
  class(Metadata$GSA_Names) <- "character"
  class(Metadata$Countries) <- "character"

  class(Metadata$Template_Version) <- "character"

  class(Metadata$SharePoint_Folder) <- "character"
  class(Metadata$Excel_Filename) <- "character"
  class(Metadata$Person_Modified) <- "character"
  class(Metadata$Time_Modified) <- c("POSIXct", "POSIXt")
  class(Metadata$Time_Imported) <- c("POSIXct", "POSIXt")

  ## 3  Handle TimeSeries
  class(TimeSeries$Assessment_ID) <- "character"
  class(TimeSeries$Year) <- "integer"
  class(TimeSeries$Rec_Lower) <- "numeric"
  class(TimeSeries$Rec) <- "numeric"
  class(TimeSeries$Rec_Upper) <- "numeric"
  class(TimeSeries$Stock1_Lower) <- "numeric"
  class(TimeSeries$Stock1) <- "numeric"
  class(TimeSeries$Stock1_Upper) <- "numeric"
  class(TimeSeries$Stock2_Lower) <- "numeric"
  class(TimeSeries$Stock2) <- "numeric"
  class(TimeSeries$Stock2_Upper) <- "numeric"
  class(TimeSeries$Catches) <- "numeric"
  class(TimeSeries$Landings) <- "numeric"
  class(TimeSeries$Discards) <- "numeric"
  class(TimeSeries$Fishing_Lower) <- "numeric"
  class(TimeSeries$Fishing) <- "numeric"
  class(TimeSeries$Fishing_Upper) <- "numeric"

  ## 4  Construct list
  star <- list(Metadata=Metadata, TimeSeries=TimeSeries)

  star
}
