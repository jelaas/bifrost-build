#!/bin/bash

SRC=openssl-1.0.1t.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=51a40a81b3b7abe8a5c33670bd3da0ce

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.openssl.org/source/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" https://mirror.umd.edu/xbmc/build-deps/sources/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://repository.timesys.com/buildsources/o/openssl/openssl-1.0.1t/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
