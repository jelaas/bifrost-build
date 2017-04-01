#!/bin/bash

SRC=musl-1.1.2.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=a81309e54efdf9c68baf679790fc5678

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.etalabs.net/musl/releases/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.musl-libc.org/releases/"${SRC}"    \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://landley.net/aboriginal/mirror/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sources.buildroot.net/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
