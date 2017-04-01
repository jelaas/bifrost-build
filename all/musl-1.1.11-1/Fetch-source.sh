#!/bin/bash

SRC=musl-1.1.11.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=48be0777e32f374d387e9cf85e36ec4d

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.musl-libc.org/releases/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://landley.net/aboriginal/mirror/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://dev.gateworks.com/sources/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sources.buildroot.net/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
