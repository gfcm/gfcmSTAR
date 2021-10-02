#' Time Series Numbers
#'
#' Assert that a STAR template's time series are numbers and not strings.
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
#' Stock assessors sometimes enter values into STAR templates as strings instead
#' of numbers. This is usually because of regional settings on different
#' computers.
#'
#' @seealso
#' \code{\link{qc}} runs all \code{qc.*} tests.
#'
#' \code{\link{gfcmSTAR-package}} gives an overview of the package.
#'
#' @examples
#' \dontrun{
#' qc.numbers("STAR_2019_HKE_5.xlsx")
#' }
#'
#' @importFrom XLConnect readTable
#' @importFrom utils type.convert
#'
#' @export

qc.numbers <- function(file, short=TRUE, stop=TRUE, quiet=FALSE)
{
  ## 1  Preamble
  filename <- if(short) basename(file) else file
  if(!quiet)
    message("* checking '", filename, "' with qc.numbers ... ", appendLF=FALSE)

  ## 2  Test
  w <- loadWorkbook(file)
  x <- readWorksheet(w, 3)
  row <- which(x[,1] == "Year")
  y <- if(nrow(x)==row) x[NULL,] else x[(row+1):nrow(x),]
  names(y) <- x[row,]
  for(i in seq_along(y))  # handwritten loop, to support R versions < 3.5
    y[[i]] <- type.convert(y[[i]], as.is=TRUE)
  cols <- sapply(y, class)
  success <- !any(cols == "character")

  ## 3  Show result
  if(!success)
  {
    if(!quiet) message("ERROR")
    cnames <- paste(names(cols[cols=="character"]), collapse="; ")
    msg <- paste("string values found in time series:", cnames)
    if(stop) stop(msg) else warning(msg)
  }
  else if(!quiet)
    message("OK")
  success
}
