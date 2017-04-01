#!/bin/bash

SRC=musl-1.1.5.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=94f8aa9dab80229fed68991bb9984cc5

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.etalabs.net/musl/releases/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sources.buildroot.net/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distfiles.alpinelinux.org/distfiles/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distfiles.lesslinux.org/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
