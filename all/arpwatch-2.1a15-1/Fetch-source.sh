#!/bin/bash

SRC=arpwatch.tar.gz
DST=/var/spool/src/$SRC
MD5=cebfeb99c4a7c2a6cee2564770415fe7

[ -s "$DST" ] || wget -O $DST ftp://ftp.ee.lbl.gov/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
