#!/bin/bash

SRC=autoconf-2.61.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=51f472f71a6a04850a0f0126bf594cdb

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://ftp.sunet.se/pub/gnu/autoconf/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.riken.jp/GNU/gnu/autoconf/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.unicamp.br/pub/gnu/autoconf/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lanet.lv/ftp/GNU/autoconf/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.mirbsd.org/.Archive/FreeWRT/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.jabawok.net/gentoo/distfiles/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.ffmpeginstaller.com/old/sources/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://portage.macrolan.co.za/distfiles/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.igh.cnrs.fr/pub/gnu/autoconf/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
