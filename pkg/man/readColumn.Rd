\name{readColumn}
\alias{readColumn}
\title{

	Read one column from a binary/ASCII table in a FITS file.

}
\description{

	Return a vector containing a specified range of data from a
	binary/ASCII table in a FITS file. The function can perform
	simple type conversions (e.g. from integers to strings).

	To change the current HDU, use either \code{\link{moveAbsHDU}}
	or \code{\link{moveRelHDU}}.

}
\usage{
	col <- readColumn(fits.obj, data.type, column.num, first.row, first.element, num.of.elements)
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

	\item{column.num}{Index of the column, ranging from 1 to the
	value returned by \code{\link{getNumOfColumns}}.}

	\item{first.row}{Index of the first row to read, ranging from
	1 to the value returned by \code{\link{getNumOfRows}}.}

	\item{first.element}{Index of the first element. This is
	significant only for vector columns; for scalar columns (the
	most widely used case) this should be 1.}

	\item{num.of.elements}{Number of rows to retrieve. This value
	should be between 1 and \code{\link{getNumOfRows}(fits.obj) -
	first.row + 1}.}

}
\value{

	A vector containing the specified subset of values taken from
	the column with index \code{column.num}.

}
\seealso{
	\code{\link{getNumOfRows}}, \code{\link{getNumOfColumns}}, \code{\link{getErrorStatus}}.
}
\author{Maurizio Tomasi \email{maurizio.tomasi@unimi.it}}
\examples{
file.name <- system.file("fits_files", "tables.fits", package = "rfitsio")
fits.obj <- openFITSFile(file.name)

# The first column of the table in HDU 2 contains logical values
moveAbsHDU(fits.obj, 2)
readColumn(fits.obj, "TLOGICAL", 1, 1, 1, getNumOfRows(fits.obj))
closeFITSFile(fits.obj)
}
