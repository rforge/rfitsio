\name{getNumOfColumns}
\alias{getNumOfColumns}
\title{

	Return the number of columns in the current HDU of a FITS file

}
\description{

	Return the number of columns contained in a FITS file (integer
	value). This value is taken from the \code{NAXIS1} keyword in
	the header of the HDU.

	To change the current HDU, use either \code{\link{moveAbsHDU}}
	or \code{\link{moveRelHDU}}.

}
\usage{
	num <- getNumOfColumns(fits.obj)
}
\arguments{

	\item{fits.obj}{A FITS object, returned e.g. by
	\code{\link{openFITSFile}}.}

}
\value{

	A integer number representing the number of columns in the
	current HDU of the FITS object.

}
\seealso{
	\code{\link{getCurrentHDUNum}}, \code{\link{getNumOfRows}}, \code{\link{getColumnNumber}}, \code{link{getColumnInformation}}, \code{\link{moveAbsHDU}}, \code{\link{moveRelHDU}}, \code{\link{getErrorStatus}}.
}
\author{Maurizio Tomasi \email{maurizio.tomasi@unimi.it}}
\examples{
}
