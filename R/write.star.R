#' @rdname gfcmSTAR-internal
#'
#' @importFrom utils write.csv
#'
#' @export

## Write

write.star <- function(star, file="", ...)
{
  metadata <- data.frame(Field=names(star$Metadata),
                         Value=unlist(star$Metadata), row.names=NULL)
  write.csv(metadata, file=file, ...)
}
