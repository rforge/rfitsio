\name{readRecordCard}
\alias{readRecord}
\alias{readCard}
\title{

	Retrieve the value of a card in the current HDU of a FITS file
	object.

}
\description{

	Both functions return a 80-byte string containing the full
	card defining a keyword in the current HDU of the FITS file
	(i.e. the string contains the name of the card, the equal
	sign, the value and any optional comment).

	The two functions only differ in the way the programmer
	specifies the card to be read: \code{readRecord} requires an
	ordinal index (starting from 1), while \code{readCard}
	requires the full name of the keyword.

	These functions are seldom used: to read the value of a
	keyword it is normally better to stick to
	\code{\link{readKeyValue}}, which extracts the value of the
	keyword and converts it into a suitable data type.

}
\usage{
	record <- readRecord(fits.obj, key.number)
	record <- readCard(fits.obj, key.name)
}
\arguments{

	\item{fits.obj}{A FITS object, returned e.g. by
	\code{\link{openFITSFile}}.}
	\item{key.number}{Index of the card to be read (starting from 1 and going till \code{\link{getNumOfKeys}}).}
	\item{key.name}{String containing the name of the card to be read (e.g. \code{"NAXIS2"}).}

}
\value{

	A 80-byte string containing the full card.

}
\seealso{
	\code{\link{readKeyValue}}, \code{\link{readKeyComment}}, \code{\link{getNumOfKeys}}, \code{\link{moveAbsHDU}}, \code{\link{moveRelHDU}}, \code{\link{getErrorStatus}}.
}
\author{Maurizio Tomasi \email{maurizio.tomasi@unimi.it}}
\examples{
file.name <- system.file("fits_files", "tables.fits", package = "rfitsio")
fits.obj <- openFITSFile(file.name)
readRecord(fits.obj, 2)          # Read the second card (this is "BITPIX")
readCard(fits.obj, "BITPIX")     # Same as above, but use the full name
closeFITSFile(fits.obj)
}
