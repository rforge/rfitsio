\name{writeColumn}
\alias{writeColumn}
\title{

	Write one column of data to a binary/ASCII table in a FITS file.

}
\description{

	Write one entire column or part of it into the current table
	of a FITS file. The function can perform simple type
	conversions (e.g. the user can pass a list of integers to be
	written as double values).

	To change the current HDU, use either \code{\link{moveAbsHDU}}
	or \code{\link{moveRelHDU}}.

}
\usage{
	col <- writeColumn(fits.obj, data.type, col.num, first.row,
                           first.elem, array, null.value = NA)
}
\arguments{

	\item{fits.obj}{A FITS object, returned e.g. by
	\code{\link{openFITSFile}}.}

	\item{data.type}{A string specifying the data type. Possible
	values are \code{"TBIT"}, \code{"TBYTE"}, \code{"TLOGICAL"},
	\code{"TSTRING"}, \code{"TSHORT"}, \code{"TLONG"},
	\code{"TLONGLONG"}, \code{"TFLOAT"}, \code{"TDOUBLE"},
	\code{"TCOMPLEX"}, \code{"TDBLCOMPLEX"}, \code{"TINT"},
	\code{"TSBYTE"}, \code{"TUINT"}, \code{"TUSHORT"} or
	\code{"TULONG"}.}

	\item{col.num}{Index of the column, ranging from 1 to the
	value returned by \code{\link{getNumOfColumns}}.}

	\item{first.row}{Index of the first row to read, ranging from
	1 to the value returned by \code{\link{getNumOfRows}}.}

	\item{first.elem}{Index of the first element. This is
	significant only for vector columns; for scalar columns (the
	most widely used case) this should be 1.}

	\item{array}{The array of data to be written in the column.}

	\item{null.value}{Value to be considered as \dQuote{null}. Its
	type must be convertible to the data type specified by
	\code{data.type}.}

}
\seealso{
	To save some data into a new FITS file, first use
	\code{createFITSFile} to create the file, and then
	\code{createTable} to add a binary/ASCII table.

	Useful information about an existing table can be obtained using
	\code{\link{getNumOfRows}} and \code{\link{getNumOfColumns}}.

	To check if the command succeeded or not, use
	\code{\link{getErrorStatus}} and \code{\link{getErrorText}}.
}
\author{Maurizio Tomasi \email{maurizio.tomasi@unimi.it}}
\examples{
fits.obj <- createFITSFile(tempfile("test.fits"))
createTable(fits.obj, c("TEST"), c("1D"))
# Write the numbers from 1 to 10
writeColumn(fits.obj, "TDOUBLE", 1, 1, 1, 1:10)
closeFITSFile(fits.obj)
}
