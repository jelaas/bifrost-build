#!/bin/bash

SRC=fetchmail-6.3.26.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://distro.ibiblio.org/slitaz/sources/packages/f/$SRC \
              || wget -O $DST ftp://gentoo.kiev.ua/distfiles/$SRC \
              || wget -O $DST http://www.openadk.org/distfiles/$SRC
