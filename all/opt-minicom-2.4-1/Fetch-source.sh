#!/bin/bash

SRC=minicom-2.4.tar.gz
DST=/var/spool/src/$SRC
MD5=d41d8cd98f00b204e9800998ecf8427e

[ -s "$DST" ] || wget --no-check-certificate -O $DST http://alioth.debian.org/download.php/3195/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
