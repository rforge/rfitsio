/* -*- mode: c -*- */

/* C wrappers to CFITSIO HDU functions
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
#include <string.h>
#include "rfitsio.h"

#define IMAGE_HDU_NAME  "IMAGE_HDU"
#define ASCII_TBL_NAME  "ASCII_TBL"
#define BINARY_TBL_NAME "BINARY_TBL"
#define UNKNOWN_NAME    "UNKNOWN"

/********************************************************************/

const char *
hdu_type_name (int hdu_type)
{
    switch (hdu_type)
    {
    case IMAGE_HDU:  return IMAGE_HDU_NAME;
    case ASCII_TBL:  return ASCII_TBL_NAME;
    case BINARY_TBL: return BINARY_TBL_NAME;
    default:         return UNKNOWN_NAME;
    }
}


/********************************************************************/

int
hdu_type_from_name (SEXP name)
{
    const char * name_cstr = NM(name);

    if (strcmp (name_cstr, IMAGE_HDU_NAME) == 0)
	return IMAGE_HDU;
    else if (strcmp (name_cstr, ASCII_TBL_NAME) == 0)
	return ASCII_TBL;
    else if (strcmp (name_cstr, BINARY_TBL_NAME) == 0)
	return BINARY_TBL;
    else
	return -1;
}

/********************************************************************/

/* Wrapper to fits_get_num_hdus */
SEXP
cfitsio_get_num_hdus (SEXP fits_object)
{
    fits_file_t * fits = R_ExternalPtrAddr (fits_object);

    if (NULL != fits && NULL != fits->cfitsio_ptr)
    {
	int hdu_num;

	fits_get_num_hdus (fits->cfitsio_ptr, &hdu_num, &(fits->status));
	return ScalarInteger (hdu_num);
    }
    else
	return ScalarInteger (-1);
}

/********************************************************************/

/* Wrapper to fits_get_hdu_num */
SEXP
cfitsio_get_hdu_num (SEXP fits_object)
{
    fits_file_t * fits = R_ExternalPtrAddr (fits_object);

    if (NULL != fits && NULL != fits->cfitsio_ptr)
    {
	int hdu_num;

	fits_get_hdu_num (fits->cfitsio_ptr, &hdu_num);
	return ScalarInteger (hdu_num);
    }
    else
	return ScalarInteger (-1);
}

/********************************************************************/

/* Wrapper to fits_movabs_hdu */
SEXP
cfitsio_movabs_hdu (SEXP fits_object,
		    SEXP hdu_num)
{
    fits_file_t * fits = R_ExternalPtrAddr (fits_object);

    if (NULL != fits && NULL != fits->cfitsio_ptr)
    {
	int hdu_type;

	fits_movabs_hdu (fits->cfitsio_ptr, asInteger (hdu_num),
			 &hdu_type, &(fits->status));
	return mkString (hdu_type_name (hdu_type));
    }
    else
	return mkString (ERROR_STR);
}

/********************************************************************/

/* Wrapper to fits_movabs_hdu */
SEXP
cfitsio_movrel_hdu (SEXP fits_object,
		    SEXP hdu_num)
{
    fits_file_t * fits = R_ExternalPtrAddr (fits_object);

    if (NULL != fits && NULL != fits->cfitsio_ptr)
    {
	int hdu_type;

	fits_movrel_hdu (fits->cfitsio_ptr, asInteger (hdu_num),
			 &hdu_type, &(fits->status));
	return mkString (hdu_type_name (hdu_type));
    }
    else
	return mkString (ERROR_STR);
}

/********************************************************************/

/* Wrapper to fits_movnam_hdu */
SEXP
cfitsio_movnam_hdu (SEXP fits_object,
		    SEXP hdu_type,
		    SEXP ext_name,
		    SEXP ext_ver)
{
    fits_file_t * fits = R_ExternalPtrAddr (fits_object);

    if (NULL != fits && NULL != fits->cfitsio_ptr)
    {
	fits_movnam_hdu (fits->cfitsio_ptr,
			 asInteger (hdu_type),
			 NM(ext_name),                   /* (1) */
			 hdu_type_from_name (ext_ver),
			 &(fits->status));
	/* (1) Any decent compiler will produce a warning here,
	 * because we are passing a "const char *" as argument to
	 * fits_movnam_hdu, which accepts "char *". This is a
	 * widespread bug in CFITSIO, which never uses "const char"
	 * when required. You can safely ignore this warning (and send
	 * a email to the CFITSIO developers). */

	return R_NilValue;
    }
    else
	return R_NilValue;
}

/********************************************************************/

/* Wrapper to fits_get_hdu_type */
SEXP
cfitsio_get_hdu_type (SEXP fits_object)
{
    fits_file_t * fits = R_ExternalPtrAddr (fits_object);

    if (NULL != fits && NULL != fits->cfitsio_ptr)
    {
	int hdu_type;

	fits_get_hdu_type (fits->cfitsio_ptr, &hdu_type,
			   &(fits->status));
	return mkString (hdu_type_name (hdu_type));
    }
    else
	return mkString (ERROR_STR);
}
