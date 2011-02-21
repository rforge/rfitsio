#ifndef RFITSIO_H
#define RFITSIO_H

#define ERROR_STR    "ERROR"            /* Used by functions returning a string */

#include <Rinternals.h>                 /* For SEXP */
#include <fitsio.h>                     /* For 'fitsfile' */

#define NM(x)      CHAR(STRING_ELT(x,0))

typedef struct {
    fitsfile * cfitsio_ptr;             /* "fitsfile" is a structure defined in fitsio.h  */
    int        status;                  /* Error status as returned by CFITSIO */
} fits_file_t;

/* Defined in "types.c" */
int type_from_typename (const char * name);
const char * typename_from_type (int type, int * var_len_flag);
SEXP sexp_from_void_ptr (const void * data, int type);

#endif /* RFITSIO_H */
