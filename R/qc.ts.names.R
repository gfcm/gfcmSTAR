#' Time Series Names
#'
#' Assert that a STAR template's time series column names are intact.
#'
#' @param file filename of an Excel STAR template.
#' @param short whether to show the filename in a short \code{\link{basename}}
#'        format.
#' @param stop whether to stop if test fails.
#' @param quiet whether to suppress messages.
#'
#' @return
#' \code{TRUE} if test succeeds, otherwise an error message
#' (if \code{stop = TRUE}) or \code{FALSE} and a warning message
#' (if \code{stop = FALSE}).
#'
#' @note
#' This function compares the column names found in the STAR template sheet
#' containing the time series against the expected column names. The expected
#' column names are those defined inside the \code{\link{set.classes}} function.
#'
#' @seealso
#' \code{\link{qc}} runs all \code{qc.*} tests.
#'
#' \code{\link{gfcmSTAR-package}} gives an overview of the package.
#'
#' @examples
#' \dontrun{
#' qc.ts.names("STAR_2019_HKE_5.xlsx")
#' }
#'
#' @importFrom XLConnect readTable
#'
#' @export

qc.ts.names <- function(file, short=TRUE, stop=TRUE, quiet=FALSE)
{
  ## 1  Preamble
  filename <- if(short) basename(file) else file
  if(!quiet)
    message("* checking '", filename, "' with qc.ts.names ... ", appendLF=FALSE)

  ## 2  Test
  w <- loadWorkbook(file)
  x <- readWorksheet(w, 3)
  row <- which(x[,1] == "Year")
  colnames <- as.character(x[row,])
  colnames <- colnames[!grepl("Effort", colnames)]

  expected <- deparse(set.classes)
  expected <- grep("TimeSeries\\$", expected, value=TRUE)
  expected <- gsub(".*\\$(.*?)\\).*", "\\1", expected)
  expected <- expected[-1]  # remove Assessment_ID

  ok <- tolower(colnames) %in% tolower(expected)
  success <- identical(tolower(colnames), tolower(expected))

  ## 3  Show result
  if(!success)
  {
    if(!quiet) message("ERROR")
    msg <- paste("column names are wrong -", colnames[!ok][1])
    if(stop) stop(msg) else warning(msg)
  }
  else if(!quiet)
    message("OK")
  success
}
