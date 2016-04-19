#!/bin/bash

SRC=git-2.7.2.tar.gz
DST=/var/spool/src/$SRC

pkg_install wget-1.15-3 || exit 2

if ! [ -s "$DST" ]; then
	wget --no-check-certificate -O $DST https://github.com/git/git/archive/v2.7.2.tar.gz
fi