#!/bin/bash

SRC=cmake-2.8.6.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=2147da452fd9212bb9b4542a9eee9d5b

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.cmake.org/files/v2.8/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lfs-matrix.net/pub/blfs/conglomeration/cmake/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distfiles.icmpv6.org/distfiles/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.jaleco.com/lfs/pub/blfs/conglomeration/cmake/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://app.nidc.kr/linux/lib/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
