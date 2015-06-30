#!/bin/bash

SRC=libvpx-v1.3.0.tar.bz2
DST=/var/spool/src/$SRC
MD5=14783a148872f2d08629ff7c694eb31f

[ -s "$DST" ] || wget -O $DST http://webm.googlecode.com/files/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
