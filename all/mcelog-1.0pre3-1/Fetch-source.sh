#!/bin/bash

SRC=mcelog-1.0pre3.tar.bz2
DST=/var/spool/src/$SRC
MD5=dbdf6507eb34ebc4ce7c583ef6c568c5

[ -s "$DST" ] || wget -O $DST http://www.kernel.org/pub/linux/utils/cpu/mce/$SRC \
              || wget -O $DST http://ftp.sunet.se/pub/Linux/distributions/bifrost/download/src/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
