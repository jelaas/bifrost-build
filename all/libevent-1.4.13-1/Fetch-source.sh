#!/bin/bash

SRC=libevent-1.4.13-stable.tar.gz
DST=/var/spool/src/$SRC

pkg_install wget-1.18-1 || exit 2

[ -s "$DST" ] || wget --no-check-certificate -O $DST http://www.monkey.org/~provos/$SRC
