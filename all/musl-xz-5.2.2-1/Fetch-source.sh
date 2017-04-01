#!/bin/bash

SRC=xz-5.2.2.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=7cf6a8544a7dae8e8106fdf7addfa28c

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://tukaani.org/xz/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://tukaani.org/xz/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://download2.nust.na/pub4/sourceforge/l/lz/lzmautils/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
