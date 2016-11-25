#!/bin/bash

SRC=nfs-utils-1.1.6.tar.bz2
DST=/var/spool/src/$SRC

pkg_install wget-1.18-1 || exit 2

[ -s "$DST" ] || wget --no-check-certificate -O $DST http://downloads.sourceforge.net/project/nfs/nfs-utils/1.1.6/$SRC
