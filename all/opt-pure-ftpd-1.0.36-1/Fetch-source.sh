#!/bin/bash

SRC=pure-ftpd-1.0.36.tar.bz2
DST=/var/spool/src/$SRC
MD5=7899c75c1fed7dbad0352eb31080e066

[ -s "$DST" ] || wget -O $DST ftp://ftp.pureftpd.org/pub/pure-ftpd/releases/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
