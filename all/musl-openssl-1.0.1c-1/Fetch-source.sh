#!/bin/bash

SRC=openssl-1.0.1c.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=ae412727c8c15b67880aef7bd2999b2e

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.openssl.org/source/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.riken.jp/net/OpenSSL/old/1.0.1/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://strawberryperl.com/package/kmx/libs_src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.guralp.com/platinum/opensource/tarballs/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sources.buildroot.net/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
