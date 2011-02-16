\name{getNumOfRows}
\alias{getNumOfRows}
\title{

	Return the number of rows in the current HDU of a FITS file

}
\description{

	Return the number of rows contained in a FITS file (integer
	value). This value is taken from the \code{NAXIS2} keyword in
	the header of the HDU.

	To change the current HDU, use either \code{\link{moveAbsHDU}}
	or \code{\link{moveRelHDU}}.

}
\usage{
	num <- getNumOfRows(fits.obj)
}
\arguments{

	\item{fits.obj}{A FITS object, returned e.g. by
	\code{\link{openFITSFile}}.}

}
\value{

	A integer number representing the number of rows in the
	current HDU of the FITS object.

}
\seealso{
	\code{\link{getCurrentHDUNum}}, \code{\link{moveAbsHDU}}, \code{\link{moveRelHDU}}, \code{\link{getErrorStatus}}.
}
\author{Maurizio Tomasi \email{maurizio.tomasi@unimi.it}}
\examples{
}
