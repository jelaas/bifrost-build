#!/bin/bash

SRC=gdbm-1.8.3.tar.gz
DST=/var/spool/src/$SRC
MD5=1d1b1d5c0245b1c00aff92da751e9aa1

[ -s "$DST" ] || wget -O $DST ftp://ftp.sunet.se/pub/gnu/gdbm/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
