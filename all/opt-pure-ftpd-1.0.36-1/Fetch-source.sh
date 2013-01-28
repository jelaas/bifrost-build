#!/bin/bash

SRC=pure-ftpd-1.0.36.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://ftp.pureftpd.org/pub/pure-ftpd/releases/$SRC
