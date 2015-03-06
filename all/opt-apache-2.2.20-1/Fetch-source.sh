#!/bin/bash

SRC=httpd-2.2.20.tar.bz2
DST=/var/spool/src/$SRC
MD5=1ac251431c8c4285f6b085c1d156bb56

[ -s "$DST" ] || wget -O $DST http://apache.archive.sunet.se/dist/httpd/$SRC \
              || wget --no-check-certificate -O $DST https://archive.apache.org/dist/httpd/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
