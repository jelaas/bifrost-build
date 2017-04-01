#!/bin/bash

SRC=libevent-2.0.22-stable.tar.gz
DST=/var/spool/src/libevent-2.0.22.tar.gz
MD5=c4c56f986aa985677ca1db89630a2e11

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://down1.ixiazai.net/lnmp/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://crux.ster.zone/distfiles/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lfs-matrix.net/pub/blfs/conglomeration/libevent/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.mirrorservice.org/sites/distfiles.macports.org/libevent/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://openlinux.windriver.com/overc/sources/core2_64/libevent-2.0.22-r0.0/libevent-2.0.22-r0/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sources.openelec.tv/mirror/libevent/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.clfs.org/pub/blfs/7.9/l/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
