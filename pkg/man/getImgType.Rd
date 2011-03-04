\name{getImgType}
\alias{getImgType}
\title{

	Return a string representing the (equivalent) data type of the
	image as given by the \code{BITPIX} keyword.

}
\description{

	Flag \code{equiv} tells RFITSIO whether to take into account
	or not the values of \code{BSCAL} and \code{BZERO} to
	determine the \dQuote{true} column type. For instance, if
	\code{BITPIX} is 16 and \code{BSCAL} is 0.1 (floating point
	number), then the routine will either return
	\code{"SHORT_IMG"} (if \code{equiv = FALSE}) or
	\code{"FLOAT_IMG"} (if \code{equiv = TRUE}).

	To change the current HDU, use either \code{\link{moveAbsHDU}}
	or \code{\link{moveRelHDU}}.

}
\usage{
	info <- getImgType(fits.obj, equiv = FALSE)
}
\arguments{

	\item{fits.obj}{A FITS object, returned e.g. by
	\code{\link{openFITSFile}}.}

	\item{equiv}{Whether to take into account the values of
	\code{TSCAL} and \code{TZERO} to determine the column type.
	(See the description.)}

}
\value{

	A string representing the (equivalent) data type. Possible
	values are \code{"BYTE_IMG"} (8 bits/pixel),
	\code{"SHORT_IMG"} (16 bits/pixel), \code{"LONG_IMG"} (32
	bits/pixel), \code{"LONGLONG_IMG"} (64 bits/pixel),
	\code{"FLOAT_IMG"} (32 bits/pixel), \code{"DOUBLE_IMG"} (64
	bits/pixel), \code{"UNKNOWN"} (the data type has not been
	recognized) or \code{""} (\code{fits.obj} is not a valid FITS
	object).

}
\seealso{
	\code{\link{getErrorStatus}}.
}
\author{Maurizio Tomasi \email{maurizio.tomasi@unimi.it}}
\examples{
file.name <- system.file("fits_files", "tables.fits", package = "rfitsio")
fits.obj <- openFITSFile(file.name)
getImgType(fits.obj)
closeFITSFile(fits.obj)
}
