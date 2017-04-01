#!/bin/bash

SRC=openssl-1.0.1g.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=de62b43dfcd858e66a74bee1c834e959

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.openssl.org/source/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://repository.timesys.com/buildsources/o/openssl/openssl-1.0.1g/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.riken.jp/net/OpenSSL/old/1.0.1/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distfiles.macports.org/openssl/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.guralp.com/platinum/opensource/tarballs/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
