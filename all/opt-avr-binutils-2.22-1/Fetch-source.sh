#!/bin/bash

SRC=binutils-2.22.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=ee0f10756c84979622b992a4a61ea3f5

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://ftp.gnu.org/pub/gnu/binutils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.mirrorservice.org/sites/sourceware.org/pub/binutils/releases/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.ntu.edu.tw/gnu/binutils/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" https://downloads.openwrt.org/sources/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://dev.gateworks.com/sources/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
