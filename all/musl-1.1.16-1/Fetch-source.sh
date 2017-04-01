#!/bin/bash

SRC=musl-1.1.16.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=ac52ccaec6b06ab0f289d37e8436859b

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.musl-libc.org/releases/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sources.buildroot.net/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://foss.aueb.gr/mirrors/linux/musl-libc/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" https://sources.voidlinux.eu/musl-bootstrap-1.1.16/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirrors.peers.community/mirrors/dragora/mirror/current/sources/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
