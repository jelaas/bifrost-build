#!/bin/bash

SRC=httpd-2.2.21.tar.bz2
DST=/var/spool/src/$SRC
MD5=1696ae62cd879ab1d4dd9ff021a470f2

[ -s "$DST" ] || wget -O $DST http://apache.archive.sunet.se/dist/httpd/$SRC \
              || wget --no-check-certificate -O $DST https://archive.apache.org/dist/httpd/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
