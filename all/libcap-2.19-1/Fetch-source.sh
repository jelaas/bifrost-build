#!/bin/bash

SRC=libcap-2.19.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://www.kernel.org/pub/linux/libs/security/linux-privs/libcap2/$SRC || wget -O $DST http://ftp.sunet.se/pub/Linux/distributions/bifrost/download/src/$SRC
