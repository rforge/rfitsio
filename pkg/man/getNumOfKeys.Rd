\name{getNumOfKeys}
\alias{getNumOfKeys}
\alias{getAvailableKeySlots}
\title{

	Return the number of keys currently defined or available in
	the HDUs of a FITS file.

}
\description{

	Function \code{getNumOfKeys} returns the number of keys
	currently defined in the current HDU of the FITS file.
	Function \code{getAvailableKeySlots} returns the number of new
	keys that can be created in the HDU before filling it
	completely.

}
\usage{
	keys <- getNumOfKeys(fits.obj)
	avail.keys <- getAvailableKeySlots(fits.obj)
}
\arguments{

	\item{fits.obj}{A FITS object, returned e.g. by
	\code{\link{openFITSFile}}.}

}
\seealso{
	\code{\link{moveAbsHDU}}, \code{\link{moveRelHDU}}, \code{\link{getErrorStatus}}.
}
\author{Maurizio Tomasi \email{maurizio.tomasi@unimi.it}}
\examples{
file.name <- system.file("fits_files", "tables.fits", package = "rfitsio")
fits.obj <- openFITSFile(file.name)
getNumOfKeys(fits.obj)
getAvailableKeySlots(fits.obj)
}
