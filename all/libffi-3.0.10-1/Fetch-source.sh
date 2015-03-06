#!/bin/bash

SRC=libffi-3.0.10.tar.gz
DST=/var/spool/src/$SRC
MD5=79390673f5d07a8fb342bc09b5055b6f

[ -s "$DST" ] || wget -O $DST ftp://sourceware.org/pub/libffi/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
