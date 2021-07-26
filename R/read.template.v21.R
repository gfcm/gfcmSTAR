#' Read STAR Template Version 2.1
#'
#' Read the results found in an Excel STAR template version 2.1 into a STAR
#' object.
#'
#' @param file name of Excel file.
#' @param prop SharePoint properties from \code{read.properties}.
#' @param suffix optional string passed to \code{combo} to construct a unique
#'        \code{Assessment_ID} field.
#' @param quiet whether to supress messages.
#'
#' @return
#' STAR object, a list containing \code{Metadata} (simple list) and
#' \code{TimeSeries} (data frame).
#'
#' @seealso
#' \code{\link{read.template}} calls \code{read.template.v21} when the Excel
#' STAR template is of version 2.1.
#'
#' \code{\link[XLConnect]{loadWorkbook}} and \code{\link[XLConnect]{readTable}}
#' are the underlying functions used to read data from Excel STAR templates.
#'
#' \code{\link{read.properties}} reads SharePoint properties from an Excel file.
#'
#' \code{\link{combo}} is used to construct the \code{Assessment_ID} metadata
#' field.
#'
#' \code{\link{gfcmSTAR-package}} gives an overview of the package.
#'
#' @examples
#' \dontrun{
#'
#' # Import
#' star <- read.template.v21("STAR_SOL_GSA17.xlsx")
#' }
#'
#' @importFrom stats na.omit quantile
#' @importFrom utils tail
#' @importFrom XLConnect loadWorkbook readTable setMissingValue
#'
#' @export

