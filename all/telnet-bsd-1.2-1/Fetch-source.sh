#!/bin/bash

SRC=telnet-bsd-1.2.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://ftp.fi.debian.org/gentoo/distfiles/$SRC
