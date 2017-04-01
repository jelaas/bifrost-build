#!/bin/bash

SRC=pcre-8.02.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=27948c1b5f5c1eabc23cba1ebe4c316f

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.cs.stanford.edu/pub/exim/pcre/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.mirrorservice.org/sites/ftp.exim.org/pub/pcre/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://piotrkosoft.net/pub/mirrors/ftp.exim.org/pcre/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.sunet.se/mirror/archive/ftp.sunet.se/pub/Linux/distributions/bifrost/download/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://slackware.blizoo.mk/slackware/slackware-13.1/source/l/pcre/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distfiles.lesslinux.org/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://freetz.mhampicke.de/packages/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
