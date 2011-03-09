\name{getImgDimSize}
\alias{getImgDim}
\alias{getImgSize}
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
	naxis <- getImgDim(fits.obj)
	sizes <- getImgSize(fits.obj)
}
\arguments{

	\item{fits.obj}{A FITS object, returned e.g. by
	\code{\link{openFITSFile}}.}

}
\value{

	\code{getImgDim} returns the number of dimensions for the
	image (e.g. 2 if the image is 2-D), \code{getImgSize} returns
	an array of integers each specifying the size of the
	corresponding dimension. For instance, in the case of a 2-D
	image with size 640x480 the value returned by
	\code{getImgSize} is \code{c(640,480)}.

}
\seealso{
	\code{\link{getCurrentHDUType}}, \code{\link{getImgType}}.
}
\author{Maurizio Tomasi \email{maurizio.tomasi@unimi.it}}
