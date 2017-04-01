#!/bin/bash

SRC=imake-1.0.3.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=ff553c4646edcc9e76b7308991ad421a

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://xorg.freedesktop.org/releases/individual/util/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.riken.jp/X11/ftp.x.org/pub/individual/util/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distro.ibiblio.org/slitaz/sources/packages/i/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://tiger2.net/distfiles/xorg/util/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.stu.edu.tw/FreeBSD/distfiles/xorg/util/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distfiles.lesslinux.org/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://dlc.openindiana.org/oi-build/source-archives/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
