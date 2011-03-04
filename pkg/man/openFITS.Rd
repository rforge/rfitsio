\name{openFITS}
\alias{openFITSFile}
\alias{openFITSData}
\alias{openFITSImage}
\alias{openFITSTable}
\title{Open an existing FITS file}
\description{Open a FITS file and optionally move the pointer to a specified HDU.}
\usage{
	fits.obj <- openFITSFile(file.name, mode = "READONLY")
	fits.obj <- openFITSData(file.name, mode = "READONLY")
	fits.obj <- openFITSImage(file.name, mode = "READONLY")
	fits.obj <- openFITSTable(file.name, mode = "READONLY")
}
\arguments{
	\item{file.name}{A string containing the name of the file to open.}
	\item{mode}{A string specifying the access mode. It can be either \code{"READONLY"} or \code{"READWRITE"}.}
}
\value{
	A FITS file object of class \code{cfitsio_obj} (an opaque type).
}
\details{

	Compressed files using \code{gzip} can be opened
	transparently. HTTP and FTP addresses are accepted as well,
	but in this case the access mode is forced to be
	\code{"READONLY"}.

	Errors occurred during the execution of these functions can be
	checked using \code{\link{getErrorStatus}}.

	The file is automatically closed when \code{fits.obj} is
	disposed by the garbage collector.

}
\seealso{
	\code{\link{getErrorStatus}}.
}
\author{Maurizio Tomasi \email{maurizio.tomasi@unimi.it}}
\examples{
file.name <- system.file("fits_files", "tables.fits", package = "rfitsio")
fits.obj <- openFITSFile(file.name)
if (getErrorStatus(fits.obj) != 0) {
   error(sprintf("Unable to open file \%s, reason: \%s",
                 file.name,
		 getErrorText(fits.obj)))
closeFITSFile(fits.obj)
}
}
