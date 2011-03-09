\name{getImageDimSize}
\alias{getImageDim}
\alias{getImageSize}
\title{

	Return information about the size of a FITS image.

}
\description{

	Retrieve the number of dimensions and the size of each one for
	an image in a FITS file. For these functions to work, the
	current HDU must contain an image (you can call
	\code{\link{getCurrentHDUType}} and check that the return
	value is \code{"IMAGE_HDU"}).

	To change the current HDU, use either \code{\link{moveAbsHDU}}
	or \code{\link{moveRelHDU}}.

}
\usage{
	naxis <- getImageDim(fits.obj)
	sizes <- getImageSize(fits.obj)
}
\arguments{

	\item{fits.obj}{A FITS object, returned e.g. by
	\code{\link{openFITSFile}}.}

}
\value{

	\code{getImageDim} returns the number of dimensions for the
	image (e.g. 2 if the image is 2-D), \code{getImageSize} returns
	an array of integers each specifying the size of the
	corresponding dimension. For instance, in the case of a 2-D
	image with size 640x480 the value returned by
	\code{getImageSize} is \code{c(640,480)}.

}
\seealso{
	\code{\link{getCurrentHDUType}}, \code{\link{getImageType}}.
}
\author{Maurizio Tomasi \email{maurizio.tomasi@unimi.it}}
\examples{
fits.obj <- openFITSFile(system.file("fits_files", "photo.fits",
                                     package = "rfitsio")
dims <- getImageDim(fits.obj)  # dims = 2
size <- getImageSize(fits.obj) # size = c(223, 229)
closeFITSFile(fits.obj)
}
