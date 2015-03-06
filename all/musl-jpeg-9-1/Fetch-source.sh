#!/bin/bash
SRC=jpegsrc.v9.tar.gz
DST=/var/spool/src/$SRC
MD5=b397211ddfd506b92cd5e02a22ac924d

[ -s "$DST" ] || wget -O $DST http://www.ijg.org/files/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
