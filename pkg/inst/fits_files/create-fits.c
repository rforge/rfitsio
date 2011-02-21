/* -*- mode: c -*- */

/* Compile this program with
 *
 *   cc -o create-fits create-fits.c -lcfitsio -lm
 */

/* C program to create a number of FITS files useful for testing
 * RFITSIO.
 *
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

#include <fitsio.h>
#include <stdio.h>

void
create_logical_HDU (fitsfile * fptr, int * status)
{
    char * ttype[] = { "LOGIC", "BITS" };
    char * tform[] = { "1L", "4X" };
    char * tunit[] = { "BOOLEAN", "BITARR" };

    char array[] = { 1, 0, 1, 0, 1, 0, 1, 1 };
    const int array_size = sizeof(array) / sizeof(array[0]);

    char bit_array[] = { 1, 0, 0, 0, 0, 0, 0, 0,
			 0, 1, 0, 0, 0, 0, 0, 1,
			 0, 0, 1, 0, 0, 0, 1, 0,
			 0, 0, 0, 1, 0, 0, 1, 1,
			 0, 0, 0, 0, 1, 1, 0, 0,
			 0, 0, 0, 0, 0, 1, 0, 1,
			 0, 0, 0, 1, 0, 1, 1, 0,
			 0, 0, 1, 0, 0, 1, 1, 1 };
    const int bit_array_size = sizeof(bit_array) / sizeof(bit_array[0]);

    fits_create_tbl (fptr, BINARY_TBL, 0, 2,
		     ttype, tform, tunit,
		     "LOGICAL_TABLE", status);
    fits_write_col (fptr, TLOGICAL, 1, 1, 1, array_size, (void *) array, status);

    /* Set elements 2, 3 and 7 to NA (Not Available) */
    fits_write_col_null (fptr, 1, 2, 1, 2, status);
    fits_write_col_null (fptr, 1, 7, 1, 1, status);

    fits_write_col_bit (fptr, 2, 1, 1, bit_array_size, bit_array, status);
}

void
create_integer_HDU (fitsfile * fptr, int * status)
{
    char * ttype[] = { "SBYTE", "UBYTE", "SHORT", "USHORT", "LONG",  "ULONG", "INT64" };
    char * tform[] = { "1S",    "1B",    "1I",    "1U",     "1J",   "1V",   "1K" };
    char * tunit[] = { "INT1",  "INT2",  "INT3",  "INT4",   "INT5", "INT6", "INT7" };

    int i;

#define CREATE_ARRAY(name, c_type)		   \
    c_type name[] = { 0, 1, 2, 3, 4, 5, 6, 7, 8 };

    CREATE_ARRAY(sbyte_array,  signed   char);
    CREATE_ARRAY(ubyte_array,  unsigned char);
    CREATE_ARRAY(sshort_array, signed   short);
    CREATE_ARRAY(ushort_array, unsigned short);
    CREATE_ARRAY(slong_array,  signed   long);
    CREATE_ARRAY(ulong_array,  unsigned long);
    CREATE_ARRAY(llong_array,  LONGLONG);

    size_t array_size = sizeof(sbyte_array) / sizeof(sbyte_array[0]);

    /* Add some constants to each array in order to put each of the C
     * types to its boundary */
    for (i = 0; i < array_size; ++i)
    {
	sbyte_array [i] += 1   << 6;
	ubyte_array [i] += 1   << 7;
	sshort_array[i] += 1   << 14;
	ushort_array[i] += 1U  << 15;
	slong_array [i] += 1L  << 30;
	ulong_array [i] += 1UL << 31;
	llong_array [i] += 1LL << 62;
    }

    fits_create_tbl (fptr, BINARY_TBL, 0, sizeof(ttype) / sizeof(ttype[0]),
		     ttype, tform, tunit,
		     "INT_TABLE", status);

    fits_write_col (fptr, TSBYTE,    1, 1, 1, array_size, (void *) sbyte_array,  status);
    fits_write_col (fptr, TBYTE,     2, 1, 1, array_size, (void *) ubyte_array,  status);
    fits_write_col (fptr, TSHORT,    3, 1, 1, array_size, (void *) sshort_array, status);
    fits_write_col (fptr, TUSHORT,   4, 1, 1, array_size, (void *) ushort_array, status);
    fits_write_col (fptr, TLONG,     5, 1, 1, array_size, (void *) slong_array,  status);
    fits_write_col (fptr, TULONG,    6, 1, 1, array_size, (void *) ulong_array,  status);
    fits_write_col (fptr, TLONGLONG, 7, 1, 1, array_size, (void *) llong_array,  status);
}

