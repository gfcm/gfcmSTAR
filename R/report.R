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
#' \item Removed. Files that were manually removed by the administrator, because
#'       they were duplicate templates, empty templates, etc.
#' }
#'
#' The report also includes a count of files that had errors detected by the
#' \code{qc} suite of quality checks. The QC issues are independent of whether
#' \code{read.template} was able to import or not. The purpose of the QC is to
#' raise a flag where stock assessors may have made a mistake when submitting
#' their STAR templates.
#'
#' In addition to file counts, the report also includes the specific filenames
#' that had errors, were removed, or had QC issues. This list is useful for STAR
#' administrators to bring into focus any STAR templates that were not
#' successfully imported.
#'
#' @section Print Method:
#' When displaying a \code{report} object, error messages from filenames that
#' failed to import are truncated to 23 characters by default. This makes the
#' report easy to read from the console. To show full error messages, pass a
#' large value of \code{nchar} to the \code{print} method:
#'
#' \preformatted{rep <- report(cluster, cluster.ok, qc.vector)
#' print(rep, nchar=999)}
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
  qc.vector <- qc.vector[qc.vector != ""]

  ## Filenames
  f.all <- names(cluster)
  f.imported <- names(cluster.ok)
  f.failed <- f.all[sapply(cluster, class) == "try-error"]
  f.removed <- setdiff(f.all, union(f.imported, f.failed))
  f.qc <- names(qc.vector)

  ## Count
  n.all <- length(f.all)
  n.imported <- length(f.imported)
  n.failed <- length(f.failed)
  n.removed <- length(f.removed)
  n.qc <- length(qc.vector)

  ## Which
  w.failed <- paste(which(f.all %in% f.failed), collapse=", ")
  w.removed <- paste(which(f.all %in% f.removed), collapse=", ")
  w.qc <- paste(which(f.all %in% f.qc), collapse=", ")

  ## Error message
  e.failed <- as.character(cluster[f.failed])
  e.failed <- gsub("\\n$", "", e.failed)

  ## Construct list: Count
  Count <- list()
  Count$Import <- data.frame(
    N=c(n.all, n.imported, n.failed, n.removed),
    Group=c("files", "imported", "failed", "removed"),
    Which=c("", "", w.failed, w.removed), stringsAsFactors=FALSE)
  Count$QC <- data.frame(N=n.qc, Group="issues", Which=w.qc,
                         stringsAsFactors=FALSE)

  ## Construct list: Filenames
  Filenames <- list()
  Filenames$Failed <- data.frame(File=f.failed, Error=e.failed,
                                 row.names=which(f.all %in% f.failed),
                                 stringsAsFactors=FALSE)
  Filenames$Removed <- data.frame(File=f.removed,
                                  row.names=which(f.all %in% f.removed),
                                  stringsAsFactors=FALSE)
  Filenames$QC <- data.frame(File=f.qc, Test=qc.vector,
                             row.names=which(f.all %in% f.qc),
                             stringsAsFactors=FALSE)

  out <- list(Count=Count, Filenames=Filenames)
  class(out) <- "report"
  out
}

#' @rdname gfcmSTAR-internal
#'
#' @export
#' @export print.report

print.report <- function(x, nchar=23, ...)
{
  arrow <- function(d)  # data.frame, put arrow before last column entries
  {
    if(nrow(d) > 0)
    {
      last <- ncol(d)
      d[[last]] <- paste("=>", d[[last]])
    }
    d
  }
  bracket <- function(d)  # data.frame, convert row names to [1] format
  {
    if(nrow(d) > 0)
    {
      row.names(d) <- format(paste0("[", row.names(d), "]"), justify="right")
    }
    d
  }
  empty <- function(d)  # data.frame, replace column names with blank space
  {
    names(d) <- rep("", ncol(d))
    d
  }
  paren <- function(d)  # data.frame, put parentheses around last column entries
  {
    last <- ncol(d)
    d[[last]] <- ifelse(d[[last]] == "", "", paste0("(", d[[last]], ")"))
    d
  }

  ## Shorten error messages
  x$Filenames$Failed$Error <- substring(x$Filenames$Failed$Error, 1, nchar)

  ## Format with arrows, brackets, empty names, and parentheses
  x$Filenames$Failed <- arrow(x$Filenames$Failed)
  x$Filenames$QC <- arrow(x$Filenames$QC)
  x$Filenames$Failed <- bracket(x$Filenames$Failed)
  x$Filenames$Removed <- bracket(x$Filenames$Removed)
  x$Filenames$QC <- bracket(x$Filenames$QC)
  x$Count$Import <- empty(x$Count$Import)
  x$Count$QC <- empty(x$Count$QC)
  x$Filenames$Failed <- empty(x$Filenames$Failed)
  x$Filenames$Removed <- empty(x$Filenames$Removed)
  x$Filenames$QC <- empty(x$Filenames$QC)
  x$Count$Import <- paren(x$Count$Import)
  x$Count$QC <- paren(x$Count$QC)

  ## Replace empty data frame with "None"
  none <- structure(list("None"), class="data.frame", names="", row.names="")
  if(nrow(x$Filenames$Failed) == 0)
    x$Filenames$Failed <- none
  if(nrow(x$Filenames$Removed) == 0)
    x$Filenames$Removed <- none
  if(nrow(x$Filenames$QC) == 0)
    x$Filenames$QC <- none

  ## Print
  cat("*** Count\n\n")
  print(x$Count, right=FALSE, row.names=FALSE)
  cat("\n*** Filenames\n\n")
  print(x$Filenames, right=FALSE)
}
