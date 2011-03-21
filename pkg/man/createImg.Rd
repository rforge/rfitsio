\name{createImage}
\alias{createImage}
\title{

	Create a new primary array or IMAGE extension in a FITS file.

}
\description{

	Create a new primary array or IMAGE extension in a FITS file
	object (which must already have been opened or created). If
	the file is empty, a new primary extension is created,
	otherwise a new IMAGE extension is appended to the file.

}
\usage{

	createImage(fits.obj, bits.per.pixel, dimensions)

}
\arguments{

	\item{fits.obj}{A FITS object, returned e.g. by
	\code{\link{createFITSFile}}.}

	\item{bits.per.pixel}{Number of bits per pixel (integer
	value). The most common values are: 8, 16, 24 and 32.}

	\item{dimensions}{Array of \var{n} entries specifying the
	number of pixels along each dimension for the
	\var{n}-dimensional image.}

}
\seealso{
	\code{\link{getImageDim}}, \code{\link{getImageSize}}.
}
\author{Maurizio Tomasi \email{maurizio.tomasi@unimi.it}}
