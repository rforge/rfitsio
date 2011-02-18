# R wrappers to the CFITSIO library
# Copyright (C) 2011 Maurizio Tomasi
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

`.fitsio.object.type` <- "cfitsio_obj"

is.fits.obj <- function (fits.obj)
{
  return (class(fits.obj) == .fitsio.object.type)
}

.message.wrong.fits.obj.type <- "Parameter 'fits.obj' must be a RFITSIO object"

######################################################################
# R wrappers to functions in "src/file_access.c"

# Private function: it is used by openFile, openData,
# openImage and openTable
`.open` <- function(c.function, file.name, mode)
{
  fits.obj <- .Call(c.function, file.name, as.character(mode))
  class(fits.obj) <- .fitsio.object.type
  return(fits.obj)
}

openFITSFile <- function(file.name, mode = "READONLY")
{
  return (.open(cfitsio_open_file, file.name, mode))
}

openFITSData <- function(file.name, mode = "READONLY")
{
  return (.open(cfitsio_open_data, file.name, mode))
}

openFITSImage <- function(file.name, mode = "READONLY")
{
  return (.open(cfitsio_open_image, file.name, mode))
}

openFITSTable <- function(file.name, mode = "READONLY")
{
  return (.open(cfitsio_open_table, file.name, mode))
}

createFITSFile <- function(file.name)
{
  fits.obj <- .Call(cfitsio_create_file, as.character (file.name))
  class(fits.obj) <- "cfitsio_obj"
  return(fits.obj)
}

######################################################################
# R wrappers to functions in "src/error.c"

getErrorStatus <- function(fits.obj, reset = FALSE)
{
  if (! is.fits.obj(fits.obj))
    stop(.message.wrong.fits.obj.type)

  return(.Call(cfitsio_get_errstatus, fits.obj,
               as.logical (reset)))
}

getErrorText <- function(fits.obj, reset = FALSE)
{
  if (! is.fits.obj(fits.obj))
    stop(.message.wrong.fits.obj.type)

  return(.Call(cfitsio_get_errtext, fits.obj,
               as.logical (reset)))
}

resetErrorStatus <- function(fits.obj)
{
  if (! is.fits.obj(fits.obj))
    stop(.message.wrong.fits.obj.type)

  .Call(cfitsio_reset_error_status, fits.obj)
}

getCFITSIOVersion <- function()
{
  return(.Call("cfitsio_get_version"))
}

######################################################################
# R wrappers to functions in "src/hdu.c"

getNumOfHDUs <- function(fits.obj)
{
  if (! is.fits.obj(fits.obj))
    stop(.message.wrong.fits.obj.type)

  return(.Call(cfitsio_get_num_hdus, fits.obj))
}

getCurrentHDUNum <- function(fits.obj)
{
  if (! is.fits.obj(fits.obj))
    stop(.message.wrong.fits.obj.type)

  return(.Call(cfitsio_get_hdu_num, fits.obj))
}

getCurrentHDUType <- function(fits.obj)
{
  if (! is.fits.obj(fits.obj))
    stop(.message.wrong.fits.obj.type)

  return(.Call(cfitsio_get_hdu_type, fits.obj))
}

moveAbsHDU <- function(fits.obj, hdu.num)
{
  if (! is.fits.obj(fits.obj))
    stop(.message.wrong.fits.obj.type)

  return(.Call(cfitsio_movabs_hdu, fits.obj, as.integer(hdu.num)))
}

moveRelHDU <- function(fits.obj, hdu.rel.num)
{
  if (! is.fits.obj(fits.obj))
    stop(.message.wrong.fits.obj.type)

  return(.Call(cfitsio_movrel_hdu, fits.obj, as.integer(hdu.rel.num)))
}

moveNamedHDU <- function(fits.obj, hdu.type, ext.name, ext.ver = 0)
{
  if (! is.fits.obj(fits.obj))
    stop(.message.wrong.fits.obj.type)

  return(.Call(cfitsio_movnam_hdu, fits.obj,
               as.character (hdu.type),
               as.character (ext.name),
               as.integer(ext.ver)))
}

######################################################################
# R wrappers to functions in "src/hdr.c"

getNumOfKeys <- function(fits.obj)
{
  if (! is.fits.obj(fits.obj))
    stop(.message.wrong.fits.obj.type)

  return(.Call(cfitsio_get_num_of_keys, fits.obj))
}

getAvailableKeySlots <- function(fits.obj)
{
  if (! is.fits.obj(fits.obj))
    stop(.message.wrong.fits.obj.type)

  return(.Call(cfitsio_get_available_key_slots, fits.obj))
}

readRecord <- function(fits.obj, key.number)
{
  if (! is.fits.obj(fits.obj))
    stop(.message.wrong.fits.obj.type)

  return(.Call(cfitsio_read_record, fits.obj, as.integer(key.number)))
}

readCard <- function(fits.obj, key.name)
{
  if (! is.fits.obj(fits.obj))
    stop(.message.wrong.fits.obj.type)

  return(.Call(cfitsio_read_card, fits.obj, as.character(key.name)))
}

######################################################################
# R wrappers to functions in "src/tables.c"

getNumOfRows <- function(fits.obj)
{
  if (! is.fits.obj(fits.obj))
    stop(.message.wrong.fits.obj.type)

  return(.Call(cfitsio_get_num_rows, fits.obj))
}

getNumOfColumns <- function(fits.obj)
{
  if (! is.fits.obj(fits.obj))
    stop(.message.wrong.fits.obj.type)

  return(.Call(cfitsio_get_num_cols, fits.obj))
}

getColumnNumber <- function(fits.obj, template, casesen = FALSE)
{
  if (! is.fits.obj(fits.obj))
    stop(.message.wrong.fits.obj.type)

  return(.Call(cfitsio_get_colnum, fits.obj,
               as.logical (casesen),
               as.character (template)))
}

getColumnName <- function(fits.obj, template, casesen = FALSE)
{
  if (! is.fits.obj(fits.obj))
    stop(.message.wrong.fits.obj.type)

  return(.Call(cfitsio_get_colname, fits.obj,
               as.logical (casesen),
               as.character (template)))
}

getColumnInformation <- function(fits.obj, column.num)
{
  if (! is.fits.obj(fits.obj))
    stop(.message.wrong.fits.obj.type)

  return(.Call(cfitsio_get_coltype, fits.obj, as.integer (column.num)));
}    

getEqColumnInformation <- function(fits.obj, column.num)
{
  if (! is.fits.obj(fits.obj))
    stop(.message.wrong.fits.obj.type)

  return(.Call(cfitsio_get_eqcoltype, fits.obj, as.integer (column.num)));
}    

readColumn <- function(fits.obj, data.type, column.num,
                       first.row, first.element, num.of.elements)
{
  if (! is.fits.obj(fits.obj))
    stop(.message.wrong.fits.obj.type)

  return(.Call(cfitsio_read_col, fits.obj, data.type,
               as.integer(column.num), as.integer(first.row),
               as.integer(first.element), as.integer(num.of.elements)));
}
