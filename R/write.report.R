#' Write Report
#'
#' Write a report object to a text file.
#'
#' @param rep a \code{\link{report}} object.
#' @param file a filename to write to.
#' @param nchar maximum number of characters in error messages.
#'
#' @details
#' When displaying a \code{report} object, error messages from filenames that
#' failed to import are truncated to 23 characters by default. This makes the
#' report easy to read from the console or a text file. To show full error
#' messages, pass a large value, such as \code{nchar = 999}.
#'
#' @seealso
#' \code{\link{report}} reports which files were successfully imported.
#'
#' \code{\link{writeLines}} is the underlying function used to write the file.
#'
#' \code{\link{gfcmSTAR-package}} gives an overview of the package.
#'
#' @examples
#' \dontrun{
#' rep <- report(cluster, cluster.ok, qc.vector)
#' write.report(rep, "report.txt")
#' }
#'
#' @importFrom utils capture.output
#'
#' @export

write.report <- function(rep, file, nchar=23)
{
  txt <- capture.output(print(rep, nchar=nchar))
  writeLines(txt, file)
}
