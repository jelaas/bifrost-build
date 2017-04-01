#!/bin/bash

SRC=openssl-0.9.8p.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=7f24047f70364c9eabc94899e356ce39

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.openssl.org/source/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.efixo.net/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://downloads.yoctoproject.org/releases/yocto/yocto-1.0/sources/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://luci.subsignal.org/~jow/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
