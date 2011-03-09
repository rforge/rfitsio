/* -*- mode: c -*- */

/* C wrappers to CFITSIO functions for primary array/IMAGE extension
 * I/O
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

SEXP
get_img_type_generic (int (*fn) (fitsfile *, int *, int *),
		      SEXP fits_object)
{
    fits_file_t * fits = R_ExternalPtrAddr (fits_object);

    if (NULL != fits && NULL != fits->cfitsio_ptr)
    {
	int bits_per_pixel;
	fn (fits->cfitsio_ptr, &bits_per_pixel, &(fits->status));

	switch (bits_per_pixel)
	{
        case 8   : return mkString ("BYTE_IMG");
        case 16  : return mkString ("SHORT_IMG");
        case 32  : return mkString ("LONG_IMG");
        case 64  : return mkString ("LONGLONG_IMG");
        case -32 : return mkString ("FLOAT_IMG");
        case -64 : return mkString ("DOUBLE_IMG");
        default  : return mkString ("UNKNOWN");
	}
    }
    else
	return mkString ("");
}

SEXP
cfitsio_get_img_type (SEXP fits_object)
{
    return get_img_type_generic (fits_get_img_type, fits_object);
}

SEXP
cfitsio_get_img_equivtype (SEXP fits_object)
{
    return get_img_type_generic (fits_get_img_equivtype, fits_object);
}

/********************************************************************/

/* Wrapper to fits_get_img_dim */
SEXP
cfitsio_get_img_dim (SEXP fits_object)
{
    fits_file_t * fits = R_ExternalPtrAddr (fits_object);

    if (NULL != fits && NULL != fits->cfitsio_ptr)
    {
	int naxis;
	fits_get_img_dim (fits->cfitsio_ptr,
			  &naxis,
			  &(fits->status));
	return ScalarInteger (naxis);
    }
    else
	return ScalarInteger (-1);
}

/********************************************************************/

/* Wrapper to fits_get_img_size */
SEXP
cfitsio_get_img_size (SEXP fits_object)
{
    fits_file_t * fits = R_ExternalPtrAddr (fits_object);

    if (NULL != fits && NULL != fits->cfitsio_ptr)
    {
	int naxis;
	int i;
	LONGLONG * axes_dimensions;
	SEXP result;
	int verybig_flag;

	/* First retrieve the number of dimensions */
	fits_get_img_dim (fits->cfitsio_ptr,
			  &naxis,
			  &(fits->status));

	if (fits->status != 0)
	    return ScalarInteger (-1);

	axes_dimensions = (long *) malloc (sizeof (long) * naxis);

	/* Now get the size for each dimension */
	fits_get_img_sizell (fits->cfitsio_ptr,
			     naxis,
			     &axes_dimensions[0],
			     &(fits->status));

	/* Check that the sizes are small enough to be contained in a
	 * integer or not */
	verybig_flag = 0;
	if (sizeof (LONGLONG) > sizeof (int))
	{
	    for (i = 0; i < naxis; ++i)
	    {
		if (axes_dimensions[i] > (long) SINT_MAX)
		    verybig_flag = 1;
	    }
	}

	/* Build a R array and initialize it with the numbers returned
	 * by fits_get_img_size */
	if (verybig_flag)
	{
	    PROTECT(result = allocVector (INTSXP, naxis));
	    for (i = 0; i < naxis; ++i)
		INTEGER(result)[i] = axes_dimensions[i];
	} else
	{
	    PROTECT(result = allocVector (REALSXP, naxis));
	    for (i = 0; i < naxis; ++i)
		REAL(result)[i] = axes_dimensions[i];
	}
	UNPROTECT(1);

	free (axes_dimensions);
	return result;
    }
    else
	return R_NilValue;
}
