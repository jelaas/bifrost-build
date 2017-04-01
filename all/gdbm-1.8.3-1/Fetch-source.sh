#!/bin/bash

SRC=gdbm-1.8.3.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=1d1b1d5c0245b1c00aff92da751e9aa1

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://ftp.sunet.se/pub/gnu/gdbm/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.sunet.se/mirror/archive/ftp.sunet.se/pub/Linux/distributions/bifrost/download/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.pt.xemacs.org/aux/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://webdata.psru.ac.th/~pisut/distfiles_80/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.mirbsd.org/.Archive/FreeWRT/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.linuxfoundation.org/pub/lsb/impl/packages/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://dev.gateworks.com/sources/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
