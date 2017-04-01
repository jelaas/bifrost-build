#!/bin/bash

SRC=util-linux-ng-2.17.2.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=4635725a3eef1c57090bac8ea5e082e6

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://ftp.kernel.org/pub/linux/utils/util-linux/v2.17/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.pgpi.org/pub/linux/utils/util-linux/v2.17/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.be.debian.org/pub/linux/utils/util-linux-ng/v2.17/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://dl.t2-project.org/mirror/8.0/u/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distro.ibiblio.org/tinycorelinux/3.x/release/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.sunet.se/mirror/archive/ftp.sunet.se/pub/Linux/distributions/bifrost/download/src/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
