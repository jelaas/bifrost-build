#!/bin/bash

SRC=libtool-2.4.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://ftp.sunet.se/pub/gnu/libtool/$SRC
