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
#'
#' @return
#' STAR object, a list containing \code{Metadata} (simple list) and
#' \code{TimeSeries} (data frame).
#'
#' @note
#' The purpose of storing \code{Metadata} as class
#' \code{c("simple.list", "list")} is to have it display in a compact and
#' readable format in the console. It is easy to convert to a normal list or
#' data frame - see examples below.
#'
#' @seealso
#' \code{\link[XLConnect]{loadWorkbook}} and \code{\link[XLConnect]{readTable}}
#' are the underlying functions used to read data from Excel STAR templates.
#'
#' \code{\link{read.properties}} reads SharePoint properties from an Excel file.
#'
#' \code{\link{write.star}} writes a STAR object to CSV files.
#'
#' \code{\link{gfcmSTAR-package}} gives an overview of the package.
#'
#' @examples
#' \dontrun{
#'
#' # Import
#' star <- read.template.v10("STAR_2019_HKE_5.xlsx")
#'
#' # Coerce metadata to list or data frame:
#' star$Metadata                 # simple.list (default)
#' unclass(star$Metadata)        # list
#' as.data.frame(star$Metadata)  # data.frame
#' }
#'
#' @importFrom stats na.omit quantile
#' @importFrom uuid UUIDgenerate
#' @importFrom utils tail
#' @importFrom XLConnect loadWorkbook readTable setMissingValue
#'
#' @export

