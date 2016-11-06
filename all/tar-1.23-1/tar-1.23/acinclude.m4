dnl Special Autoconf macros for GNU Tar         -*- autoconf -*-
dnl Copyright (C) 2009 Free Software Foundation, Inc.
dnl
dnl GNU tar is free software; you can redistribute it and/or modify
dnl it under the terms of the GNU General Public License as published by
dnl the Free Software Foundation; either version 3, or (at your option)
dnl any later version.
dnl
dnl GNU tar is distributed in the hope that it will be useful,
dnl but WITHOUT ANY WARRANTY; without even the implied warranty of
dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
dnl GNU General Public License for more details.
dnl
dnl You should have received a copy of the GNU General Public License along
dnl with GNU tar.  If not, see <http://www.gnu.org/licenses/>.

AC_DEFUN([TAR_COMPR_PROGRAM],[
 m4_pushdef([tar_compr_define],translit($1,[a-z+-],[A-ZX_])[_PROGRAM])
 m4_pushdef([tar_compr_var],[tar_cv_compressor_]translit($1,[+-],[x_]))
 AC_ARG_WITH($1,
             AC_HELP_STRING([--with-]$1[=PROG],
	                    [use PROG as ]$1[ compressor program]),
             [tar_compr_var=${withval}],
	     [tar_compr_var=m4_if($2,,$1,$2)])
 AC_DEFINE_UNQUOTED(tar_compr_define, "$tar_compr_var",
                    [Define to the program name of ]$1[ compressor program])])
