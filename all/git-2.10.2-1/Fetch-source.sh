#!/bin/bash

SRC=git-2.10.2.tar.gz
DST=/var/spool/src/$SRC
SHA=7a5e6b8ec17ce0e3b81d36fb2f899affbb6d5e328e9e71a24252704aeb51e817

pkg_install curl-7.51.0-1 || exit 2
pkg_install tarmd-1.2-1 || exit 2
[ -s "$DST" ] || tarmd $SHA $DST curl -L -k https://www.kernel.org/pub/software/scm/git/$SRC
