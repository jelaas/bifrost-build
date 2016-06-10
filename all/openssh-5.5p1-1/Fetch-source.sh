#!/bin/bash

SRC=openssh-5.5p1.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://ftp.openbsd.org/pub/OpenBSD/OpenSSH/portable/$SRC || wget -O $DST http://ftp.openbsd.org/pub/OpenBSD/OpenSSH/portable/$SRC
