#!/bin/bash

SRC=sysklogd-1.4.1.tar.gz
DST=/var/spool/src/$SRC
SHA=42c71b067fc6d780b171315fc28803bf82bed450c068e91e702b816f4fd929be

pkg_install tarmd-1.2-1 || exit 2
[ -s "$DST" ] || tarmd $SHA $DST wget -O- http://www.infodrom.org/projects/sysklogd/download/$SRC
