#!/bin/bash

SRC=readline-6.1.tar.gz
DST=/var/spool/src/$SRC
MD5=fc2f7e714fe792db1ce6ddc4c9fb4ef3

[ -s "$DST" ] || wget -O $DST ftp://ftp.sunet.se/pub/gnu/readline/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
