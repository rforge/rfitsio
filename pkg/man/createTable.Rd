\name{createTable}
\alias{createTable}
\title{

	Create a new ASCII/binary table in an already opened FITS file.

}
\description{

	Create a new table with a predefined set of columns and
	optionally allocates a certain number of rows.

}
\usage{

	createTable(fits.obj, column.types, column.form,
                    column.units = c(), ext.name = "", num.of.rows = 0,
                    binary = TRUE)

}
\arguments{

	\item{fits.obj}{A FITS object, returned e.g. by
	\code{\link{openFITSFile}}.}

	\item{column.types}{Array of strings specifying the type of columns using Fortran-like data specifiers, e.g. \code{c("1D", "3D")}.}

	\item{column.form}{Array of strings specifying the column names (only letters, digits and underscores are allowed).}

	\item{column.units}{(Optional) Array of strings specifying the
	measure unit for this column.}

	\item{ext.name}{(Optional) Extended name for the table.}

	\item{num.of.rows}{(Optional) Number of rows to pre-allocate for the table.}

	\item{binary}{If \code{TRUE} (the default) a binary table will be created, otherwise an ASCII table will be used. Beware that ASCII tables only support a limited subset of data types (e.g. complex numbers are not allowed).}

}
\seealso{
	\code{\link{readColumn}}, \code{\link{getNumOfRows}}, \code{\link{getNumOfColumns}}, \code{\link{getErrorStatus}}.
}
\author{Maurizio Tomasi \email{maurizio.tomasi@unimi.it}}
\examples{
fits.obj <- createFITSFile(tempfile("rfitsio"))
createTable(fits.obj,
            c("COUNTS", "AVERAGE"),
	    c("1I", "1D"),
	    c("Pure number", "Meters"))
closeFITSFile(fits.obj)
}
