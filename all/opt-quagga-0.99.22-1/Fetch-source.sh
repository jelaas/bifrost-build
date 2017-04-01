#!/bin/bash

SRC=quagga-0.99.22.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=3057bf3a91116a1017dd0df7e5e8ef93

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://downloads.sourceforge.net/project/quagga/"${SRC}"       \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://downloads.sourceforge.net/project/quagga/attic/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://download.savannah.gnu.org/releases/quagga/"${SRC}"      \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.quagga.net/download/"${SRC}"       \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.quagga.net/download/attic/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
