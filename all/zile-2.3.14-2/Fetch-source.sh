#!/bin/bash

SRC=zile-2.3.14.tar.gz
DST=/var/spool/src/$SRC
MD5=88322abbb8146f3c4e7bb31fa4d351c6

[ -s "$DST" ] || wget -O $DST ftp://ftp.sunet.se/pub/gnu/zile/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
