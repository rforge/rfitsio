/* -*- mode: c -*- */

/* C wrappers to CFITSIO functions for reading/writing tables
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

/********************************************************************/

/* Wrapper to fits_get_num_rows and fits_get_num_cols */
#define IMPLEMENT_GET_NUM(wrapper_func,cfitsio_func,int_type)			\
SEXP										\
wrapper_func (SEXP fits_object)							\
{										\
    fits_file_t * fits = R_ExternalPtrAddr (fits_object);			\
										\
    if (NULL != fits && NULL != fits->cfitsio_ptr)				\
    {										\
	int_type num;								\
										\
	cfitsio_func (fits->cfitsio_ptr, &num, &(fits->status));		\
	return ScalarInteger (num);						\
    }										\
    else									\
	return ScalarInteger (-1);						\
}

IMPLEMENT_GET_NUM(cfitsio_get_num_rows, fits_get_num_rowsll, LONGLONG)
IMPLEMENT_GET_NUM(cfitsio_get_num_cols, fits_get_num_cols,   int)

/********************************************************************/

/* Wrapper to fits_get_colnum */
SEXP
cfitsio_get_colnum (SEXP fits_object,
		    SEXP case_sensitive,
		    SEXP template)
{
    fits_file_t * fits = R_ExternalPtrAddr (fits_object);
    int case_flag;

    case_flag = asLogical (case_sensitive) ? CASESEN : CASEINSEN;

    if (NULL != fits && NULL != fits->cfitsio_ptr)
    {
	int column_number;

	fits_get_colnum (fits->cfitsio_ptr,
			 case_flag,
			 (char *) NM(template),
			 &column_number,
			 &(fits->status));

	return ScalarInteger (column_number);
    }
    else
	return ScalarInteger (-1);   
}

/********************************************************************/

/* Wrapper to fits_get_colname */
SEXP
cfitsio_get_colname (SEXP fits_object,
		    SEXP case_sensitive,
		    SEXP template)
{
    fits_file_t * fits = R_ExternalPtrAddr (fits_object);
    int case_flag;

    case_flag = asLogical (case_sensitive) ? CASESEN : CASEINSEN;

    if (NULL != fits && NULL != fits->cfitsio_ptr)
    {
	char column_name[FLEN_VALUE + 1];
	int column_index;

	fits_get_colname (fits->cfitsio_ptr,
			  case_flag,
			  (char *) NM(template),
			  column_name,
			  &column_index,
			  &(fits->status));

	return mkString (column_name);
    }
    else
	return mkString ("");   
}

/********************************************************************/

/* Wrapper to fits_get_coltypell */
SEXP
get_coltype (SEXP fits_object,
	     SEXP column_number,
	     int (*fn) (fitsfile *, int, int *,
			LONGLONG *, LONGLONG *, int *))
{
    fits_file_t * fits = R_ExternalPtrAddr (fits_object);
    SEXP result;
    int type_code = -1;
    int var_len;
    LONGLONG repeat = -1;
    LONGLONG width = -1;
    SEXP type_code_sexp;
    SEXP repeat_sexp;
    SEXP width_sexp;
    SEXP var_len_sexp;
    SEXP names;

    if (NULL != fits && NULL != fits->cfitsio_ptr)
    {
	fn (fits->cfitsio_ptr,
	    asInteger (column_number),
	    &type_code,
	    &repeat,
	    &width,
	    &(fits->status));
    } /* "else" clause not needed: TYPE_CODE, REPEAT and WIDTH have
       * already been initialized */

    /* Allocate room for the result (a list of three elements) */
    PROTECT(result = allocVector (VECSXP, 4));

    /* Allocate room for each of the three elements that will go
     * into the result */
    ;
    PROTECT(type_code_sexp = mkString (typename_from_type (type_code,
							   &var_len)));
    PROTECT(repeat_sexp    = ScalarInteger (repeat));
    PROTECT(width_sexp     = ScalarInteger (width));
    PROTECT(var_len_sexp   = ScalarLogical (var_len));

    /* Set the three elements of the 'result' list */
    SET_VECTOR_ELT(result, 0, type_code_sexp);
    SET_VECTOR_ELT(result, 1, repeat_sexp);
    SET_VECTOR_ELT(result, 2, width_sexp);
    SET_VECTOR_ELT(result, 3, var_len_sexp);

    /* Set the names of each element in the list */
    PROTECT(names = allocVector (VECSXP, 4));
    SET_VECTOR_ELT(names, 0, mkString ("type"));
    SET_VECTOR_ELT(names, 1, mkString ("repeat.count"));
    SET_VECTOR_ELT(names, 2, mkString ("width"));
    SET_VECTOR_ELT(names, 3, mkString ("variable.length"));
    setAttrib (result, R_NamesSymbol, names);

    UNPROTECT(6);

    return result;
}

