#!/bin/bash

SRC=util-linux-ng-2.17.2.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://ftp.kernel.org/pub/linux/utils/util-linux/v2.17/$SRC
