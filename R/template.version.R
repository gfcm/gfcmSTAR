#' Template Version
#'
#' Detect STAR template version of an Excel file.
#'
#' @param file Excel STAR template, with the version number specified on the
#'        first sheet.
#'
#' @return String containing version number.
#'
#' @seealso
#' \code{\link{read.template}} reads an Excel template into a STAR object.
#'
#' \code{\link{gfcmSTAR-package}} gives an overview of the package.
#'
#' @examples
#' \dontrun{
#' template.version("STAR_2019_HKE_5.xlsx")
#' }
#'
#' @importFrom XLConnect getTables loadWorkbook readTable readWorksheet
#'
#' @export

template.version <- function(file)
{
  w <- loadWorkbook(file)
  if("Version" %in% getTables(w, 1))
    readTable(w, 1, "Version", simplify=TRUE)
  else if(identical(readWorksheet(w,1,header=FALSE)[1,3], "2021-01-15")) # NA ok
    "1.0.0"
  else
    stop("STAR template version not found in ", basename(file))
}
