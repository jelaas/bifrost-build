#!/bin/bash

SRC=yasm-1.2.0.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=4cfc0686cf5350dd1305c4d905eb55a6

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.tortall.net/projects/yasm/releases/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/yasm/yasm-1.2.0.tar.gz/4cfc0686cf5350dd1305c4d905eb55a6/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://download.videolan.org/pub/videolan/testing/contrib/yasm/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
