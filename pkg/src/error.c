/* -*- mode: c -*- */

/* C wrappers to CFITSIO error/diagnostic functions
 * Copyright (C) 2011 Maurizio Tomasi
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

#include <R.h>
#include <Rinternals.h>
#include <fitsio.h>
#include "rfitsio.h"

/********************************************************************/

/* Return the value of the 'status' variable (an integer) */
SEXP
cfitsio_get_errstatus (SEXP fits_object,
		       SEXP reset_status)
{
    fits_file_t * fits = R_ExternalPtrAddr (fits_object);
    int result = -1;

    if (fits)
    {
	result = fits->status;

	if (asLogical (reset_status))
	    fits->status = 0;
    }

    return ScalarInteger (result);
}

/********************************************************************/

/* Wrapper to fits_get_errstatus */
SEXP
cfitsio_get_errtext (SEXP fits_object,
		     SEXP reset_status)
{
    fits_file_t * fits = R_ExternalPtrAddr (fits_object);
    char error_string[31];

    fits_get_errstatus (fits->status, &(error_string[0]));
    if (asLogical (reset_status))
	fits->status = 0;

    return mkString (error_string);
}


/********************************************************************/

/* Reset the error status */
SEXP
cfitsio_reset_error_status (SEXP fits_object)
{
    fits_file_t * fits = R_ExternalPtrAddr (fits_object);
    fits->status = 0;

    return R_NilValue;
}

/********************************************************************/

/* Wrapper to fits_get_hdu_num */
SEXP
cfitsio_get_version ()
{
    float version;
    fits_get_version (&version);

    return ScalarReal (version);
}
