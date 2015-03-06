#!/bin/bash

SRC=autoconf-2.69.tar.gz
DST=/var/spool/src/$SRC
MD5=82d05e03b93e45f5a39b828dc9c6c29b

[ -s "$DST" ] || wget -O $DST ftp://ftp.sunet.se/pub/gnu/autoconf/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
