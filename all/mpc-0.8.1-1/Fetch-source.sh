#!/bin/bash

SRC=mpc-0.8.1.tar.gz
DST=/var/spool/src/$SRC
MD5=5b34aa804d514cc295414a963aedb6bf

[ -s "$DST" ] || wget -O $DST ftp://gcc.gnu.org/pub/gcc/infrastructure/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
