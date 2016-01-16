#!/bin/bash

SRC=tmate-2.2.0.tar.gz
DST=/var/spool/src/$SRC
MD5=

pkg_install wget-1.12-2 || exit 2

[ -s "$DST" ] || wget --no-check-certificate -O $DST https://github.com/tmate-io/tmate/archive/3a73f1735437ef08d32e3d14966f813a5ed7dfb9.tar.gz
