\name{is.fits.obj}
\alias{is.fits.obj}
\title{
	Test for objects of type \code{"cfitsio_obj"}.
}
\description{

	Check if a variable contains a valid FITS file object. Such
	objects can be created by one of the following functions:
	\code{\link{createFITSFile}}, \code{\link{openFITSFile}},
	\code{\link{openFITSData}}, \code{\link{openFITSImage}},
	\code{\link{openFITSTable}}.

}
\usage{
	result <- is.fits.obj(var)
}
\value{
	The function returns \code{TRUE} or \code{FALSE} depending on
	whether its argument is a FITS file object or not.
}
