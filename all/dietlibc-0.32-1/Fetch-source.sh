#!/bin/bash

SRC=dietlibc-0.32.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=0098761c17924c15e21d25acdda4a8b5

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/dietlibc/dietlibc-0.32.tar.bz2/0098761c17924c15e21d25acdda4a8b5/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://korg.cs.utah.edu/pub/linux/libs/dietlibc/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.sunet.se/mirror/archive/ftp.sunet.se/pub/Linux/distributions/bifrost/download/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distro.ibiblio.org/fatdog/source/600/d/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ba.mirror.garr.it/mirrors/slitaz/sources/packages-4.0/d/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://download.tuxfamily.org/slitaz/sources/packages/d/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://download.lunar-linux.org/lunar/cache/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
