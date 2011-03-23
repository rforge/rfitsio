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

  if (getErrorStatus(fits.obj) != 0)
    warning(getErrorText(fits.obj))

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

  if (getErrorStatus(fits.obj) != 0)
    warning(getErrorText(fits.obj))

  return(fits.obj)
}

closeFITSFile <- function(fits.obj)
{
  if (! is.fits.obj(fits.obj))
    stop(.message.wrong.fits.obj.type)

  return(.Call(cfitsio_close_file, fits.obj))
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

  result <- .Call(cfitsio_get_num_hdus, fits.obj)

  if (getErrorStatus(fits.obj) != 0)
    warning(getErrorText(fits.obj))
  
  return(result)
}

getCurrentHDUNum <- function(fits.obj)
{
  if (! is.fits.obj(fits.obj))
    stop(.message.wrong.fits.obj.type)

  result <- .Call(cfitsio_get_hdu_num, fits.obj)

  if (getErrorStatus(fits.obj) != 0)
    warning(getErrorText(fits.obj))
  
  return(result);
}

getCurrentHDUType <- function(fits.obj)
{
  if (! is.fits.obj(fits.obj))
    stop(.message.wrong.fits.obj.type)

  result <- .Call(cfitsio_get_hdu_type, fits.obj)

  if (getErrorStatus(fits.obj) != 0)
    warning(getErrorText(fits.obj))
  
  return(result)
}

moveAbsHDU <- function(fits.obj, hdu.num)
{
  if (! is.fits.obj(fits.obj))
    stop(.message.wrong.fits.obj.type)

  result <- .Call(cfitsio_movabs_hdu, fits.obj, as.integer(hdu.num))

  if (getErrorStatus(fits.obj) != 0)
    warning(getErrorText(fits.obj))
  
  return(result)
}

moveRelHDU <- function(fits.obj, hdu.rel.num)
{
  if (! is.fits.obj(fits.obj))
    stop(.message.wrong.fits.obj.type)

  result <- .Call(cfitsio_movrel_hdu, fits.obj, as.integer(hdu.rel.num))

  if (getErrorStatus(fits.obj) != 0)
    warning(getErrorText(fits.obj))
  
  return(result)
}

moveNamedHDU <- function(fits.obj, hdu.type, ext.name, ext.ver = 0)
{
  if (! is.fits.obj(fits.obj))
    stop(.message.wrong.fits.obj.type)

  result <- .Call(cfitsio_movnam_hdu, fits.obj,
                  as.character (hdu.type),
                  as.character (ext.name),
                  as.integer(ext.ver))

  if (getErrorStatus(fits.obj) != 0)
    warning(getErrorText(fits.obj))
  
  return(result)
}

######################################################################
# R wrappers to functions in "src/hdr.c"

getNumOfKeys <- function(fits.obj)
{
  if (! is.fits.obj(fits.obj))
    stop(.message.wrong.fits.obj.type)

  result <- .Call(cfitsio_get_num_of_keys, fits.obj)

  if (getErrorStatus(fits.obj) != 0)
    warning(getErrorText(fits.obj))
  
  return(result)
}

getAvailableKeySlots <- function(fits.obj)
{
  if (! is.fits.obj(fits.obj))
    stop(.message.wrong.fits.obj.type)

  result <- .Call(cfitsio_get_available_key_slots, fits.obj)

  if (getErrorStatus(fits.obj) != 0)
    warning(getErrorText(fits.obj))
  
  return(result)
}

readRecord <- function(fits.obj, key.number)
{
  if (! is.fits.obj(fits.obj))
    stop(.message.wrong.fits.obj.type)

  result <- .Call(cfitsio_read_record, fits.obj, as.integer(key.number))

  if (getErrorStatus(fits.obj) != 0)
    warning(getErrorText(fits.obj))
  
  return(result)
}

readCard <- function(fits.obj, key.name)
{
  if (! is.fits.obj(fits.obj))
    stop(.message.wrong.fits.obj.type)

  result <- .Call(cfitsio_read_card, fits.obj, as.character(key.name))

  if (getErrorStatus(fits.obj) != 0)
    warning(getErrorText(fits.obj))
  
  return(result)
}

readKeyValue <- function(fits.obj, data.type, key.name)
{
  if (! is.fits.obj(fits.obj))
    stop(.message.wrong.fits.obj.type)

  result <- .Call(cfitsio_read_key, fits.obj,
               as.character(data.type),
               as.character(key.name), TRUE)

  if (getErrorStatus(fits.obj) != 0)
    warning(getErrorText(fits.obj))
  
  return(result)
}

readKeyComment <- function(fits.obj, key.name)
{
  if (! is.fits.obj(fits.obj))
    stop(.message.wrong.fits.obj.type)

  # TSTRING has no effect in the retrieval of the comment, but it
  # grants it can be used with every type of card.
  result <- .Call(cfitsio_read_key, fits.obj,
               "TSTRING", as.character(key.name), FALSE)

  if (getErrorStatus(fits.obj) != 0)
    warning(getErrorText(fits.obj))
  
  return(result)
}

######################################################################
# R wrappers to functions in "src/tables.c"

getNumOfRows <- function(fits.obj)
{
  if (! is.fits.obj(fits.obj))
    stop(.message.wrong.fits.obj.type)

  result <- .Call(cfitsio_get_num_rows, fits.obj)

  if (getErrorStatus(fits.obj) != 0)
    warning(getErrorText(fits.obj))
  
  return(result)
}

