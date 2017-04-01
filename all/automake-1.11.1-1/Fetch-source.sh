#!/bin/bash

SRC=automake-1.11.1.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=c2972c4d9b3e29c03d5f2af86249876f

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.gnu.org/gnu/automake/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.cogentco.com/pub/gnu/automake/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.riken.jp/GNU/gnu/automake/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://gnu.askapache.com/automake/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://gnu.raffsoftware.com/automake/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://oe-lite.org/mirror/automake/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.iij.ad.jp/pub/linux/momonga/updates/6/SOURCES/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
