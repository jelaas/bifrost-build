#!/bin/bash

SRC=openssh-6.1p1.tar.gz
DST=/var/spool/src/$SRC
MD5=3345cbf4efe90ffb06a78670ab2d05d5

[ -s "$DST" ] || wget -O $DST ftp://ftp.openbsd.org/pub/OpenBSD/OpenSSH/portable/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
