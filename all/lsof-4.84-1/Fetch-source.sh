#!/bin/bash

SRC=lsof_4.84.tar.gz
DST=/var/spool/src/$SRC
MD5=6dae655988c810a7042c06a4e2fa3c5f

[ -s "$DST" ] || wget -O $DST ftp://lsof.itap.purdue.edu/pub/tools/unix/lsof/OLD/$SRC \
              || wget -O $DST ftp://ftp.fu-berlin.de/pub/unix/tools/lsof/OLD/$SRC     \
              || wget -O $DST ftp://ftp.fu-berlin.de/pub/unix/tools/lsof/$SRC         \
              || wget -O $DST ftp://lsof.itap.purdue.edu/pub/tools/unix/lsof/$SRC     \
 || ../../wget-finder -O $DST $SRC:$MD5
