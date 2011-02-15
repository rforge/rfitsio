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

#include "rfitsio.h"

/********************************************************************/

/* Return the CFITSIO type for a given type name */
int type_from_typename (const char * name)
{
#define EMIT_CODE_FOR_TYPE(match)  \
    if (strcmp (name, #match) == 0) \
        return match;

    EMIT_CODE_FOR_TYPE(TBIT);
    EMIT_CODE_FOR_TYPE(TBYTE);
    EMIT_CODE_FOR_TYPE(TLOGICAL);
    EMIT_CODE_FOR_TYPE(TSTRING);
    EMIT_CODE_FOR_TYPE(TSHORT);
    EMIT_CODE_FOR_TYPE(TLONG);
    EMIT_CODE_FOR_TYPE(TLONGLONG);
    EMIT_CODE_FOR_TYPE(TFLOAT);
    EMIT_CODE_FOR_TYPE(TDOUBLE);
    EMIT_CODE_FOR_TYPE(TCOMPLEX);
    EMIT_CODE_FOR_TYPE(TDBLCOMPLEX);
    EMIT_CODE_FOR_TYPE(TINT);
    EMIT_CODE_FOR_TYPE(TSBYTE);
    EMIT_CODE_FOR_TYPE(TUINT);
    EMIT_CODE_FOR_TYPE(TUSHORT);
    EMIT_CODE_FOR_TYPE(TULONG);
    EMIT_CODE_FOR_TYPE(TINT32BIT);

#undef EMIT_CODE_FOR_TYPE

    return -1;
}

/********************************************************************/

/* Return a descriptive name for each CFITSIO type. If var_len_flag is
 * not null, it will be set to nonzero if TYPE specifies a variable
 * length array. */
const char *
typename_from_type (int type, int * var_len_flag)
{
    int abs_type = type >= 0 ? type : -type;

    if (var_len_flag)
	*var_len_flag = (abs_type != type);

#define EMIT_CODE_FOR_TYPE(match) \
    if (abs_type == match) \
	return #match;

    EMIT_CODE_FOR_TYPE(TBIT);
    EMIT_CODE_FOR_TYPE(TBYTE);
    EMIT_CODE_FOR_TYPE(TLOGICAL);
    EMIT_CODE_FOR_TYPE(TSTRING);
    EMIT_CODE_FOR_TYPE(TSHORT);
    EMIT_CODE_FOR_TYPE(TLONG);
    EMIT_CODE_FOR_TYPE(TLONGLONG);
    EMIT_CODE_FOR_TYPE(TFLOAT);
    EMIT_CODE_FOR_TYPE(TDOUBLE);
    EMIT_CODE_FOR_TYPE(TCOMPLEX);
    EMIT_CODE_FOR_TYPE(TDBLCOMPLEX);
    EMIT_CODE_FOR_TYPE(TINT);
    EMIT_CODE_FOR_TYPE(TSBYTE);
    EMIT_CODE_FOR_TYPE(TUINT);
    EMIT_CODE_FOR_TYPE(TUSHORT);
    EMIT_CODE_FOR_TYPE(TULONG);
    EMIT_CODE_FOR_TYPE(TINT32BIT);

#undef EMIT_CODE_FOR_TYPE

    return "UNKNOWN";
}