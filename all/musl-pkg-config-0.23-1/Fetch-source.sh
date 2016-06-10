#!/bin/bash

SRC=pkg-config-0.23.tar.gz
DST=/var/spool/src/$SRC

pkg_install curl-7.49.1-1 || exit 2
[ -s "$DST" ] || wget -O $DST http://pkg-config.freedesktop.org/releases/$SRC || curl -L -k -o $DST http://pkg-config.freedesktop.org/releases/$SRC
