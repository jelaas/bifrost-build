#!/bin/bash

SRC=tmux-1.9a.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=b07601711f96f1d260b390513b509a2d

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://kent.dl.sourceforge.net/project/tmux/tmux/tmux-1.9/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://repo.onion.io/omega/source/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distro.ibiblio.org/quirky/quirky6/sources/easy/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://dlc.everycity.com/ec-userland/source-archives/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lip6.fr/pub/minix/distfiles/local/3.3.0/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sources.buildroot.net/?C=M;O=A"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://software.verknowsys.com/source/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://source.ipfire.org/source-2.x/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
