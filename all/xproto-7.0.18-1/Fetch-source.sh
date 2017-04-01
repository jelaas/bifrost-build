#!/bin/bash

SRC=xproto-7.0.18.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=6b8a34b274c6fceaffe57c579db826b9

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://xorg.freedesktop.org/releases/individual/proto/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.riken.jp/X11/ftp.x.org/pub/individual/proto/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sources.angstrom-distribution.org/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lyx.org/pub/minix/distfiles/backup/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://dlc.openindiana.org/oi-build/source-archives/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://source.ipfire.org/source-3.x/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.minix3.org/distfiles-backup/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.igh.cnrs.fr/pub/os/openindiana/dlc/oi-build/source-archives/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
