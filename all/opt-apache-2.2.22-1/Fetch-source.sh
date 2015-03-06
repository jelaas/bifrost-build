#!/bin/bash

SRC=httpd-2.2.22.tar.bz2
DST=/var/spool/src/$SRC
MD5=9fe3093194c8a57f085ff7c3fc43715f

[ -s "$DST" ] || wget -O $DST http://apache.archive.sunet.se/dist/httpd/$SRC \
              || wget --no-check-certificate -O $DST https://archive.apache.org/dist/httpd/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
