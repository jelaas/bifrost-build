#!/bin/bash

SRC=libevent-2.0.22-stable.tar.gz
DST=/var/spool/src/libevent-2.0.22.tar.gz
MD5=c4c56f986aa985677ca1db89630a2e11

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" https://github.com/libevent/libevent/releases/download/release-2.0.22-stable/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lfs-matrix.net/pub/blfs/conglomeration/libevent/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.mirrorservice.org/sites/distfiles.macports.org/libevent/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://repository.timesys.com/buildsources/l/libevent2/libevent2-2.0.22/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
