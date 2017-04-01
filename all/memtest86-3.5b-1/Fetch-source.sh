#!/bin/bash

SRC=memtest86-3.5b.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=af6adbfa287173bcaaf88ebb5f7694b2

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}"  http://ftp.sunet.se/pub/Linux/distributions/bifrost/download/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.acc.umu.se/mirror/archive/ftp.sunet.se/pub/Linux/distributions/bifrost/download/src/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
