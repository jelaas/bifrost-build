#!/bin/bash

VER=0.2
PROGNAME=fzy
SRC="${PROGNAME}-${VER}".tar.gz
DST=/var/spool/src/"${SRC}"
MD5=84f116bccece4c33b25360bc6c55906d

pkg_install wget-1.15-1 || exit 2

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" --no-check-certificate https://github.com/jhawthorn/"${PROGNAME}"/archive/"${VER}".tar.gz \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
