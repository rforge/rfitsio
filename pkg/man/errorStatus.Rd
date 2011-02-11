\name{errorStatus}
\alias{getErrorStatus}
\alias{getErrorText}
\alias{resetErrorStatus}
\title{Get/set the error status of a FITS object}
\description{Determine if an error occurred while working with a FITS file and optionally reset the error flag.}
\usage{
	flag <- getErrorStatus(fits.obj, reset = FALSE)
	msg <- getErrorText(fits.obj, reset = FALSE)
	resetErrorStatus(fits.obj)
}
\arguments{
	\item{fits.obj}{A FITS object.}
	\item{reset}{If \code{TRUE}, the error status will be reset to zero (no errors) after the call to the function.}
}
\value{

	\code{getErrorStatus} returns an integer indicating if an
	error happened while working with \code{fits.obj} (zero means
	that no errors occurred). \code{getErrorText} returns a string
	describing the error status. \code{resetErrorStatus} clears
	the error flag associated with \code{fits.obj}, so that any
	subsequent call to \code{getErrorStatus} will return zero.

}
\details{

	The RFITSIO library uses the same logic used by CFITSIO to
	handle errors. Every time some error occurs, a flag in the
	FITS object is set to the error code. Any subsequent use of
	this object in a RFITSIO function will halt the function
	immediately. This has the advantage of not requiring the
	programmer to check for errors every time a RFITSIO function
	is called: it is enough to do the check once at the end of the
	processing of the FITS file.

	A error status is identified by an integer: each FITS object
	(returned either by \code{\link{openFITSFile}},
	\code{\link{openFITSData}}, \code{\link{openFITSImage}},
	\code{\link{openFITSTable}} or \code{\link{createFITSFile}})
	has its own integer flag. The function described in this page
	allow to access and modify the flag. (Note that the only way
	the programmer can modify the flag is to set it to zero using
	either the \code{reset} parameter or the
	\code{resetErrorStatus} function.)

}
\author{Maurizio Tomasi <maurizio.tomasi@unimi.it>}
\examples{
# Try to open a file which does not exist
fits.obj <- openFITSFile("error-this-does-not-exist.fits")

# Get the value of the status and print the error message
cat(getErrorStatus(fits.obj))
cat(getErrorText(fits.obj))

# Clear the error status
resetErrorStatus(fits.obj)

# Now the error status is set back to zero
cat(getErrorStatus(fits.obj))
cat(getErrorText(fits.obj))
rm(fits.obj)
}
