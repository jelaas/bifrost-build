#!/bin/bash

SRC=libcli-1.9.7.tar.gz
DST=/var/spool/src/$SRC
MD5=f33e0fdb8ae8e14e66036424704b201b

pkg_install wget-1.15-1 || exit 2

[ -s "$DST" ] || wget --no-check-certificate -O $DST https://github.com/dparrish/libcli/archive/v1.9.7.tar.gz \
 || ../../wget-finder -O $DST $SRC:$MD5
