\name{writeCommentHistory}
\alias{writeComment}
\alias{writeHistory}
\alias{writeDate}
\title{

	Write/append a comment, a history or the current date in the Current Header Unit (CHU).

}
\description{

	These functions write a record in the Current Header Unit
	(CHU) of the file. Depending on the function, the record
	includes (1) a general comment about the file
	(\code{writeComment}), (2) a comment about the history of the
	file (\code{writeHistory}), or (3) the current date.

	These functions are useful for bookkeeping. A typical usage of
	\code{writeComment} is to provide the name and version of the
	library which has created the FITS file. Using
	\code{writeHistory} and \code{writeDate} is useful to label
	different versions/releases of the same data.

}
\usage{
	writeComment(fits.obj, comment)
	writeHistory(fits.obj, history)
	writeDate(fits.obj)
}
\arguments{

	\item{fits.obj}{A FITS object, returned e.g. by
	\code{\link{createFITSFile}}.}

	\item{comment}{A string containing the comment to be written.}

	\item{history}{A string containing the history to be written.}

}
\seealso{
	\code{\link{getErrorStatus}}.
}
\author{Maurizio Tomasi \email{maurizio.tomasi@unimi.it}}
