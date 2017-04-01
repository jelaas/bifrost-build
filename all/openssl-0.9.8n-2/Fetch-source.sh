#!/bin/bash

SRC=openssl-0.9.8n.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=076d8efc3ed93646bd01f04e23c07066

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.openssl.org/source/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.riken.jp/net/OpenSSL/old/0.9.x/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://repository.timesys.com/buildsources/o/openssl/openssl-0.9.8n/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" https://downloads.openwrt.org/sources/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.naist.jp/pub/Linux/momonga/updates/6.1/SOURCES/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
