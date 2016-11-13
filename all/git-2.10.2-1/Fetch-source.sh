#!/bin/bash

SRC=git-2.10.2.tar.gz
DST=/var/spool/src/$SRC
SHA=7a5e6b8ec17ce0e3b81d36fb2f899affbb6d5e328e9e71a24252704aeb51e817
MD5=45e8b30a9e7c1b734128cc0fc6663619

pkg_install curl-7.51.0-1 || exit 2
pkg_install tarmd-1.2-1   || exit 2
[ -s "$DST" ] || tarmd $SHA $DST curl -L -k https://www.kernel.org/pub/software/scm/git/$SRC \
              || tarmd $SHA $DST curl -L -k http://ftp.riken.jp/Linux/kernel.org/software/scm/git/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
