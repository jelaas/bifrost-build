#!/bin/bash

SRC=gcc-5.3.0.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=c9616fd448f980259c31de613e575719

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://ftp.gnu.org/pub/gnu/gcc/gcc-5.3.0/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.wayne.edu/gnu/gcc/gcc-5.3.0/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.bjtu.edu.cn/gnu/gcc/gcc-5.3.0/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.acc.umu.se/mirror/gnu.org/gnu/gcc/gcc-5.3.0/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.unicamp.br/pub/gnu/gcc/gcc-5.3.0/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.iij.ad.jp/pub/gnu/gcc/gcc-5.3.0/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.jaist.ac.jp/pub/GNU/gcc/gcc-5.3.0/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://gnumirror.nkn.in/gcc/gcc-5.3.0/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ocw.nust.na/ftp.gnu.org/gnu/gcc/gcc-5.3.0/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.mirrorservice.org/sites/sourceware.org/pub/gcc/releases/gcc-5.3.0/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.netgull.com/gcc/releases/gcc-5.3.0/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirrors-usa.go-parts.com/gcc/releases/gcc-5.3.0/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
