#!/bin/bash

SRC=openssl-1.0.1u.tar.gz
DST=/var/spool/src/$SRC
SHA=74dd510914a26c883365580808905fc95c953a60b479506e4985c16ac404def2
MD5=130bb19745db2a5a09f22ccbbf7e69d0

pkg_install tarmd-1.2-1   || exit 2
pkg_install curl-7.51.0-1 || exit 2
pkg_install wget-1.15-1   || exit 2
[ -s "$DST" ] || tarmd $SHA $DST /usr/bin/curl -L -k http://www.openssl.org/source/$SRC \
              || wget -O $DST http://slackware.org.uk/slackware/slackware/patches/source/openssl/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
