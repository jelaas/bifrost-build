#!/bin/bash

SRC=cmake-2.8.5.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=3c5d32cec0f4c2dc45f4c2e84f4a20c5

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.cmake.org/files/v2.8/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sources.angstrom-distribution.org/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.astro-wise.org/losoft/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://grey.colorado.edu/emergent_ftp/old/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://developer.digitalstrom.org/download/oe-sources-mirror/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distro.ibiblio.org/slitaz/sources/packages/c/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sources.buildroot.net/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
