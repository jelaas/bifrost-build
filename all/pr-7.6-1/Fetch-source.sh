#!/bin/bash

SRC=coreutils-7.6.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=3d82f979229365f880da750642e67cf3

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://ftp.sunet.se/pub/gnu/coreutils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.riken.jp/GNU/gnu/coreutils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.yz.yamagata-u.ac.jp/pub/GNU/coreutils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.lihnidos.org/GNU/ftp/gnu/coreutils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.sunet.se/mirror/archive/ftp.sunet.se/pub/Linux/distributions/bifrost/download/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.ntu.edu.tw/pub/gnu/coreutils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.clfs.org/pub/clfs/conglomeration/coreutils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" https://mirrors.peers.community/mirrors/gnu/coreutils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://download.nust.na/pub/ftp.gnu.org/gnu/coreutils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://download.nust.na/pub/ftp.gnu.org/gnu/coreutils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://cpan.nust.na/ftp.gnu.org/gnu/coreutils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.otenet.gr/gnu/coreutils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://core.ring.gr.jp/archives/GNU/coreutils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://gnu.mirror.constant.com/coreutils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" https://public.p-knowledge.co.jp/gnu-mirror/coreutils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://open-source-box.org/coreutils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.rasanegar.com/gnu/coreutils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://gnumirror.nkn.in/coreutils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.casita.houston.tx.us/pub/skel/coreutils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.internode.on.net/pub/gnu/coreutils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://download.tuxfamily.org/slitaz/sources/packages/c/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirrors.hust.edu.cn/gnu/coreutils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.igh.cnrs.fr/pub/gnu/coreutils/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
