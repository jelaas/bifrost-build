#!/bin/bash

SRC=uClibc-0.9.30.1.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=1a4b84e5536ad8170563ffa88c34679c

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://uclibc.org/downloads/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lfs-matrix.net/pub/clfs/conglomeration/uClibc/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/uClibc/uClibc-0.9.30.1.tar.bz2/1a4b84e5536ad8170563ffa88c34679c/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://landley.net/aboriginal/mirror/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" https://downloads.openwrt.org/sources/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.bjtu.edu.cn/clfs/conglomeration/uClibc/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://clfs.org/files/packages/embedded-0.0.1/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" https://dl.t2-project.org/mirror/8.0/u/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distro.ibiblio.org/tinycorelinux/2.x/release/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.efixo.net/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
