#!/bin/bash

SRC=xz-5.0.3.tar.bz2 
DST=/var/spool/src/$SRC

pkg_install curl-7.49.1-1 || exit 2
[ -s "$DST" ] || curl -L -k -o $DST http://tukaani.org/xz/$SRC
