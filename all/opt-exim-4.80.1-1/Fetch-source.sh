#!/bin/bash

SRC=exim-4.80.1.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=1a95dc9f02834b1b7430403a75edf162

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://ftp.exim.org/pub/exim/exim4/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://ftp.exim.org/pub/exim/exim4/old/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.cs.stanford.edu/pub/exim/exim/exim4/old/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.tw.freebsd.org/distfiles/exim/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
