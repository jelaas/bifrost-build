#!/bin/bash

SRC=libmnl-1.0.3.tar.bz2
DST=/var/spool/src/$SRC
MD5=7d95fc3bea3365bc03c48e484224f65f

[ -s "$DST" ] || wget -O $DST ftp://ftp.netfilter.org/pub/libmnl/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
