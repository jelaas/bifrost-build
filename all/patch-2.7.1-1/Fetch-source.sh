#!/bin/bash

SRC=patch-2.7.1.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=95dd8d7e41dcbcecdd5cd88ef915378d

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.gnu.org/gnu/patch/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://gnu.cypherpunks.ru/patch/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://download.nust.na/pub/ftp.gnu.org/gnu/patch/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://open-source-box.org/patch/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://gnu.askapache.com/patch/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.swin.edu.au/gnu/patch/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.dvlnx.com/software/gnu/patch/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sources.buildroot.net/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://gnu.mirror.constant.com/patch/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
