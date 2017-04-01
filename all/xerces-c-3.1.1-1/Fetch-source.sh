#!/bin/bash

SRC=xerces-c-3.1.1.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=6a8ec45d83c8cfb1584c5a5345cb51ae

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://apache.archive.sunet.se/dist/xerces/c/3/sources/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/mingw32-xerces-c/xerces-c-3.1.1.tar.gz/6a8ec45d83c8cfb1584c5a5345cb51ae/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.mirrorservice.org/sites/vectorlinux.com/VL64-7.0/source/sourceAbs/xerces-c/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distro.ibiblio.org/slitaz/sources/packages/x/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
