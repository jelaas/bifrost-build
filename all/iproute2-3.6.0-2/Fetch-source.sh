#!/bin/bash

SRC=iproute2-3.6.0.tar.bz2
DST=/var/spool/src/$SRC
MD5=cbb1d326ee73e21df5fd35d210d67f0a

pkg_install wget-1.12-2 || exit 2

[ -s "$DST" ] || wget -O $DST http://ftp.sunet.se/pub/Linux/distributions/bifrost/download/src/$SRC \
              || wget --no-check-certificate -O $DST https://www.kernel.org/pub/linux/utils/net/iproute2/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
