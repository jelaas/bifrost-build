#!/bin/bash

SRC=automake-1.15.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=716946a105ca228ab545fc37a70df3a3

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.riken.jp/GNU/gnu/automake/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.cogentco.com/pub/gnu/automake/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://cdimage.debian.org/mirror/gnu.org/gnu/automake/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" https://distfiles.macports.org/automake/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://gnu.mirror.constant.com/automake/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://dev.gateworks.com/sources/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://openlinux.amlogic.com:8000/download/GPL_code_release/ThirdParty/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sources.webos-ports.org/downloads/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
