#!/bin/bash

SRC=libnl-1.1.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=ae970ccd9144e132b68664f98e7ceeb1

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://people.suug.ch/~tgr/libnl/files/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" https://people.gnome.org/~fpeters/libnl/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://repository.timesys.com/buildsources/l/libnl/libnl-1.1/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.uni-stuttgart.de/pub/mirrors/mirror.slitaz.org/slitaz/sources/packages-2.0/l/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.b-tronic.net/source/src/LGPL/libnl/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://gpl.matrix-vision.com/mvblx-sources/LGPL/libnl/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distro.ibiblio.org/slitaz/sources/packages/l/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.ufs.ac.za/archlinux/other/libnl/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
