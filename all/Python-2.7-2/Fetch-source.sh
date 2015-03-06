#!/bin/bash

SRC=Python-2.7.tar.bz2
DST=/var/spool/src/$SRC
MD5=0e8c9ec32abf5b732bea7d91b38c3339

if [ ! -s "$DST" ]; then
    pkg_install wget-1.12-2 || exit 2
    wget --no-check-certificate -O $DST https://www.python.org/ftp/python/2.7/$SRC \
           || ../../wget-finder -O $DST $SRC:$MD5
fi
