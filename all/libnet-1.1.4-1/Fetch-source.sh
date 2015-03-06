#!/bin/bash

SRC=libnet-1.1.4.tar.gz
DST=/var/spool/src/$SRC
MD5=c5e06418a89cc4209f677a776a798fd9

[ -s "$DST" ] || wget -O $DST http://downloads.sourceforge.net/project/libnet-dev/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
