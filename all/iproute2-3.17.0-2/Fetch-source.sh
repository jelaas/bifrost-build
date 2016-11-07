#!/bin/bash

SRC=iproute2-3.17.0.tar.gz
DST=/var/spool/src/$SRC

pkg_install wget-1.18-1 || exit 2

[ -s "$DST" ] || wget --no-check-certificate -O $DST https://www.kernel.org/pub/linux/utils/net/iproute2/$SRC
