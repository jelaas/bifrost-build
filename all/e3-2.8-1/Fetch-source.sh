#!/bin/bash

SRC=e3-2.8.tgz
SSRC=e3-2.8.tar.gz
DST=/var/spool/src/"${SSRC}"
MD5=0120bb073133ad26a054b35f88333183

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sites.google.com/site/e3editor/Home/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" https://src.fedoraproject.org/repo/pkgs/rpms/e3/e3-2.8.tgz/0120bb073133ad26a054b35f88333183/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distro.ibiblio.org/fatdog/source/600/e/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distro.ibiblio.org/slitaz/sources/packages-cooking/e/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.eu.openbsd.org/pub/mirrors/lunar-linux.org/lunar/mirrors/?C=D;O=A"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" https://download.tuxfamily.org/slitaz/sources/packages-4.0/e/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.uni-stuttgart.de/pub/mirrors/mirror.slitaz.org/slitaz/sources/packages-stable/e/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://trumpetti.atm.tut.fi/gentoo/distfiles/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://dietpc.org/downloads/source/common/e3/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ba.mirror.garr.it/mirrors/slitaz/sources/packages-cooking/e/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
