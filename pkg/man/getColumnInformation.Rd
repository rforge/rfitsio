\name{getColumnInformation}
\alias{getColumnInformation}
\alias{getEqColumnInformation}
\title{

	Return the number of columns in the current HDU of a FITS file

}
\description{

	Return a list describing the column with the specified index
	(starting from 1).

	The two functions \code{getColumnInformation} and
	\code{getEqColumnInformation} are identical, except for the
	fact that \code{getEqColumnInformation} takes into account the
	values of \code{TSCAL} and \code{TZERO} to determine the
	\dQuote{true} column type. For instance, if a column has type
	\code{1I} and \code{TSCALn} equal to 0.12, then the type
	returned by \code{getColumnInformation} will be
	\code{"TSHORT"}, while the type returned by
	\code{getEqColumnInformation} will be \code{"TFLOAT"}.

	To change the current HDU, use either \code{\link{moveAbsHDU}}
	or \code{\link{moveRelHDU}}.

}
\usage{
	info <- getColumnInformation(fits.obj, column.num)
	info <- getEqColumnInformation(fits.obj, column.num)
}
\arguments{

	\item{fits.obj}{A FITS object, returned e.g. by
	\code{\link{openFITSFile}}.}

	\item{column.num}{The index of the column (starting from 1).}

}
\value{

	A list containing a number of information about the specified
	column in the current HDU. The fields in the list are:

	\tabular{ll}{
		\code{type} \tab A string specifying the CFITSIO type
		(see below). \cr
		\code{repeat.count} \tab A integer specifying how many
		data are stored in each row (=1 for scalar columns, >1
		for vector columns). \cr
		\code{width} \tab Width (in bytes) of each column
		element (e.g. a \code{10D} binary table column will
		have 8 here). \cr
		\code{variable.length} \tab \code{TRUE} if it is a
		variable-length column, \code{FALSE} otherwise.
	}

	The \code{type} string field can be either \code{"TBIT"},
	\code{"TBYTE"}, \code{"TLOGICAL"}, \code{"TSTRING"},
	\code{"TSHORT"}, \code{"TLONG"}, \code{"TLONGLONG"},
	\code{"TFLOAT"}, \code{"TDOUBLE"}, \code{"TCOMPLEX"},
	\code{"TDBLCOMPLEX"}, \code{"TINT"}, \code{"TSBYTE"},
	\code{"TUINT"}, \code{"TUSHORT"} or \code{"TULONG"}.

}
\seealso{
	\code{\link{getColumnNumber}}, \code{\link{moveAbsHDU}}, \code{\link{moveRelHDU}}, \code{\link{getErrorStatus}}.
}
\author{Maurizio Tomasi \email{maurizio.tomasi@unimi.it}}
\examples{
}
