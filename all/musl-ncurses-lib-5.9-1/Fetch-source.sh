#!/bin/bash

SRC=ncurses-5.9.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=8cb9c412e5f2d96bc6f459aa8c6282a1

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.gnu.org/pub/gnu/ncurses/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.tw.freebsd.org/distfiles/ncurses/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://download.nust.na/pub/ftp.gnu.org/gnu/ncurses/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.clfs.org/pub/clfs/conglomeration/ncurses/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://gnu.askapache.com/ncurses/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://download.videolan.org/pub/contrib/ncurses/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://repository.timesys.com/buildsources/n/ncurses/ncurses-5.9/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://invisible-mirror.net/archives/ncurses/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
