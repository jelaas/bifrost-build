#!/bin/bash

SRC=bird-1.3.7.tar.gz
DST=/var/spool/src/$SRC
MD5=c400b008ef834d9e7288dcdbe41b7c15

[ -s "$DST" ] || wget -O $DST ftp://bird.network.cz/pub/bird/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
