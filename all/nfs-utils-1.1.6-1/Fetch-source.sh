#!/bin/bash

SRC=nfs-utils-1.1.6.tar.bz2
DST=/var/spool/src/$SRC
MD5=b0d1b8ec5c8c081a340cfc77bb8670cd

[ -s "$DST" ] || wget -O $DST http://freefr.dl.sourceforge.net/project/nfs/nfs-utils/1.1.6/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
