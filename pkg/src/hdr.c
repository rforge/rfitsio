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

    if (NULL != fits && NULL != fits->cfitsio_ptr)
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

    if (NULL != fits && NULL != fits->cfitsio_ptr)
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

/********************************************************************/

/* Wrapper to fits_read_record */
SEXP
cfitsio_read_record (SEXP fits_object, SEXP key_number)
{
    fits_file_t * fits = R_ExternalPtrAddr (fits_object);

    if (NULL != fits && NULL != fits->cfitsio_ptr)
    {
	char record[FLEN_CARD + 1];

	fits_read_record (fits->cfitsio_ptr, asInteger (key_number),
			  &record[0], &(fits->status));
	record[FLEN_CARD] = 0;
	return mkString (record);
    }
    else
	return mkString ("");
}

/********************************************************************/

/* Wrapper to fits_read_card */
SEXP
cfitsio_read_card (SEXP fits_object, SEXP key_name)
{
    fits_file_t * fits = R_ExternalPtrAddr (fits_object);

    if (NULL != fits && NULL != fits->cfitsio_ptr)
    {
	char record[FLEN_CARD + 1];

	fits_read_card (fits->cfitsio_ptr, (char *) NM (key_name),
			&record[0], &(fits->status));
	record[FLEN_CARD] = 0;
	return mkString (record);
    }
    else
	return mkString ("");
}

/********************************************************************/

/* Wrapper to fits_read_key */
SEXP
cfitsio_read_key (SEXP fits_object, SEXP type_name,
		  SEXP key_name, SEXP return_value)
{
    fits_file_t * fits = R_ExternalPtrAddr (fits_object);

    if (NULL != fits && NULL != fits->cfitsio_ptr)
    {
	/* Note that we size 'value' using the maximum number of
	 * characters allowed for a *string*. Since all the other data
	 * types allowed in a keyword require less storage, this is a
	 * safe bet. */
	int type;
	char value[FLEN_VALUE + 1];
	char comment[FLEN_COMMENT + 1];

	type = type_from_typename (NM (type_name));
	if (type < 0)
	{
	    error ("Invalid value for 'data.type' in call to "
		   "'readKeyValue' or 'readKeyComment'");
	    return mkString ("");
	}

	fits_read_key (fits->cfitsio_ptr, type,
		       (char *) NM (key_name),
		       (void *) &value[0], &comment[0],
		       &(fits->status));
	if (fits->status != 0)
	    warning ("Error in call to fits_read_key: %d, type is %d, key is %s", fits->status, type, NM (key_name));

	value[FLEN_VALUE] = 0;
	comment[FLEN_COMMENT] = 0;

	if (! asLogical (return_value))
	    return mkString (comment);

	return sexp_from_void_ptr ((const void *) value, type);
    }
    else
	return mkString ("");
}
