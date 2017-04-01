#!/bin/bash

SRC=pcre-8.38.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=00aabbfe56d5a48b270f999b508c5ad2

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.cs.stanford.edu/pub/exim/pcre/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.mirrorservice.org/sites/ftp.exim.org/pub/pcre/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://piotrkosoft.net/pub/mirrors/ftp.exim.org/pcre/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.is.co.za/mirror/ftp.exim.org/ftp/pcre/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lfs-matrix.net/pub/blfs/conglomeration/pcre/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://tinycorelinux.net/8.x/armv7/tcz/src/pcre/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://fco.it.distfiles.macports.org/mirrors/macports-distfiles/pcre/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://dev.gateworks.com/sources/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
