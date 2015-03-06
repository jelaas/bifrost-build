#!/bin/bash

SRC=libexif-0.6.21.tar.gz
DST=/var/spool/src/$SRC
MD5=9321c409a3e588d4a99d63063ef4bbb7

[ -s "$DST" ] || wget -O $DST http://downloads.sourceforge.net/project/libexif/libexif/0.6.21/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
