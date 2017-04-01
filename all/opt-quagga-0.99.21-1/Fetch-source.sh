#!/bin/bash

SRC=quagga-0.99.21.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=99840adbe57047c90dfba6b6ed9aec7f

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://downloads.sourceforge.net/project/quagga/"${SRC}"       \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://downloads.sourceforge.net/project/quagga/attic/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://download.savannah.gnu.org/releases/quagga/"${SRC}"      \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.quagga.net/download/"${SRC}"       \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.quagga.net/download/attic/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
