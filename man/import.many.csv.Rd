% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/import.many.csv.R
\name{import.many.csv}
\alias{import.many.csv}
\title{Import Many CSV Files}
\usage{
import.many.csv(dir)
}
\arguments{
\item{dir}{directory name.}
}
\value{
A cluster (list) of STAR objects.
}
\description{
Import many STAR CSV files from a directory tree into a cluster (list) of
STAR objects.
}
\note{
The top directory can have any name, but the directory tree must have the
following structure: \preformatted{
dirname/
    STAR_2019_HKE_4/
        metadata.csv
        timeseries.csv
    STAR_2019_HKE_5/
        metadata.csv
        timeseries.csv}
}
\examples{
\dontrun{
cluster <- import.many.csv("csv")
}

}
\seealso{
\code{\link{read.star.csv}} reads a pair of STAR CSV files into a STAR
object.

\code{\link{write.star.csv}} writes a STAR object to CSV files.

\code{\link{import.many.templates}} imports many Excel STAR templates from a
directory into a cluster (list).

\code{\link{export.many.csv}} exports a cluster (list) of STAR objects to CSV
files.

\code{\link{gfcmSTAR-package}} gives an overview of the package.
}
