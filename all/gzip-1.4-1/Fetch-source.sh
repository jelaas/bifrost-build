#!/bin/bash

SRC=gzip-1.4.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=e381b8506210c794278f5527cba0e765

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://ftp.sunet.se/pub/gnu/gzip/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.ntu.edu.tw/gnu/gzip/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.riken.jp/GNU/gnu/gzip/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.sunet.se/mirror/archive/ftp.sunet.se/pub/Linux/distributions/bifrost/download/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lfs-matrix.net/pub/lfs/lfs-packages/6.6/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.devil-linux.org/pub/devel/sources/1.4/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
