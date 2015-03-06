#!/bin/bash

SRC=util-linux-ng-2.17.2.tar.bz2
DST=/var/spool/src/$SRC
MD5=4635725a3eef1c57090bac8ea5e082e6

[ -s "$DST" ] || wget -O $DST ftp://ftp.kernel.org/pub/linux/utils/util-linux/v2.17/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
