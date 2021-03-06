% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/set.classes.R
\name{set.classes}
\alias{set.classes}
\title{Set Classes}
\usage{
set.classes(star)
}
\arguments{
\item{star}{STAR object, a list containing \code{Metadata} and
\code{TimeSeries}.}
}
\value{
STAR object with correct data types.
}
\description{
Convert \code{Metadata} fields and \code{TimeSeries} columns in a STAR object
to match the data types in the STAR database.
}
\examples{
\dontrun{
star <- set.classes(star)
}

}
\seealso{
\code{\link{read.template}} uses \code{set.classes} to convert data types.

\code{\link{gfcmSTAR-package}} gives an overview of the package.
}
