#!/bin/bash

SRC=quagga-1.1.0.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=daa303871e07ea5856aae6fd79e89722

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://downloads.sourceforge.net/project/quagga/"${SRC}"       \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://downloads.sourceforge.net/project/quagga/attic/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://download.savannah.gnu.org/releases/quagga/"${SRC}"      \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.quagga.net/download/"${SRC}"       \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.quagga.net/download/attic/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
