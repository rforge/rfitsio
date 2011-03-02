\name{getNumOfRowsColumns}
\alias{getNumOfRows}
\alias{getNumOfColumns}
\title{

	Return the number of rows/columns in the current HDU of a FITS file

}
\description{

	Return the number of rows or column contained in a table
	(integer value). These values are taken from the \code{NAXIS1}
	and \code{NAXIS2} keywords in the HDU header. For the two
	functions to work, the current HDU must either be a binary or
	ASCII table (you can check this with
	\code{\link{getCurrentHDUType}}).

	To change the current HDU, use either \code{\link{moveAbsHDU}}
	or \code{\link{moveRelHDU}}.

}
\usage{
	rows <- getNumOfRows(fits.obj)
	cols <- getNumOfColumns(fits.obj)
}
\arguments{

	\item{fits.obj}{A FITS object, returned e.g. by
	\code{\link{openFITSFile}}.}

}
\value{

	A integer number representing either the number of rows or
	column for the current table of the FITS object.

}
\seealso{
	\code{\link{getCurrentHDUNum}}, \code{\link{moveAbsHDU}}, \code{\link{moveRelHDU}}, \code{\link{getErrorStatus}}.
}
\author{Maurizio Tomasi \email{maurizio.tomasi@unimi.it}}
\examples{
file.name <- system.file("fits_files", "tables.fits", package = "rfitsio")
fits.obj <- openFITSFile(file.name)
for (cur.hdu in 1:getNumOfHDUs(fits.obj)) {
    moveAbsHDU(fits.obj, cur.hdu)
    cur.hdu.type <- getCurrentHDUType(fits.obj)

    if(cur.hdu.type == "ASCII_TBL" || cur.hdu.type == "BINARY_TBL")
        cat(sprintf("HDU \%d contains a table of \%d columns and \%d rows\\n",
                    cur.hdu,
                    getNumOfRows(fits.obj),
		    getNumOfColumns(fits.obj)))
}
closeFITSFile(fits.obj)
}
