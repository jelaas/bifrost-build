#!/bin/bash

VER=0.3; PROGNAME=fzy; SRC="${PROGNAME}-${VER}".tar.gz
DST=/var/spool/src/"${SRC}"
MD5=2a0c15d51f68d6f5bd05e8129b651264

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}"  https://github.com/jhawthorn/"${PROGNAME}"/archive/"${VER}".tar.gz \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
