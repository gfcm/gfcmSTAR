#' Read Properties
#'
#' Read SharePoint properties from an Excel file.
#'
#' @param file Excel file containing the SharePoint properties.
#' @param template optional filename of an Excel STAR template.
#'
#' @return Data frame with SharePoint properties.
#'
#' @note
#' To download Excel SharePoint properties:
#' \enumerate{
#'   \item Starting in Teams, navigate to STAR folder.
#'   \item Select \sQuote{Open in SharePoint}.
#'   \item In SharePoint, select \sQuote{Export to Excel}.
#'   \item Save file with a descriptive filename, such as
#'         \file{properties_WGSAD_Western Mediterranean.xlsx}.
#' }
#'
#' @seealso
#' \code{\link[XLConnect]{loadWorkbook}} and \code{\link[XLConnect]{readTable}}
#' are the underlying functions used to read SharePoint properties from an Excel
#' file.
#'
#' \code{\link{read.template.v10}} reads an Excel template into a STAR object.
#'
#' \code{\link{gfcmSTAR-package}} gives an overview of the package.
#'
#' @examples
#' \dontrun{
#'
#' read.properties("properties_WGSAD_Western Mediterranean.xlsx")
#'
#' read.properties("properties_WGSAD_Western Mediterranean.xlsx",
#'                 template="STAR_2019_HKE_5.xlsx")
#' }
#'
#' @importFrom XLConnect getTables loadWorkbook readTable
#'
#' @export


read.properties <- function(file, template=NULL)
{
  ## 1  Load workbook
  w <- loadWorkbook(file)

  ## 2  Read table
  props <- readTable(w, 1, getTables(w, 1))

  ## 3  Extract row(s) of interest
  if(!is.null(template))
    props <- props[props$Name == template,]

  props
}
