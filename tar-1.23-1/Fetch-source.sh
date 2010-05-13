#!/bin/bash

SRC=tar-1.23.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://ftp.sunet.se/pub/gnu/tar/$SRC
