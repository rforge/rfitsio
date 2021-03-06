\name{createFITSFile}
\alias{createFITSFile}
\title{Create a FITS file}
\description{Create an empty FITS file.}
\usage{
	fits.obj <- createFITSFile(file.name, extended.syntax = TRUE)
}
\arguments{
	\item{file.name}{A string containing the name of the file to create.}
	\item{extended.syntax}{If \code{TRUE} (the default) then
	control characters in \code{file.name} are interpreted by the
	CFITSIO routines. For more information refer to the CFITSIO
	User's Guide.}
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

	The file is closed automatically when \code{fits.obj} is
	disposed by the garbage collector.

}
\seealso{
	\code{\link{openFITSFile}}, \code{\link{getErrorStatus}}.
}
\author{Maurizio Tomasi \email{maurizio.tomasi@unimi.it}}
\examples{
fits.obj <- createFITSFile(tempfile("rfitsio"))
closeFITSFile(fits.obj)
rm(fits.obj)
}
