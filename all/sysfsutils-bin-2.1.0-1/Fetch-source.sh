#!/bin/bash

SRC=sysfsutils-2.1.0.tar.gz
DST=/var/spool/src/$SRC
MD5=14e7dcd0436d2f49aa403f67e1ef7ddc

[ -s "$DST" ] || wget -O $DST http://downloads.sourceforge.net/project/linux-diag/sysfsutils/2.1.0/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
