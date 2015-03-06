#!/bin/bash

SRC=popt-1.16.tar.gz
DST=/var/spool/src/$SRC
MD5=3743beefa3dd6247a73f8f7a32c14c33

[ -s "$DST" ] || wget -O $DST http://rpm5.org/files/popt/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
