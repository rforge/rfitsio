\name{getColumnNumber}
\alias{getColumnNumber}
\alias{getColumnName}
\title{

	Return the index/name of the first column whose name matches a
	template.

}
\description{

	The \var{template} string can contain the following wildcard
	characters:
	\tabular{ll}{
		\code{*} \tab Any sequence of characters (including
		zero characters.) \cr
		\code{?}  \tab Any single character. \cr
		\code{#} \tab Any consecutive string of decimal digits
		(0-9).
	}

	If more than one match has been found, the status of the FITS
	object as returned by \code{\link{getErrorStatus}} is set to
	237 (\code{COL_NOT_UNIQUE}). In this case, calling the
	function again will issue the next matches until the status is
	set to 219 (\code{COL_NOT_FOUND}).

	To change the current HDU, use either \code{\link{moveAbsHDU}}
	or \code{\link{moveRelHDU}}.

}
\usage{
	num <- getColumnNumber(fits.obj, template, casesen = FALSE)
	name <- getColumnName(fits.obj, template, casesen = FALSE)
}
\arguments{

	\item{fits.obj}{A FITS object, returned e.g. by
	\code{\link{openFITSFile}}.}
	\item{template}{A string containing the template to look for (see the Description for details).}
	\item{casesen}{If \code{TRUE}, case will be significant in the search.}

}
\value{

	\code{getColumnNumber} returns the integer index of the column
	(the first column has index 1).

	\code{getColumnName} returns a string containing the full name
	of the column.

}
\seealso{
	\code{\link{getColumnInformation}}, \code{\link{moveAbsHDU}}, \code{\link{moveRelHDU}}, \code{\link{getErrorStatus}}.
}
\author{Maurizio Tomasi \email{maurizio.tomasi@unimi.it}}
\examples{
}
