#!/bin/bash

SRC=gcc-5.3.0.tar.bz2
DST=/var/spool/src/$SRC
MD5=c9616fd448f980259c31de613e575719

[ -s "$DST" ] || wget -O $DST ftp://ftp.gnu.org/pub/gnu/gcc/gcc-5.3.0/$SRC \
              || wget -O $DST http://pkgs.fedoraproject.org/repo/pkgs/mingw-gcc/gcc-5.3.0.tar.bz2/c9616fd448f980259c31de613e575719/$SRC \
              || wget -O $DST http://artfiles.org/cygwin.org/pub/gcc/releases/gcc-5.3.0/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
