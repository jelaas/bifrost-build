#!/bin/bash

SRC=git-2.7.2.tar.gz
DST=/var/spool/src/$SRC
MD5=162ddc6c9b243899ad67ebd6b1c166b1

pkg_install wget-1.15-3 || exit 2

if ! [ -s "$DST" ]; then
    wget --no-check-certificate -O $DST https://www.kernel.org/pub/software/scm/git/$SRC \
 || wget --no-check-certificate -O $DST http://pkgs.fedoraproject.org/repo/pkgs/git/${SRC}/162ddc6c9b243899ad67ebd6b1c166b1/$SRC \
 || wget --no-check-certificate -O $DST http://ftp.riken.jp/Linux/kernel.org/software/scm/git/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
fi
