#!/bin/bash

SRC=libssh-0.5.2.tar.gz
DST=/var/spool/src/$SRC

pkg_install wget-1.12-2 || exit 2

[ -s "$DST" ] || wget -O $DST http://www.libssh.org/files/0.5/$SRC \
              || wget --no-check-certificate -O $DST https://distfiles.macports.org/libssh/$SRC \
              || wget -O $DST http://pkgs.fedoraproject.org/repo/pkgs/libssh/libssh-0.5.2.tar.gz/38b67c48af7a9204660a3e08f97ceba6/$SRC
