#!/bin/bash

SRC=libnfnetlink-1.0.1.tar.bz2
DST=/var/spool/src/$SRC
MD5=98927583d2016a9fb1936fed992e2c5e

[ -s "$DST" ] || wget -O $DST http://www.netfilter.org/projects/libnfnetlink/files/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
