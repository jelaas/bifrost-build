#!/bin/bash

SRC=STLport-5.2.1.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=a8341363e44d9d06a60e03215b38ddde

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://downloads.sourceforge.net/project/stlport/STLport/STLport-5.2.1/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://files.gentoo.gr/distfiles/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.overthewire.com.au/pub/gentoo/distfiles/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.belnet.be/pub/rsync.gentoo.org/gentoo/distfiles/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
