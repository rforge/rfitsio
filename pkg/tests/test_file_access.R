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

num.of.HDUs <- getNumOfHDUs(fits.obj)

for (i in 1:num.of.HDUs) {
  cat(sprintf("HDU #%d: type is %s\n", i, getCurrentHDUType(fits.obj)))
  if (i < num.of.HDUs)
    moveRelHDU(fits.obj, +1)
}

# Go back to the second HDU so we can test moveAbsHDU as well
moveAbsHDU(fits.obj, 2)

rm(fits.obj)
