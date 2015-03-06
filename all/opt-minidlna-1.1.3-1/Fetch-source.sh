#!/bin/bash

SRC=minidlna-1.1.3.tar.gz
DST=/var/spool/src/$SRC
MD5=879027192c89e5376cdd2ae2d1aa33b4

[ -s "$DST" ] || wget -O $DST http://downloads.sourceforge.net/project/minidlna/minidlna/1.1.3/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
