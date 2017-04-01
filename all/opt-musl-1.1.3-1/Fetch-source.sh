#!/bin/bash

SRC=musl-1.1.3.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=1628bd4c86b14b90447e1dcf8421aed7

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.etalabs.net/musl/releases/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sources.buildroot.net/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.musl-libc.org/releases/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://foss.aueb.gr/mirrors/linux/musl-libc/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
