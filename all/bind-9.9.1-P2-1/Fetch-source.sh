#!/bin/bash

SRC=bind-9.9.1-P2.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=5f2f9ec0f1f1c67beaada349cdac0c15

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://ftp.isc.org/isc/bind9/9.9.1-P2/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" https://www.mirrorservice.org/sites/ftp.isc.org/isc/bind/9.9.1-P2/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.ripe.net/mirrors/sites/ftp.isc.org/isc/bind/9.9.1-P2/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lfs-matrix.net/pub/blfs/conglomeration/bind/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/bind/bind-9.9.1-P2.tar.gz/5f2f9ec0f1f1c67beaada349cdac0c15/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.go-parts.com/mirrors-usa/blfs/conglomeration/bind/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.yafi.ru/distfiles/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://bbgentoo.ilb.ru/distfiles/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" https://www.jabawok.net/gentoo/distfiles/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.sobukus.de/files/src/bind/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
