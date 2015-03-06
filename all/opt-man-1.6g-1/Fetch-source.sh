#!/bin/bash

SRC=man-1.6g.tar.gz
DST=/var/spool/src/$SRC
MD5=ba154d5796928b841c9c69f0ae376660

[ -s "$DST" ] || wget -O $DST http://www.mirrorservice.org/sites/distfiles.macports.org/man/$SRC \
              || wget -O $DST http://ftp.devil-linux.org/pub/devel/sources/1.6/$SRC \
              || wget -O $DST http://pkgs.fedoraproject.org/lookaside/pkgs/man2html/man-1.6g.tar.gz/ba154d5796928b841c9c69f0ae376660/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
