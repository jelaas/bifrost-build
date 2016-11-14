#!/bin/bash

SRC=openssl-1.0.1c.tar.gz
DST=/var/spool/src/$SRC
MD5=ae412727c8c15b67880aef7bd2999b2e

pkg_install wget-1.15-1 || exit 2
[ -s "$DST" ] || wget -O $DST http://www.openssl.org/source/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
