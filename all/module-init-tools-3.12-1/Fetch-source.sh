#!/bin/bash

SRC=module-init-tools-3.12.tar.bz2
DST=/var/spool/src/$SRC
MD5=8b2257ce9abef74c4a44d825d23140f3

[ -s "$DST" ] || wget -O $DST ftp://ftp.kernel.org/pub/linux/utils/kernel/module-init-tools/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
