\name{readKey}
\alias{readKeyValue}
\alias{readKeyComment}
\title{

	Retrieve the value/comment from a card in the current HDU of a
	FITS file object.

}
\description{

	Function \code{readKeyValue} returns a variable whose type is
	specified by the \var{data.type} parameter. Function
	\code{readKeyComment} always returns a string.

	To change the current HDU, use either \code{\link{moveAbsHDU}}
	or \code{\link{moveRelHDU}}.

}
\usage{
	val <- readKeyValue(fits.obj, data.type, key.name)
	com <- readKeyComment(fits.obj, key.name)
}
\arguments{

	\item{fits.obj}{A FITS object, returned e.g. by
	\code{\link{openFITSFile}}.}

	\item{data.type}{A string specifying the data type of the
	value returned by \code{readKeyValue}. Possible values are
	\code{"TBYTE"}, \code{"TLOGICAL"}, \code{"TSTRING"},
	\code{"TSHORT"}, \code{"TLONG"}, \code{"TLONGLONG"},
	\code{"TFLOAT"}, \code{"TDOUBLE"}, \code{"TCOMPLEX"},
	\code{"TDBLCOMPLEX"}, \code{"TINT"}, \code{"TUINT"},
	\code{"TUSHORT"} or \code{"TULONG"}.}

	\item{key.name}{String containing the name of the card (e.g.
	\code{NAXIS2}).}

}
\value{

	Function \code{readKeyValue} returns the value of the
	specified card converted to the desired datatype (if you are
	unsure about what data type to use, \code{"TSTRING"} is a safe
	bet as this conversion always works).

}
\seealso{
	\code{\link{readRecord}}, \code{\link{readCard}}, \code{\link{getErrorStatus}}.
}
\author{Maurizio Tomasi \email{maurizio.tomasi@unimi.it}}
\examples{
file.name <- system.file("fits_files", "tables.fits", package = "rfitsio")
fits.obj <- openFITSFile(file.name)

# The first column of the table in HDU 2 contains logical values
readKeyValue(fits.obj, "TINT", "NAXIS")
readKeyComment(fits.obj, "NAXIS")
}
