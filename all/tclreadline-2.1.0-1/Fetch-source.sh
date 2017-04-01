#!/bin/bash

SRC=tclreadline-2.1.0.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=219d0247a1373578080940ebde53bdd0

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://downloads.sourceforge.net/project/tclreadline/tclreadline/tclreadline-2.1.0/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.mirrorservice.org/sites/distfiles.macports.org/tclreadline/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.sunet.se/mirror/archive/ftp.sunet.se/pub/gnuish/geda/dist/dependencies/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.sunet.se/mirror/archive/ftp.sunet.se/pub/gnuish/geda/dist/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://http.mirror.yandex.ru/macports/distfiles/tclreadline/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ba.mirror.garr.it/mirrors/macports-distfiles/tclreadline/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" https://mirror.yandex.ru/macports/distfiles/tclreadline/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
