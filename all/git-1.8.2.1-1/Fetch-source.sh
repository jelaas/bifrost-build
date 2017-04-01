#!/bin/bash

SRC=git-1.8.2.1.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=3f6ebca116c627490e4ee1f1324d5e65

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://git-core.googlecode.com/files/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://geoweb.cse.ucdavis.edu/~buildbot/deps/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lyx.org/pub/minix/distfiles/backup/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://daemon.plala.jp/~meke/files/PKGS/SOURCES/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distfiles.icmpv6.org/distfiles/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lfs-matrix.net/pub/blfs/conglomeration/git/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
