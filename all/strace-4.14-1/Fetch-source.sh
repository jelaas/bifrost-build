#!/bin/bash

SRC=strace-4.14.tar.xz
DST=/var/spool/src/$SRC
SHA=6ff598822cf4fd79aaff383ee22d91eacf74d5088e613c1f22dc2aead83325fe

pkg_install curl-7.51.0-1 || exit 2
pkg_install tarmd-1.2-1 || exit 2
[ -s "$DST" ] || tarmd $SHA $DST curl -L -k http://downloads.sourceforge.net/project/strace/strace/4.14/$SRC

