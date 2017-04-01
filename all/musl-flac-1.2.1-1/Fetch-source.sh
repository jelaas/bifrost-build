#!/bin/bash

SRC=flac-1.2.1.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=153c8b15a54da428d1f0fadc756c22c7

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://downloads.sourceforge.net/project/flac/flac-src/flac-1.2.1-src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://download.videolan.org/pub/contrib/flac/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.icm.edu.pl/packages/xiph/flac/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://dev.gateworks.com/sources/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://winswitch.org/src/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
