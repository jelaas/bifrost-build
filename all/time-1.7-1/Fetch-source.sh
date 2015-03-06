#!/bin/bash

SRC=time-1.7.tar.gz
DST=/var/spool/src/$SRC
MD5=e38d2b8b34b1ca259cf7b053caac32b3

[ -s "$DST" ] || wget -O $DST ftp://ftp.sunet.se/pub/gnu/time/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
