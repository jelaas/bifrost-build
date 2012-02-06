#!/bin/bash

SRC=dietlibc-0.31.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://www.kernel.org/pub/linux/libs/dietlibc/$SRC || wget -O $DST http://ftp.sunet.se/pub/Linux/kernel.org/linux/libs/dietlibc/$SRC
