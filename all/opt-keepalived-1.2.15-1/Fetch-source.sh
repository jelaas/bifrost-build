#!/bin/bash

SRC=keepalived-1.2.15.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=d85fcb8e564ea03b0ca7b2357bf30c51

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.keepalived.org/software/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distro.ibiblio.org/slitaz/sources/packages/k/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.uni-stuttgart.de/pub/mirrors/mirror.slitaz.org/slitaz/sources/packages/k/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sources.lede-project.org/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.uni-stuttgart.de/pub/mirrors/mirror.slitaz.org/slitaz/sources/packages/k/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ba.mirror.garr.it/mirrors/slitaz/sources/packages-cooking/k/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
