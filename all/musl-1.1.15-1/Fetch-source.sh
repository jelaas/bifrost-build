#!/bin/bash

SRC=musl-1.1.15.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=9590a9d47ee64f220b3c12f7afb864ca

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.musl-libc.org/releases/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" https://sources.lede-project.org/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" https://sources.voidlinux.eu/musl-bootstrap-1.1.15/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://gadow.freifunk.net:8004/srv2/lede/test/850v2/source/dl/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://openwrt.rmgss.net/dl/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distfiles.lesslinux.org/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
