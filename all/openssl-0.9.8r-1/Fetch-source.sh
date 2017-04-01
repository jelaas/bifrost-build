#!/bin/bash

SRC=openssl-0.9.8r.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=0352932ea863bc02b056cda7c9ac5b79

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.openssl.org/source/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.acc.umu.se/mirror/xbmc.org/build-deps/sources/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://kanebebe.dip.jp/download/ARM9-2440-DVD/Linux/apache/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.sunet.se/mirror/archive/ftp.sunet.se/pub/multimedia/xbmc/build-deps/darwin-libs/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://freetz.mhampicke.de/packages/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://public.yafi.ru/gentoo/distfiles/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
