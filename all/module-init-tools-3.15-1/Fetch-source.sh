#!/bin/bash

SRC=module-init-tools-3.15.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://ftp.kernel.org/pub/linux/utils/kernel/module-init-tools/$SRC
