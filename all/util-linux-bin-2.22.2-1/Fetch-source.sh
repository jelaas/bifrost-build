#!/bin/bash

SRC=util-linux-2.22.2.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://ftp.kernel.org/pub/linux/utils/util-linux/v2.22/$SRC
