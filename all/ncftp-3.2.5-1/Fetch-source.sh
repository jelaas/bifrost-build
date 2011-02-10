#!/bin/bash

SRC=ncftp-3.2.5-src.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://ftp.ncftp.com/ncftp/$SRC

