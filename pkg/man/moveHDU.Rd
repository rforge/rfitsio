\name{moveHDU}
\alias{moveAbsHDU}
\alias{moveRelHDU}
\alias{moveNamedHDU}
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
	moveNamedHDU(fits.obj, hdu.type, ext.name, ext.ver = 0)
}
\arguments{

	\item{fits.obj}{A FITS object, returned e.g. by
	\code{\link{openFITSFile}}.}

	\item{hdu.num}{Absolute index of the new HDU, starting from
	1 and going till the value returned by
	\code{\link{getNumOfHDUs}}.}

	\item{hdu.rel.num}{Relative index of the new HDU with respect to
	the current HDU index. Specifying 0 does nothing.}

	\item{hdu.type}{String identifying the HDU type. Valid values
	are \code{"ASCII_TBL"}, \code{"BINARY_TBL"} and
	\code{"IMAGE_HDU"}.}

	\item{ext.name}{String identifying the name of the extension
	(see parameter \code{ext.name} in the documentation of
	\code{\link{createTable}}). This is compared with the value of
	the \code{EXTNAME}/\code{HDUNAME} keyword in each HDU to find
	the match.}

	\item{ext.ver}{Value of the \code{EXTVER}/\code{HDUVER}
	keyword for the match. If zero (the default), it is ignored.}

}
\seealso{
	\code{\link{getCurrentHDUNum}}, \code{\link{moveAbsHDU}}, \code{\link{moveRelHDU}}, \code{\link{getErrorStatus}}.
}
\author{Maurizio Tomasi \email{maurizio.tomasi@unimi.it}}
