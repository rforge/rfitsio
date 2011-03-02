\name{closeFITSFile}
\alias{closeFITSFile}
\title{Close a FITS file}
\description{Close a FITS file that has been opened by one of the
following functions: \code{\link{createFITSFile}},
\code{\link{openFITSFile}}, \code{\link{openFITSData}},
\code{\link{openFITSImage}}, \code{\link{openFITSTable}}.}
\usage{
	closeFITSFile(fits.obj)
}
\arguments{
	\item{fits.obj}{A FITS file object.}
}
\details{

	If this function is not called directly, it will be eventually
	called by the garbage collector (typically when quitting R,
	e.g. after a call to \code{\link{q}()}). It is however
	advisable to call \code{closeFITSFile} explicitly as soon as
	the code no longer uses the file, in order to free unused
	memory and flush the internal buffers. The latter is extremely
	important, as if any disaster happens preventing the
	garbage collector from working properly (e.g. segmentation
	faults), possible loss of data might occur.

	After a call to \code{closeFITSFile}, the FITS object is no
	longer usable.
}
\seealso{
	\code{\link{getErrorStatus}}.
}
\author{Maurizio Tomasi \email{maurizio.tomasi@unimi.it}}
\examples{
file.name <- system.file("fits_files", "tables.fits", package = "rfitsio")
fits.obj <- openFITSFile(file.name)
closeFITSFile(fits.obj)
}
