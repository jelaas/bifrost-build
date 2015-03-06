#!/bin/bash

SRC=libcap-2.19.tar.bz2
DST=/var/spool/src/$SRC
MD5=eb1ff04d39bfa2342b8e78b0fd60dc2d

[ -s "$DST" ] || wget -O $DST http://ftp.be.debian.org/pub/linux/libs/security/linux-privs/libcap2/$SRC \
              || wget -O $DST http://ftp.sunet.se/pub/Linux/distributions/bifrost/download/src/$SRC     \
              || wget -O $DST http://mirror.linux.org.au/linux/libs/security/linux-privs/libcap2/$SRC   \
 || ../../wget-finder -O $DST $SRC:$MD5
