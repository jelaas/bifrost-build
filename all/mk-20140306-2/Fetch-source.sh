#!/bin/bash

SRC=plan9port-20140306.tgz
DST=/var/spool/src/"${SRC}"
MD5=f03331f0fa0d0d6c6582ced4bc0094c5

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://slackware.uk/sbosrcarch/by-name/system/plan9port/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.su.se/pub/OpenBSD/5.7/packages/i386/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.nluug.nl/OpenBSD/5.7/packages/amd64/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.yandex.ru/openbsd/5.7/packages/amd64/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://warwick-euro.archive.parrotsec.org/mirrors/pub/OpenBSD/5.6/packages/i386/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirrors.sohu.com/OpenBSD/5.6/packages/i386/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://filedump.se.rit.edu/pub/OpenBSD/5.7/packages/i386/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
