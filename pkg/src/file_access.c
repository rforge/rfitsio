/* -*- mode: c -*- */

/* C wrappers to CFITSIO file access functions
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
#include <Rdefines.h>
#include <fitsio.h>
#include <assert.h>

#include "rfitsio.h"

#define READONLY_NAME  "READONLY"
#define READWRITE_NAME "READWRITE"
#define UNKNOWN_NAME   "UNKNOWN"

/********************************************************************/

int
mode_from_name (SEXP name)
{
    const char * name_cstr = NM(name);

    if (strcmp (name_cstr, READONLY_NAME) == 0)
	return READONLY;
    else if (strcmp (name_cstr, READWRITE_NAME) == 0)
	return READWRITE;
    else
	return -1;
}

/********************************************************************/

/* Destroy a R object.
 *
 * This function is automatically called by R when a object of type
 * "fits" is being garbage collected (i.e. disposed).
 */
void
cfitsio_finalizer (SEXP fits_object)
{
    fits_file_t * fits = R_ExternalPtrAddr (fits_object);

    if (NULL != fits && NULL != fits->cfitsio_ptr)
	fits_close_file (fits->cfitsio_ptr, &(fits->status));

    Free (fits);
}

/********************************************************************/

/* Create a SEXP object from a fits_file_t pointer. */
SEXP
fits_ptr2SEXP (fits_file_t * fits)
{
    SEXP return_value = R_MakeExternalPtr (fits, R_NilValue, R_NilValue);
    assert (return_value != R_NilValue);
    R_RegisterCFinalizer (return_value, cfitsio_finalizer);
    return return_value;
}

/********************************************************************/

/* Generic implementation of a wrapper for functions like
 * 'fits_open_file', 'fits_open_data', 'fits_open_image',
 * 'fits_open_table'. Macros are usually ugly, but here we have four
 * functions which are identical in their prototype and very similar
 * in their purpose, so it is meaningless to cut and paste four times
 * the same code... */
#define IMPLEMENT_FITS_OPEN_FUNC(wrapper_func,cfitsio_func)        \
SEXP                                                               \
wrapper_func (SEXP file_name, SEXP mode_name)                      \
{                                                                  \
    fits_file_t * fits;                                            \
    SEXP return_value;                                             \
                                                                   \
    fits = Calloc (1, fits_file_t);                                \
    cfitsio_func (&(fits->cfitsio_ptr),                            \
		  NM(file_name),                  /* (1) */        \
		  mode_from_name (mode_name),                      \
		  &(fits->status));                                \
    /* (1) Ignore any warning here: it is a CFITSIO bug */         \
                                                                   \
    return fits_ptr2SEXP (fits);                                   \
}

IMPLEMENT_FITS_OPEN_FUNC(cfitsio_open_file,  fits_open_file)
IMPLEMENT_FITS_OPEN_FUNC(cfitsio_open_data,  fits_open_data)
IMPLEMENT_FITS_OPEN_FUNC(cfitsio_open_table, fits_open_table)
IMPLEMENT_FITS_OPEN_FUNC(cfitsio_open_image, fits_open_image)

/********************************************************************/

/* Wrapper to fits_create_file */
SEXP
cfitsio_create_file (SEXP file_name)
{
    fits_file_t * fits;
    SEXP return_value;

    fits = Calloc (1, fits_file_t);
    fits_create_file (&(fits->cfitsio_ptr),
		      NM(file_name),
		      &(fits->status));

    return fits_ptr2SEXP (fits);
}

/********************************************************************/

/* Wrapper to fits_close_file */
SEXP
cfitsio_close_file (SEXP fits_object)
{
    fits_file_t * fits = R_ExternalPtrAddr (fits_object);

    if (NULL != fits && NULL != fits->cfitsio_ptr)
    {
	fits_close_file (fits->cfitsio_ptr, &(fits->status));
	fits->cfitsio_ptr = NULL;
	fits->status = 0;
    }
}
