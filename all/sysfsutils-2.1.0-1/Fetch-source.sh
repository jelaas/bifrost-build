#!/bin/bash

SRC=sysfsutils-2.1.0.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=14e7dcd0436d2f49aa403f67e1ef7ddc

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://downloads.sourceforge.net/project/linux-diag/sysfsutils/2.1.0/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distro.ibiblio.org/damnsmall/dslcore/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sourceforge.mirrorservice.org/l/li/linux-diag/sysfsutils/2.1.0/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.guralp.com/platinum/opensource/platinum-stable-13349/files/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.embeddedarm.com/ftp/mirror/yocto/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://oe-lite.org/mirror/sysfsutils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.multitech.net/mlinux/sources/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://tinycorelinux.net/archive/src/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
