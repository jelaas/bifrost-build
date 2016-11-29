#!/bin/bash

SRC=example.tar.gz
DST=/var/spool/src/$SRC
SHA=deadbeef

pkg_install tarmd-1.2-1 || exit 2
pkg_install curl-7.51.0-1 || exit 2
[ -s "$DST" ] || tarmd $SHA $DST curl -L -k http://source.on.internet/$SRC
