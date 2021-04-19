#' Read STAR Template Version 1.0
#'
#' Import the results found in an Excel STAR template version 1.0.
#'
#' @param file name of Excel file.
#'
#' @return
#' List containing \code{Metadata} (list) and \code{TimeSeries} (data frame).
#'
#' @seealso
#' \code{\link[XLConnect]{loadWorkbook}}, \code{\link[XLConnect]{readTable}},
#' and \code{\link[XLConnect]{readWorksheet}} are the underlying functions to
#' read data from Excel workbooks.
#'
#' \code{\link{gfcmSTAR-package}} gives an overview of the package.
#'
#' @examples
#' \dontrun{
#' star <- read.star.v10("STAR_2019_HKE_5.xlsx")
#' }
#'
#' @importFrom XLConnect loadWorkbook readWorksheet readTable setMissingValue
#'
#' @export

read.star.v10 <- function(file)
{
  w <- loadWorkbook(file)
  setMissingValue(w, "NA")
  Dimensions <- readTable(w, "Metadata", "Dimensions")
  From_TimeSeries <-
    readWorksheet(w, "Metadata", region="J20:J21",
                  header=FALSE, useCachedValues=TRUE, simplify=TRUE)
  w
}
