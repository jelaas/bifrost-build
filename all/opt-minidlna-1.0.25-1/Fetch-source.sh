#!/bin/bash

SRC=minidlna_1.0.25_src.tar.gz
DST=/var/spool/src/$SRC
MD5=d966256baf2f9b068b9de871ab5dade5

[ -s "$DST" ] || wget -O $DST http://downloads.sourceforge.net/project/minidlna/minidlna/1.0.25/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
