#' Read STAR Template
#'
#' Read the results found in an Excel STAR template into a STAR object.
#'
#' @param file name of Excel file.
#' @param \dots passed to version-specific functions, such as
#'        \code{read.template.v10}.
#'
#' @return
#' STAR object, a list containing \code{Metadata} (simple list) and
#' \code{TimeSeries} (data frame).
#'
#' @note
#' The user can either use the general \code{read.template} function or
#' version-specific functions, such as read.template.v10, to the same effect.
#'
#' The Excel STAR templates have a version number that consists of three
#' numbers: \emph{major.minor.patch}. The \dfn{major} version is incremented
#' when the STAR database design needs to be changed, the \dfn{minor} version
#' when the R import function needs to be changed, and the \dfn{patch} version
#' when changes are backwards compatible.
#'
#' Detailed documentation of the functionality of \code{read.template} is found
#' in the version-specific help pages, listed below.
#'
#' @seealso
#' \code{\link{import.many.templates}} imports many Excel STAR templates from a
#' directory into a cluster (list).
#'
#' \code{\link{read.template.v10}} reads an Excel STAR template of version 1.0
#' into a STAR object.
#'
#' \code{\link{write.star}} writes a STAR object to CSV files.
#'
#' \code{\link{gfcmSTAR-package}} gives an overview of the package.
#'
#' @examples
#' \dontrun{
#' star <- read.template("STAR_2019_HKE_5.xlsx")
#' }
#'
#' @export

read.template <- function(file, ...)
{
  switch(template.version(file),
         "1.0.0"=read.template.v10(file, ...))
}
