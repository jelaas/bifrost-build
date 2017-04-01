#!/bin/bash

SRC=make-3.81.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=a4e9494ac6dc3f6b0c5ff75c5d52abba

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://ftp.gnu.org/pub/gnu/make/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.riken.jp/GNU/gnu/make/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lanet.lv/ftp/GNU/make/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.ntu.edu.tw/gnu/make/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://open-source-box.org/make/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
