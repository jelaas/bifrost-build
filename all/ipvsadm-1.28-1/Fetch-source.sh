#!/bin/bash

SRC=ipvsadm-1.28.tar.gz
DST=/var/spool/src/$SRC
SHA=3d81f96f81699fe8d65ba56b435704ec9800fcbb2b53a572d38544cdf35482d1
MD5=9b449f0b2cc1dc486c70a5911f8319e1

pkg_install curl-7.51.0-1 || exit 2
pkg_install tarmd-1.2-1 || exit 2
[ -s "$DST" ] || tarmd $SHA $DST curl -L -k https://www.kernel.org/pub/linux/utils/kernel/ipvsadm/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5

