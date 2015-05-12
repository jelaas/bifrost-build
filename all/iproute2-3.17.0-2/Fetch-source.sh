#!/bin/bash

SRC=iproute2-3.17.0.tar.gz
DST=/var/spool/src/$SRC

pkg_install wget-1.12-2 || exit 2

[ -s "$DST" ] || wget -O $DST http://ftp.sunet.se/pub/Linux/distributions/bifrost/download/src/$SRC || \
 wget --no-check-certificate -O $DST https://www.kernel.org/pub/linux/utils/net/iproute2/$SRC
