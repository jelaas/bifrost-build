#!/bin/bash

SRC=openssl-0.9.8q.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=80e67291bec9230f03eefb5cfe858998

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.openssl.org/source/"${SRC}" \
[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.sunet.se/mirror/archive/ftp.sunet.se/pub/Linux/distributions/bifrost/old/src/"${SRC}" \
[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://opkg.familienforum.biz/download/"${SRC}" \
[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://freetz.mhampicke.de/packages/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
