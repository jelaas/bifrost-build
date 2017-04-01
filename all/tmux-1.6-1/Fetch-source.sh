#!/bin/bash

SRC=tmux-1.6.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=3e37db24aa596bf108a0442a81c845b3

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://kent.dl.sourceforge.net/project/tmux/tmux/tmux-1.6/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.mirrorservice.org/sites/download.salixos.org/x86_64/14.0/source/ap/tmux/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.uni-stuttgart.de/pub/mirrors/mirror.slitaz.org/slitaz/sources/packages-4.0/t/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://salix.enialis.net/arm/14.0/source/ap/tmux/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ba.mirror.garr.it/mirrors/slitaz/sources/packages-4.0/t/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distro.ibiblio.org/slitaz/sources/packages/t/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://downloads.aredn.org/sources/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://software.verknowsys.com/source/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
