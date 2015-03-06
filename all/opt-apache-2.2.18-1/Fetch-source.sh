#!/bin/bash

SRC=httpd-2.2.18.tar.bz2
DST=/var/spool/src/$SRC
MD5=d077dff812191a5899649132d835d3c8

[ -s "$DST" ] || wget -O $DST http://apache.archive.sunet.se/dist/httpd/$SRC \
              || wget --no-check-certificate -O $DST https://archive.apache.org/dist/httpd/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
