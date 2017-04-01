#!/bin/bash

SRC=squid-3.1.22.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=a25ce5937875990c950cc8cd1b120a5e

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.squid-cache.org/Versions/v3/3.1/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.meisei-u.ac.jp/mirror/squid/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.riken.jp/net/squid/squid/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.ist.utl.pt/pub/squid/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://namibia.html.tucows.com/squid/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.icm.edu.pl/packages/squid/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://source.ipfire.org/source-2.x/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirrors.is.co.za/pub/squid/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
