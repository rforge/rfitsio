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

library (RFITSIO)

fits.obj <- RFITSIO::openFile("/Users/tomasi/work/test_data/foreground-maps/dmr/dmr_31a_imap_4yr.fits dmr_53a_imap_4yr.fits")

cat(paste ("File was opened successfully, error status is",
           RFITSIO::getErrorStatus(fits.obj),
           "and error string is",
           RFITSIO::getErrorText(fits.obj),
           "\n"))

rm(fits.obj)
