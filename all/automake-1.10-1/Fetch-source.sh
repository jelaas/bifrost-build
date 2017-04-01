#!/bin/bash

SRC=automake-1.10.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=0e2e0f757f9e1e89b66033905860fded

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.gnu.org/gnu/automake/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.riken.jp/GNU/gnu/automake/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.cogentco.com/pub/gnu/automake/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.mirrorservice.org/sites/sourceware.org/pub/automake/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lanet.lv/ftp/GNU/automake/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://cdimage.debian.org/mirror/gnu.org/gnu/automake/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://gnu.raffsoftware.com/automake/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.spectrumcontrols.com/OpenSource/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
