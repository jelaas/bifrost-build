#!/bin/bash

SRC=iproute2-3.17.0.tar.gz
DST=/var/spool/src/$SRC
MD5=e55ebbeaa2ebc307e4fd5a575d729430

pkg_install wget-1.12-2 || exit 2

[ -s "$DST" ] || wget -O $DST http://ftp.sunet.se/pub/Linux/distributions/bifrost/download/src/$SRC \
              || wget --no-check-certificate -O $DST https://www.kernel.org/pub/linux/utils/net/iproute2/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
