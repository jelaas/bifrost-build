#!/bin/bash

SRC=bind-9.7.6-P2.tar.gz
DST=/var/spool/src/$SRC
MD5=8570762bba843aa409f243032ba8faf5

[ -s "$DST" ] || wget -O $DST ftp://ftp.isc.org/isc/bind9/9.7.6-P2/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
