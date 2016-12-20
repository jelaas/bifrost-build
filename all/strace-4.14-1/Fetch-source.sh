#!/bin/bash

SRC=strace-4.14.tar.xz
DST=/var/spool/src/$SRC
SHA=6ff598822cf4fd79aaff383ee22d91eacf74d5088e613c1f22dc2aead83325fe
MD5=1e39b5f7583256d7dc21170b9da529ae

pkg_install wget-1.18-1   || exit 2
pkg_install curl-7.51.0-1 || exit 2
pkg_install tarmd-1.2-1   || exit 2
[ -s "$DST" ] || tarmd $SHA $DST curl -L -k http://downloads.sourceforge.net/project/strace/strace/4.14/$SRC \
    || ../../wget-finder -O $DST $SRC:$MD5
