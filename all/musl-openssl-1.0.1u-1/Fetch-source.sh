#!/bin/bash

SRC=openssl-1.0.1u.tar.gz
DST=/var/spool/src/$SRC
SHA=74dd510914a26c883365580808905fc95c953a60b479506e4985c16ac404def2

pkg_install tarmd-1.2-1 || exit 2
pkg_install curl-7.51.0-1 || exit 2
[ -s "$DST" ] || tarmd $SHA $DST /usr/bin/curl -L -k http://www.openssl.org/source/$SRC
