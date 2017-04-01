#!/bin/bash

SRC=quagga-0.99.24.1.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=7986bdc2fe6027d4c9216f7f5791e718

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://downloads.sourceforge.net/project/quagga/"${SRC}"       \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://downloads.sourceforge.net/project/quagga/attic/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://download.savannah.gnu.org/releases/quagga/"${SRC}"      \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.quagga.net/download/"${SRC}"       \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.quagga.net/download/attic/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
