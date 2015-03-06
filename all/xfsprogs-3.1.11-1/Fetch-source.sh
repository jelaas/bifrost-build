#!/bin/bash

SRC=xfsprogs-3.1.11.tar.gz
DST=/var/spool/src/$SRC
MD5=de9f1f45026c2f4e0776058d429ff4b6

[ -s "$DST" ] || wget -O $DST ftp://oss.sgi.com/projects/xfs/cmd_tars/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
