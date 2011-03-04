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
	return ScalarInteger (bits_per_pixel);
    }
    else
	return ScalarInteger (-1);
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
