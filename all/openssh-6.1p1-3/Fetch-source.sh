#!/bin/bash

SRC=openssh-6.1p1.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://ftp.openbsd.org/pub/OpenBSD/OpenSSH/portable/$SRC
