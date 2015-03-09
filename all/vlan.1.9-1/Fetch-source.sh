#!/bin/bash

SRC=vlan.1.9.tar.gz
DST=/var/spool/src/$SRC
MD5=5f0c6060b33956fb16e11a15467dd394

if [ ! -s "$DST" ]; then
    pkg_install wget-1.12-1 || exit 2
       wget -O $DST --no-check-certificate https://laas.mine.nu/srcrepo/$SRC \
    || ../../wget-finder -O $DST $SRC:$MD5
fi
