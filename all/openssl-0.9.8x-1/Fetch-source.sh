#!/bin/bash

SRC=openssl-0.9.8x.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=ee17e9bc805c8cc7d0afac3b0ef78eda

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.openssl.org/source/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://public.yafi.ru/gentoo/distfiles/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.pccc.com/downloads/apache/current/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
