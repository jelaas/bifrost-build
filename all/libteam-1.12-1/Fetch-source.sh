#!/bin/bash

VER=1.12
SRC=libteam-$VER.tar.gz
DST=/var/spool/src/$SRC

pkg_install wget-1.15-1 || exit 2

[ -s "$DST" ] || wget --no-check-certificate -O $DST https://github.com/jpirko/libteam/archive/v$VER.tar.gz
