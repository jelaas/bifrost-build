#!/bin/bash

SRC=gnuplot-4.4.0.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=e708665bd512153ad5c35252fe499059

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sourceforge.net/projects/gnuplot/files/gnuplot/4.4.0/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.naist.jp/pub/sunfreeware/SOURCES/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sourceforge.mirrorservice.org/g/project/gn/gnuplot/gnuplot/4.4.0/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.sunet.se/mirror/archive/ftp.sunet.se/pub/Linux/distributions/bifrost/download/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://dlc.openindiana.org/oi-build/source-archives/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.acc.umu.se/mirror/archive/ftp.sunet.se/pub/Linux/distributions/bifrost/download/src/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
