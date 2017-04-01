#!/bin/bash

SRC=iproute2-3.6.0.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=cbb1d326ee73e21df5fd35d210d67f0a

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.sunet.se/pub/Linux/distributions/bifrost/download/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.iij.ad.jp/pub/linux/kernel/linux/utils/net/iproute2/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.riken.jp/Linux/kernel.org/linux/utils/net/iproute2/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
