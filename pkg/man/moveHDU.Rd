\name{moveHDU}
\alias{moveAbsHDU}
\alias{moveRelHDU}
\title{

	Change the current HDU for a FITS object.

}
\description{

	This function changes the current HDU used by a number of
	other RFITSIO functions (e.g. \code{\link{getNumOfRows}}). The
	difference between \code{moveAbsHDU} and \code{moveRelHDU} is
	that the former requires an absolute index (starting from 1),
	while the second one requires a positive/negative number
	specifying the number of HDUs to move forward (positive index)
	or backward (negative index).

}
\usage{
	moveAbsHDU(fits.obj, hdu.num)
	moveRelHDU(fits.obj, hdu.rel.num)
}
\arguments{

	\item{fits.obj}{A FITS object, returned e.g. by
	\code{\link{openFITSFile}}.}

	\item{hdu.num}{Absolute index of the new HDU, starting from
	1 and going till the value returned by
	\code{\link{getNumOfHDUs}}.}

	\item{hdu.rel.num}{Relative index of the new HDU with respect to
	the current HDU index. Specifying 0 does nothing.}

}
\seealso{
	\code{\link{getCurrentHDUNum}}, \code{\link{moveAbsHDU}}, \code{\link{moveRelHDU}}, \code{\link{getErrorStatus}}.
}
\author{Maurizio Tomasi \email{maurizio.tomasi@unimi.it}}
