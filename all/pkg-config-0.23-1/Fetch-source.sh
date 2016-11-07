#!/bin/bash

SRC=pkg-config-0.23.tar.gz
DST=/var/spool/src/$SRC

pkg_install wget-1.18-1 || exit 2

[ -s "$DST" ] || wget --no-check-certificate -O $DST http://pkg-config.freedesktop.org/releases/$SRC
