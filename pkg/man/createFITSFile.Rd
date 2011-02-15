\name{createFITSFile}
\alias{createFITSFile}
\title{Create a FITS file}
\description{Create an empty FITS file.}
\usage{fits.obj <- createFITSFile(file.name)}
\arguments{
	\item{file.name}{A string containing the name of the file to create.}
}
\value{
	A FITS file object of class \code{cfitsio_obj} (an opaque type).
}
\details{

	If the file already exists an error is returned (use
	\code{\link{getErrorStatus}} and its companion functions to
	determine if this event occurred), unless the name of the file
	begins with \code{!}: in the latter case, the exclamation mark
	is removed and the file is overwritten when necessary.

}
\seealso{
	\code{\link{openFITS}}, \code{\link{closeFITSFile}}, \code{\link{getErrorStatus}}.
}
\author{Maurizio Tomasi <maurizio.tomasi@unimi.it>}
\examples{
fits.obj <- createFITSFile("!/tmp/foo.fits")  # ! prevents errors if file exists
rm(fits.obj)
}