/* Wrapper to fits_get_coltypell */
SEXP
cfitsio_get_coltype (SEXP fits_object,
		     SEXP column_number)
{
    return get_coltype (fits_object, column_number, fits_get_coltypell);
}

/* Wrapper to fits_get_eqcoltypell */
SEXP
cfitsio_get_eqcoltype (SEXP fits_object,
		       SEXP column_number)
{
    return get_coltype (fits_object, column_number, fits_get_eqcoltypell);
}

/********************************************************************/

SEXP
cfitsio_read_col (SEXP fits_object,
		  SEXP data_type,
		  SEXP column_sexp,
		  SEXP first_row_sexp,
		  SEXP first_element_sexp,
		  SEXP num_of_elements_sexp)
{
    fits_file_t * fits = R_ExternalPtrAddr (fits_object);
    int type;
    int column;
    LONGLONG first_row;
    LONGLONG first_element;
    LONGLONG num_of_elements;
    LONGLONG element_size;
    char * null_array;

    if (NULL == fits || NULL == fits->cfitsio_ptr)
	return R_NilValue;

    column          = asInteger (column_sexp);
    first_row       = (LONGLONG) (asReal (first_row_sexp));
    first_element   = (LONGLONG) (asReal (first_element_sexp));
    num_of_elements = (LONGLONG) (asReal (num_of_elements_sexp));

    /* This will hold the positions of the NA elements in ARRAY */
    null_array = (char *) R_alloc (sizeof (null_array[0]), num_of_elements);

#define PLAIN_COPY(sexp_type, sexp_macro, c_type, NA)			\
    {									\
	SEXP result;							\
	c_type * array;							\
	int i;								\
	int any_null_value; /* Not used */				\
									\
	array = (c_type *) R_alloc (sizeof (c_type), num_of_elements);	\
	fits_read_colnull (fits->cfitsio_ptr, type,			\
		           column, first_row, first_element,		\
		           num_of_elements, (void *) array,		\
		           null_array, &any_null_value,			\
		           &(fits->status));				\
									\
	PROTECT(result = allocVector (sexp_type, num_of_elements));	\
	for (i = 0; i < num_of_elements; ++i)				\
	    sexp_macro(result)[i] = null_array[i] ? NA : array[i];      \
	UNPROTECT(1);							\
									\
	return result;							\
    }

#define COMPLEX_COPY(c_type)						\
    {									\
	SEXP result;							\
	c_type * array;							\
	int i;								\
	int any_null_value; /* Not used */				\
									\
	array = (c_type *) R_alloc (sizeof (c_type) * 2,		\
				    num_of_elements);			\
	fits_read_colnull (fits->cfitsio_ptr, type,			\
		           column, first_row, first_element,		\
		           num_of_elements, (void *) array,		\
		           null_array, &any_null_value,			\
		           &(fits->status));				\
									\
	PROTECT(result = allocVector (CPLXSXP, num_of_elements));	\
	for (i = 0; i < num_of_elements; ++i)				\
	{								\
	    if (null_array[i])						\
	    {								\
		COMPLEX(result)[i].r = NA_REAL;				\
		COMPLEX(result)[i].i = NA_REAL;				\
	    } else {							\
		COMPLEX(result)[i].r = array[2*i];			\
		COMPLEX(result)[i].i = array[2*i + 1];			\
	    }								\
	}								\
	UNPROTECT(1);							\
									\
	return result;							\
    }

    /* Initialize ELEMENT_SIZE to the size (in bytes) of one element
     * in ARRAY */
    type = type_from_typename (NM (data_type));
    switch (type)
    {
    case TBIT: {
	SEXP result;
	char * array;
	int i;

	array = (char *) R_alloc (sizeof (char), num_of_elements);
	fits_read_col_bit (fits->cfitsio_ptr, column, first_row,
			   first_element, num_of_elements, array,
			   &(fits->status));

	PROTECT(result = allocVector (LGLSXP, num_of_elements));
	for (i = 0; i < num_of_elements; ++i)
	   LOGICAL(result)[i] = array[i];
	UNPROTECT(1);

	return result;
    }
    case TLOGICAL:  PLAIN_COPY(LGLSXP,  LOGICAL, unsigned char,  NA_LOGICAL);

    case TBYTE:     PLAIN_COPY(INTSXP,  INTEGER, unsigned char,  NA_INTEGER);
    case TSBYTE:    PLAIN_COPY(INTSXP,  INTEGER, signed char,    NA_INTEGER);
    case TSHORT:    PLAIN_COPY(INTSXP,  INTEGER, signed short,   NA_INTEGER);
    case TUSHORT:   PLAIN_COPY(INTSXP,  INTEGER, unsigned short, NA_INTEGER);
    case TINT:      PLAIN_COPY(INTSXP,  INTEGER, signed int,     NA_INTEGER);
    case TUINT:     PLAIN_COPY(INTSXP,  INTEGER, unsigned int,   NA_INTEGER);
    case TLONG:     
    {
	if (sizeof (long) <= sizeof(int))
	{
	    PLAIN_COPY(INTSXP, INTEGER, signed long, NA_INTEGER);
	}
	else
	{
	    PLAIN_COPY(REALSXP, REAL, signed long, NA_REAL);
	}
    }

    case TULONG:
    {
	if (sizeof (long) <= sizeof(int))
	{
	    PLAIN_COPY(INTSXP, INTEGER, unsigned long, NA_INTEGER);
	}
	else
	{
	    PLAIN_COPY(REALSXP, REAL, unsigned long, NA_REAL);
	}
    }

    case TLONGLONG: 
    {
	if (sizeof (LONGLONG) <= sizeof(int))
	{
	    PLAIN_COPY(INTSXP, INTEGER, LONGLONG, NA_INTEGER);
	}
	else
	{
	    PLAIN_COPY(REALSXP, REAL, LONGLONG, NA_REAL);
	}
    }

    case TFLOAT:    PLAIN_COPY(REALSXP, REAL,    float,          NA_REAL);
    case TDOUBLE:   PLAIN_COPY(REALSXP, REAL,    double,         NA_REAL);

    case TSTRING: {
	SEXP result_array;
	char ** array;
	int i;
	int type_code = -1;
	LONGLONG repeat = -1;
	LONGLONG width = -1;

	/* Determine the length of each string in the specified column */
	fits_get_coltypell (fits->cfitsio_ptr, column, &type_code,
			    &repeat, &width, &(fits->status));

	/* Allocate room for each string */
	array = (char **) R_alloc (sizeof (char *), num_of_elements);
	for (i = 0; i < num_of_elements; ++i)
	    array[i] = (char *) R_alloc (sizeof (char), width);

	/* Read the column */
	fits_read_col_str (fits->cfitsio_ptr, column, first_row,
			   first_element, num_of_elements, "", array,
			   NULL, &(fits->status));

	/* Convert the array of C strings into a vector of R strings */
	PROTECT(result_array = allocVector (STRSXP, num_of_elements));
	for (i = 0; i < num_of_elements; ++i)
	    SET_STRING_ELT(result_array, i, mkChar (array[i]));
	UNPROTECT(1);

	return result_array;
    }

    case TCOMPLEX:	COMPLEX_COPY(float);
    case TDBLCOMPLEX:	COMPLEX_COPY(double);
    default:
	error ("Invalid value for 'data.type' in readColumn"); 
	return R_NilValue;
    }
}
#undef PLAIN_COPY
#undef COMPLEX_COPY

