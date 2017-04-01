#!/bin/bash

SRC=cronie-1.4.4.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=eb9834c5f87cca9efeed68e6fed3fe3d

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://fedorahosted.org/releases/c/r/cronie/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://bbgentoo.ilb.ru/distfiles/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/lookaside/pkgs/cronie/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.acc.umu.se/mirror/archive/ftp.sunet.se/pub/Linux/distributions/bifrost/download/src/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
