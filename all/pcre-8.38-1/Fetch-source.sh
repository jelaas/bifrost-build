#!/bin/bash

SRC=pcre-8.38.tar.bz2
DST=/var/spool/src/$SRC
MD5=00aabbfe56d5a48b270f999b508c5ad2

pkg_install wget-1.15-1 || exit 2
[ -s "$DST" ] || wget -O $DST ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/$SRC   \
              || wget -O $DST http://downloads.sourceforge.net/project/pcre/pcre/8.02/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
