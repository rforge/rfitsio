/* -*- mode: c -*- */

/* C wrappers to CFITSIO functions to parse FITS headers
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

/* The first of the two wrappers to fits_get_hdrspace... */
SEXP
cfitsio_get_num_of_keys (SEXP fits_object)
{
    fits_file_t * fits = R_ExternalPtrAddr (fits_object);

    if (NULL != fits->cfitsio_ptr)
    {
	int num_of_keys;

	fits_get_hdrspace (fits->cfitsio_ptr, &num_of_keys,
			   NULL, &(fits->status));
	return ScalarInteger (num_of_keys);
    }
    else
	return ScalarInteger (-1);
}

/* ...and the second one */
SEXP
cfitsio_get_available_key_slots (SEXP fits_object)
{
    fits_file_t * fits = R_ExternalPtrAddr (fits_object);

    if (NULL != fits->cfitsio_ptr)
    {
	int num_of_keys;
	int available_slots;

	fits_get_hdrspace (fits->cfitsio_ptr, &num_of_keys,
			   &available_slots, &(fits->status));
	return ScalarInteger (available_slots);
    }
    else
	return ScalarInteger (-1);
}