read.template.v21 <- function(file, prop=NULL, suffix="", quiet=TRUE)
{
  ## 1  Load workbook
  if(!quiet)
    message("Reading template '", file, "'")
  w <- loadWorkbook(file)
  setMissingValue(w, "NA")

  ## 2  Read tables
  Template_Version <- readTable(w, "Readme", "Version")[[1]]
  Assessment_Info <- readTable.transpose(w, "Metadata", "Assessment_Info")
  For_Advice <- readTable.transpose(w, "Metadata", "For_Advice",
                                    useCachedValues=TRUE)
  For_Advice[For_Advice==""] <- NA_character_
  VPA_Model <- readTable.logical(w, "Metadata", "VPA_Model")
  Forecast_Included <- readTable.logical(w, "Metadata", "Forecast_Included")
  Reference_Points <- readTable.transpose(w, "Metadata", "Reference_Points")
  From_TimeSeries <- readTable.transpose(w, "Metadata", "From_TimeSeries")
  Type_Confint <- readTable(w, "TimeSeries", "Type_Confint")[[1]]
  Info_Recruitment <- readTable.transpose(w, "TimeSeries", "Info_Recruitment")
  Info_Stock1 <- readTable.transpose(w, "TimeSeries", "Info_Stock1")
  Info_Stock2 <- readTable.transpose(w, "TimeSeries", "Info_Stock2")
  Info_Catch <- readTable(w, "TimeSeries", "Info_Catch")[[1]]
  Info_Exploitation <- readTable.transpose(w, "TimeSeries", "Info_Exploitation")
  TS_Table <- readTable(w, "TimeSeries", "TS_Table")
  Advice_Export <- readTable(w, "Advice", "Advice_Export", useCachedValues=TRUE)
  Advice_Export[Advice_Export==""] <- NA_character_
  GSA_Countries <- readTable(w, "Advice", "GSA_Countries")

  ## 3  Extract information
  Scientific_Name <- Advice_Export$Species
  GSA <- Advice_Export$GSA

  Assessment_Type <- Assessment_Info$Assessment_Type
  Reference_Year <- Assessment_Info$Reference_Year
  Reporting_Year <- Assessment_Info$Reporting_Year
  Validation_Status <- Assessment_Info$Validation_Status
  Year_Benchmarked <- Assessment_Info$Year_Benchmarked
  Assessment_Method <- Assessment_Info$Assessment_Method
  Expert_Group <- Assessment_Info$Expert_Group
  Contact_Person <- Assessment_Info$Contact_Person

  Status_Fref <- For_Advice$Quantitative_Status_F_Fref
  Status_Btarget <- For_Advice$Quantitative_Status_B_Btarget
  Status_Bthreshold <- For_Advice$Quantitative_Status_B_Bthreshold
  Status_Blimit <- For_Advice$Quantitative_Status_B_Blimit
  Status_Text_F <- For_Advice$Stock_Status_Text_Exploitation
  Status_Text_B <- For_Advice$Stock_Status_Text_Biomass
  Scientific_Advice <- For_Advice$Scientific_Advice
  WG_Comments <- For_Advice$WG_Comments

  Fref_Basis <- names(Reference_Points)[1]
  Fref_Value <- Reference_Points[[1]]
  Fmsy <- if(identical(Fref_Basis,"Fmsy")) Fref_Value else NA
  F0.1 <- if(identical(Fref_Basis,"F0.1")) Fref_Value else NA
  E0.4 <- if(identical(Fref_Basis,"E0.4")) Fref_Value else NA
  Bmsy <- Reference_Points$Bmsy
  Bpa <-  Reference_Points$Bpa
  Blim <- Reference_Points$Blim

  Current_F <- From_TimeSeries$Current_F
  Current_B <- From_TimeSeries$Current_B
  B0.33 <- From_TimeSeries$B0.33
  B0.66 <- From_TimeSeries$B0.66

  Recruitment_Unit <- Info_Recruitment$Unit
  Recruitment_Age <- Info_Recruitment$Age_at_Recruitment
  Recruitment_Length <- Info_Recruitment$or_Length_at_Recruitment
  Stock1_Indicator <- Info_Stock1$Indicator
  Stock1_Unit <- Info_Stock1$Unit
  Stock2_Indicator <- Info_Stock2$Indicator
  Stock2_Unit <- Info_Stock2$Unit
  Catches_Unit <- Info_Catch
  Exploitation_Unit <- Info_Exploitation$Exploitation_Unit
  Effort_Unit <- Info_Exploitation$Effort_Unit
  Fbar_First_Age <- Info_Exploitation$Fbar_First_Age
  Fbar_Last_Age <- Info_Exploitation$Fbar_Last_Age
  Fbar_First_Length <- Info_Exploitation$or_Fbar_First_Length
  Fbar_Last_Length <- Info_Exploitation$and_Fbar_Last_Length

  Advice_Levels <- comma2period(Advice_Export$Current.Levels)
  Advice_Refpts <- comma2period(Advice_Export$Reference.Points)
  Advice_Quant_Status <- comma2period(Advice_Export$Quantitative.Status)
  Advice_Stock_Status <- Advice_Export$Stock.Status
  GSA_Names <- GSA_Countries$GSA.Names
  Countries <- GSA_Countries$Countries

  Excel_Filename <- basename(file)
  if(is.null(prop))
  {
    SharePoint_Folder <- NA
    Person_Modified <- NA
    Time_Modified <- NA
  }
  else
  {
    SharePoint_Folder <- prop$Path[prop$Name==Excel_Filename]
    Person_Modified <- prop$Modified.By[prop$Name==Excel_Filename]
    Time_Modified <- prop$Modified[prop$Name==Excel_Filename]
  }
  Time_Imported <- Sys.time()

  ## 4  Construct Assessment_ID
  m <- data.frame(Reference_Year, Scientific_Name, GSA, stringsAsFactors=FALSE)
  Assessment_ID <- combo(list(Metadata=m), "_", suffix)
  Assessment_ID <- gsub("__", "_", Assessment_ID)  # no double underscores
  Assessment_ID <- gsub("_$", "", Assessment_ID)   # no trailing underscore

  ## 5  Create Metadata
  Metadata <- as.list(data.frame(
    Assessment_ID, Scientific_Name, GSA,
    Assessment_Type, Reference_Year, Reporting_Year, Validation_Status,
    Year_Benchmarked, Assessment_Method, Expert_Group, Contact_Person,
    Status_Fref, Status_Btarget, Status_Bthreshold, Status_Blimit,
    Status_Text_F, Status_Text_B, Scientific_Advice, WG_Comments,
    VPA_Model, Forecast_Included,
    Fmsy, F0.1, E0.4, Bmsy, Bpa, Blim, Fref_Basis, Fref_Value,
    Current_F, Current_B, B0.33, B0.66,
    Type_Confint, Recruitment_Unit, Recruitment_Age, Recruitment_Length,
    Stock1_Indicator, Stock1_Unit, Stock2_Indicator, Stock2_Unit,
    Catches_Unit, Exploitation_Unit, Effort_Unit,
    Fbar_First_Age, Fbar_Last_Age, Fbar_First_Length, Fbar_Last_Length,
    Advice_Levels, Advice_Refpts, Advice_Quant_Status, Advice_Stock_Status,
    GSA_Names, Countries, Template_Version,
    SharePoint_Folder, Excel_Filename, Person_Modified,
    Time_Modified, Time_Imported,
    stringsAsFactors=FALSE))
  class(Metadata) <- c("simple.list", "list")

  ## 6  Create TimeSeries
  TimeSeries <- data.frame(Assessment_ID, TS_Table, stringsAsFactors=FALSE)
  names(TimeSeries) <- Start_Case(names(TimeSeries))

  ## 7  Convert data types
  star <- list(Metadata=Metadata, TimeSeries=TimeSeries)
  star <- set.classes(star)

  star
}
