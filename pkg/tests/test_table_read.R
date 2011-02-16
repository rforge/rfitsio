# Test cases for file creation routines
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

library (rfitsio)

fits.obj <- openFITSFile("tables.fits")

if (getErrorStatus(fits.obj) == 0) {
  cat(paste("File was opened successfully, error status is",
             getErrorStatus(fits.obj),
             "and error string is",
             getErrorText(fits.obj),
             "\n"))
} else {
  cat(paste("Error in opening file, error status is",
            getErrorStatus(fits.obj),
            "and error string is",
            getErrorText(fits.obj),
            "\n"))
  q()
}

######################################################################
# TLOGICAL/TBIT columns

moveAbsHDU(fits.obj, 2)
num.of.rows.2 <- getNumOfRows(fits.obj)
num.of.columns.2 <- getNumOfColumns(fits.obj)

if (num.of.columns.2 != 2)
  error("Wrong number of columns in HDU#2")

log.col.1 <- readColumn(fits.obj, "TLOGICAL", 1, 1, 1, num.of.rows.2)
log.col.2 <- readColumn(fits.obj, "TBIT",     2, 1, 1, num.of.rows.2 * 8)

######################################################################
# Integer columns

moveAbsHDU(fits.obj, 3)
num.of.rows.3 <- getNumOfRows(fits.obj)
num.of.columns.3 <- getNumOfColumns(fits.obj)

if (num.of.columns.3 != 7)
  error("Wrong number of columns in HDU#3")

int.col.1 <- readColumn(fits.obj, "TSBYTE",    1, 1, 1, num.of.rows.3)
int.col.2 <- readColumn(fits.obj, "TBYTE",     2, 1, 1, num.of.rows.3)
int.col.3 <- readColumn(fits.obj, "TSHORT",    3, 1, 1, num.of.rows.3)
int.col.4 <- readColumn(fits.obj, "TUSHORT",   4, 1, 1, num.of.rows.3)
int.col.5 <- readColumn(fits.obj, "TLONG",     5, 1, 1, num.of.rows.3)
int.col.6 <- readColumn(fits.obj, "TULONG",    6, 1, 1, num.of.rows.3)
int.col.7 <- readColumn(fits.obj, "TLONGLONG", 7, 1, 1, num.of.rows.3)

######################################################################
# Real columns

moveAbsHDU(fits.obj, 4)
num.of.rows.4 <- getNumOfRows(fits.obj)
num.of.columns.4 <- getNumOfColumns(fits.obj)

if (num.of.columns.4 != 2)
  error("Wrong number of columns in HDU#4")

flt.col.1 <- readColumn(fits.obj, "TFLOAT",  1, 1, 1, num.of.rows.4)
flt.col.2 <- readColumn(fits.obj, "TDOUBLE", 2, 1, 1, num.of.rows.4)

######################################################################
# Complex columns

moveAbsHDU(fits.obj, 5)
num.of.rows.5 <- getNumOfRows(fits.obj)
num.of.columns.5 <- getNumOfColumns(fits.obj)

if (num.of.columns.5 != 2)
  error("Wrong number of columns in HDU#5")

cmp.col.1 <- readColumn(fits.obj, "TCOMPLEX",    1, 1, 1, num.of.rows.5)
cmp.col.2 <- readColumn(fits.obj, "TDBLCOMPLEX", 2, 1, 1, num.of.rows.5)

######################################################################
# String columns

moveAbsHDU(fits.obj, 6)
num.of.rows.6 <- getNumOfRows(fits.obj)
num.of.columns.6 <- getNumOfColumns(fits.obj)

if (num.of.columns != 1)
  error("Wrong number of columns in HDU#6")

str.col.1 <- readColumn(fits.obj, "TSTRING", 1, 1, 1, num.of.rows.6)

rm(fits.obj)
