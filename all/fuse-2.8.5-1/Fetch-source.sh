#!/bin/bash

SRC=fuse-2.8.5.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=8aa2fd689de00b73963620483084ae3b

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ignum2.dl.sourceforge.net/project/fuse/fuse-2.X/2.8.5/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://dev.gateworks.com/sources/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sources.geexbox.org/devel/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://attic-distfiles.pld-linux.org/distfiles/distfiles/by-md5/8/a/8aa2fd689de00b73963620483084ae3b/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.acc.umu.se/mirror/archive/ftp.sunet.se/pub/Linux/distributions/bifrost/download/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sources.buildroot.net/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
