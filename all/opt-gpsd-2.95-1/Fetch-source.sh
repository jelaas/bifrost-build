#!/bin/bash

SRC=gpsd-2.95.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=12535a9ed9fecf9ea2c5bdc9840da5ae

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.mirrorservice.org/sites/downloads.sourceforge.net/g/gp/gpsd.berlios/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sources.buildroot.net/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
