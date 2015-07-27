#!/bin/bash

SRC=util-linux-2.26.2.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://ftp.kernel.org/pub/linux/utils/util-linux/v2.26/$SRC
