\name{getCFITSIOVersion}
\title{Return the version of the CFITSIO library used to compile RFITSIO}
\description{Return a floating point value representing the version of the CFITSIO library linked to RFITSIO.}
\usage{
	version <- getCFITSIOVersion()
}
\value{

	A floating point number of the form \code{xx.yy}, where
	\code{xx} is the major version number and \code{yy} the minor
	version number.

}
\author{Maurizio Tomasi <maurizio.tomasi@unimi.it>}
\examples{
version <- getCFITSIOVersion()
trunc(version)                      # Major version number
signif(version - trunc(version), 2) # Minor version number
}
