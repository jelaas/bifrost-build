#!/bin/bash

SRC=nano-2.2.4.tar.gz
DST=/var/spool/src/$SRC
MD5=6304308afb1f7ef4a5e93eb99206632a

[ -s "$DST" ] || wget -O $DST http://www.nano-editor.org/dist/v2.2/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
