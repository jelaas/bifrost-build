#!/bin/bash

SRC=zlib-1.2.6.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=dc2cfa0d2313ca77224b4d932b2911e9

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.zlib.net/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://ftp.simplesystems.org/pub/libpng/png/src/history/zlib/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sources.angstrom-distribution.org/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distro.ibiblio.org/slitaz/sources/packages/z/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sourceforge.mirrorservice.org/l/li/libpng/zlib/1.2.6/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://oe-lite.org/mirror/zlib/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.icm.edu.pl/packages/ImageMagick/delegates/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sources.geexbox.org/3.0/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" https://downloads.yoctoproject.org/mirror/sources/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
