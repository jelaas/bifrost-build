#!/bin/bash

SRC=openssl-0.9.8o.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=63ddc5116488985e820075e65fbe6aa4

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.openssl.org/source/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sources.buildroot.net/"${SRC}"  \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://freetz.mhampicke.de/packages/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
