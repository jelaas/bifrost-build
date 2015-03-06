#!/bin/bash

SRC=util-linux-2.22.2.tar.bz2
DST=/var/spool/src/$SRC
MD5=3e379b4d8b9693948d751c154614c73e

[ -s "$DST" ] || wget -O $DST ftp://ftp.kernel.org/pub/linux/utils/util-linux/v2.22/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
