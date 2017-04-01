#!/bin/bash

SRC=fossil-src-1.36.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=48021bb79dd44145f5275b531e96bd55

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://fossil-scm.org/index.html/uv/download/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" https://sources.voidlinux.eu/fossil-1.36/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://slackware.uk/sbosrcarch/by-name/development/fossil/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://nyftp.netbsd.org/pub/pkgsrc/distfiles/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.transip.net/openbsd/distfiles/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
