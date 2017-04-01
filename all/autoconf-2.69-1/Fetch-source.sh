#!/bin/bash

SRC=autoconf-2.69.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=82d05e03b93e45f5a39b828dc9c6c29b

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://ftp.sunet.se/pub/gnu/autoconf/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.riken.jp/GNU/gnu/autoconf/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.unicamp.br/pub/gnu/autoconf/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://download.videolan.org/pub/contrib/autoconf/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://webdiis.unizar.es/pub/unix/prog/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://dev.gateworks.com/sources/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://netbsd.gw.com/pub/distfiles/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.embedian.com/oe-downloads/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.lihnidos.org/GNU/ftp/gnu/autoconf/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
