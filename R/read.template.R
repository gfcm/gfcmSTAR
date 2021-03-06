#' Read STAR Template
#'
#' Read the results found in an Excel STAR template into a STAR object.
#'
#' @param file name of Excel file.
#' @param prop SharePoint properties from \code{read.properties}.
#' @param suffix optional string passed to \code{combo} to construct a unique
#'        \code{Assessment_ID} field.
#' @param quiet whether to supress messages.
#' @param \dots passed to version-specific functions, such as
#'        \code{read.template.v21}.
#'
#' @details
#' \code{prop} is required to provide metadata values for
#' \code{SharePoint_Folder}, \code{Person_Modified}, and \code{Time_Modified}.
#' If \code{prop} is not supplied, these metadata values will be \code{NA}.
#'
#' \code{suffix} is required when there are stock assessments that have the same
#' Reference Year, Species, and GSA. It is used to distinguish each assessment
#' by appending the suffix with an underscore separator to create a unique
#' \code{Assessment_ID} metadata field for the STAR object. See examples below.
#'
#' @return
#' STAR object, a list containing \code{Metadata} (simple list) and
#' \code{TimeSeries} (data frame).
#'
#' @note
#' The user can either use the general \code{read.template} function or
#' version-specific functions, such as read.template.v21, to the same effect.
#'
#' The Excel STAR templates have a version number that consists of three
#' numbers: \emph{major.minor.patch}. The \dfn{major} version is incremented
#' when the STAR database design needs to be changed, the \dfn{minor} version
#' when the R import function needs to be changed, and the \dfn{patch} version
#' when changes are backwards compatible.
#'
#' @seealso
#' \code{\link{import.many.templates}} imports many Excel STAR templates from a
#' directory into a cluster (list).
#'
#' \code{\link{read.template.v10}} reads an Excel STAR template of version 1.0
#' into a STAR object.
#'
#' \code{\link{read.template.v21}} reads an Excel STAR template of version 2.1
#' into a STAR object.
#'
#' \code{\link{read.star.csv}} reads a pair of STAR CSV files into a STAR
#' object.
#'
#' \code{\link{read.properties}} reads SharePoint properties from an Excel file.
#'
#' \code{\link{combo}} is used to construct the \code{Assessment_ID} metadata
#' field.
#'
#' \code{\link{template.version}} detects the STAR template version of an Excel
#' file.
#'
#' \code{\link{write.star.csv}} writes a STAR object to CSV files.
#'
#' \code{\link{gfcmSTAR-package}} gives an overview of the package.
#'
#' @examples
#' \dontrun{
#' star <- read.template("STAR_2019_HKE_5.xlsx")
#'
#' # Passing a suffix
#' read.template("STAR_2019_HKE_5.xlsx")$Metadata$Assessment_ID
#' read.template("STAR_2019_HKE_5.xlsx", suffix="a4a")$Metadata$Assessment_ID
#' read.template("STAR_2019_HKE_5.xlsx", suffix="sam")$Metadata$Assessment_ID
#' read.template("STAR_2019_HKE_5.xlsx", suffix="something_special")
#' }
#'
#' @export

read.template <- function(file, prop=NULL, suffix="", quiet=TRUE, ...)
{
  switch(template.version(file),
         "1.0.0"=
           read.template.v10(file, prop=prop, suffix=suffix, quiet=quiet, ...),
         "2.1.0"=
           read.template.v21(file, prop=prop, suffix=suffix, quiet=quiet, ...))
}
