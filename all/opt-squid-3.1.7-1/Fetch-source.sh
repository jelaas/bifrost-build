#!/bin/bash

SRC=squid-3.1.7.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=83e7aabc1b5bb5b7c83f6dc2f32ca418

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.squid-cache.org/Versions/v3/3.1/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.ist.utl.pt/pub/squid/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://artfiles.org/squid-cache.org/pub/archive/3.1/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp-archive.freebsd.org/pub/FreeBSD-Archive/ports/distfiles/squid3.1/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://piotrkosoft.net/pub/mirrors/squid-cache.org/pub/archive/3.1/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.gts.lug.ro/freebsd/distfiles/squid3.1/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
