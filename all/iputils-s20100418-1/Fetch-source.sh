#!/bin/bash

SRC=iputils-s20100418.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=df6b0062118cdc5c62e3c810f831e976

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.skbuff.net/iputils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/extras/iputils/iputils-s20100418.tar.bz2/df6b0062118cdc5c62e3c810f831e976/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.skbuff.net/iputils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.clfs.org/pub/clfs/conglomeration/iputils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distro.ibiblio.org/amigolinux/distro/kiss-4.0/SOURCE/net/iputils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.math.princeton.edu/pub/slackware/slackware64-13.1/source/n/iputils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.bjtu.edu.cn/clfs/conglomeration/iputils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.mirrorservice.org/pub/slackware/slackware-13.1/source/n/iputils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://slackware.blizoo.mk/slackware/slackware-13.1/source/n/iputils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.linuxgrill.com/anonymous/iproute2/iputils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.slackware.org.nz/slackware//slackware64-13.1/source/n/iputils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.acc.umu.se/mirror/archive/ftp.sunet.se/pub/Linux/distributions/bifrost/download/src/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
