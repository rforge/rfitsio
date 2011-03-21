\name{insertDeleteRows}
\alias{insertRows}
\alias{deleteRows}
\title{

	Insert/delete rows in a FITS ASCII/binary table.

}
\description{

	Function \code{insertRows} inserts empty rows in a existing
	ASCII/binary table at the specified position. Function
	\code{deleteRows} deletes a set of rows.

}
\usage{

	insertRows(fits.obj, first.row, num)
	deleteRows(fits.obj, rows)

}
\arguments{

	\item{fits.obj}{A FITS object, returned e.g. by
	\code{\link{openFITSFile}}.}

	\item{first.row}{Index of the row \emph{before} the new rows to be inserted. Set this to 0 in order to add rows at the beginning of the table.}

	\item{num}{Number of rows to add.}

	\item{rows}{Rows to delete. This can be either an array of integers specifying the indexes of the rows (starting from 1) or a string like \code{"1,4-6"}.}

}
\seealso{
	\code{\link{createTable}}, \code{\link{getNumOfRows}}, \code{\link{getErrorStatus}}.
}
\author{Maurizio Tomasi \email{maurizio.tomasi@unimi.it}}
\examples{
fits.obj <- createFITSFile(tempfile("rfitsio"))
createTable(fits.obj, c("1I", "1D"), c("COUNTS", "AVERAGE"), c("Pure number", "Meters"))
# Insert new rows and immediately remove some of them
# (A bit silly...)
insertRows(fits.obj, 0, 100)
deleteRows(fits.obj, 1:5)
deleteRows(fits.obj, "1,3,10-16,20")
closeFITSFile(fits.obj)
}
