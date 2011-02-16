\name{getNumOfHDUs}
\alias{getNumOfHDUs}
\title{

	Return the number of HDUs in a FITS file

}
\description{

	Return the number of HDUs contained in a FITS file (integer
	value).

}
\usage{
	num <- getNumOfHDUs(fits.obj)
}
\arguments{

	\item{fits.obj}{A FITS object, returned e.g. by
	\code{\link{openFITSFile}}.}

}
\value{

	A integer number representing the number of HDUs in the FITS
	object.

}
\seealso{
	\code{\link{getCurrentHDUNum}}, \code{\link{moveAbsHDU}}, \code{\link{moveRelHDU}}, \code{\link{getErrorStatus}}.
}
\author{Maurizio Tomasi \email{maurizio.tomasi@unimi.it}}
\examples{
}
