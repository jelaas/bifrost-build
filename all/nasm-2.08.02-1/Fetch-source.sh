#!/bin/bash

SRC=nasm-2.08.02.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=2b0dfe9266491c14c4025f57c9cfd0f1

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.nasm.us/pub/nasm/releasebuilds/2.08.02/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.zytor.com/pub/nasm/releasebuilds/2.08.02/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.sunet.se/mirror/archive/ftp.sunet.se/pub/Linux/distributions/bifrost/download/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.acc.umu.se/mirror/archive/ftp.sunet.se/pub/Linux/distributions/bifrost/download/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://daemon.plala.jp/~meke/files/PKGS/SOURCES/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://kobyla.info/distfiles/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
