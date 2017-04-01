#!/bin/bash

SRC=openssl-0.9.8y.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=47c7fb37f78c970f1d30aa2f9e9e26d8

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.openssl.org/source/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://code.enthought.com/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.riken.jp/net/OpenSSL/old/0.9.x/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
