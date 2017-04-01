#!/bin/bash

SRC=musl-0.9.10.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=8998be253b6f0880a1ce00d85dbae9c5

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.etalabs.net/musl/releases/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" https://www.musl-libc.org/releases/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" https://foss.aueb.gr/mirrors/linux/musl-libc/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://landley.net/aboriginal/mirror/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
