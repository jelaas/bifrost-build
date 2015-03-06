#!/bin/bash

SRC=module-init-tools-3.15.tar.bz2
DST=/var/spool/src/$SRC
MD5=04f04e6f976f46c89523679c452a0324

[ -s "$DST" ] || wget -O $DST ftp://ftp.kernel.org/pub/linux/utils/kernel/module-init-tools/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
