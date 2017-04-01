#!/bin/bash

SRC=minidlna_1.0.25_src.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=d966256baf2f9b068b9de871ab5dade5

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://downloads.sourceforge.net/project/minidlna/minidlna/1.0.25/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.fr.netbsd.org/pub/NetBSD/packages/distfiles/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.mirrorservice.org/sites/ftp.cs.vu.nl/pub/minix/distfiles/local/3.3.0/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://source.ipfire.org/source-2.x/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" https://mirrors.v40.net/sources.buildroot.net/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
