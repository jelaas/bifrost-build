#!/bin/bash

SRC=bridge-utils-1.4.tar.gz
DST=/var/spool/src/$SRC
MD5=0182fcac3a2b307113bbec34e5f1c673

[ -s "$DST" ] || wget -O $DST http://downloads.sourceforge.net/project/bridge/bridge/bridge-utils-1.4/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
