#!/bin/bash

SRC=util-linux-2.20.1.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=079b37517fd4e002a2e6e992e8b4e361

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://ftp.kernel.org/pub/linux/utils/util-linux/v2.20/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.be.debian.org/pub/linux/utils/util-linux/v2.20/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/util-linux/util-linux-2.20.1.tar.bz2/079b37517fd4e002a2e6e992e8b4e361/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.mirrorservice.org/pub/linux/utils/util-linux/v2.20/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sources.angstrom-distribution.org/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" https://www.jabawok.net/gentoo/distfiles/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sources.buildroot.net/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" https://downloads.yoctoproject.org/mirror/sources/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
