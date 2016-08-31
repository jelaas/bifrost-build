#!/bin/bash

SRC=exim-4.87.tar.bz2
DST=/var/spool/src/$SRC
SHA=1eda7c7b2a28b610b94506107a1c066df605e0c82d99eaa648dbd87a8c69f28d

pkg_install tarmd-1.2-1 || exit 2

[ -s "$DST" ] || tarmd $SHA $DST wget -O- ftp://ftp.exim.org/pub/exim/exim4/$SRC || tarmd $SHA $DST wget -O- ftp://ftp.exim.org/pub/exim/exim4/old/$SRC
