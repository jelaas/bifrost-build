#!/bin/bash

SRC=gmp-4.3.2.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://ftp.sunet.se/pub/gnu/gmp/$SRC
