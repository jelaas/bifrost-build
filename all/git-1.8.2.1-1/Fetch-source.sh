#!/bin/bash

SRC=git-1.8.2.1.tar.gz
DST=/var/spool/src/$SRC
MD5=3f6ebca116c627490e4ee1f1324d5e65

[ -s "$DST" ] || wget -O $DST http://git-core.googlecode.com/files/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
