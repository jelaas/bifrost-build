#!/bin/bash

SRC=cmake-2.8.5.tar.gz
DST=/var/spool/src/$SRC
MD5=3c5d32cec0f4c2dc45f4c2e84f4a20c5

[ -s "$DST" ] || wget -O $DST http://www.cmake.org/files/v2.8/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
