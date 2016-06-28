#!/bin/bash

SRC=ntp-4.2.6p2.tar.gz
DST=/var/spool/src/$SRC
MD5=cf73cd85f248232c62f8029e6eb05938

pkg_install wget-1.15-3 || exit 2
[ -s "$DST" ] || wget --no-check-certificate -O $DST http://www.eecis.udel.edu/~ntp/ntp_spool/ntp4/ntp-4.2/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
