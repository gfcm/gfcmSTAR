#' @rdname gfcmSTAR-internal
#'
#' @export

## Ensure text file has DOS line endings

u2d <- function(file)
{
  txt <- readLines(file)
  con <- file(file, open="wb")
  writeLines(txt, con, sep="\r\n")
  close(con)
}
