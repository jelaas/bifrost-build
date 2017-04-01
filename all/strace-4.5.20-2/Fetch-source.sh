#!/bin/bash

SRC=strace-4.5.20.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=64dfe10d9db0c1e34030891695ffca4b

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://downloads.sourceforge.net/project/strace/strace/4.5.20/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distro.ibiblio.org/openwall/Owl/pool/sources/strace/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lip6.fr/pub/linux/distributions/slackware/slackware-13.37/source/d/strace/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.sunet.se/mirror/archive/ftp.sunet.se/pub/Linux/distributions/bifrost/download/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://oe-lite.org/mirror/crosstool-ng/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" https://slackbuilds.org/mirror/slackware/slackware-14.0/source/d/strace/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://repository.timesys.com/buildsources/s/strace/strace-4.5.20/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.efixo.net/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.math.princeton.edu/pub/slackware/slackware64-14.0/source/d/strace/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://downloads.aredn.org/sources/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.acc.umu.se/mirror/archive/ftp.sunet.se/pub/Linux/distributions/bifrost/download/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ponce.cc/mirrors/slackware-13.37/source/d/strace/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
