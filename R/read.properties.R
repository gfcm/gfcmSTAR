#' Read Properties
#'
#' Read SharePoint properties from an Excel file.
#'
#' @param file Excel file containing the SharePoint properties.
#' @param template optional filename of an Excel STAR template.
#' @param quiet whether to supress messages.
#'
#' @return Data frame with SharePoint properties.
#'
#' @note
#' To download Excel SharePoint properties:
#' \enumerate{
#' \item Starting in Teams, navigate to STAR folder.
#' \item Select \sQuote{Open in SharePoint}.
#' \item In SharePoint, select \sQuote{Export to Excel}.
#' \item Save file with a descriptive filename, such as
#'       \file{WGSAD_Western_Mediterranean.xlsx}.
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
#' read.properties("WGSAD_Western_Mediterranean.xlsx")
#'
#' read.properties("WGSAD_Western_Mediterranean.xlsx", "STAR_2019_HKE_5.xlsx")
#' }
#'
#' @importFrom XLConnect getTables loadWorkbook readTable
#'
#' @export

read.properties <- function(file, template=NULL, quiet=TRUE)
{
  ## 1  Load workbook
  if(!quiet)
    message("Reading properties '", file, "'")
  w <- loadWorkbook(file)

  ## 2  Read table
  props <- readTable(w, 1, getTables(w, 1))

  ## 3  Extract row(s) of interest
  if(!is.null(template))
    props <- props[props$Name == template,]

  props
}
