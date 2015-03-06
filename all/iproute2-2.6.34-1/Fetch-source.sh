#!/bin/bash

SRC=iproute2-2.6.34.tar.bz2
DST=/var/spool/src/$SRC
MD5=5c5742bdac05a1688f266512e685b83c

[ -s "$DST" ] || wget -O $DST http://ftp.sunet.se/pub/Linux/distributions/bifrost/download/src/$SRC \
              || wget -O $DST http://devresources.linuxfoundation.org/dev/iproute2/download/$SRC    \
 || ../../wget-finder -O $DST $SRC:$MD5
