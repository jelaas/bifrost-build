#!/bin/bash

SRC=libcap-2.19.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=eb1ff04d39bfa2342b8e78b0fd60dc2d

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.be.debian.org/pub/linux/libs/security/linux-privs/libcap2/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.sunet.se/pub/Linux/distributions/bifrost/download/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.linux.org.au/linux/libs/security/linux-privs/libcap2/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.naist.jp/pub/linux/libs/security/linux-privs/libcap2/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://korg.cs.utah.edu/pub/linux/libs/security/linux-privs/libcap2/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distro.ibiblio.org/slitaz/sources/packages/l/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.slackware.org.nz/slackware//slackware64-13.1/source/l/libcap/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.uni-stuttgart.de/pub/mirrors/mirror.slitaz.org/slitaz/sources/packages/l/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.acc.umu.se/mirror/archive/ftp.sunet.se/pub/Linux/distributions/bifrost/download/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://slackware.blizoo.mk/slackware/slackware-13.1/source/l/libcap/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
