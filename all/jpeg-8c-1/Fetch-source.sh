#!/bin/bash

SRC=jpegsrc.v8c.tar.gz
DST=/var/spool/src/$SRC
MD5=a2c10c04f396a9ce72894beb18b4e1f9

[ -s "$DST" ] || wget -O $DST http://www.ijg.org/files/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
