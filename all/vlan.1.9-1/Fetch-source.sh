#!/bin/bash

SRC=vlan.1.9.tar.gz
DST=/var/spool/src/$SRC

if [ ! -s "$DST" ]; then
    pkg_install wget-1.12-1 || exit 2
    wget -O $DST --no-check-certificate  http://raemmen.eu/srcrepo/$SRC || wget -O $DST http://www.candelatech.com/~greear/vlan/$SRC
fi
