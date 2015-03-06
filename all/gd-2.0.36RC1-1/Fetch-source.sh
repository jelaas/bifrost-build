#!/bin/bash

SRC=gd-2.0.36RC1.tar.bz2
DST=/var/spool/src/$SRC
MD5=e876979ca3130623a4e7866d9579171a

[ -s "$DST" ] || wget -O $DST http://ring.u-toyama.ac.jp/archives/graphics/gd/$SRC \
              || wget -O $DST ftp://ring.ix.oita-u.ac.jp/archives/graphics/gd/$SRC \
              || wget -O $DST ftp://distro.ibiblio.org/tinycorelinux/2.x/tce/src/libgd/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
