#!/bin/bash

SRC=bandwidth-0.23a.tar.gz
DST=/var/spool/src/$SRC
MD5=f0f78081b5ba66ea9e5eb4721dad3818

[ -s "$DST" ] || wget -O $DST http://home.comcast.net/~fbui/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
