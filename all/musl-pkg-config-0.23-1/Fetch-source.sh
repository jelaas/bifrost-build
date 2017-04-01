#!/bin/bash

SRC=pkg-config-0.23.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=d922a88782b64441d06547632fd85744

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkg-config.freedesktop.org/releases/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lfs-matrix.net/pub/blfs/conglomeration/pkg-config/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.mucross.com/downloads/tonga-linux/sources/GPL/pkgconfig-native/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
