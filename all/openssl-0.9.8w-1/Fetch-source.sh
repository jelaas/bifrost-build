#!/bin/bash

SRC=openssl-0.9.8w.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=4ceb7d570e42c094b360cc7b8e848a0b

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.openssl.org/source/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.riken.jp/net/OpenSSL/old/0.9.x/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://repository.timesys.com/buildsources/o/openssl/openssl-0.9.8w/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
