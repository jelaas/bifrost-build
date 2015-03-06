#!/bin/bash

SRC=xerces-c-3.1.1.tar.gz
DST=/var/spool/src/$SRC
MD5=6a8ec45d83c8cfb1584c5a5345cb51ae

[ -s "$DST" ] || wget -O $DST http://apache.archive.sunet.se/dist/xerces/c/3/sources/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
