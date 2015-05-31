#!/bin/bash

SRC=bird-1.4.5.tar.gz
DST=/var/spool/src/$SRC
MD5=a8e5e0a9129ce30fe6102c593bafb763

[ -s "$DST" ] || wget -O $DST ftp://bird.network.cz/pub/bird/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
