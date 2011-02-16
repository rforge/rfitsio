\name{getCurrentHDUNum}
\alias{getCurrentHDUNum}
\title{

	Return the index of the current HDU in a FITS file object

}
\description{

	Return the number of the current HDU in the specified FITS
	file object, starting from 1. The total number of HDUs in the
	file can be retrieved using \code{\link{getNumOfHDUs}}.

}
\usage{
	num <- getCurrentHDUNum(fits.obj)
}
\arguments{

	\item{fits.obj}{A FITS object, returned e.g. by
	\code{\link{openFITSFile}}.}

}
\value{

	A integer number representing the index of the current HDU in
	the FITS object.

}
\details{

	To handle an arbitrary number of HDUs in a file, CFITSIO (and
	hence RFITSIO) associated with each FITS object a so-called
	\dQuote{current HDU}. Every operation which runs on a
	specified HDU (e.g. retrieving a keyword or getting a image)
	will run on the current HDU.

	Function \code{getCurrentHDUNum} returns a index (running from
	1 to \code{\link{getNumOfHDUs}}, inclusive) specifying which is
	the current HDU. To change the current HDU you can use
	\code{\link{moveAbsHDU}} or \code{\link{moveRelHDU}}.

}
\seealso{
	\code{\link{getNumOfHDUs}}, \code{\link{moveAbsHDU}}, \code{\link{moveRelHDU}}, \code{\link{getErrorStatus}}.
}
\author{Maurizio Tomasi \email{maurizio.tomasi@unimi.it}}
\examples{
}
