#!/bin/bash

SRC=util-linux-2.20.1.tar.bz2
DST=/var/spool/src/$SRC
MD5=079b37517fd4e002a2e6e992e8b4e361

[ -s "$DST" ] || wget -O $DST ftp://ftp.kernel.org/pub/linux/utils/util-linux/v2.20/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
