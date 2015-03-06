#!/bin/bash

SRC=procps-3.2.8.tar.gz
DST=/var/spool/src/$SRC
MD5=9532714b6846013ca9898984ba4cd7e0

[ -s "$DST" ] || wget -O $DST http://procps.sourceforge.net/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
