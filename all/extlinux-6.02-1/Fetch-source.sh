#!/bin/bash

SRC=syslinux-6.02.tar.bz2
DST=/var/spool/src/$SRC

pkg_install wget-1.15-1 || exit 2
[ -s "$DST" ] || wget --no-check-certificate -O $DST https://www.kernel.org/pub/linux/utils/boot/syslinux/$SRC

