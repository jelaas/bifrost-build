#!/bin/bash

SRC=libtirpc-1.0.1.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=36ce1c0ff80863bb0839d54aa0b94014

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://downloads.sourceforge.net/project/libtirpc/libtirpc/1.0.1/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/libtirpc/libtirpc-1.0.1.tar.bz2/36ce1c0ff80863bb0839d54aa0b94014/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lfs-matrix.net/pub/blfs/conglomeration/libtirpc/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.fileplanet.com/lfs/pub/blfs/conglomeration/libtirpc/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.clfs.org/pub/blfs/7.9/l/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sources.openelec.tv/mirror/libtirpc/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://download2.nust.na/pub4/sourceforge/l/li/libtirpc/libtirpc/1.0.1/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www4.frugalware.org/pub/linux/distributions/frugalware/frugalware-stable/source/lib/libtirpc/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://tinycorelinux.net/7.x/x86_64/tcz/src/libtirpc/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distfiles.lesslinux.org/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://portages.ifcem.if.ua/distfiles/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
