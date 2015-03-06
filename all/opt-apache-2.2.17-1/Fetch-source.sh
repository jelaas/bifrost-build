#!/bin/bash

SRC=httpd-2.2.17.tar.bz2
DST=/var/spool/src/$SRC
MD5=16eadc59ea6b38af33874d300973202e

[ -s "$DST" ] || wget -O $DST http://apache.archive.sunet.se/dist/httpd/$SRC \
              || wget --no-check-certificate -O $DST https://archive.apache.org/dist/httpd/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
