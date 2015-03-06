#!/bin/bash

SRC=unzip60.tgz
DST=/var/spool/src/$SRC
MD5=62b490407489521db863b523a7f86375

[ -s "$DST" ] || wget -O $DST ftp://ftp.info-zip.org/pub/infozip/src/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
