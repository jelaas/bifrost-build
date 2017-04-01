#!/bin/bash

SRC=xz-5.0.3.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=8d900b742b94fa9e708ca4f5a4b29003

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://tukaani.org/xz/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/extras/xz/xz-5.0.3.tar.bz2/8d900b742b94fa9e708ca4f5a4b29003/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://tukaani.org/xz/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distro.ibiblio.org/slitaz/sources/packages/x/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lfs-matrix.net/pub/lfs/lfs-packages/7.1/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
