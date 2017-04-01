#!/bin/bash

SRC=libav-9.6.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=53b0b21a509c4dc9c1df84fbbae021cf

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://libav.org/releases/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.icm.edu.pl/packages/libav/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
