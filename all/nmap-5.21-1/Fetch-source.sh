#!/bin/bash

SRC=nmap-5.21.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=f77fa51d89ab27d35e5cd87bb086b858

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://nmap.org/dist/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://crypto.nknu.edu.tw/textbook/update/CH11/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.linuxolution.org/soft/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.icm.edu.pl/packages/nmap/dist/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.mirrorservice.org/sites/distfiles.finkmirrors.net/md5/f77fa51d89ab27d35e5cd87bb086b858/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.acc.umu.se/mirror/archive/ftp.sunet.se/pub/Linux/distributions/bifrost/download/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mexmat.sgu.ru/soft/Linux/distributions/gentoo/distfiles/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