getNumOfColumns <- function(fits.obj)
{
  if (! is.fits.obj(fits.obj))
    stop(.message.wrong.fits.obj.type)

  result <- .Call(cfitsio_get_num_cols, fits.obj)

  if (getErrorStatus(fits.obj) != 0)
    warning(getErrorText(fits.obj))
  
  return(result)
}

getColumnNumber <- function(fits.obj, template, casesen = FALSE)
{
  if (! is.fits.obj(fits.obj))
    stop(.message.wrong.fits.obj.type)

  result <- .Call(cfitsio_get_colnum, fits.obj,
                  as.logical (casesen),
                  as.character (template))

  if (getErrorStatus(fits.obj) != 0)
    warning(getErrorText(fits.obj))
  
  return(result)
}

getColumnName <- function(fits.obj, template, casesen = FALSE)
{
  if (! is.fits.obj(fits.obj))
    stop(.message.wrong.fits.obj.type)

  result <- .Call(cfitsio_get_colname, fits.obj,
                  as.logical (casesen),
                  as.character (template))

  if (getErrorStatus(fits.obj) != 0)
    warning(getErrorText(fits.obj))
  
  return(result)
}

getColumnInformation <- function(fits.obj, column.num, equiv = FALSE)
{
  if (! is.fits.obj(fits.obj))
    stop(.message.wrong.fits.obj.type)

  f <- if(equiv) cfitsio_get_eqcoltype else cfitsio_get_coltype
  result <- .Call(f, fits.obj, as.integer (column.num))

  if (getErrorStatus(fits.obj) != 0)
    warning(getErrorText(fits.obj))
  
  return(result)
}    

readColumn <- function(fits.obj, data.type, column.num,
                       first.row, first.element, num.of.elements)
{
  if (! is.fits.obj(fits.obj))
    stop(.message.wrong.fits.obj.type)

  result <- .Call(cfitsio_read_col, fits.obj, data.type,
                  as.integer(column.num), as.integer(first.row),
                  as.integer(first.element), as.integer(num.of.elements))

  if (getErrorStatus(fits.obj) != 0)
    warning(getErrorText(fits.obj))
  
  return(result)
}

createTable <- function(fits.obj, column.types, column.form,
                        column.units = c(), extname = "", num.of.rows = 0,
                        binary = TRUE)
{
  if(! is.fits.obj(fits.obj))
    stop(.message.wrong.fits.obj.type)

  if(length(column.types) != length(column.form)
     || (length(column.units) > 0
         && (length(column.types) != length(column.units))))
     stop(paste("Mismatch in the number of elements",
                "among column.units, column.types",
                "(and column.units, if provided)"))
     
  fn <- if(binary) cfitsio_create_binary_tbl else cfitsio_create_ascii_tbl
  result <- .Call(fn,
                  fits.obj,
                  as.real(num.of.rows),
                  as.character(column.types),
                  as.character(column.form),
                  as.character(column.units),
                  as.character(extname))

  if (getErrorStatus(fits.obj) != 0)
    warning(getErrorText(fits.obj))
  
  return(result)
  
}

insertRows <- function(fits.obj, first.row, num)
{
  if(! is.fits.obj(fits.obj))
    stop(.message.wrong.fits.obj.type)

  # We use as.number instead of as.integer because of
  # values possibly greater than R's "integer" sizes
  result <- .Call(cfitsio_insert_rows,
                  fits.obj,
                  as.double(first.row),
                  as.double(num))

  if (getErrorStatus(fits.obj) != 0)
    warning(getErrorText(fits.obj))
  
  return(result)
}

deleteRows <- function(fits.obj, rows)
{
  if(! is.fits.obj(fits.obj))
    stop(.message.wrong.fits.obj.type)

  if(is.character(rows))
    result <- .Call(cfitsio_delete_rowrange,
                    fits.obj,
                    as.character(rows))
  else
    result <- .Call(cfitsio_delete_rowlist,
                    fits.obj,
                    sort(as.double(rows)))  # Note the `sort'!

  if (getErrorStatus(fits.obj) != 0)
    warning(getErrorText(fits.obj))
  
  return(result)
}

######################################################################
# R wrappers to functions in "src/img.c"

getImageType <- function(fits.obj, equiv = FALSE)
{
  if (! is.fits.obj(fits.obj))
    stop(.message.wrong.fits.obj.type)

  f <- if(equiv) cfitsio_get_img_equivtype else cfitsio_get_img_type
  result <- .Call(f, fits.obj)

  if (getErrorStatus(fits.obj) != 0)
    warning(getErrorText(fits.obj))
  
  return(result)
}

getImageDim <- function(fits.obj)
{
  if (! is.fits.obj(fits.obj))
    stop(.message.wrong.fits.obj.type)

  result <- .Call(cfitsio_get_img_dim, fits.obj)

  if (getErrorStatus(fits.obj) != 0)
    warning(getErrorText(fits.obj))
  
  return(result)
}

getImageSize <- function(fits.obj)
{
  if (! is.fits.obj(fits.obj))
    stop(.message.wrong.fits.obj.type)

  result <- .Call(cfitsio_get_img_size, fits.obj)

  if (getErrorStatus(fits.obj) != 0)
    warning(getErrorText(fits.obj))
  
  return(result)
}

createImage <- function(fits.obj, bits.per.pixel, dimensions)
{
  if (! is.fits.obj(fits.obj))
    stop(.message.wrong.fits.obj.type)

  result <- .Call(cfitsio_create_img,
                  as.integer(bits.per.pixel),
                  as.double(dimensions))

  if(getErrorStatus(fits.obj) != 0)
    warning(getErrorText(fits.obj))

  return(result)
}
