#!/bin/bash

SRC=grub-2.00.tar.gz
DST=/var/spool/src/$SRC
MD5=e927540b6eda8b024fb0391eeaa4091c

[ -s "$DST" ] || wget -O $DST ftp://ftp.sunet.se/pub/gnu/grub/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
