#!/bin/bash

SRC=gnupg-1.4.10.tar.bz2
DST=/var/spool/src/$SRC
MD5=dcf7ed712997888d616e029637bfc303

[ -s "$DST" ] || wget -O $DST ftp://ftp.gnupg.org/gcrypt/gnupg/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
