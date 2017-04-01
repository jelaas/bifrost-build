#!/bin/bash

SRC=wget-1.18.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=fc2debd8399e3b933a9b226794e2a886

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.gnu.org/gnu/wget/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://sunsite.icm.edu.pl/pub/gnu/wget/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://gnu.askapache.com/wget/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.acc.umu.se/mirror/gnu.org/gnu/wget/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
