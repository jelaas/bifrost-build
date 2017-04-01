#!/bin/bash

SRC=inetutils-1.9.1.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=944f7196a2b3dba2d400e9088576000c

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.sunet.se/pub/gnu/inetutils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.swin.edu.au/gnu/inetutils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.riken.jp/GNU/gnu/inetutils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://cdimage.debian.org/mirror/gnu.org/gnu/inetutils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lfs-matrix.net/pub/lfs/lfs-packages/7.2/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.multitech.net/mlinux/sources/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.netinch.com/pub/LFS/lfs-packages/7.4-rc1/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.manux.info/versions/0/0.0.1/sources_std/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