read.template.v10 <- function(file, atype="Standard", refyear=2019,
                              repyear=2021, countries=NA)
{
  atype <- match.arg(atype, c("Standard", "Benchmark"))

  ## 1  Load workbook
  w <- loadWorkbook(file)
  setMissingValue(w, "NA")

  ## 2  Read tables
  Assessment_Information <-
    readTableTranspose(w, "Metadata", "Assessment_Information")
  Advice_Table <- readTableTranspose(w, "Metadata", "Advice_Table",
                                     useCachedValues=TRUE)
  VPA_Model <- readTableLogical(w, "Metadata", "VPA_Model")
  Forecast_Included <- readTableLogical(w, "Metadata", "Forecast_Included")
  Reference_Points <- readTable(w, "Metadata", "Reference_Points")
  Dimensions <- readTable(w, "Metadata", "Dimensions")
  Summary_Information <- readTableTranspose(w, "Summary", "Summary_Information")
  Summary_Table <- readTable(w, "Summary", "Summary_Table", colTypes="numeric")
  Summary_Table$Year <- as.integer(Summary_Table$Year)
  Advice_Export <- readTable(w, "Advice", "Advice_Export", useCachedValues=TRUE)
  Advice_Export[Advice_Export==""] <- NA_character_

  ## 3  Extract information
  Assessment_ID <- as.character(UUIDgenerate())
  Scientific_Name <- as.character(Advice_Export$Species)
  GSA <- as.character(Advice_Export$GSA)

  Assessment_Type <- as.character(atype)
  Reference_Year <- as.integer(refyear)
  Reporting_Year <- as.integer(repyear)
  Validation_Status <- as.character(Assessment_Information$Validation_Status)
  Year_Benchmarked <- as.integer(Assessment_Information$Year_Benchmarked)
  Assessment_Method <- as.character(Assessment_Information$Assessment_Method)
  Expert_Group <- as.character(Assessment_Information$Expert_Group)
  Contact_Person <- as.character(Assessment_Information$Contact_Person)

  Status_Fref <- as.numeric(Advice_Table$Quantitative_Status_F_Ftarget)
  Status_Btarget <- as.numeric(Advice_Table$Quantitative_Status_B_Btarget)
  Status_Bthreshold <- as.numeric(Advice_Table$Quantitative_Status_B_Bthreshold)
  Status_Blimit <- as.numeric(Advice_Table$Quantitative_Status_B_Blimit)
  Status_Text_F <- as.character(Advice_Table$Stock_Status_Text_Exploitation)
  Status_Text_B <- as.character(Advice_Table$Stock_Status_Text_Stock_Size)
  Scientific_Advice <- as.character(Advice_Table$Scientific_Advice)
  WG_Comments <- as.character(Advice_Table$WG_Comments)

  Fref_Basis <- as.character(Reference_Points$Reference.Point[1])
  Fref_Value <- as.numeric(Reference_Points$Value[1])
  Fmsy <- if(identical(Fref_Basis,"Fmsy")) Fref_Value else NA_real_
  F0.1 <- if(identical(Fref_Basis,"F0.1")) Fref_Value else NA_real_
  E0.4 <- if(identical(Fref_Basis,"E0.4")) Fref_Value else NA_real_
  Bmsy <- if(identical(Reference_Points$Reference.Point[2],"Bmsy"))
            as.numeric(Reference_Points$Value[2]) else NA_real_
  Bpa <-  if(identical(Reference_Points$Reference.Point[3],"Bpa"))
            as.numeric(Reference_Points$Value[3]) else NA_real_
  Blim <- if(identical(Reference_Points$Reference.Point[2],"Blim"))
            as.numeric(Reference_Points$Value[2]) else NA_real_

  Current_F <- mean(tail(na.omit(Summary_Table$Fishing),
                         if(VPA_Model) 3 else 1))
  Current_B <- mean(tail(na.omit(Summary_Table$Stock1), if(VPA_Model) 3 else 1))
  B0.33 <- as.numeric(quantile(na.omit(Summary_Table$Stock1), 0.33,
                               names=FALSE))
  B0.66 <- as.numeric(quantile(na.omit(Summary_Table$Stock1), 0.66,
                               names=FALSE))

  Type_Confint <- as.character(Summary_Information$Type_of_confidence_intervals)
  Rec_Unit <- as.character(Summary_Information$Recruitment_Unit)
  Recruitment_Age <- as.integer(Dimensions$Age[1])
  Recruitment_Length <- as.numeric(Dimensions$Length[1])
  Stock1_Indicator <- as.character(Summary_Information$Stock_Size_Indicator_1)
  Stock1_Unit <- as.character(Summary_Information$Stock_Size_Unit_1)
  Stock2_Indicator <- as.character(Summary_Information$Stock_Size_Indicator_2)
  Stock2_Unit <- as.character(Summary_Information$Stock_Size_Unit_2)
  Catches_Unit <- as.character(Summary_Information$Catches_Unit)
  Exploitation_Unit <- as.character(Summary_Information$Fishing_Pressure_Type)
  Effort_Unit <- as.character(Summary_Information$Fishing_Effort_Unit)
  Fbar_First_Age <- as.integer(Dimensions$Age[2])
  Fbar_Last_Age <- as.integer(Dimensions$Age[3])
  Fbar_First_Length <- as.numeric(Dimensions$Length[2])
  Fbar_Last_Length <- as.numeric(Dimensions$Length[3])

  Advice_Levels <- as.character(comma2period(Advice_Export$Current.Levels))
  Advice_Refpts <- as.character(comma2period(Advice_Export$Reference.Points))
  Advice_Quant_Status <-
    as.character(comma2period(Advice_Export$Quantitative.Status))
  Advice_Stock_Status <- as.character(Advice_Export$Stock.Status)
  GSA_Names <- as.character(gsa.names(GSA))
  Countries <- as.character(countries)

  Template_Version <- as.character("1.0.0")
  Excel_Filename <- as.character(basename(file))

  ## 4  Assemble list
  Metadata <- as.list(data.frame(
    Assessment_ID, Scientific_Name, GSA,
    Assessment_Type, Reference_Year, Reporting_Year, Validation_Status,
    Year_Benchmarked, Assessment_Method, Expert_Group, Contact_Person,
    Status_Fref, Status_Btarget, Status_Bthreshold, Status_Blimit,
    Status_Text_F, Status_Text_B, Scientific_Advice, WG_Comments,
    VPA_Model, Forecast_Included,
    Fmsy, F0.1, E0.4, Bmsy, Bpa, Blim, Fref_Basis, Fref_Value,
    Current_F, Current_B, B0.33, B0.66,
    Type_Confint, Rec_Unit, Recruitment_Age, Recruitment_Length,
    Stock1_Indicator, Stock1_Unit, Stock2_Indicator, Stock2_Unit, Catches_Unit,
    Exploitation_Unit, Effort_Unit,
    Fbar_First_Age, Fbar_Last_Age, Fbar_First_Length, Fbar_Last_Length,
    Advice_Levels, Advice_Refpts, Advice_Quant_Status, Advice_Stock_Status,
    GSA_Names, Countries, Template_Version, Excel_Filename,
    stringsAsFactors=FALSE))
  class(Metadata) <- c("simple.list", "list")
  TimeSeries <- data.frame(Assessment_ID, Summary_Table, stringsAsFactors=FALSE)

  list(Metadata=Metadata, TimeSeries=TimeSeries)
}
