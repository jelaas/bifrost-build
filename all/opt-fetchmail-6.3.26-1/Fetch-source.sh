#!/bin/bash

SRC=fetchmail-6.3.26.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=d9ae3d939205a3c06a21ea79b8f14793

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distro.ibiblio.org/slitaz/sources/packages/f/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ba.mirror.garr.it/mirrors/slitaz/sources/packages-cooking/f/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distro.ibiblio.org/slitaz/sources/packages/f/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.uni-stuttgart.de/pub/mirrors/mirror.slitaz.org/slitaz/sources/packages/f/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://f.archlinuxvn.org/slitaz/sources/packages/f/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
