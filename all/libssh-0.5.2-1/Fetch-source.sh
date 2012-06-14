#!/bin/bash

SRC=libssh-0.5.2.tar.gz
DST=/var/spool/src/$SRC

pkg_install wget-1.12-2 || exit 2

[ -s "$DST" ] || wget --no-check-certificate -O $DST https://red.libssh.org/attachments/download/27/$SRC
