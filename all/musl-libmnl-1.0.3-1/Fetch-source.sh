#!/bin/bash

SRC=libmnl-1.0.3.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://ftp.netfilter.org/pub/libmnl/$SRC
