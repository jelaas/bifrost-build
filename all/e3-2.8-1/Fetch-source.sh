#!/bin/bash

SRC=e3-2.8.tar.gz
DST=/var/spool/src/$SRC
MD5=0120bb073133ad26a054b35f88333183

if [ ! -s "$DST" ]; then
    pkg_install wget-1.12-2 || exit 2
    wget --no-check-certificate -O $DST http://sites.google.com/site/e3editor/Home/e3-2.8.tgz \
           || ../../wget-finder -O $DST $SRC:$MD5
fi
