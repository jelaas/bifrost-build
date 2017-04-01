#!/bin/bash

SRC=mysql-5.5.21.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=86d6bd335054a0aed1756ed60574c16d

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.sunet.se/pub/unix/databases/relational/mysql/Downloads/MySQL-5.5/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://app.nidc.kr/mysql/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distfiles.icmpv6.org/distfiles/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
