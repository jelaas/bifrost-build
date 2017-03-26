#!/bin/bash

SRC=fdupes-1.51.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=47d0410c90c9e51e450933ba35a32b62

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/lookaside/pkgs/fdupes/fdupes-1.51.tar.gz/47d0410c90c9e51e450933ba35a32b62/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://her.gr.distfiles.macports.org/fdupes/1.51_1/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sources.openelec.tv/mirror/fdupes/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.mirrorservice.org/sites/distfiles.macports.org/fdupes/1.51_1/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://slackware.uk/sbosrcarch/by-md5/c/c/cc90047dea9f1e0a849c3c1a6e8b2d68/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.twaren.net/FreeBSD/ports/distfiles/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sources.libreelec.tv/mirror/fdupes/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" https://ftp.heanet.ie/mirrors/ftp.openbsd.org/distfiles/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
