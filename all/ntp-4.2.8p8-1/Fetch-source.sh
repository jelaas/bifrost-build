#!/bin/bash

SRC=ntp-4.2.8p8.tar.gz
DST=/var/spool/src/$SRC
MD5=4a8636260435b230636f053ffd070e34

pkg_install wget-1.15-3 || exit 2
[ -s "$DST" ] || wget --no-check-certificate -O $DST http://www.eecis.udel.edu/~ntp/ntp_spool/ntp4/ntp-4.2/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
