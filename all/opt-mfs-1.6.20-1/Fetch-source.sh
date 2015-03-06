#!/bin/bash

SRC=mfs-1.6.20.tar.gz
DST=/var/spool/src/$SRC
MD5=c57bdb9d7d41eec57c2bee9a1ff872c2

[ -s "$DST" ] || wget -O $DST http://moosefs.org/tl_files/mfscode/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