/********************************************************************/

/* Wrapper to fits_create_tbl */
SEXP
cfitsio_create_tbl (SEXP fits_object,
		    SEXP naxis2,
		    SEXP ttype,
		    SEXP tform,
		    SEXP tunit,
		    SEXP extname,
		    int ascii_flag)
{
    fits_file_t * fits = R_ExternalPtrAddr (fits_object);
    int i;
    char ** ttype_array;
    char ** tform_array;
    char ** tunit_array;

    if (NULL == fits || NULL == fits->cfitsio_ptr)
	return R_NilValue;

    ttype_array = (char **) R_alloc (sizeof (char *), length (ttype));
    tform_array = (char **) R_alloc (sizeof (char *), length (ttype));
    if (length(tunit) > 0)
	tunit_array = (char **) R_alloc (sizeof (char *), length (ttype));
    else
	tunit_array = NULL;

    for (i = 0; i < length(ttype); ++i)
    {
	ttype_array[i] = (char *) CHAR(STRING_ELT(ttype,i));
	tform_array[i] = (char *) CHAR(STRING_ELT(tform,i));
	if (tunit_array != NULL)
	    tunit_array[i] = (char *) CHAR(STRING_ELT(tunit,i));
    }

    fits_create_tbl (fits->cfitsio_ptr,
		     ascii_flag ? ASCII_TBL : BINARY_TBL,
		     (LONGLONG) (REAL(naxis2)[0]),
		     length(ttype),
		     ttype_array,
		     tform_array,
		     tunit_array,
		     (char *) NM(extname),
		     &(fits->status));

    return R_NilValue;
}

