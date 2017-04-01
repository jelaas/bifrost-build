#!/bin/bash

SRC=sqlite-autoconf-3071602.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=ce7d2bc0d9b8dd18995b888c6b0b220f

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.sqlite.org/2013/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lfs-matrix.net/pub/blfs/conglomeration/sqlite/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.tisys.org/pub/blfs/conglomeration/sqlite/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sources.openelec.tv/mirror/sqlite/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.mirrorservice.org/sites/ftp.cs.vu.nl/pub/minix/distfiles/backup/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
