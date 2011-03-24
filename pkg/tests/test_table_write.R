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

fits.obj <- createFITSFile("table_write_test.fits")

if (getErrorStatus(fits.obj) == 0) {
  cat(paste("File was created successfully, error status is",
             getErrorStatus(fits.obj),
             "and error string is",
             getErrorText(fits.obj),
             "\n"))
} else {
  cat(paste("Error in creating the file, error status is",
            getErrorStatus(fits.obj),
            "and error string is",
            getErrorText(fits.obj),
            "\n"))
  q()
}

createTable(fits.obj, c("FLOAT", "INT"), c("1D", "1I"))

insertRows(fits.obj, 0, 10)
getNumOfRows(fits.obj) == 10

deleteRows(fits.obj, 2:4)
getNumOfRows(fits.obj) == 7

deleteRows(fits.obj, "1,4-5")
getNumOfRows(fits.obj) == 4

closeFITSFile(fits.obj)
