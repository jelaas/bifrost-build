#!/bin/bash

SRC=musl-1.1.8.tar.gz
DST=/var/spool/src/"${SRC}"
MD5SUM=d965d4bc873db4a3b56bbe7f31e47b4a

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.etalabs.net/musl/releases/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distfiles.alpinelinux.org/distfiles/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distfiles.lesslinux.org/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.musl-libc.org/releases/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://foss.aueb.gr/mirrors/linux/musl-libc/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
