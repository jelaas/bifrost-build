#!/bin/bash

SRC=groff-1.21.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://ftp.sunet.se/pub/gnu/groff/$SRC
