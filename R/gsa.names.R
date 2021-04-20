#' @rdname gfcmSTAR-internal
#'
#' @export

## Convert comma-separated GSA codes to GSA full names

gsa.names <- function(gsa)
{
  ## 1  Split GSA
  gsa <- gsub(" ", "", gsa)
  gsa <- unlist(strsplit(gsa, ","))

  ## 2  Define GSA codes
  lookup <- data.frame(
    Code=c("1","2","3","4","5","6","7","8","9","10","11.1","11.2","12","13",
           "14","15","16","17","18","19","20","21","22","23","24","25","26",
           "27","28","29","30"),
    Name=c("Northern Alboran Sea","Alboran Island","Southern Alboran Sea",
           "Algeria","Balearic Islands","Northern Spain","Gulf of Lion",
           "Corsica","Ligurian Sea and Northern Tyrrhenian Sea",
           "Southern and Central Tyrrhenian Sea","Western Sardinia",
           "Eastern Sardinia","Northern Tunisia","Gulf of Hammamet",
           "Gulf of Gabes","Malta","Southern Sicily","Northern Adriatic Sea",
           "Southern Adriatic Sea","Western Ionian Sea","Eastern Ionian Sea",
           "Southern Ionian Sea","Aegean Sea","Crete","Northern Levant Sea",
           "Cyprus","Southern Levant Sea","Eastern Levant Sea","Marmara Sea",
           "Black Sea","Azov Sea"), stringsAsFactors=FALSE)

  ## 3  Check user input
  if(any(duplicated(gsa)))
    stop("GSA ", gsa[which(duplicated(gsa))[1]], " is duplicated")
  ok <- gsa %in% lookup$Code
  if(any(!ok))
    stop("GSA ", gsa[which(!ok)[1]], " not defined")

  ## 4  Construct full GSA names
  full <- lookup[match(gsa, lookup$Code),]
  full <- apply(full, 1, paste, collapse=" - ")
  full <- paste(full, collapse=", ")

  full
}
