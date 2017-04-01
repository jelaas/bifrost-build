#!/bin/bash

SRC=strace-4.5.20.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=64dfe10d9db0c1e34030891695ffca4b

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distro.ibiblio.org/openwall/Owl/pool/sources/strace/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://slackbuilds.org/mirror/slackware/slackware-13.37/source/d/strace/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/strace/strace-4.5.20.tar.bz2/64dfe10d9db0c1e34030891695ffca4b/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://oe-lite.org/mirror/crosstool-ng/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.sunet.se/mirror/archive/ftp.sunet.se/pub/Linux/distributions/bifrost/download/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://repository.timesys.com/buildsources/s/strace/strace-4.5.20/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.efixo.net/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" https://ftp.yzu.edu.tw/Linux/Owl/pool/sources/strace/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lip6.fr/pub/linux/distributions/slackware/slackware-13.37/source/d/strace/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sourceforge.mirrorservice.org/s/st/strace/strace/4.5.20/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.devil-linux.org/pub/devel/sources/1.4/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.math.princeton.edu/pub/slackware/slackware64-14.0/source/d/strace/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.pgpi.org/pub/Linux/slackware/slackware64-14.0/source/d/strace/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.guralp.com/platinum/opensource/platinum-stable-13349/files/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