SEXP
cfitsio_create_ascii_tbl (SEXP fits_object,
			  SEXP naxis2,
			  SEXP ttype,
			  SEXP tform,
			  SEXP tunit,
			  SEXP extname)
{
    return cfitsio_create_tbl (fits_object,
			       naxis2,
			       ttype,
			       tform,
			       tunit,
			       extname,
			       1);
}

SEXP
cfitsio_create_binary_tbl (SEXP fits_object,
			   SEXP naxis2,
			   SEXP ttype,
			   SEXP tform,
			   SEXP tunit,
			   SEXP extname)
{
    return cfitsio_create_tbl (fits_object,
			       naxis2,
			       ttype,
			       tform,
			       tunit,
			       extname,
			       0);
}
		    
/********************************************************************/

/* Wrapper to fits_insert_rows */
SEXP
cfitsio_insert_rows (SEXP fits_object,
		     SEXP first_row,
		     SEXP num)
{
    fits_file_t * fits = R_ExternalPtrAddr (fits_object);

    if (NULL == fits || NULL == fits->cfitsio_ptr)
	return R_NilValue;

    fits_insert_rows (fits->cfitsio_ptr,
		      (LONGLONG) (REAL(first_row)[0]),
		      (LONGLONG) (REAL(num)[0]),
		      &(fits->status));

    return R_NilValue;
}

/********************************************************************/

SEXP
cfitsio_delete_rowrange (SEXP fits_object,
			 SEXP range_list)
{
    fits_file_t * fits = R_ExternalPtrAddr (fits_object);

    if (NULL == fits || NULL == fits->cfitsio_ptr)
	return R_NilValue;

    fits_delete_rowrange (fits->cfitsio_ptr,
			  (char *) NM(range_list),
			  &(fits->status));

    return R_NilValue;
}

/********************************************************************/

SEXP
cfitsio_delete_rowlist (SEXP fits_object,
			SEXP row_list_sexp)
{
    fits_file_t * fits = R_ExternalPtrAddr (fits_object);
    LONGLONG * row_list;
    LONGLONG i;

    if (NULL == fits || NULL == fits->cfitsio_ptr)
	return R_NilValue;

    row_list = (LONGLONG *) R_alloc (length (row_list_sexp), sizeof (long));
    for (i = 0; i < length (row_list_sexp); ++i)
	row_list[i] = (LONGLONG) (REAL(row_list_sexp)[i]);

    fits_delete_rowlistll (fits->cfitsio_ptr,
			   row_list,
			   length (row_list_sexp),
			   &(fits->status));

    return R_NilValue;
}

/********************************************************************/

