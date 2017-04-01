#!/bin/bash

SRC=nmap-5.21.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=f77fa51d89ab27d35e5cd87bb086b858

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://nmap.org/dist/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/nmap/nmap-5.21.tar.bz2/f77fa51d89ab27d35e5cd87bb086b858/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.icm.edu.pl/packages/nmap/dist/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://dl.t2-project.org/mirror/8.0/n/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.linuxolution.org/soft/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.sunet.se/mirror/archive/ftp.sunet.se/pub/Linux/distributions/bifrost/download/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distfiles.icmpv6.org/distfiles/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.acc.umu.se/mirror/archive/ftp.sunet.se/pub/Linux/distributions/bifrost/download/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.sleepgate.ru/pub/FreeBSD/ports/distfiles/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.yafi.ru/distfiles/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://portage.macrolan.co.za/distfiles/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
