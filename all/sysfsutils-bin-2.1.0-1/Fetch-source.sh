#!/bin/bash

SRC=sysfsutils-2.1.0.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=14e7dcd0436d2f49aa403f67e1ef7ddc

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://downloads.sourceforge.net/project/linux-diag/sysfsutils/2.1.0/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distro.ibiblio.org/damnsmall/dslcore/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.guralp.com/platinum/opensource/platinum-stable-13349/files/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://oe-lite.org/mirror/sysfsutils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://tinycorelinux.net/archive/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.devil-linux.org/pub/devel/sources/1.4/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.uni-stuttgart.de/pub/mirrors/mirror.slitaz.org/slitaz/sources/packages-4.0/s/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://files.virt2real.ru/packages/buildroot/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
