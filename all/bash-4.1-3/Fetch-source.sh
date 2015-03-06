#!/bin/bash

SRC=bash-4.1.tar.gz
DST=/var/spool/src/$SRC
MD5=9800d8724815fd84994d9be65ab5e7b8

[ -s "$DST" ] || wget -O $DST ftp://ftp.sunet.se/pub/gnu/bash/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
