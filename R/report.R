#' Report Files Successfully Imported
#'
#' Show a summary report after importing and quality checking a directory of
#' STAR templates.
#'
#' @param cluster a list of STAR objects, including ones that resulted in import
#'        \code{"try-error"}.
#' @param cluster.ok a list of STAR objects that have been selected and prepared
#'        for final import into the STAR database.
#' @param qc.vector a logical vector, output from \code{qc}.
#'
#' @return Nested list with top elements \code{Count} and \code{Filenames}.
#'
#' @note
#' The full set of Excel templates included in the report consists of all the
#' STAR objects in \code{cluster}. They can be divided into three categories:
#' \itemize{
#' \item Imported. The STAR objects found in \code{cluster.ok}.
#' \item Failed. Files that \code{read.template} could not import.
#' \item Removed. Files that were manually removed by administrator, because
#'       they were duplicate templates, empty templates, etc.
#' }
#'
#' The report also includes a count of files that had errors detected by the
#' \code{qc} suite of quality checks. The QC errors are independent of whether
#' \code{read.template} was able to import or not. The purpose of the QC is to
#' raise a flag where stock assessors may have made a mistake when submitting
#' their STAR templates.
#'
#' In addition to file counts, the report also includes the specific filenames
#' that had errors, were removed, or had QC issues. This list is useful for STAR
#' administrators to bring into focus any STAR templates that were not
#' successfully imported.
#'
#' @seealso
#' \code{\link{import.many.templates}} imports many Excel STAR templates from a
#' directory into a cluster (list).
#'
#' \code{\link{qc}} runs all QC tests on an Excel STAR template or a directory
#' containing Excel STAR templates.
#'
#' \code{\link{gfcmSTAR-package}} gives an overview of the package.
#'
#' @examples
#' \dontrun{
#'
#' # Directory names
#' uploads <- "~/StockAssessmentResults/uploads/2021"
#' star.dir <- file.path(uploads, "WGSASP_General")
#' prop.file <- file.path(uploads, "properties/WGSASP_General.xlsx")
#'
#' # Import
#' prop <- read.properties(prop.file)
#' cluster <- import.many.templates(star.dir, prop=prop)
#'
#' # Select valid STAR objects to import into STAR database
#' cluster.ok <- cluster[sapply(cluster, class) != "try-error"]
#' cluster.ok$"star_template.xlsx" <- NULL
#'
#' # Quality check
#' qc.vector <- qc(star.dir)
#'
#' # Report
#' report(cluster, cluster.ok, qc.vector)
#' }
#'
#' @export

report <- function(cluster, cluster.ok, qc.vector)
{
  n.files <- length(cluster)
  n.imported <- length(cluster.ok)
  n.failed <- sum(sapply(cluster, class) == "try-error")
  n.removed <- n.files - n.imported - n.failed
  n.qc <- sum(!qc.vector)
  Count <- list(Import=data.frame(
                  N=c(n.files, n.imported, n.failed, n.removed),
                  Group=c("files", "imported", "failed", "removed"),
                  stringsAsFactors=FALSE),
                QC=data.frame(N=n.qc, Group="Errors detected by QC",
                              stringsAsFactors=FALSE))

  fname.error <- names(cluster)[sapply(cluster, class) == "try-error"]
  fname.removed <- setdiff(names(cluster),
                           union(names(cluster.ok), fname.error))
  fname.qc <- names(qc.vector)[!qc.vector]
  Filenames <- list(Error=data.frame(" "=fname.error, check.names=FALSE,
                                     stringsAsFactors=FALSE),
                    Removed=data.frame(" "=fname.removed, check.names=FALSE,
                                       stringsAsFactors=FALSE),
                    QC=data.frame(" "=fname.qc, check.names=FALSE,
                                  stringsAsFactors=FALSE))

  out <- list(Count=Count, Filenames=Filenames)
  class(out) <- "report"
  out
}

#' @rdname gfcmSTAR-internal
#'
#' @export
#' @export print.report

print.report <- function(x, ...)
{
  cat("*** Count\n\n")
  print(x$Count, right=FALSE, row.names=FALSE)
  cat("\n*** Filenames\n\n")
  print(x$Filenames, right=FALSE, row.names=FALSE)
}
