#!/bin/bash

SRC=gnupg-1.4.10.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://ftp.gnupg.org/gcrypt/gnupg/$SRC
