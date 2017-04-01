#!/bin/bash

SRC=libnfnetlink-1.0.1.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=98927583d2016a9fb1936fed992e2c5e

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.netfilter.org/projects/libnfnetlink/files/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.netfilter.org/pub/libnfnetlink/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/libnfnetlink/libnfnetlink-1.0.1.tar.bz2/98927583d2016a9fb1936fed992e2c5e/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://repository.timesys.com/buildsources/l/libnfnetlink/libnfnetlink-1.0.1/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://files.virt2real.ru/packages/buildroot/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.uni-stuttgart.de/pub/mirrors/mirror.slitaz.org/slitaz/sources/packages/l/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://dev.gateworks.com/sources/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mir0.gentoo-fr.org/distfiles/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sources.buildroot.net/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://download.tuxfamily.org/slitaz/sources/packages/l/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ba.mirror.garr.it/mirrors/slitaz/sources/packages-cooking/l/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://source.ipfire.org/source-2.x/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://home.rmrf.org/o/openwrt/misc/dls/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://dl.openwrtdl.com/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
