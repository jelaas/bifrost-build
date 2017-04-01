#!/bin/bash

SRC=grep-2.6.3.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=3095b57837b312f087c0680559de7f13

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://ftp.gnu.org/pub/gnu/grep/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://gnu.mirror.constant.com/grep/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.riken.jp/GNU/gnu/grep/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lfs-matrix.net/pub/clfs/conglomeration/grep/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
