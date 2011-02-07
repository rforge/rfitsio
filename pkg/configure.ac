## Process this file with autoconf to produce a configure script.
##

AC_PREREQ(2.61)

## ---[ VERSION ]-------------------------------------------------------------

AC_INIT([RFITSIO], 1.0.0)

dnl Select an optional include path, from a configure option
dnl or from an environment variable.
AC_ARG_WITH([cfitsio-include],
	AC_HELP_STRING([--with-cfitsio-include=INCLUDE_PATH],
                       [the location of CFITSIO header files]),
                       [cfitsio_include_path=$withval])

CFITSIO_CPPFLAGS="-I."
if test [ -n "$cfitsio_include_path" ] ; then 
   CFITSIO_CPPFLAGS="-I. -I${cfitsio_include_path}"
else
   if test [ -n "${CFITSIO_INCLUDE}" ] ; then
      CFITSIO_CPPFLAGS="-I. -I${CFITSIO_INCLUDE}"
   fi
fi

dnl ditto for a library path
AC_ARG_WITH([cfitsio-lib],
	AC_HELP_STRING([--with-cfitsio-lib=LIB_PATH],
                       [the location of CFITSIO library files]),
                       [cfitsio_lib_path=$withval])

if test [ -n "$cfitsio_lib_path" ] ; then 
   LIBS="-L${cfitsio_lib_path} ${LIBS}"
else
   if test [ -n "${CFITSIO_LIBS}" ] ; then
      LIBS="-L${cfitsio_lib_path} ${CFITSIO_LIBS}"
   fi
fi

## pick up compiler as will be used by R CMD INSTALL/SHLIB
if test -n "${R_HOME}"; then
  CC=`${R_HOME}/bin/R CMD config CC`
  CPP=`${R_HOME}/bin/R CMD config CPP`
  CFLAGS=`${R_HOME}/bin/R CMD config CFLAGS`
  CXX=`${R_HOME}/bin/R CMD config CXX`
  CXXFLAGS=`${R_HOME}/bin/R CMD config CXXFLAGS`
fi

CPPFLAGS="${CPPFLAGS} ${CFITSIO_CPPFLAGS}"

AC_CHECK_HEADER([fitsio.h], , [AC_MSG_ERROR([Unable to find fitsio.h, are you sure you have CFITSIO installed?])])
AC_CHECK_LIB([cfitsio], [ffclos], , [AC_MSG_ERROR([cfitsio library not found])])

## --- Output ----------------------------------------------------------------
AC_SUBST(CFITSIO_CPPFLAGS)
AC_SUBST(CFITSIO_LIBS)

AC_SUBST(CPPFLAGS)
AC_SUBST(CXXFLAGS)
AC_SUBST(LIBS)

AC_OUTPUT(src/Makevars)
