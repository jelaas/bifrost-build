#!/bin/bash

SRC=ncurses-5.7.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=cce05daf61a64501ef6cd8da1f727ec6

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://ftp.sunet.se/pub/gnu/ncurses/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/ncurses/ncurses-5.7.tar.gz/cce05daf61a64501ef6cd8da1f727ec6/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.tw.freebsd.org/distfiles/ncurses/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.clfs.org/pub/clfs/conglomeration/ncurses/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://download.nust.na/pub/ftp.gnu.org/gnu/ncurses/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://invisible-mirror.net/archives/ncurses/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://slackware.blizoo.mk/slackware/slackware64-13.0/source/l/ncurses/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.ntu.edu.tw/gnu/ncurses/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
