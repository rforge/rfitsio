\name{getCurrentHDUType}
\alias{getCurrentHDUType}
\title{

	Return the type of the current HDU in a FITS file object

}
\description{

	Return a string representing the type of the current HDU in
	the specified FITS file object.

}
\usage{
	type.str <- getCurrentHDUType(fits.obj)
}
\arguments{

	\item{fits.obj}{A FITS object, returned e.g. by
	\code{\link{openFITSFile}}}.

\value{

	A string representing the kind of the currently selected HDU
	for \var{fits.obj}. Possible values are:

	\tabular{ll}{
		\code{"IMAGE_HDU"}  \tab The HDU contains a image. \cr
		\code{"ASCII_TBL"}  \tab The HDU contains an ASCII table. \cr
		\code{"BINARY_TBL"} \tab The HDU contains a binary table. \cr
		\code{"UNKNOWN"} \tab Some error occurred (in this
		case, use \code{\link{getErrorStatus}}).
	}

}
\seealso{
	\code{\link{getCurrentHDUNum}}, \code{\link{getErrorStatus}}.
}
\author{Maurizio Tomasi \email{maurizio.tomasi@unimi.it}}

