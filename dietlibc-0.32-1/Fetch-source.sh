#!/bin/bash

SRC=dietlibc-0.32.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://www.kernel.org/pub/linux/libs/dietlibc/$SRC
