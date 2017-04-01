#!/bin/bash

SRC=libnet-1.1.4.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=c5e06418a89cc4209f677a776a798fd9

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://downloads.sourceforge.net/project/libnet-dev/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/libnet/libnet-1.1.4.tar.gz/c5e06418a89cc4209f677a776a798fd9/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mexmat.sgu.ru/soft/Linux/distributions/gentoo/distfiles/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.acc.umu.se/mirror/archive/ftp.sunet.se/pub/Linux/distributions/bifrost/download/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://freetz.mhampicke.de/packages/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
