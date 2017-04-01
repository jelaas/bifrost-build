#!/bin/bash

SRC=gcc-core-4.6.1.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=0c0e7e35d2215e19de9c97efba507553

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://ftp.gnu.org/pub/gnu/gcc/gcc-4.6.1/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.yzu.edu.tw/gnu/gcc/gcc-4.6.1/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirrors.ibiblio.org/gnu/ftp/gnu/gcc/gcc-4.6.1/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.mirrorservice.org/sites/sourceware.org/pub/gcc/releases/gcc-4.6.1/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://download.nust.na/pub/ftp.gnu.org/gnu/gcc/gcc-4.6.1/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.squ.edu.om/gnu/gcc/gcc-4.6.1/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ocw.nust.na/ftp.gnu.org/gnu/gcc/gcc-4.6.1/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://gcc.parentingamerica.com/releases/gcc-4.6.1/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://gnu.mirror.vexxhost.com/gcc/gcc-4.6.1/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.lihnidos.org/GNU/ftp/gnu/gcc/gcc-4.6.1/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.igh.cnrs.fr/pub/gnu/gcc/gcc-4.6.1/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://gcc.skazkaforyou.com/releases/gcc-4.6.1/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
