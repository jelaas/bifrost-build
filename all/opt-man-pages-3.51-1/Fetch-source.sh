#!/bin/bash

SRC=man-pages-3.51.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=f8d8cfb9fc92810c22cb37ca33a18a5a

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.riken.jp/Linux/kernel.org/linux/docs/man-pages/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.be.debian.org/pub/linux/docs/man-pages/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.nodesdirect.com/kernel/linux/docs/man-pages/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
