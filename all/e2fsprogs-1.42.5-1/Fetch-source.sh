#!/bin/bash

SRC=e2fsprogs-1.42.5.tar.gz
DST=/var/spool/src/$SRC
MD5=aca828bb4bcca20991a442deb950b670

[ -s "$DST" ] || wget -O $DST http://downloads.sourceforge.net/project/e2fsprogs/e2fsprogs/v1.42.5/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