void
create_real_HDU (fitsfile * fptr, int * status)
{
    char * ttype[] = { "FLOAT", "DOUBLE" };
    char * tform[] = { "1E",    "1D"     };
    char * tunit[] = { "e",     "pi"     };

    float  float_array[]  = { 1.0, 2.7182818284590452354, 1.23456789876543e+6 };
    double double_array[] = { 1.0, 3.1415926535897932385, 1.23456789876543e+51 };
    const size_t array_size = sizeof(float_array) / sizeof(float_array[0]);

    fits_create_tbl (fptr, BINARY_TBL, 0, 2,
		     ttype, tform, tunit,
		     "REAL_TABLE", status);

    fits_write_col (fptr, TFLOAT,  1, 1, 1, array_size, (void *) float_array,  status);
    fits_write_col (fptr, TDOUBLE, 2, 1, 1, array_size, (void *) double_array,  status);
}

void
create_complex_HDU (fitsfile * fptr, int * status)
{
    char * ttype[] = { "FLTC",   "DBLC"   };
    char * tform[] = { "1C",     "1M"     };
    char * tunit[] = { "CMPLX1", "CMPLX2" };

    float  float_array[]  = { 1.4142135623730950488, 1.7320508075688772935,
			      2.2360679774997896964, 2.2360679774997896964 };
    double double_array[] = { 2.6457513110645905905, 2.8284271247461900976,
			      3.1622776601683793320, 3.3166247903553998491 };
    const size_t array_size = sizeof(float_array) / sizeof(float_array[0]);

    fits_create_tbl (fptr, BINARY_TBL, 0, 2,
		     ttype, tform, tunit,
		     "COMPLEX_TABLE", status);

    fits_write_col (fptr, TCOMPLEX,    1, 1, 1, array_size >> 1, (void *) float_array,  status);
    fits_write_col (fptr, TDBLCOMPLEX, 2, 1, 1, array_size >> 1, (void *) double_array, status);
}

void
create_string_HDU (fitsfile * fptr, int * status)
{
    char * ttype[] = { "Character"  };
    char * tform[] = { "20A"        };
    char * tunit[] = { "First name" };

    char * array[] = { "Fyodor", "Dmitri", "Ivan", "Aleksey",
		       "Pavel", "Grushenka", "Katerina",
		       "Father Zosima", "Ilyusha" };
    const size_t array_size = sizeof(array) / sizeof(array[0]);

    fits_create_tbl (fptr, BINARY_TBL, 0, 1,
		     ttype, tform, tunit,
		     "COMPLEX_TABLE", status);

    fits_write_col_str (fptr, 1, 1, 1, array_size, array, status);
}

int
main (void)
{
    fitsfile * fptr;
    int status = 0;

    fits_create_file (&fptr, "!tables.fits", &status);

    fits_create_img (fptr, 8, 0, NULL, &status);

    create_logical_HDU (fptr, &status);
    create_integer_HDU (fptr, &status);
    create_real_HDU    (fptr, &status);
    create_complex_HDU (fptr, &status);
    create_string_HDU  (fptr, &status);

    fits_close_file (fptr, &status);

    if (status)
    {
	fits_report_error (stderr, status);
	status = 0;
    }

    return 0;
}
