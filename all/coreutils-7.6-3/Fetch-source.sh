#!/bin/bash

SRC=coreutils-7.6.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=3d82f979229365f880da750642e67cf3

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://ftp.sunet.se/pub/gnu/coreutils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.riken.jp/GNU/gnu/coreutils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.yz.yamagata-u.ac.jp/pub/GNU/coreutils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distro.ibiblio.org/tinycorelinux/2.x/tcz/src/coreutils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.lihnidos.org/GNU/ftp/gnu/coreutils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.clfs.org/pub/clfs/conglomeration/coreutils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.sunet.se/mirror/archive/ftp.sunet.se/pub/Linux/distributions/bifrost/download/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" https://mirrors.peers.community/mirrors/gnu/coreutils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://download.nust.na/pub/ftp.gnu.org/gnu/coreutils/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
