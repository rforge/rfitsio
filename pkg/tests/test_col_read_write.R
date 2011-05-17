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

file.name <- "table_read_write_test.fits"

######################################################################
# Part 1. Write the file

fits.obj <- createFITSFile(paste("!", file.name, sep = ""))

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

createTable(fits.obj, c("FLOAT1", "FLOAT2", "INT1", "INT2"), c("1D", "1D", "1I", "1I"))

writeColumn(fits.obj, "TDOUBLE", 1, 1, 1, 1:10, null.value = 3)
writeColumn(fits.obj, "TDOUBLE", 2, 1, 1, c(1, 2, NA, 4:10))
writeColumn(fits.obj, "TSHORT", 1, 1, 1, 1:10, null.value = 3)
writeColumn(fits.obj, "TSHORT", 2, 1, 1, c(1, 2, NA, 4:10))

closeFITSFile(fits.obj)

######################################################################
# Part 2. Read the file

fits.obj <- openFITSTable(file.name)
num.of.rows <- getNumOfRows(fits.obj)
table <- data.frame(col1 = readColumn(fits.obj, "TDOUBLE", 1, 1, 1, num.of.rows),
                    col2 = readColumn(fits.obj, "TDOUBLE", 1, 1, 1, num.of.rows),
                    col3 = readColumn(fits.obj, "TSHORT", 1, 1, 1, num.of.rows),
                    col4 = readColumn(fits.obj, "TSHORT", 1, 1, 1, num.of.rows))
closeFITSFile(fits.obj)

######################################################################
# Part 3. Check the file

table
