#!/bin/bash

SRC=cronie-1.4.4.tar.gz
DST=/var/spool/src/$SRC

pkg_install wget-1.12-1 || exit 1

[ -s "$DST" ] || wget --no-check-certificate -O $DST http://fedorahosted.org/releases/c/r/cronie/$SRC
