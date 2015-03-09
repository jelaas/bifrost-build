#!/bin/bash

SRC=httpd-2.2.19.tar.bz2
DST=/var/spool/src/$SRC
MD5=832f96a6ec4b8fc7cf49b9efd4e89060

[ -s "$DST" ] || wget -O $DST http://apache.archive.sunet.se/dist/httpd/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
