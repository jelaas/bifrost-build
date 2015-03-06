#!/bin/bash

SRC=openssh-5.5p1.tar.gz
DST=/var/spool/src/$SRC
MD5=88633408f4cb1eb11ec7e2ec58b519eb

[ -s "$DST" ] || wget -O $DST ftp://ftp.openbsd.org/pub/OpenBSD/OpenSSH/portable/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
