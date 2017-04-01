#!/bin/bash

SRC=ncurses-5.7.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=cce05daf61a64501ef6cd8da1f727ec6

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://ftp.sunet.se/pub/gnu/ncurses/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/ncurses/ncurses-5.7.tar.gz/cce05daf61a64501ef6cd8da1f727ec6/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.tw.freebsd.org/distfiles/ncurses/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.clfs.org/pub/clfs/conglomeration/ncurses/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.bjtu.edu.cn/clfs/conglomeration/ncurses/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://invisible-mirror.net/archives/ncurses/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.ist.utl.pt/pub/slackware/slackware-current/source/l/ncurses/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.naist.jp/pub/Linux/slackware/slackware64-13.0/source/l/ncurses/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.oasis.onnetcorp.com/FreeBSD/distfiles/ncurses/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.b-tronic.net/source/src/MIT/ncurses/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.rasanegar.com/gnu/ncurses/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.guralp.com/platinum/opensource/platinum-stable-13718/files/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
