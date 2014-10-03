#!/bin/bash

SRC=libcli-1.9.7.tar.gz
DST=/var/spool/src/$SRC

pkg_install wget-1.15-1 || exit 2

[ -s "$DST" ] || wget --no-check-certificate -O $DST https://github.com/dparrish/libcli/archive/v1.9.7.tar.gz
