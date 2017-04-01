#!/bin/bash

SRC=minidlna-1.1.3.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=879027192c89e5376cdd2ae2d1aa33b4

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://downloads.sourceforge.net/project/minidlna/minidlna/1.1.3/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.mirrorservice.org/sites/distfiles.macports.org/minidlna/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp5.de.freebsd.org/macports/distfiles/minidlna/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ba.mirror.garr.it/mirrors/macports-distfiles/minidlna/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sources.buildroot.net/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.yandex.ru/macports/distfiles/minidlna/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
