#!/bin/bash

SRC=ppp-2.4.5.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://ftp.samba.org/pub/ppp/$SRC
