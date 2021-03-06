#' @docType package
#'
#' @name gfcmSTAR-package
#'
#' @aliases gfcmSTAR
#'
#' @title Tools to Work with GFCM Stock Assessment Results (STAR)
#'
#' @description
#' Tools that support the Stock Assessment Results (STAR) framework of the
#' General Fisheries Commission for the Mediterranean.
#'
#' @details
#' \emph{Import:}
#' \tabular{ll}{
#'   \code{\link{import.many.templates}} \tab import many templates\cr
#'   \code{\link{import.many.csv}}       \tab import many CSV files\cr
#'   \code{\link{read.star.csv}}         \tab read a pair of CSV files\cr
#'   \code{\link{read.template}}         \tab read STAR template\cr
#'   \code{\link{read.template.v10}}     \tab read STAR template version 1.0\cr
#'   \code{\link{read.template.v21}}     \tab read STAR template version 2.1\cr
#'   \code{\link{read.properties}}       \tab read SharePoint properties\cr
#'   \code{\link{set.classes}}           \tab convert data types\cr
#'   \code{\link{template.version}}      \tab detect STAR template version
#' }
#' \emph{Export:}
#' \tabular{ll}{
#'   \code{\link{export.many.csv}} \tab export many STAR objects to CSV files\cr
#'   \code{\link{write.star.csv}}  \tab write STAR object to CSV files
#' }
#' \emph{Manipulate strings:}
#' \tabular{ll}{
#'   \code{\link{append.id}} \tab modify existing \code{Assessment_ID}\cr
#'   \code{\link{combo}}     \tab combine reference year, species, and GSA\cr
#'   \code{\link{gsa.names}} \tab convert GSA codes to full GSA names
#' }
#' \emph{Lookup tables:}
#' \tabular{ll}{
#'   \code{\link{lookup.gsa}}     \tab geographical subareas (GSA)\cr
#'   \code{\link{lookup.species}} \tab species
#' }
#' \emph{Quality control:}
#' \tabular{ll}{
#'   \code{\link{diff.stars}}      \tab show differences between STAR objects\cr
#'   \code{\link{identical.stars}} \tab check if STAR objects are identical\cr
#'   \code{\link{peek}}            \tab examine a metadata field\cr
#'   \code{\link{qc}}              \tab run all quality checks\cr
#'   \code{\link{qc.exists}}       \tab file exists\cr
#'   \code{\link{qc.xlsx}}         \tab file extension is \file{xlsx}\cr
#'   \code{\link{qc.star}}         \tab file is a STAR template\cr
#'   \code{\link{qc.vpa}}    \tab \code{VPA_Model} is \code{Yes} or \code{No}\cr
#'   \code{\link{qc.ts.names}}     \tab time series column names are intact\cr
#'   \code{\link{qc.ts.numbers}} \tab time series are numbers and not strings\cr
#'   \code{\link{report}}          \tab report files successfully imported\cr
#'   \code{\link{write.report}}    \tab write a report object to a text file
#' }
#'
#' @note
#' STAR objects store \code{Metadata} as class \code{c("simple.list", "list")}
#' in order to have it display in a compact and readable format in the console.
#' It is easy to convert to a normal list or data frame:
#'
#' \preformatted{
#' star$Metadata                 # simple.list (default)
#' unclass(star$Metadata)        # list
#' as.data.frame(star$Metadata)  # data.frame
#' }
#'
#' The main drawback of the \code{simple.list} format is that date-time objects
#' are shown as integers in the console. This is only a minor display issue -
#' the date-time objects are stored as \code{POSIXct} objects and are easy to
#' access:
#'
#' \preformatted{
#' star$Metadata$Time_Modified
#' star$Metadata$Time_Imported
#' }
#'
#' @section Script:
#' A fully annotated script to import and export a large collection of STARs is
#' found here:
#'
#' \href{https://github.com/gfcm/gfcmSTAR/blob/master/inst/scripts/import.R}{import.R}
#'
#' It demonstrates administrative procedures to quality check and handle STAR
#' templates that may contain errors. This script can also be found on the local
#' hard drive:
#'
#' \preformatted{system.file("scripts/import.R", package="gfcmSTAR")}
#'
#' @author Arni Magnusson.
#'
#' @references
#' \url{https://github.com/gfcm/star}
#'
#' \url{https://github.com/gfcm/gfcmSTAR}
#'
#' @seealso
#' The \pkg{gfcmSTAR} package uses \pkg{XLConnect} to read STAR templates, as it
#' supports Excel table objects.

NA
