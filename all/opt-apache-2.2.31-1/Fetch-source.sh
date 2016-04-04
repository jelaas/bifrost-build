#!/bin/bash

SRC=httpd-2.2.31.tar.bz2
DST=/var/spool/src/$SRC
MD5=6c10e15835ab214464228a9beb7afba8

pkg_install wget-1.12-2 || exit 2

[ -s "$DST" ] || wget -O $DST http://apache.archive.sunet.se/dist/httpd/$SRC \
              || wget --no-check-certificate -O $DST https://archive.apache.org/dist/httpd/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
