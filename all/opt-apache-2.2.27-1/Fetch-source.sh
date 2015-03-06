#!/bin/bash

SRC=httpd-2.2.27.tar.bz2
DST=/var/spool/src/$SRC
MD5=8faef0decf3fa7e69b2568eb2105a3d8

pkg_install wget-1.12-2 || exit 2

[ -s "$DST" ] || wget -O $DST http://apache.archive.sunet.se/dist/httpd/$SRC \
              || wget --no-check-certificate -O $DST https://archive.apache.org/dist/httpd/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
