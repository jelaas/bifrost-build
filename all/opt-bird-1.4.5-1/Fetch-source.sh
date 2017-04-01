#!/bin/bash

SRC=bird-1.4.5.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=a8e5e0a9129ce30fe6102c593bafb763

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://bird.network.cz/pub/bird/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.icm.edu.pl/packages/bird/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://entware.dyndns.info/sources/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.twaren.net/FreeBSD/ports/distfiles/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://trumpetti.atm.tut.fi/gentoo/distfiles/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