SEXP
cfitsio_write_col (SEXP fits_object,
		   SEXP data_type_sexp,
		   SEXP col_num_sexp,
		   SEXP first_row_sexp,
		   SEXP first_elem_sexp,
		   SEXP array_sexp,
		   SEXP null_value_sexp)
{
    fits_file_t * fits = R_ExternalPtrAddr (fits_object);
    int type;
    int col_num;
    LONGLONG first_row;
    LONGLONG first_elem;

    if (NULL == fits || NULL == fits->cfitsio_ptr)
	return R_NilValue;

    col_num = INTEGER(col_num_sexp)[0];
    first_row = (LONGLONG) (REAL(first_row_sexp)[0]);
    first_elem = (LONGLONG) (REAL(first_elem_sexp)[0]);
    
#define PLAIN_WRITE(sexp_macro, c_type, r_conv, c_conv)			\
    {									\
	SEXP conv_sexp = r_conv(array_sexp);				\
	c_type null_value = c_conv(null_value_sexp);			\
	c_type * array;							\
	LONGLONG i;							\
									\
	array = (c_type *) R_alloc (sizeof (c_type),			\
				    length(conv_sexp));			\
	for (i = 0; i < length(conv_sexp); ++i)	{			\
	    c_type cur_value = sexp_macro(conv_sexp)[i];		\
	    if (R_finite(cur_value))					\
		array[i] = sexp_macro(conv_sexp)[i];			\
	    else							\
		array[i] = null_value;					\
	}								\
									\
	if (! isNull(null_value_sexp))					\
	{								\
	    fits_write_colnull (fits->cfitsio_ptr, type,		\
				col_num, first_row, first_elem,		\
				length(conv_sexp),			\
				(void *) array,				\
				&null_value,				\
				&(fits->status));			\
	} else								\
	    fits_write_col (fits->cfitsio_ptr, type,			\
			    col_num, first_row, first_elem,		\
			    length(conv_sexp),				\
			    (void *) array,				\
			    &(fits->status));				\
									\
	break;								\
    }

#define COMPLEX_WRITE(c_type)						\
    {									\
	SEXP conv_sexp = AS_COMPLEX(array_sexp);			\
	c_type null_value[2];						\
	c_type * array;							\
	LONGLONG i;							\
									\
	null_value[0] = asComplex(null_value_sexp).r;			\
	null_value[1] = asComplex(null_value_sexp).i;			\
									\
	array = (c_type *) R_alloc (sizeof (c_type) * 2,		\
				    length(conv_sexp));			\
	for (i = 0; i < length(conv_sexp); ++i)				\
	{								\
	    array[2*i]   = COMPLEX(conv_sexp)[i].r;			\
	    array[2*i+1] = COMPLEX(conv_sexp)[i].i;			\
	}								\
									\
	if (! isNull(null_value_sexp))					\
	{								\
	    fits_write_colnull (fits->cfitsio_ptr, type,		\
				col_num, first_row, first_elem,		\
				length(conv_sexp),			\
				(void *) array,				\
				&null_value,				\
				&(fits->status));			\
	} else								\
	    fits_write_col (fits->cfitsio_ptr, type,			\
			    col_num, first_row, first_elem,		\
			    length(conv_sexp),				\
			    (void *) array,				\
			    &(fits->status));				\
									\
	break;								\
    }

    /* Initialize ELEMENT_SIZE to the size (in bytes) of one element
     * in ARRAY */
    type = type_from_typename (NM (data_type_sexp));
    switch (type)
    {
    case TBIT:
    {
	SEXP conv_sexp = AS_LOGICAL(array_sexp);
	char * array;
	LONGLONG i;

	array = R_alloc (sizeof (char), length(conv_sexp));
	for (i = 0; i < length(conv_sexp); ++i)
	    array[i] = LOGICAL(conv_sexp)[i];

	fits_read_col_bit (fits->cfitsio_ptr, col_num, first_row,
			   first_elem, length(conv_sexp), array,
			   &(fits->status));

	break;
    }

    case TLOGICAL:  PLAIN_WRITE(LOGICAL, unsigned char,  AS_LOGICAL, asLogical);
    case TBYTE:     PLAIN_WRITE(INTEGER, unsigned char,  AS_INTEGER, asInteger);
    case TSBYTE:    PLAIN_WRITE(INTEGER, signed char,    AS_INTEGER, asInteger);
    case TSHORT:    PLAIN_WRITE(INTEGER, signed short,   AS_INTEGER, asInteger);
    case TUSHORT:   PLAIN_WRITE(INTEGER, unsigned short, AS_INTEGER, asInteger);
    case TINT:      PLAIN_WRITE(INTEGER, signed int,     AS_INTEGER, asInteger);
    case TUINT:     PLAIN_WRITE(INTEGER, unsigned int,   AS_INTEGER, asInteger);
    case TLONG:     PLAIN_WRITE(REAL,    signed long,    AS_NUMERIC, asReal);
    case TULONG:    PLAIN_WRITE(REAL,    unsigned long,  AS_NUMERIC, asReal);
    case TLONGLONG: PLAIN_WRITE(REAL,    LONGLONG,       AS_NUMERIC, asReal);
    case TFLOAT:    PLAIN_WRITE(REAL,    float,          AS_NUMERIC, asReal);
    case TDOUBLE:   PLAIN_WRITE(REAL,    double,         AS_NUMERIC, asReal);

    case TSTRING: {
	char ** array;
	LONGLONG i;

	array = (char **) R_alloc (sizeof (char *), length(array_sexp));
	for (i = 0; i < length(array_sexp); ++i)
	    array[i] = (char *) CHAR(STRING_ELT(array_sexp, i));

	/* Read the column */
	if (! isNull (null_value_sexp))
	{
	    fits_write_colnull_str (fits->cfitsio_ptr, col_num, first_row,
				    first_elem, length(array_sexp),
				    array, (char *) NM(asChar(null_value_sexp)),
				    &(fits->status));
	} else
	{
	    fits_write_col_str (fits->cfitsio_ptr, col_num, first_row,
				first_elem, length(array_sexp),
				array, &(fits->status));
	}

	break;
    }

    case TCOMPLEX:	COMPLEX_WRITE(float);
    case TDBLCOMPLEX:	COMPLEX_WRITE(double);
    default:
	error ("Invalid value for 'data.type' in readColumn"); 
    }

    return R_NilValue;
}
#undef PLAIN_WRITE
#undef COMPLEX_WRITE
