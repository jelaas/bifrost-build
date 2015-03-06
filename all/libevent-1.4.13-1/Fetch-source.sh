#!/bin/bash

SRC=libevent-1.4.13-stable.tar.gz
DST=/var/spool/src/$SRC
MD5=0b3ea18c634072d12b3c1ee734263664

[ -s "$DST" ] || wget -O $DST http://www.monkey.org/~provos/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
