#' Read STAR Template Version 1.0
#'
#' Read the results found in an Excel STAR template version 1.0 into a STAR
#' object.
#'
#' @param file name of Excel file.
#' @param atype assessment type, \code{"Standard"} or \code{"Benchmark"}.
#' @param refyear reference year.
#' @param repyear reporting year.
#' @param countries countries, separated by comma and space.
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
#' \code{\link{read.template}} calls \code{read.template.v10} when the Excel
#' STAR template is of version 1.0.
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
#' star <- read.template.v10("STAR_2019_HKE_5.xlsx")
#' }
#'
#' @importFrom stats na.omit quantile
#' @importFrom utils tail
#' @importFrom XLConnect loadWorkbook readTable setMissingValue
#'
#' @export

read.template.v10 <- function(file, atype="Standard", refyear=2019,
                              repyear=2021, countries=NA, prop=NULL, suffix="",
                              quiet=TRUE)
{
  atype <- match.arg(atype, c("Standard", "Benchmark"))

  ## 1  Load workbook
  if(!quiet)
    message("Reading template '", file, "'")
  w <- loadWorkbook(file)
  setMissingValue(w, "NA")

  ## 2  Read tables
  Assessment_Information <-
    readTable.transpose(w, "Metadata", "Assessment_Information")
  Advice_Table <- readTable.transpose(w, "Metadata", "Advice_Table",
                                      useCachedValues=TRUE)
  VPA_Model <- readTable.logical(w, "Metadata", "VPA_Model")
  Forecast_Included <- readTable.logical(w, "Metadata", "Forecast_Included")
  Reference_Points <- readTable(w, "Metadata", "Reference_Points")
  Dimensions <- readTable(w, "Metadata", "Dimensions")
  Summary_Information <-
    readTable.transpose(w, "Summary", "Summary_Information")
  Summary_Table <- readTable(w, "Summary", "Summary_Table")
  Advice_Export <- readTable(w, "Advice", "Advice_Export", useCachedValues=TRUE)
  Advice_Export[Advice_Export==""] <- NA_character_

  ## 3  Extract information
  Scientific_Name <- Advice_Export$Species
  GSA <- Advice_Export$GSA

  Assessment_Type <- atype
  Reference_Year <- refyear
  Reporting_Year <- repyear
  Validation_Status <- Assessment_Information$Validation_Status
  Year_Benchmarked <- Assessment_Information$Year_Benchmarked
  Assessment_Method <- Assessment_Information$Assessment_Method
  Expert_Group <- Assessment_Information$Expert_Group
  Contact_Person <- Assessment_Information$Contact_Person

  Status_Fref <- Advice_Table$Quantitative_Status_F_Ftarget
  Status_Btarget <- Advice_Table$Quantitative_Status_B_Btarget
  Status_Bthreshold <- Advice_Table$Quantitative_Status_B_Bthreshold
  Status_Blimit <- Advice_Table$Quantitative_Status_B_Blimit
  Status_Text_F <- Advice_Table$Stock_Status_Text_Exploitation
  Status_Text_B <- Advice_Table$Stock_Status_Text_Stock_Size
  Scientific_Advice <- Advice_Table$Scientific_Advice
  WG_Comments <- Advice_Table$WG_Comments

  Fref_Basis <- Reference_Points$Reference.Point[1]
  Fref_Value <- Reference_Points$Value[1]
  Fmsy <- if(identical(Fref_Basis,"Fmsy")) Fref_Value else NA
  F0.1 <- if(identical(Fref_Basis,"F0.1")) Fref_Value else NA
  E0.4 <- if(identical(Fref_Basis,"E0.4")) Fref_Value else NA
  Bmsy <- if(identical(Reference_Points$Reference.Point[2],"Bmsy"))
            Reference_Points$Value[2] else NA
  Bpa <-  if(identical(Reference_Points$Reference.Point[3],"Bpa"))
            Reference_Points$Value[3] else NA
  Blim <- if(identical(Reference_Points$Reference.Point[2],"Blim"))
            Reference_Points$Value[2] else NA

  Current_F <- mean(tail(na.omit(Summary_Table$Fishing),
                         if(VPA_Model) 3 else 1))
  Current_B <- mean(tail(na.omit(Summary_Table$Stock1), if(VPA_Model) 3 else 1))
  B0.33 <- quantile(na.omit(Summary_Table$Stock1), 0.33, names=FALSE)
  B0.66 <- quantile(na.omit(Summary_Table$Stock1), 0.66, names=FALSE)

  Type_Confint <- Summary_Information$Type_of_confidence_intervals
  Recruitment_Unit <- Summary_Information$Recruitment_Unit
  Recruitment_Age <- Dimensions$Age[1]
  Recruitment_Length <- Dimensions$Length[1]
  Stock1_Indicator <- Summary_Information$Stock_Size_Indicator_1
  Stock1_Unit <- Summary_Information$Stock_Size_Unit_1
  Stock2_Indicator <- Summary_Information$Stock_Size_Indicator_2
  Stock2_Unit <- Summary_Information$Stock_Size_Unit_2
  Catches_Unit <- Summary_Information$Catches_Unit
  Exploitation_Unit <- Summary_Information$Fishing_Pressure_Type
  Effort_Unit <- Summary_Information$Fishing_Effort_Unit
  Fbar_First_Age <- Dimensions$Age[2]
  Fbar_Last_Age <- Dimensions$Age[3]
  Fbar_First_Length <- Dimensions$Length[2]
  Fbar_Last_Length <- Dimensions$Length[3]

  Advice_Levels <- comma2period(Advice_Export$Current.Levels)
  Advice_Refpts <- comma2period(Advice_Export$Reference.Points)
  Advice_Quant_Status <- comma2period(Advice_Export$Quantitative.Status)
  Advice_Stock_Status <- Advice_Export$Stock.Status
  GSA_Names <- gsa.names(GSA)
  Countries <- countries

  Template_Version <- "1.0.0"
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
  TimeSeries <- data.frame(Assessment_ID, Summary_Table, stringsAsFactors=FALSE)
  names(TimeSeries) <- Start_Case(names(TimeSeries))
  TimeSeries <- TimeSeries[-grep("Effort", names(TimeSeries))]

  ## 7  Convert data types
  star <- list(Metadata=Metadata, TimeSeries=TimeSeries)
  star <- set.classes(star)

  star
}
