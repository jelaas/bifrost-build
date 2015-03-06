#!/bin/bash

SRC=vlan.1.9.tar.gz
DST=/var/spool/src/$SRC
MD5=0337d229cd756ba2aeae6eb5bf81ad7d

if [ ! -s "$DST" ]; then
    pkg_install wget-1.12-1 || exit 2
    wget -O $DST --no-check-certificate https://laas.mine.nu/srcrepo/$SRC \
    || wget -O $DST http://www.candelatech.com/~greear/vlan/$SRC          \
    || ../../wget-finder -O $DST $SRC:$MD5
fi
