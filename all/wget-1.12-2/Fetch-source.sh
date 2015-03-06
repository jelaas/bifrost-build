#!/bin/bash

SRC=wget-1.12.tar.gz
DST=/var/spool/src/$SRC
MD5=141461b9c04e454dc8933c9d1f2abf83

[ -s "$DST" ] || wget -O $DST ftp://ftp.sunet.se/pub/gnu/wget/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
