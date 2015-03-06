#!/bin/bash

SRC=fetchmail-6.3.26.tar.bz2
DST=/var/spool/src/$SRC
MD5=d9ae3d939205a3c06a21ea79b8f14793

[ -s "$DST" ] || wget -O $DST http://distro.ibiblio.org/slitaz/sources/packages/f/$SRC \
              || wget -O $DST ftp://gentoo.kiev.ua/distfiles/$SRC   \
              || wget -O $DST http://www.openadk.org/distfiles/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
