#!/bin/bash

SRC=avrdude-6.2.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=11eba11661713a43d371e4ff382d98c3

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://nongnu.askapache.com/avrdude/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://download.savannah.gnu.org/releases/avrdude/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror6.layerjet.com/nongnu/avrdude/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.chmuri.net/salix/i486/extra-14.2/source/development/avrdude/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
