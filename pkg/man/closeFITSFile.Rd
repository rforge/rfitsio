\name{closeFITSFile}
\title{Close a FITS file object}
\description{Close a FITS flie, flushing the cache to disk, and release the memory associated with it.}
\usage{
	closeFITSFile(fits.obj)
}
\arguments{
	\item{fits.obj}{A FITS object, returned e.g. by \code{\link{createFITSFile}}}
}
\details{

	The function flushes the cache associated with the file and
	release any memory allocated for it. You can get the same
	result by using \code{\link{rm}} with \code{fits.obj}.

}
\author{Maurizio Tomasi <maurizio.tomasi@unimi.it>}
\examples{
fits.obj <- createFITSFile("!/tmp/test.fits")
closeFITSFile(fits.obj)                 # This is the same as rm(fits.obj)
}
