#!/bin/bash

SRC=exim-4.72.tar.bz2
DST=/var/spool/src/$SRC
MD5=ccc937b533568e5e8340f181a3b3d2ff

[ -s "$DST" ] || wget -O $DST ftp://ftp.exim.org/pub/exim/exim4/$SRC     \
              || wget -O $DST ftp://ftp.exim.org/pub/exim/exim4/old/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
