#!/bin/bash

SRC=bison-2.4.2.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=63584004613aaef2d3dca19088eb1654

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://ftp.sunet.se/pub/gnu/bison/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.cogentco.com/pub/gnu/bison/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.acc.umu.se/mirror/gnu.org/gnu/bison/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.clfs.org/pub/clfs/conglomeration/bison/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://gnumirror.nkn.in/bison/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ns2.autopilotas.lt/slackware-13.1/source/d/bison/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
