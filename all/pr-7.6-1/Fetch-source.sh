#!/bin/bash

SRC=coreutils-7.6.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://ftp.sunet.se/pub/gnu/coreutils/$SRC
