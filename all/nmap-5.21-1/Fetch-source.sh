#!/bin/bash

SRC=nmap-5.21.tar.bz2
DST=/var/spool/src/$SRC

pkg_install curl-7.49.1-1 || exit 2
[ -s "$DST" ] || curl -L -k -o $DST  http://nmap.org/dist/$SRC
