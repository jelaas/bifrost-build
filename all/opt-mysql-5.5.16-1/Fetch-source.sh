#!/bin/bash

SRC=mysql-5.5.16.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=462ab3752dd666ec06ca32f92673b59e

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.sunet.se/pub/unix/databases/relational/mysql/Downloads/MySQL-5.5/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://app.nidc.kr/mysql/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.magiksys.net/download/ddumbfs/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distfiles.icmpv6.org/distfiles/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
