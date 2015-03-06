#!/bin/bash

SRC=httpd-2.2.16.tar.bz2
DST=/var/spool/src/$SRC
MD5=c8ff2a07c884300bc7766a2e7f662d33

[ -s "$DST" ] || wget -O $DST http://apache.archive.sunet.se/dist/httpd/$SRC \
              || wget --no-check-certificate -O $DST https://archive.apache.org/dist/httpd/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
